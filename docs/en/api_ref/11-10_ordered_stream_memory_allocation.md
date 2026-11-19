# 11-10 Stream Ordered Memory Allocation

<!-- md-trans-meta sourceCommit=6b0fd8c6df946e4dd62a62605cdf0121a78564f1 translatedAt=2026-11-11T06:51:07.509Z pushedAt=2026-11-16T09:00:00.301Z nl=2 -->

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
    - Opportunistic memory reuse: When executing a task in a stream, the system attempts to reuse eligible memory in the memory pool. If no such memory is found, the normal memory pool allocation process continues, and whether the allocation succeeds is determined by the allocation result.
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

<a id="aclrtMemPoolCreate"></a>

## aclrtMemPoolCreate

```c
aclError aclrtMemPoolCreate(aclrtMemPool *memPool, const aclrtMemPoolProps *poolProps)
```

**Caution: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id3039 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3039 -->
<!-- npu="A3" id3040 -->
- Atlas A3 products: Not supported
<!-- end id3040 -->
<!-- npu="910b" id3041 -->
- Atlas A2 products: Supported
<!-- end id3041 -->
<!-- npu="310b" id3042 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3042 -->
<!-- npu="310p" id3043 -->
- Atlas inference products: Not supported
<!-- end id3043 -->
<!-- npu="910" id3044 -->
- Atlas training products: Not supported
<!-- end id3044 -->
<!-- npu="IPV350" id3045 -->
- IPV350: Not supported
<!-- end id3045 -->
<!-- npu="5162A" id5001 -->
- Hisilicon5162A: Not supported
<!-- end id5001 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-10_ordered_stream_memory_allocation_res.md#id1 -->

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

<a id="aclrtMemPoolDestroy"></a>

## aclrtMemPoolDestroy

```c
aclError aclrtMemPoolDestroy(const aclrtMemPool memPool)
```

**Caution: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1555 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1555 -->
<!-- npu="A3" id1556 -->
- Atlas A3 products: Not supported
<!-- end id1556 -->
<!-- npu="910b" id1557 -->
- Atlas A2 products: Supported
<!-- end id1557 -->
<!-- npu="310b" id1558 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1558 -->
<!-- npu="310p" id1559 -->
- Atlas inference products: Not supported
<!-- end id1559 -->
<!-- npu="910" id1560 -->
- Atlas training products: Not supported
<!-- end id1560 -->
<!-- npu="IPV350" id1561 -->
- IPV350: Not supported
<!-- end id1561 -->
<!-- npu="5162A" id5002 -->
- Hisilicon5162A: Not supported
<!-- end id5002 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-10_ordered_stream_memory_allocation_res.md#id2 -->

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

<a id="aclrtMemPoolSetAttr"></a>

## aclrtMemPoolSetAttr

