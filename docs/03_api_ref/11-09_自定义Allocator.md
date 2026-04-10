# 11-09 自定义 Allocator

本章节描述自定义 Allocator 接口，用于注册、查询和注销用户自定义的内存分配器。

- [`aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)`](#aclrtAllocatorRegister)：调用该接口注册用户提供的Allocator以及Allocator对应的回调函数，以便后续使用用户提供的Allocator。
- [`aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)`](#aclrtAllocatorGetByStream)：根据Stream查询用户注册的Allocator信息。
- [`aclError aclrtAllocatorUnregister(aclrtStream stream)`](#aclrtAllocatorUnregister)：用户销毁Allocator前，需调用本接口取消注册用户提供的Allocator以及Allocator对应的回调函数。


<a id="aclrtAllocatorRegister"></a>

# aclrtAllocatorRegister

```c
aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

调用该接口注册用户提供的Allocator以及Allocator对应的回调函数，以便后续使用用户提供的Allocator。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 该Allocator需要注册的Stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。<br>传入的stream参数值不能为NULL，否则返回报错。 |
| allocatorDesc | 输入 | Allocator描述符指针。类型定义请参见[aclrtAllocatorDesc](24_数据类型及其操作接口.md#aclrtAllocatorDesc)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

-   当前仅支持在单算子模型执行、动态shape模型推理场景下使用本接口。

    单算子模型场景下，需在算子执行接口（例如aclopExecuteV2）之前调用本接口。

    动态shape模型推理场景，本接口需配合aclmdlExecuteAsync接口一起使用，且需在aclmdlExecuteAsync接口之前调用本接口。

-   调用本接口前，需要先调用[aclrtAllocatorCreateDesc](24_数据类型及其操作接口.md#aclrtAllocatorCreateDesc)创建Allocator描述符，再分别调用[aclrtAllocatorSetObjToDesc](24_数据类型及其操作接口.md#aclrtAllocatorSetObjToDesc)、[aclrtAllocatorSetAllocFuncToDesc](24_数据类型及其操作接口.md#aclrtAllocatorSetAllocFuncToDesc)、[aclrtAllocatorSetGetAddrFromBlockFuncToDesc](24_数据类型及其操作接口.md#aclrtAllocatorSetGetAddrFromBlockFuncToDesc)、[aclrtAllocatorSetFreeFuncToDesc](24_数据类型及其操作接口.md#aclrtAllocatorSetFreeFuncToDesc)设置Allocator对象及回调函数。Allocator描述符使用完成后，可调用[aclrtAllocatorDestroyDesc](24_数据类型及其操作接口.md#aclrtAllocatorDestroyDesc)接口销毁Allocator描述符。
-   对于同一条流，多次调用本接口，以最后一次注册为准。
-   对于不同流，如果用户使用同一个Allocator，不可以多条流并发执行，在执行下一条Stream前，需要对上一Stream做流同步。
-   将Allocator中的内存释放给操作系统前，需要先调用[aclrtSynchronizeStream](06_Stream管理.md#aclrtSynchronizeStream)接口执行流同步，确保Stream中的任务已执行完成。


<br>
<br>
<br>



<a id="aclrtAllocatorGetByStream"></a>

# aclrtAllocatorGetByStream

```c
aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

根据Stream查询用户注册的Allocator信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 注册的类型，按照不同的子模块区分。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |
| allocatorDesc | 输出 | Allocator描述符指针。类型定义请参见[aclrtAllocatorDesc](24_数据类型及其操作接口.md#aclrtAllocatorDesc)。 |
| allocator | 输出 | 用户提供的Allocator对象指针。类型定义请参见[aclrtAllocator](24_数据类型及其操作接口.md#aclrtAllocator)。 |
| allocFunc | 输出 | 申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocFunc)([aclrtAllocator](24_数据类型及其操作接口.md#aclrtAllocator) allocator, size_t size); |
| freeFunc | 输出 | 释放内存block的回调函数。<br>回调函数定义如下：<br>typedef void (*aclrtAllocatorFreeFunc)([aclrtAllocator](24_数据类型及其操作接口.md#aclrtAllocator) allocator, [aclrtAllocatorBlock](24_数据类型及其操作接口.md#aclrtAllocatorBlock) block); |
| allocAdviseFunc | 输出 | 根据建议地址申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocAdviseFunc)([aclrtAllocator](24_数据类型及其操作接口.md#aclrtAllocator) allocator, size_t size, [aclrtAllocatorAddr](24_数据类型及其操作接口.md#aclrtAllocatorAddr) addr); |
| getAddrFromBlockFunc | 输出 | 根据申请来的block获取device内存地址的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorGetAddrFromBlockFunc)([aclrtAllocatorBlock](24_数据类型及其操作接口.md#aclrtAllocatorBlock) block); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclrtAllocatorUnregister"></a>

# aclrtAllocatorUnregister

```c
aclError aclrtAllocatorUnregister(aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

用户销毁Allocator前，需调用本接口取消注册用户提供的Allocator以及Allocator对应的回调函数。

待取消注册的Stream不存在，或多次调用本接口取消注册，本接口内部不做任何操作，返回成功。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 该Allocator对应的stream。类型定义请参见[aclrtStream](24_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。
