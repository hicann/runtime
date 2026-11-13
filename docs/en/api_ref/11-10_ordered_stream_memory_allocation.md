# 11-10 Stream Ordered Memory Allocation

<!-- md-trans-meta sourceCommit=24ca51095ac0bf93e3b457b14c8c227ba61d7798 translatedAt=2026-11-06T11:22:36.282Z pushedAt=2026-11-09T08:52:09.000Z nl=2 -->

This section describes the Stream Ordered Memory Allocation (SOMA) APIs of CANN Runtime, which create and configure memory pools and asynchronously allocate and release memory.

- [`aclError aclrtMemPoolCreate(aclrtMemPool *memPool, const aclrtMemPoolProps *poolProps)`](#aclrtMemPoolCreate): Creates a memory pool.
- [`aclError aclrtMemPoolDestroy(const aclrtMemPool memPool)`](#aclrtMemPoolDestroy): Destroys a memory pool created by calling [aclrtMemPoolCreate](#aclrtMemPoolCreate).
- [`aclError aclrtMemPoolSetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)`](#aclrtMemPoolSetAttr): Sets an attribute value.
- [`aclError aclrtMemPoolGetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)`](#aclrtMemPoolGetAttr): Obtains the value of a specified attribute.
- [`aclError aclrtMemPoolMallocAsync(void **ptr, size_t size, aclrtMemPool memPool, aclrtStream stream)`](#aclrtMemPoolMallocAsync): Allocates memory of a specified size from the memory pool. This is an asynchronous API.
- [`aclError aclrtMemPoolFreeAsync(void *ptr, aclrtStream stream)`](#aclrtMemPoolFreeAsync): Frees memory allocated by calling [aclrtMemPoolMallocAsync](#aclrtMemPoolMallocAsync), returning only the memory to the memory pool instead of actually releasing physical memory. This is an asynchronous API.
- [`aclError aclrtMemPoolTrimTo(aclrtMemPool memPool, size_t minBytesToKeep)`](#aclrtMemPoolTrimTo): Shrinks the memory pool, retaining memory of a specified size.

## Instructions

### Background

aclrtMalloc and aclrtFree are APIs for synchronous memory allocation and management. The following sample code shows a common memory use case: use aclrtMalloc to allocate memory, copy the memory data to the device asynchronously for use by operators, wait for stream synchronization after operator execution to confirm that the memory is no longer in use, and then release the memory with aclrtFree. This approach is acceptable when asynchronous operations are few. However, when a large number of operators are dispatched and memory operations are performed asynchronously at high frequency, this approach has the following drawbacks:

1. **Synchronization bottleneck**: During task delivery, adjustments involving memory allocation or release can easily cause synchronization bottlenecks, reducing overall efficiency.
2. **Cumulative latency**: Memory allocation and release are time-consuming. Frequent operations accumulate unnecessary latency, further degrading performance.

```c
#include "acl/acl_rt.h"
#include "acl/acl.h"

int main() {
    typedef struct {
        ......
    } ArgsInfo;

    void *ptr0 = nullptr;
    aclrtStream stream1;

    // Allocate memory.
    aclrtMalloc(&ptr0, sizeof(ArgsInfo), ACL_MEM_MALLOC_HUGE_FIRST);
    ......

    // Configure task delivery.
    ArgsInfo usrArgs;
    // Copy information to the memory allocated on the device.
    error = aclrtMemcpyAsync(ptr0, sizeof(ArgsInfo), (void *)&usrArgs, sizeof(ArgsInfo), ACL_MEMCPY_HOST_TO_DEVICE, stream1);

    // Deliver tasks.
    uint32_t blockDim = 32;
    aclrtLaunchKernelV2(funcHandle, blockDim, (void *)&usrArgs, sizeof(ArgsInfo), nullptr, stream1);

    // Synchronize the stream to release the allocated memory synchronously.
    aclrtSynchronizeStream(stream1);

    // Release the memory. Stream synchronization is required before release.
    aclrtFree(ptr0);
    ......

    // Synchronize the stream.
    aclrtSynchronizeStream(stream1);

    return 0;
}
```

In contrast, the SOMA mechanism described in this section integrates memory allocation and release operations into the stream scheduling order to manage memory. This approach closely integrates memory management with task execution in a stream, so memory management can be performed without explicitly synchronizing tasks in the stream, and the order-preserving mechanism of the stream itself ensures ordered execution of operations. In addition, the runtime allows for memory reuse to fully support complex memory management use cases.

```c
#include "acl/acl_rt.h"
#include "acl/acl.h"

int main() {
    typedef struct {
        ......
    } ArgsInfo;

    void *ptr0 = nullptr;
    aclrtStream stream1;

    // Allocate memory asynchronously. testReusePool is the user-created memory pool.
    aclrtMemPoolMallocAsync(&ptr0, sizeof(ArgsInfo), testReusePool, stream1);
    ......

    // Configure task delivery.
    ArgsInfo usrArgs;
    // Copy information to the memory allocated on the device.
    error = aclrtMemcpyAsync(ptr0, sizeof(ArgsInfo), (void *)&usrArgs, sizeof(ArgsInfo), ACL_MEMCPY_HOST_TO_DEVICE, stream1);

    // Deliver tasks.
    uint32_t blockDim = 32;
    aclrtLaunchKernelV2(funcHandle, blockDim, (void *)&usrArgs, sizeof(ArgsInfo), nullptr, stream1);

    // Release memory asynchronously. No stream synchronization is required.
    aclrtMemPoolFreeAsync(ptr0, stream1);
    ......

    // Synchronize the stream.
    aclrtSynchronizeStream(stream1);

    return 0;
}
```

### Memory Reuse Mechanism

When aclrtMemPoolFreeAsync is called, the memory is only returned to the memory pool, and the physical memory is not actually released. In this way, subsequent tasks can reuse the physical memory, avoiding frequent allocation and release of physical memory and improving performance. When reusing memory, the system selects the idle memory block whose size is closest to the memory size required by the current task.

![](figures/memory_reuse_diagram.png)

By default, when the idle physical memory in the memory pool exceeds the specified threshold (the threshold can be configured via aclrtMemPoolSetAttr and defaults to `0`), the system attempts to actually release the idle physical memory at the next stream synchronization task (for example, when aclrtSynchronizeStream is called). The runtime also provides aclrtMemPoolTrimTo. You can call this API to shrink the memory pool and release the idle physical memory. If you configure the threshold of the memory size to retain in the memory pool by calling aclrtMemPoolSetAttr (corresponding to the ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD config) and also configure the physical memory size to retain by setting `minBytesToKeep` in aclrtMemPoolTrimTo, the latter takes higher priority.

Currently, memory reuse is supported within a stream and between two streams:

- When memory is reused within a stream, the following mechanism is used: When executing a task in a stream, the system searches for the memory that preceding tasks in the stream have returned to the memory pool and reuses these memory resources to improve memory utilization and reduce memory allocation overhead.
- For memory reuse between two streams, the following types are supported:
    - Event-dependent: When executing a task in a stream, the system searches for other streams associated with this stream via an event and reuses the memory returned to the memory pool by tasks in these associated streams. This mechanism applies to use cases where tasks between streams are synchronized via an event in a user application.
    - Opportunistic: When executing a task in a stream, the system retrieves reusable memory from the memory pool, but memory reuse is not guaranteed to succeed. If memory reuse fails, the program reports an error and stops.
    - Implicitly dependent: When executing a task in a stream, the system retrieves reusable memory from the memory pool. If the memory was previously used by other streams but no task dependency exists between the related streams, the system automatically performs synchronization waiting between the related streams to ensure that tasks in the preceding stream have finished accessing the memory, thereby achieving safe memory reuse.

### Sample Code

The following sample code demonstrates a use case of asynchronous memory allocation and release, with tasks issued through aclrtLaunchKernelV2. The code is for reference only. Do not copy or compile it directly. Adjust it according to the actual environment and requirements.

```c
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

    // Create a context and a stream.
    aclrtContext context;
    aclrtStream stream1;

    aclrtCreateContext(&context, 0);
    aclrtCreateStream(&stream1);

    // Set memory pool attributes.
    aclrtMemLocation testLoc = {
            0,                           // id
            ACL_MEM_LOCATION_TYPE_DEVICE // type
    };
    aclrtMemPoolProps testProp = {
            ACL_MEM_ALLOCATION_TYPE_PINNED, // allocType
            ACL_MEM_HANDLE_TYPE_NONE,       // handleType
            testLoc,                        // location
            14UL << 30,                     // maxSize = 14GB; memory pool size is 14GB
            {0}                             // reserved
    };

    // Create a memory pool.
    aclrtMemPool testReusePool;
    auto ret = aclrtMemPoolCreate(&testReusePool, &testProp);
    if (ret != ACL_SUCCESS) {
        fprintf(stderr, "Failed to create memory pool\n");
        return -1;
    }

    const size_t GB_TO_B = 1024ULL * 1024 * 1024;

    // Define the operator information structure.
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

    // Allocate memory asynchronously.
    aclrtMemPoolMallocAsync(&ptr1, sizeof(uint64_t), testReusePool, stream1);
    aclrtMemPoolMallocAsync(&ptr2, sizeof(uint64_t), testReusePool, stream1);
    aclrtMemPoolMallocAsync(&ptr3, sizeof(uint64_t), testReusePool, stream1);
    aclrtMemPoolMallocAsync(&ptr0, sizeof(ArgsInfo), testReusePool, stream1);

    // Configure task delivery.
    ArgsInfo usrArgs;
    usrArgs.input_x = ptr1
    usrArgs.input_y = ptr2;
    usrArgs.output_z = ptr3;

    error = aclrtMemcpyAsync(devPtr, sizeof(ArgsInfo), (void *)&usrArgs, sizeof(ArgsInfo), ACL_MEMCPY_HOST_TO_DEVICE, stream1);

    // Deliver tasks.
    uint32_t blockDim = 32;
    aclrtLaunchKernelV2(funcHandle, blockDim, (void *)&usrArgs, sizeof(ArgsInfo), nullptr, stream1);

    // Release memory asynchronously; no prior stream synchronization is required.
    aclrtMemPoolFreeAsync(ptr0, stream1);
    aclrtMemPoolFreeAsync(ptr1, stream1);
    aclrtMemPoolFreeAsync(ptr2, stream1);
    aclrtMemPoolFreeAsync(ptr3, stream1);

    // Synchronize streams.
    aclrtSynchronizeStream(stream1);

    // Destroy the memory pool, stream, and context.
    aclrtMemPoolDestroy(testReusePool);
    aclrtDestroyStream(stream1);
    aclrtDestroyContext(context);

    aclrtResetDevice(devid);
    aclFinalize();
    return 0;
}
```

---

<a class="method_anchor" id="aclrtMemPoolCreate"></a>

## aclrtMemPoolCreate

```c
aclError aclrtMemPoolCreate(aclrtMemPool *memPool, const aclrtMemPoolProps *poolProps)
```

**Caution: This is a reserved API and is not supported yet.**

### Function

Creates a memory pool.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| memPool | Output | Memory pool instance. For the type definition, see [aclrtMemPool](25-05_Typedefs.md#aclrtMemPool). |
| poolProps | Input | Memory pool configuration. For the type definition, see [aclrtMemPoolProps](25-04_Structs.md#aclrtMemPoolProps). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemPoolDestroy"></a>

## aclrtMemPoolDestroy

```c
aclError aclrtMemPoolDestroy(const aclrtMemPool memPool)
```

**Caution: This is a reserved API and is not supported yet.**

### Function

Destroys the memory pool created by calling [aclrtMemPoolCreate](#aclrtMemPoolCreate).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| memPool | Input | Memory pool instance. For the type definition, see [aclrtMemPool](25-05_Typedefs.md#aclrtMemPool). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemPoolSetAttr"></a>

## aclrtMemPoolSetAttr

```c
aclError aclrtMemPoolSetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

**Caution: This is a reserved API and is not supported yet.**

### Function

Sets the attribute value.

If the same attribute of the same memory pool is set multiple times, the last setting takes effect.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| memPool | Input | Memory pool instance. For the type definition, see also [aclrtMemPool](25-05_Typedefs.md#aclrtMemPool). |
| attr | Input | Attribute to set. For the type definition, see also [aclrtMemPoolAttr](25-02_Enumerations.md#aclrtMemPoolAttr). |
| value | Input | Pointer to the address for writing the attribute value. The data to write must be of the same type as the attribute specified by `attr`. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemPoolGetAttr"></a>

## aclrtMemPoolGetAttr

```c
aclError aclrtMemPoolGetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

**Caution: This is a reserved API and is not supported yet.**

### Function

Obtains the value of the specified attribute.

If an attribute is not set via [aclrtMemPoolSetAttr](#aclrtMemPoolSetAttr), its default value is returned.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| memPool | Input | Memory pool instance. For the type definition, see [aclrtMemPool](25-05_Typedefs.md#aclrtMemPool). |
| attr | Input | Specified attribute. For the type definition, see [aclrtMemPoolAttr](25-02_Enumerations.md#aclrtMemPoolAttr). |
| value | Output | Pointer to the address of the output attribute value. The type pointed to by the pointer must be the same as the type of the attribute specified by `attr`. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemPoolMallocAsync"></a>

## aclrtMemPoolMallocAsync

```c
aclError aclrtMemPoolMallocAsync(void **ptr, size_t size, aclrtMemPool memPool, aclrtStream stream)
```

**Caution: This is a reserved API and is not supported yet.**

### Function

Allocates memory of a specified size from the memory pool. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| ------- | :-------: | ------------------------------------------------------------ |
| ptr     |   Output    | Pointer to the address of the memory to allocate. |
| size    |   Input    | Size of the memory to allocate, in bytes. |
| memPool |   Input    | Memory pool instance. For the type definition, see [aclrtMemPool](25-05_Typedefs.md#aclrtMemPool). |
| stream  |   Input    | Stream for executing the memory allocation task. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemPoolFreeAsync"></a>

## aclrtMemPoolFreeAsync

```c
aclError aclrtMemPoolFreeAsync(void *ptr, aclrtStream stream)
```

**Caution: This is a reserved API and is not supported yet.**

### Function

Destroys the memory allocated by calling [aclrtMemPoolMallocAsync](#aclrtMemPoolMallocAsync). The memory is only returned to the memory pool, and the physical memory is actually not released. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| ------- | :-------: | ------------------------------------------------------------ |
| ptr     |   Input    | Pointer to the address of the memory to release. |
| stream |   Input    | Stream that executes the memory release task. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemPoolTrimTo"></a>

## aclrtMemPoolTrimTo

```c
aclError aclrtMemPoolTrimTo(aclrtMemPool memPool, size_t minBytesToKeep)
```

**Caution: This is a reserved API and is not supported yet.**

### Function

Shrinks the memory pool and retains memory of the specified size.

When memory is released by calling [aclrtMemPoolFreeAsync](#aclrtMemPoolFreeAsync), the memory is only returned to the memory pool and the physical memory is not actually released. As a result, the memory may remain occupied, preventing [aclrtMemPoolMallocAsync](#aclrtMemPoolMallocAsync) from allocating new memory. In this case, call aclrtMemPoolTrimTo to shrink the memory pool and release idle physical memory without affecting the physical memory currently in use.

### Parameters

| Parameter      | Input/Output | Description                                                  |
| -------------- | :-------: | ------------------------------------------------------------ |
| memPool        |   Input   | Memory pool instance. For the type definition, see [aclrtMemPool](25-05_Typedefs.md#aclrtMemPool). |
| minBytesToKeep |   Input   | Size of the physical memory to retain in the memory pool after the memory pool is shrunk, in bytes. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>