```c
aclError aclrtMemPoolSetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

**Caution: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1485 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1485 -->
<!-- npu="A3" id1486 -->
- Atlas A3 products: Not supported
<!-- end id1486 -->
<!-- npu="910b" id1487 -->
- Atlas A2 products: Supported
<!-- end id1487 -->
<!-- npu="310b" id1488 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1488 -->
<!-- npu="310p" id1489 -->
- Atlas inference products: Not supported
<!-- end id1489 -->
<!-- npu="910" id1490 -->
- Atlas training products: Not supported
<!-- end id1490 -->
<!-- npu="IPV350" id1491 -->
- IPV350: Not supported
<!-- end id1491 -->
<!-- npu="5162A" id5003 -->
- Hisilicon5162A: Not supported
<!-- end id5003 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-10_ordered_stream_memory_allocation_res.md#id3 -->

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

<a id="aclrtMemPoolGetAttr"></a>

## aclrtMemPoolGetAttr

```c
aclError aclrtMemPoolGetAttr(aclrtMemPool memPool, aclrtMemPoolAttr attr, void *value)
```

**Caution: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1695 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1695 -->
<!-- npu="A3" id1696 -->
- Atlas A3 products: Not supported
<!-- end id1696 -->
<!-- npu="910b" id1697 -->
- Atlas A2 products: Supported
<!-- end id1697 -->
<!-- npu="310b" id1698 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1698 -->
<!-- npu="310p" id1699 -->
- Atlas inference products: Not supported
<!-- end id1699 -->
<!-- npu="910" id1700 -->
- Atlas training products: Not supported
<!-- end id1700 -->
<!-- npu="IPV350" id1701 -->
- IPV350: Not supported
<!-- end id1701 -->
<!-- npu="5162A" id5004 -->
- Hisilicon5162A: Not supported
<!-- end id5004 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-10_ordered_stream_memory_allocation_res.md#id4 -->

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

<a id="aclrtMemPoolMallocAsync"></a>

## aclrtMemPoolMallocAsync

```c
aclError aclrtMemPoolMallocAsync(void **ptr, size_t size, aclrtMemPool memPool, aclrtStream stream)
```

**Caution: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1569 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1569 -->
<!-- npu="A3" id1570 -->
- Atlas A3 products: Not supported
<!-- end id1570 -->
<!-- npu="910b" id1571 -->
- Atlas A2 products: Supported
<!-- end id1571 -->
<!-- npu="310b" id1572 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1572 -->
<!-- npu="310p" id1573 -->
- Atlas inference products: Not supported
<!-- end id1573 -->
<!-- npu="910" id1574 -->
- Atlas training products: Not supported
<!-- end id1574 -->
<!-- npu="IPV350" id1575 -->
- IPV350: Not supported
<!-- end id1575 -->
<!-- npu="5162A" id5005 -->
- Hisilicon5162A: Not supported
<!-- end id5005 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-10_ordered_stream_memory_allocation_res.md#id5 -->

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

<a id="aclrtMemPoolFreeAsync"></a>

## aclrtMemPoolFreeAsync

```c
aclError aclrtMemPoolFreeAsync(void *ptr, aclrtStream stream)
```

**Caution: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id512 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id512 -->
<!-- npu="A3" id513 -->
- Atlas A3 products: Not supported
<!-- end id513 -->
<!-- npu="910b" id514 -->
- Atlas A2 products: Supported
<!-- end id514 -->
<!-- npu="310b" id515 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id515 -->
<!-- npu="310p" id516 -->
- Atlas inference products: Not supported
<!-- end id516 -->
<!-- npu="910" id517 -->
- Atlas training products: Not supported
<!-- end id517 -->
<!-- npu="IPV350" id518 -->
- IPV350: Not supported
<!-- end id518 -->
<!-- npu="5162A" id5006 -->
- Hisilicon5162A: Not supported
<!-- end id5006 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-10_ordered_stream_memory_allocation_res.md#id6 -->

### Function

Destroys the memory allocated by calling [aclrtMemPoolMallocAsync](#aclrtMemPoolMallocAsync). The memory is only returned to the memory pool, and the physical memory is actually not released. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| ------- | :-------: | ------------------------------------------------------------ |
| ptr     |   Input    | Pointer to the address of the memory to release. |
| stream  |   Input    | Stream that executes the memory release task. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a id="aclrtMemPoolTrimTo"></a>

## aclrtMemPoolTrimTo

```c
aclError aclrtMemPoolTrimTo(aclrtMemPool memPool, size_t minBytesToKeep)
```

**Caution: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1030 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1030 -->
<!-- npu="A3" id1031 -->
- Atlas A3 products: Not supported
<!-- end id1031 -->
<!-- npu="910b" id1032 -->
- Atlas A2 products: Supported
<!-- end id1032 -->
<!-- npu="310b" id1033 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1033 -->
<!-- npu="310p" id1034 -->
- Atlas inference products: Not supported
<!-- end id1034 -->
<!-- npu="910" id1035 -->
- Atlas training products: Not supported
<!-- end id1035 -->
<!-- npu="IPV350" id1036 -->
- IPV350: Not supported
<!-- end id1036 -->
<!-- npu="5162A" id5007 -->
- Hisilicon5162A: Not supported
<!-- end id5007 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-10_ordered_stream_memory_allocation_res.md#id7 -->

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
