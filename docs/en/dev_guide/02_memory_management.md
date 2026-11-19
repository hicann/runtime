# Memory Management

<!-- md-trans-meta sourceCommit=c984fae7c73f88f7e9e16b034bea72bc18e7517c translatedAt=2026-10-16T10:09:00.788Z pushedAt=2026-10-19T07:24:50.127Z -->

## Overview

In the Ascend heterogeneous computation architecture, the system consists of a host and a device. The host and the device each have independent memory. Host memory refers to the host memory (that is, CPU memory) of the server where the AI processor resides, while device memory refers to the device memory built into the AI processor.

Two things must be done well in memory management:

1. **Memory accessibility:** Runtime provides a set of memory management APIs, allowing you to write memory management code in applications efficiently and conveniently. Because host memory and device memory are independent of each other, Runtime provides dedicated APIs to request and release host memory and device memory separately. For example, the APIs for requesting and releasing host memory are **aclrtMallocHost** and **aclrtFreeHost**, while the APIs for requesting and releasing device memory are **aclrtMalloc** and **aclrtFree**.
2. **Efficient memory access:** To achieve optimal memory access performance, data must be stored in the corresponding memory. For example, when an operator runs on the device, the performance of accessing data on the device is far higher than that of accessing data on the host. For data transfer between the host and the device and between devices, see [Data Copy](02-01_data_copy.md).

## Device Memory Usage

In Ascend heterogeneous computation programming, a typical usage scenario is as follows: Host memory is requested through the **aclrtMallocHost** API, device memory is requested through the **aclrtMalloc** API, data is copied from the host to the device through the memory copy API, and the device memory is used for computation and result storage during operator execution.

The following is a simple example. In the example, two tensors are copied from the host memory to the device memory, computation is completed on the device, and the result is then copied from the device memory back to the host memory:

```c
int main(void)
{
    int32_t deviceId = 0;
    int64_t N = 16;
    const size_t bytes = static_cast<size_t>(N) * sizeof(float);
    aclrtStream stream = nullptr;

    // Step 1: Perform initialization and create a stream.
    aclInit(nullptr);
    aclrtSetDevice(deviceId);
    aclrtCreateStream(&stream);

    // Step 2: Request host memory.
    void* hostA = nullptr;
    void* hostB = nullptr;
    void* hostOut = nullptr;

    aclrtMallocHost(&hostA, bytes);
    aclrtMallocHost(&hostB, bytes);
    aclrtMallocHost(&hostOut, bytes);

    // Initialize the input data.
    ...

    // STEP 3: Request Device memory
    void* deviceA = nullptr;
    void* deviceB = nullptr;
    void* deviceOut = nullptr;

    // The third parameter aclrtMemMallocPolicy indicates the memory page allocation policy used when requesting memory.
    // ACL_MEM_MALLOC_HUGE_FIRST indicates that large page memory is preferred. For other definitions, see the API documentation.
    aclrtMalloc(&deviceA, bytes, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&deviceB, bytes, ACL_MEM_MALLOC_HUGE_FIRST);
    aclrtMalloc(&deviceOut, bytes, ACL_MEM_MALLOC_HUGE_FIRST);

    // Step 4: Transfer the input data from the host memory to the device memory.
    aclrtMemcpy(deviceA, bytes, hostA, bytes, ACL_MEMCPY_HOST_TO_DEVICE);
    aclrtMemcpy(deviceB, bytes, hostB, bytes, ACL_MEMCPY_HOST_TO_DEVICE);

    // Step 5: Execute computation, for example, aclnnAdd, and store the result in the device memory.
    // ...

    // Step 6: Transfer the computation result from the device memory to the host memory.
    aclrtMemcpy(hostOut, bytes, deviceOut, bytes, ACL_MEMCPY_DEVICE_TO_HOST);

    // Step 7: Process the computation result on the host.
    // ...

    // Step 8: Clean up resources.
    // Step 8.1: Release the host memory and device memory.
    if (deviceA) (void)aclrtFree(deviceA);
    if (deviceB) (void)aclrtFree(deviceB);
    if (deviceOut) (void)aclrtFree(deviceOut);
    if (hostA) (void)aclrtFreeHost(hostA);
    if (hostB) (void)aclrtFreeHost(hostB);
    if (hostOut) (void)aclrtFreeHost(hostOut);

    // Step 8.2: Clean up the device and process resources.
    if (stream) (void)aclrtDestroyStream(stream);
    (void)aclrtResetDevice(deviceId);
    (void)aclFinalize();

    return 0;
}
```

