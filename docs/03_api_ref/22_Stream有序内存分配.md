# 22. Stream有序内存分配

本章节描述 CANN Runtime 的 Stream 有序内存分配（SOMA）接口，用于内存池的创建、配置及异步内存分配与释放。

## Stream有序内存分配使用说明

### 背景

aclrtMalloc和aclrtFree是用于同步内存分配和管理的接口。以下示例代码展示了一个常见的内存使用场景：使用aclrtMalloc申请内存，通过异步拷贝的方式将内存数据拷贝到Device侧以备算子使用，算子执行完成后，通过Stream同步来确认该内存使用完毕，然后使用aclrtFree释放内存。在异步操作较少的情况下，这样的方式是可接受的。然而，在有大量算子下发和对申请内存的高频异步操作时，这种方式存在以下不足：

1.  **同步瓶颈**：在任务下发过程中，如果需要进行内存分配或释放的调整，容易产生同步瓶颈，影响整体效率。
2.  **累积延迟**：内存申请与释放本身耗时，频繁操作会累积不必要的延迟，进一步降低性能。

```
#include "acl/acl_rt.h"
#include "acl/acl.h"

int main() {
    typedef struct {
        ......
    } ArgsInfo;

    void *ptr0 = nullptr;
    aclrtStream stream1;

    // 申请内存
    aclrtMalloc(&ptr0, sizeof(ArgsInfo), ACL_MEM_MALLOC_HUGE_FIRST);
    ......

    // 配置任务下发
    ArgsInfo usrArgs;
    // 拷贝信息到device侧申请内存
    error = aclrtMemcpyAsync(ptr0, sizeof(ArgsInfo), (void *)&usrArgs, sizeof(ArgsInfo), ACL_MEMCPY_HOST_TO_DEVICE, stream1);

    // 下发任务
    uint32_t blockDim = 32;
    aclrtLaunchKernelV2(funcHandle, blockDim, (void *)&usrArgs, sizeof(ArgsInfo), nullptr, stream1);

    // 流同步以同步释放申请内存
    aclrtSynchronizeStream(stream1);

    // 释放内存，释放前需要流同步
    aclrtFree(ptr0);
    ......

    // 流同步
    aclrtSynchronizeStream(stream1);

    return 0;
}
```

相比之下，本章所描述的Stream有序内存分配机制将内存分配与释放操作融入到Stream调度序列中，以管理内存。这种方式将内存管理与Stream中的任务执行紧密结合，无需显式同步Stream中的任务即可进行内存管理，并且可依靠Stream本身的保序机制确保操作的有序执行。此外，Runtime还提供内存复用的能力，能够全面支持复杂的内存管理场景。

```
#include "acl/acl_rt.h"
#include "acl/acl.h"

int main() {
    typedef struct {
        ......
    } ArgsInfo;

    void *ptr0 = nullptr;
    aclrtStream stream1;

    // 异步申请内存,testReusePool为用户创建的内存池
    aclrtMemPoolMallocAsync(&ptr0, sizeof(ArgsInfo), testReusePool, stream1);
    ......

    // 配置任务下发
    ArgsInfo usrArgs;
    // 拷贝信息到device侧申请内存
    error = aclrtMemcpyAsync(ptr0, sizeof(ArgsInfo), (void *)&usrArgs, sizeof(ArgsInfo), ACL_MEMCPY_HOST_TO_DEVICE, stream1);

    // 下发任务
    uint32_t blockDim = 32;
    aclrtLaunchKernelV2(funcHandle, blockDim, (void *)&usrArgs, sizeof(ArgsInfo), nullptr, stream1);

    // 异步释放内存，无需进行流同步
    aclrtMemPoolFreeAsync(ptr0, stream1);
    ......

    // 流同步
    aclrtSynchronizeStream(stream1);

    return 0;
}
```

### 内存复用机制

调用aclrtMemPoolFreeAsync接口时，仅将内存归还至内存池，而不实际释放物理内存，以便后续任务能够复用这些物理内存，从而避免频繁申请和释放物理内存，提升性能。复用内存时，会根据本次任务所需的内存大小选择符合大小最接近的空闲内存。

![](figures/Device-Context-Stream之间的关系-4.png)

