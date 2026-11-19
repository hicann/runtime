# Data Copy

<!-- md-trans-meta sourceCommit=e96cabba1f2f151e2452e27b1b5c20873505b812 translatedAt=2026-11-11T06:19:20.197Z pushedAt=2026-11-16T02:27:22.609Z nl=2 -->

A host and a device have independent memory spaces. Data prepared on the host must be copied to the device memory before operators on the device can access it with higher performance. Likewise, computation results usually need to be copied from the device back to the host. Runtime provides multiple copy APIs, including synchronous, asynchronous, batch, 2D, and descriptor-based APIs, to cover different data transfer scenarios.

## Copy Direction

Common copy directions are as follows:

| Scenario | Direction | Common API | Description |
| --- | --- | --- | --- |
| Host-to-device copy | ACL_MEMCPY_HOST_TO_DEVICE | **aclrtMemcpy**, **aclrtMemcpyAsync** | Commonly used for input data transfer. To achieve a truly asynchronous effect with asynchronous APIs, it is recommended to use pinned memory for the host memory. |
| Device-to-host copy | ACL_MEMCPY_DEVICE_TO_HOST | **aclrtMemcpy**, **aclrtMemcpyAsync** | Commonly used to retrieve operator output. Before reading the host result, ensure that the copy task is complete. |
| Device-to-device copy | ACL_MEMCPY_DEVICE_TO_DEVICE | **aclrtMemcpy**, **aclrtMemcpyAsync** | Indicates data copy within the same device or across devices. These APIs determine the actual copy path based on the source and destination addresses, so users do not need to explicitly distinguish between intra-device and cross-device copy. |
| Intra-device descriptor copy | ACL_MEMCPY_INNER_DEVICE_TO_DEVICE | **aclrtMemcpyAsyncWithDesc** | Indicates data copy within the same device. The descriptor method requires this enum to be explicitly specified. |
| Intra-host copy | ACL_MEMCPY_HOST_TO_HOST | **aclrtMemcpy** | Generally, standard C/C++ APIs can be used directly for host-side memory copy. When using Runtime asynchronous APIs for intra-host copy, pay attention to product support limitations. |

The synchronous API **aclrtMemcpy** returns after the copy is complete. The asynchronous API **aclrtMemcpyAsync** dispatches the copy task to the specified stream, and its return only indicates that the task has been dispatched, not that the copy task is complete. Before reading the destination memory, call **aclrtSynchronizeStream**, **aclrtSynchronizeDevice**, or use mechanisms such as **Event** to confirm that the task is complete.

## Host-Device Copy

Data copy between the host and the device is the most common way to transfer inputs and outputs. The typical process is as follows: request host memory and device memory, copy the input from the host to the device, dispatch operators on a stream, and finally copy the output from the device back to the host.

```c
aclrtStream stream = nullptr;
aclrtCreateStream(&stream);

void *hostIn = nullptr;
void *hostOut = nullptr;
void *devIn = nullptr;
void *devOut = nullptr;
aclrtMallocHost(&hostIn, size);
aclrtMallocHost(&hostOut, size);
aclrtMalloc(&devIn, size, ACL_MEM_MALLOC_HUGE_FIRST);
aclrtMalloc(&devOut, size, ACL_MEM_MALLOC_HUGE_FIRST);

// Copy the input data from the host to the device.
aclrtMemcpyAsync(devIn, size, hostIn, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);

// Dispatch the compute task, which is executed in order with the preceding copy task on the same stream.
myKernel<<<numBlocks, nullptr, stream>>>(devIn, devOut);

// Copy the output data from the device back to the host.
aclrtMemcpyAsync(hostOut, size, devOut, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// Wait until all copies and computations on the same stream are complete before reading hostOut.
aclrtSynchronizeStream(stream);
```

If a synchronous copy API is used, the API waits for the current copy to complete before returning, but it does not implicitly synchronize other streams. If there are other asynchronous tasks before or after the copy, you need to ensure data dependencies through stream ordering, events, or explicit synchronization.

## Asynchronous Copy of Non-Pinned Host Memory