## Device Memory Page Policy

When calling APIs such as **aclrtMalloc** and **aclrtMallocWithCfg** to request device memory, you need to specify the memory allocation policy through the **aclrtMemMallocPolicy** parameter. This policy mainly addresses two types of issues: whether to use normal pages or large pages, and how to balance performance priority, capacity utilization, and handling of request failures.

The differences between normal pages and large pages are as follows:

- **Normal pages**: Also called small pages, the page table granularity is usually processed at 4 KB. They are suitable for small, short-lived, or numerous memory requests. Normal pages can reduce the space waste caused by large page alignment, and memory fragmentation pressure is easier to control.
- **2-MB large pages**: The memory request granularity is 2 MB, and sizes that are not multiples of 2 MB are aligned upward to 2 MB. Large pages can reduce the number of page table entries and expand the TLB coverage, making them suitable for large, long-lived, frequently accessed device memory such as input, output, and workspace.
- **1-GB large pages**: The memory request granularity is 1 GB, and only some products support it. Compared with 2-MB large pages, 1-GB large pages can further reduce the number of page table entries. For example, 1 GB of memory requires 512 page table entries with 2-MB large pages, but only 1 page table entry with 1-GB large pages. This policy is suitable for very large, long-lived memory that is sensitive to access performance, but it brings more obvious capacity occupation and alignment waste.

The design philosophy of **aclrtMemMallocPolicy** is to express "page size", "fallback policy", and "access topology" separately:

- **Priority or mandatory**: **ACL_MEM_MALLOC_HUGE_FIRST** indicates large page priority, and falls back to normal pages when large pages cannot be requested. **ACL_MEM_MALLOC_HUGE_ONLY** indicates that only large pages are requested, and an error is reported if they cannot be requested. **ACL_MEM_MALLOC_NORMAL_ONLY** indicates that only normal pages are requested.
- **Default balance between performance and capacity**: **ACL_MEM_MALLOC_HUGE_FIRST** is suitable for most large blocks of device memory. When the requested size is less than or equal to 1 MB, Runtime requests normal pages even if this policy is configured; when the requested size is greater than 1 MB, Runtime prioritizes 2-MB large pages and falls back to normal pages when large pages are insufficient. This design prevents small memory from over-occupying large pages while allowing large blocks of data to achieve better TLB hit performance.
- **Cross-device transfer**: Policies with the P2P suffix are used for memory copy scenarios between two devices, such as **ACL_MEM_MALLOC_HUGE_FIRST_P2P**, **ACL_MEM_MALLOC_HUGE_ONLY_P2P**, and **ACL_MEM_MALLOC_NORMAL_ONLY_P2P**. If the memory is mainly used for inter-device copy, select the P2P policy so that the memory attributes match the access path.
- **Large-page granularity selection**: **ACL_MEM_MALLOC_HUGE_ONLY** uses 2-MB large pages; **ACL_MEM_MALLOC_HUGE1G_ONLY** uses 1-GB large pages. 1-GB large pages focus more on high-capacity contiguous access performance, while 2-MB large pages strike a better balance between performance and capacity usage.
- **Bandwidth type prompt**: **ACL_MEM_TYPE_LOW_BAND_WIDTH** and **ACL_MEM_TYPE_HIGH_BAND_WIDTH** can be combined with some page policies using bitwise OR, but the system ultimately selects an appropriate physical memory type based on hardware support. When not explicitly required, they generally do not need to be configured separately.