默认当内存池中空闲的物理内存超过指定阈值（该阈值可通过aclrtMemPoolSetAttr接口配置，默认值为0）时，在下一次Stream同步（例如调用aclrtSynchronizeStream接口）时，系统将尝试真正释放空闲的物理内存。

目前支持在一个Stream中复用内存，也支持在两个Stream之间复用内存：

-   一个Stream内进行内存复用时，基于下面的机制进行：在执行某个Stream的任务时，系统会查找该 Stream 中前序任务已归还到内存池中的内存，并复用这些内存资源，以提高内存利用率和减少内存分配的开销。
-   两个Stream之间复用内存，支持以下几种类型：
    -   事件依赖内存复用：在执行某个Stream的任务时，系统会查找与该Stream通过Event关联的其他Stream，并复用这些关联Stream中的任务已归还到内存池中的内存。此机制适用于用户应用程序中通过Event实现Stream间任务同步的场景。
    -   机会主义内存复用：在执行某个Stream的任务时，系统会检索内存池中可复用的内存，但不保证内存复用一定成功。当内存复用失败时，程序会报错停止。
    -   隐式依赖内存复用：在执行某个Stream的任务时，系统会检索内存池中可复用的内存。若这些内存曾被其他Stream使用，但相关Stream之间不存在任务依赖关系，则系统将自动实现相关Stream之间的同步等待，以确保前一个Stream中的任务对内存的访问已经结束，从而实现安全的内存复用。

### 示例代码

以下代码示例展现了应用异步内存申请与释放的场景，结合aclrtLaunchKernelV2接口下发任务。代码仅做参考，不能直接复制编译，需要根据实际环境和需求进行调整。

```
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <gtest/gtest.h>
#include "acl/acl_rt.h"
#include "acl/acl.h"

int main() {
    uint32_t devid = 0;
    aclInit(NULL);
    aclrtSetDevice(devid);

    // 创建Context和Stream
    aclrtContext context;
    aclrtStream stream1;

    aclrtCreateContext(&context, 0);
    aclrtCreateStream(&stream1);

    // 设置内存池属性
    aclrtMemLocation testLoc = {
            0,                           // id
            ACL_MEM_LOCATION_TYPE_DEVICE // type
    };
    aclrtMemPoolProps testProp = {
            ACL_MEM_ALLOCATION_TYPE_PINNED, // allocType
            ACL_MEM_HANDLE_TYPE_NONE,       // handleType
            testLoc,                        // location
            14UL << 30,                     // maxSize = 14GB， 内存池大小为14G
            {0}                             // reserved
    };

    // 创建内存池
    aclrtMemPool testReusePool;
    auto ret = aclrtMemPoolCreate(&testReusePool, &testProp);
    if (ret != ACL_SUCCESS) {
        fprintf(stderr, "Failed to create memory pool\n");
        return -1;
    }

    const size_t GB_TO_B = 1024ULL * 1024 * 1024;

    // 定义算子信息结构体
    typedef struct {
        void *input_x;
        void *input_y;
        void *output_z;
    } ArgsInfo;

    aclrtBinHandle bin_handle = nullptr;
    aclrtFuncHandle func_handle;
    aclError aclrtBinaryGetFunction(binHandle, "add_custom", &funcHandle);

    void *ptr0 = nullptr;
    void *ptr1 = nullptr;
    void *ptr2 = nullptr;
    void *ptr3 = nullptr;

    // 异步申请内存
    aclrtMemPoolMallocAsync(&ptr1, sizeof(uint64_t), testReusePool, stream1);
    aclrtMemPoolMallocAsync(&ptr2, sizeof(uint64_t), testReusePool, stream1);
    aclrtMemPoolMallocAsync(&ptr3, sizeof(uint64_t), testReusePool, stream1);
    aclrtMemPoolMallocAsync(&ptr0, sizeof(ArgsInfo), testReusePool, stream1);

    // 配置任务下发
    ArgsInfo usrArgs;
    usrAgrs.input_x = ptr1
    usrAgrs.input_y = ptr2;
    usrAgrs.output_z = ptr3;

    error = aclrtMemcpyAsync(devPtr, sizeof(ArgsInfo), (void *)&usrArgs, sizeof(ArgsInfo), ACL_MEMCPY_HOST_TO_DEVICE, stream1);

    // 下发任务
    uint32_t blockDim = 32;
    aclrtLaunchKernelV2(funcHandle, blockDim, (void *)&usrArgs, sizeof(ArgsInfo), nullptr, stream1);

    // 异步释放内存，此前无需进行流同步
    aclrtMemPoolFreeAsync(ptr0, stream1);
    aclrtMemPoolFreeAsync(ptr1, stream1);
    aclrtMemPoolFreeAsync(ptr2, stream1);
    aclrtMemPoolFreeAsync(ptr3, stream1);

    // 流同步
    aclrtSynchronizeStream(stream1);

    // 销毁内存池、Stream和Context
    aclrtMemPoolDestroy(testReusePool);
    aclrtDestroyStream(stream1);
    aclrtDestroyContext(context);

    aclrtResetDevice(devid);
    aclFinalize();
    return 0;
}
```