Host memory requested through traditional APIs such as **malloc** and **mmap** is non-pinned memory. Asynchronous APIs such as **aclrtMemcpyAsync**, **aclrtMemcpy2dAsync**, and **aclrtMemcpyBatchAsync** support non-pinned host memory, but the following scenarios require special attention:

- When the host memory involved in the copy is pinned memory, the asynchronous copy API only dispatches the copy task and returns the result, allowing the host thread to continue with other work while the copy task is executed in order in the stream.
- When the host memory involved in the copy is non-pinned memory, the asynchronous copy API returns only after the memory copy task is complete. In this case, although the API name contains "Async", the host thread cannot run in parallel with this copy, and data transfer is difficult to fully overlap with computation.
- To stably achieve overlap between copy and computation, it is recommended that you request pinned memory through **aclrtMallocHost**, or register existing host memory as pinned memory through **aclrtHostRegisterV2** on supported systems.
- When ACL Graph captures an asynchronous memory copy task, if the copy involves host memory, the host memory must be pinned memory requested through Runtime APIs; otherwise, an error is returned during capture.

Therefore, non-pinned host memory is more suitable for low-frequency, temporary data transfer that is not sensitive to concurrency performance; performance-sensitive input and output paths should use pinned host memory.

## Intra-Device Copy

When using **aclrtMemcpy** or **aclrtMemcpyAsync** for device-to-device copy, set the copy type to **ACL_MEMCPY_DEVICE_TO_DEVICE**. This enum indicates data copy within the same device or across devices. Runtime determines the actual copy path based on the source address and destination address, so users do not need to explicitly specify **ACL_MEMCPY_INNER_DEVICE_TO_DEVICE** or **ACL_MEMCPY_INTER_DEVICE_TO_DEVICE**.

**ACL_MEMCPY_INNER_DEVICE_TO_DEVICE** indicates only intra-device copy and must be explicitly specified in descriptor-based copy scenarios, for example, in the **aclrtMemcpyAsyncWithDesc** API. The descriptor approach is suitable for scenarios where copy parameters can be reused. The user first obtains the descriptor size and sets the source address, destination address, and length, and then uses the descriptor to dispatch a copy task on the stream.

## Inter-Device Copy

Inter-device copy is used for data transfer between different devices in the same process. Before calling the copy API, confirm whether data exchange is supported between the two devices, and enable Peer Access in the access direction:

```c
int32_t canAccess = 0;
// Query the access direction to be enabled: dstDeviceId -> srcDeviceId.
aclrtDeviceCanAccessPeer(&canAccess, dstDeviceId, srcDeviceId);
if (canAccess != 0) {
    aclrtSetDevice(dstDeviceId);
    aclrtDeviceEnablePeerAccess(srcDeviceId, 0);
}
```

For device memory used for inter-device copy, it is recommended to request it using the memory allocation policy with the P2P suffix in [memory management](02_memory_management.md#device-memory-page-policy), for example, **ACL_MEM_MALLOC_HUGE_FIRST_P2P**. For more examples of multi-device resource management and copy, see [Multi-Device Programming](05_multi_device_programming.md).

## 2D and Batch Copy

The 2D copy APIs **aclrtMemcpy2d** and **aclrtMemcpy2dAsync** apply to matrices, images, or 2D data with pitch. When calling them, you need to specify the address distance between two adjacent rows in the source and destination memory respectively, as well as the width and height of the area to be copied. When asynchronous 2D copy involves host memory, it also follows the rule that "only pinned host memory is truly asynchronous".

The batch copy APIs **aclrtMemcpyBatch**, **aclrtMemcpyBatchAsync**, and their V2 versions apply to dispatching multiple host-to-device or device-to-host copies at a time. Note the following for batch copy:

- The copy operations in a batch are not guaranteed to be executed in the order of the array.
- The destination address array, source address array, and copy size array of each copy operation must have the same length.
- The copy direction in the same batch supports only one of host-to-device or device-to-host copy.
- When the related APIs are experimental features, the product description and constraints in the API reference prevail.

## Memory Settings

**aclrtMemset** and **aclrtMemsetAsync** are used to initialize device memory. The synchronous API returns the result after the setting is complete; the asynchronous API dispatches the memory setting task to the specified stream. For device memory used as a synchronization flag or computation input, it is recommended to explicitly initialize it before use to avoid reading undefined data.