The usage recommendations are as follows:

- For most common computation inputs, outputs, and workspaces, use **ACL_MEM_MALLOC_HUGE_FIRST** first.
- For a large number of small memory blocks, temporary memory, or when alignment waste needs to be reduced, use **ACL_MEM_MALLOC_NORMAL_ONLY**.
- When there is a strong dependency on large page performance and you want resource shortages to be exposed as early as possible, use **ACL_MEM_MALLOC_HUGE_ONLY** or **ACL_MEM_MALLOC_HUGE1G_ONLY**.
- In cross-device copy scenarios, prefer policies with the P2P suffix.
- Frequently calling **aclrtMalloc**/**aclrtFree** affects performance. For memory of a fixed size or a predictable size, it is recommended to preallocate it during the initialization phase and reuse it on the service side.

## Host Page-Locked Memory Usage 

In the CANN programming framework, host memory can be **pageable memory** or **page-locked memory** (also called pinned memory):

- **Pageable memory** is managed by the operating system. You can use traditional APIs such as **malloc** and **mmap** to request memory, and use APIs such as **free** and **munmap** to release memory. When memory pressure is high, pageable memory is swapped out to the swap space provided by the backing store. When data in pageable memory is transferred to the device, the data is first copied to a buffer and then transferred to the device through a Direct Memory Access (DMA) channel.
- **Page-locked memory**, that is, pinned memory. You need to use the APIs provided by Runtime to request and release pinned memory, such as **aclrtMallocHost** and **aclrtFreeHost**. For pinned memory, the mapping between virtual pages and physical pages is fixed, and it is not swapped out to the swap space during its lifecycle. When data in pinned memory is transferred to the device, it is transferred directly through the DMA channel without passing through a buffer, delivering better transfer performance.

    In Runtime, **the benefits of using pinned memory are as follows**:

    - The device can directly access host memory through DMA without passing through a buffer, delivering better transfer performance.
    - The data transfer process does not require CPU involvement, enabling asynchronous data transfer.
    - Asynchronous data transfer allows the transfer process and the computation process to overlap with each other, reducing the total time of transfer plus computation.

Pinned memory can be requested directly through the **aclrtMallocHost** API. The following is an example. If you need to specify other memory configurations when requesting memory, such as a custom module ID or virtual address (VA) consistency, you can also use the **aclrtMallocHostWithCfg** API.

```c
// Initialize resources.
......

// Request pinned memory.
void *hostPtr = NULL;
aclrtMallocHost(&hostPtr, size);

// Request device memory.
void *devicePtr = NULL;
aclrtMalloc(&devicePtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);

// Initialize memory.
......

// Perform asynchronous H2D.
aclrtMemcpyAsync(devicePtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);

// Wait for the asynchronous copy to complete.
aclrtSynchronizeStream(stream);

// Release resources.
if (devicePtr) (void)aclrtFree(devicePtr);
if (hostPtr) (void)aclrtFreeHost(hostPtr);
......
```

If pageable memory is requested through memory management APIs such as **malloc**/**mmap**, Runtime provides the **aclrtHostRegisterV2** API to convert pageable memory into pinned memory for device access. Note that when the OS kernel version is 5.10 or earlier, this method causes exceptions. In this case, request pinned memory through the **aclrtMallocHost** API instead.

```c
// Request pageable memory.
void *hostPtr = malloc(size);

// Register as pinned memory (ACL_HOST_REG_PINNED) and map to the device (ACL_HOST_REG_MAPPED).
aclrtHostRegisterV2(hostPtr, size, ACL_HOST_REG_PINNED|ACL_HOST_REG_MAPPED);

// Obtain the device address.
void *devicePtr = NULL;
aclrtHostGetDevicePointer(hostPtr, &devicePtr, 0);

// The task accesses the corresponding memory through the device address.
...

// Release resources.
aclrtHostUnregister(hostPtr);
free(hostPtr);
```