---

- [`aclError aclrtMemPoolCreate(aclrtMemPool *memPool, const aclrtMemPoolProps *poolProps)`](#aclrtMemPoolCreate)：创建内存池。
- [`aclError aclrtMemPoolDestroy(const aclrtMemPool memPool)`](#aclrtMemPoolDestroy)：销毁通过[aclrtMemPoolCreate](#aclrtMemPoolCreate)接口创建的内存池。
- [`aclError aclrtMemPoolSetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)`](#aclrtMemPoolSetAttr)：设置属性值。
- [`aclError aclrtMemPoolGetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)`](#aclrtMemPoolGetAttr)：获取指定属性的值。
- [aclrtMemPoolMallocAsync](#aclrtMemPoolMallocAsync)
- [aclrtMemPoolFreeAsync](#aclrtMemPoolFreeAsync)
- [aclrtMemPoolTrimTo](#aclrtMemPoolTrimTo)


<a id="aclrtMemPoolCreate"></a>

# aclrtMemPoolCreate

```c
aclError aclrtMemPoolCreate(aclrtMemPool *memPool, const aclrtMemPoolProps *poolProps)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建内存池。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| memPool | 输出 | 内存池实例。类型定义请参见[aclrtMemPool](24_数据类型及其操作接口.md#aclrtMemPool)。 |
| poolProps | 输入 | 内存池配置。类型定义请参见[aclrtMemPoolProps](24_数据类型及其操作接口.md#aclrtMemPoolProps)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtMemPoolDestroy"></a>

# aclrtMemPoolDestroy

```c
aclError aclrtMemPoolDestroy(const aclrtMemPool memPool)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[aclrtMemPoolCreate](#aclrtMemPoolCreate)接口创建的内存池。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| memPool | 输入 | 内存池实例。类型定义请参见[aclrtMemPool](24_数据类型及其操作接口.md#aclrtMemPool)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtMemPoolSetAttr"></a>

# aclrtMemPoolSetAttr

```c
aclError aclrtMemPoolSetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置属性值。

多次对同一个内存池的同一个属性值进行设置，以最后一次为准。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| memPool | 输入 | 内存池实例。类型定义请参见[aclrtMemPool](24_数据类型及其操作接口.md#aclrtMemPool)。 |
| attr | 输入 | 指定属性。类型定义请参见[aclrtMemPoolAttr](24_数据类型及其操作接口.md#aclrtMemPoolAttr)。 |
| value | 输入 | 指向写入属性值地址的指针，写入的数据，其类型需要与attr处指定属性的类型相同。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtMemPoolGetAttr"></a>

# aclrtMemPoolGetAttr

```c
aclError aclrtMemPoolGetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | ☓ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取指定属性的值。

如果未通过[aclrtMemPoolSetAttr](#aclrtMemPoolSetAttr)接口设置相应属性，则获取该属性的默认值。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| memPool | 输入 | 内存池实例。类型定义请参见[aclrtMemPool](24_数据类型及其操作接口.md#aclrtMemPool)。 |
| attr | 输入 | 指定属性。类型定义请参见[aclrtMemPoolAttr](24_数据类型及其操作接口.md#aclrtMemPoolAttr)。 |
| value | 输出 | 指向输出属性值地址的指针，该指针指向的类型需与attr处指定属性的类型相同。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



# aclrtMemPoolMallocAsync

> 文档暂缺



<br>
<br>
<br>



# aclrtMemPoolFreeAsync

> 文档暂缺



<br>
<br>
<br>



# aclrtMemPoolTrimTo

> 文档暂缺