If the VA consistency of host memory is involved:

- Host memory can be registered to the device through the **aclrtHostRegister** API, and the device pointer is obtained by mapping the host pointer for use by the device. By default, for the same block of host memory, the VAs seen by the host and the device are different.
- If the VAs of the host and the device need to remain consistent, you can use the **aclrtMallocHostWithCfg** API to request pinned memory and specify the **ACL\_RT\_MEM\_ATTR\_VA\_FLAG** attribute in the **aclrtMallocConfig** parameter. The device virtual address obtained through subsequent registration will then be consistent with the host virtual address.

## Virtual Memory Management

Runtime provides a set of virtual memory management APIs that allow you to manage memory in a more fine-grained manner. For example, a large block of contiguous virtual memory can be requested in advance to simplify subsequent management; physical memory can also be requested on demand during use and mapped to virtual memory, which enables both fine-grained memory management and maximum utilization of physical memory. In addition, physical memory can be shared between processes by using the handle in virtual memory management.

The following is a basic example of using virtual memory. After the physical memory and virtual memory are requested, they are mapped by calling the **aclrtMapMem** API, and the corresponding data can then be accessed through the virtual address:

```c
void SampleTest()
{
    // 1. Query the memory request granularity and align size.
    // Set the attributes of the physical memory to be requested.
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;            // Handle type. Currently, only ACL_MEM_HANDLE_TYPE_NONE is supported.
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;  // Memory allocation type. Currently, only pinned memory allocation is supported.
    prop.memAttr = ACL_HBM_MEM_NORMAL;                     // Memory attribute. HBM memory is requested here.
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;     // Memory location. Device memory is requested here, with deviceId set to 0.
    prop.location.id = 0;
    // Query the minimum memory request granularity.
    size_t granularity = 0UL;
    aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    // Align the memory based on the found memory request granularity to save memory.
    const size_t dataSize = 1024 * sizeof(float);
    size_t alignedSize =  ((dataSize + granularity - 1U) / granularity) * granularity;

    // 2. Request physical memory.
    // Obtain the handle that stores the physical memory information for subsequent virtual memory usage. Note that the handle cannot be directly accessed as a virtual address.
    aclrtDrvMemHandle handle = nullptr;
    aclrtMallocPhysical(&handle, alignedSize, &prop, 0);  // The last flag parameter is set to 0 by default.

    // 3. Reserve virtual memory.
    void *virPtr;
    // virPtr indicates the reserved virtual address pointer, and alignedSize indicates the size of the reserved memory.
    aclrtReserveMemAddress(&virPtr, alignedSize, 0, nullptr, 0);

    // 4. Map the virtual memory to the physical memory.
    // Associate the handle obtained during physical memory request with the reserved virtual address space.
    // Note that the mapped memory size alignedSize must be the same as the size set during physical memory request.
    aclrtMapMem(virPtr, alignedSize, 0, handle, 0);

    // 5. Set the virtual memory access permission.
    aclrtMemAccessDesc accessDesc = {};
    accessDesc.flags = ACL_RT_MEM_ACCESS_FLAGS_READWRITE;
    accessDesc.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    accessDesc.location.id = 0;
    aclrtMemSetAccess(virPtr, alignedSize, &accessDesc, 1);

    // 6. Access the memory.
    // The following uses a device-to-host memory copy as an example to show normal access to the mapped memory address.
    int *hostPtr;
    aclrtMallocHost(reinterpret_cast<void**>(&hostPtr), alignedSize);
    aclrtMemcpy(hostPtr, alignedSize, virPtr, alignedSize, ACL_MEMCPY_DEVICE_TO_HOST);
    aclrtFreeHost(hostPtr);

    // 7. Unmap the virtual memory from the physical memory.
    aclrtUnmapMem(virPtr);

    // 8. Release the virtual memory.
    aclrtReleaseMemAddress(virPtr);

    // 9. Release the physical memory.
    aclrtFreePhysical(handle);
}
```
