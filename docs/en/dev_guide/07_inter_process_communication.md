# Inter-Process Communication

<!-- md-trans-meta sourceCommit=3b0457ee8efa5f40a7b80d475fb8c1e345f74156 translatedAt=2026-11-11T06:22:05.857Z pushedAt=2026-11-16T03:09:53.790Z nl=2 -->

Any device memory, event resource, or Notify resource created by a host thread can be directly referenced by other threads in the same process. However, these pointers or handles are invalid outside the process and therefore cannot be directly used by threads of other processes.

To share device memory, event resources, or Notify resources between processes, the application needs to use the inter-process communication APIs provided by Runtime to implement the following typical scenario: **a primary process generates a batch of input data and provides the data to multiple subordinate processes for use, without regenerating or copying the data in each process**. Different resources involve different Inter-Process Communication (IPC) APIs. For details, see the call examples below.

Note that when device memory is allocated through the **aclrtMalloc** API, it may be split from a larger underlying memory block for performance reasons. In this case, the IPC API checks whether the shared memory is page table aligned. If it is not aligned, the API intercepts the operation and reports an error to prevent information leakage caused by inter-process multi-mapped memory. Therefore, it is recommended to use the **aclrtMalloc** API to apply for memory according to the memory allocation rules. When applying for different types of memory, the page table sizes differ: the page table size of normal page memory is 4 KB, and the page table size of large page memory supports 2 MB or 1 GB.

## Inter-Process Memory Sharing

The following uses process A (memory lender) and process B (memory borrower) as an example to describe the memory sharing API call process between processes.

![](figures/inter_process_share_mem.png)

The following is example code for memory sharing between processes A and B. It cannot be directly copied, compiled, or run, and is for reference only.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
For the complete example code, see [Link](https://gitcode.com/cann/runtime/tree/master/example/1_basic_features/memory/11_ipc_memory_withoutpid).
<!-- end id1 -->

1. Allocate memory in process A and generate a shared key.

    **Note**: Process A must wait for process B to complete the import before closing the IPC sharing. If process A closes the sharing early, the import in process B will fail.

    ```c
    uint keyLen = 65;
    char key[keyLen];
    void *ptrA = nullptr;

    aclrtSetDevice(0);  // Process A uses Device 0.
    aclrtMalloc(&ptrA, size);

    aclrtIpcMemGetExportKey(ptrA, size, key, keyLen, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);

    // Exchange the key for inter-process communication (interact by writing to a file).
    writeFile("file/ipc_mem", key, keyLen);

    // Perform read and write operations on the shared memory.
    ......

    // After the shared memory is no longer needed, the lender closes the IPC shared memory.
    aclrtIpcMemClose(key);
    aclrtFree(ptrA);
    aclrtResetDeviceForce(0);
    ```

2. In process B, import the shared memory through the shared key.

    ```c
    uint keyLen = 65;
    char key[keyLen];
    void *ptrB;

    // Exchange the key for inter-process communication (interact by writing to a file).
    readFile("file/ipc_mem", key, keyLen);

    aclrtSetDevice(1);  // Process B uses Device 1.

    // Processes A and B use different devices. To import and access the shared memory, enable data exchange between the two devices.
    aclrtIpcMemImportByKey(&ptrB, key, ACL_RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS);

    // Read from and write to the ptrB memory.
    ......

    // After use, the borrower closes the IPC shared memory.
    aclrtIpcMemClose(key);
    aclrtResetDeviceForce(1);
    ```

## Inter-Process Event Sharing

Between processes, event synchronization can be achieved through shared events. Taking process A creating an event and sharing it with process B as an example, the following sample code illustrates task synchronization between two processes. It cannot be directly copied, compiled, and run, and is for reference only. For the complete example, see [Link](../../../example/2_advanced_features/ipcevent/0_ipcevent).

1. In process A, create an event and generate a shared handle.

    **Note:** Process A must wait for process B to complete the import before destroying the shared event. If process A destroys it early, the import in process B will fail.

    ```c
    aclrtEvent event;
    aclrtStream stream;
    aclrtIpcEventHandle handle;

    aclrtSetDevice(0);  // Process A uses Device 0.
    aclrtCreateEventExWithFlag(&event, ACL_EVENT_IPC);  // Create an IPC Event
    aclrtCreateStream(&stream);  // Create a stream.

    // Export the inter-process shared handle.
    aclrtIpcGetEventHandle(event, &handle);

    // Exchange the key for inter-process communication (interact by writing to a file).
    writeFile("file/ipc_event", handle, ACL_IPC_EVENT_HANDLE_SIZE);

    // Dispatch the record task.
    aclrtRecordEvent(event, stream);

    // After use, destroy the shared event.
    aclrtDestroyEvent(event);
    aclrtResetDeviceForce(0);
    ```

2. In process B, import the shared event through the shared handle.

    ```c
    aclrtStream stream;
    aclrtEvent event;
    aclrtIpcEventHandle handle;

    aclrtCreateStream(&stream);  // Create a stream.
    // Obtain the shared handle across processes (interact by writing to a file).
    readFile("file/ipc_event", handle, ACL_IPC_EVENT_HANDLE_SIZE);

    aclrtSetDevice(1);  // Process B uses Device 1.

    // Import the handle and return the shared event.
    // Processes A and B use different devices.
    aclrtIpcOpenEventHandle(handle, &event);

    // Dispatch a wait task.
    aclrtStreamWaitEvent(stream, event);

    // Synchronize the tasks on the stream.
    aclrtSynchronizeStream(stream);

    // After use, destroy the shared event.
    aclrtDestroyEvent(event);
    aclrtResetDeviceForce(1);
    ```

## Inter-Process Notify Sharing

Through shared Notify, you can implement inter-process notification. Here with process A creating a Notify and sharing it with process B as an example, the following is example code for task synchronization between the two processes. It cannot be directly copied, compiled, or run, and is for reference only.

<!-- npu="950,A3,910b,910,310p,310b" id2 -->
For the complete example code, see [Link](https://gitcode.com/cann/runtime/tree/master/example/2_advanced_features/notify/1_ipc_notify_withoutpid).
<!-- end id2 -->

Note: The creation end allocates Notify hardware resources, so wait can only be performed by the hardware of the creation end. Therefore, shared Notify has a usage constraint: **aclrtWaitAndResetNotify** can only be called on the creation end to perform wait, and cannot be called on the sharing end.

1. In process A, create a Notify and generate a shared key.

    **Note**: Process A must wait until process B completes the import before destroying the shared Notify. If process A destroys it early, the import in process B will fail.

    ```c
    uint keyLen = 65;
    char key[keyLen];
    aclrtNotify notify;
    aclrtStream stream;

    // Process A uses Device 0.
    aclrtSetDevice(0);
    aclrtCreateStream(&stream);

    aclrtCreateNotify(&notify, 0);
    // Export the key (that is, the Notify shared name).
    aclrtNotifyGetExportKey(notify, key, keyLen, ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION);
    // Exchange the key for inter-process communication (interact by writing a file).
    writeFile("file/ipc_notify", key, keyLen);

    // Dispatch the wait task.
    aclrtWaitAndResetNotify(notify, stream, 0);

    // After use, destroy the shared Notify.
    aclrtDestroyNotify(notify);
    aclrtResetDeviceForce(0);
    ```

2. In process B, import the shared Notify through the shared key.

    ```c
    uint keyLen = 65;
    char key[keyLen];
    aclrtNotify notify;
    aclrtStream stream;

    // Exchange the key for inter-process communication (interact by writing to a file).
    readFile("file/ipc_notify", key, keyLen);

    // Process B uses Device 1.
    aclrtSetDevice(1);
    aclrtCreateStream(&stream);

    // Import the key and return the shared Notify.
    // Processes A and B use different devices. To import the shared Notify, enable data exchange between the two devices.
    aclrtNotifyImportByKey(&notify, key, ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS);

    // Dispatch the record task.
    aclrtRecordNotify(notify, stream);

    // After use, destroy the shared Notify.
    aclrtDestroyNotify(notify);
    aclrtResetDeviceForce(1);
    ```

## Inter-Process Memory Sharing Through VMM APIs

In addition to memory sharing by IPC Mem, Runtime provides another set of memory management and memory sharing APIs. The Virtual Memory Management (VMM) APIs offer more flexible capabilities, supporting virtual address request, physical memory request, and inter-process physical memory sharing, as well as mapping between virtual addresses and physical memory.

Here with processes A and B as an example, the following is example code for physical memory sharing between two processes on one device. It cannot be directly copied, compiled, or run, and is for reference only. If processes A and B use different devices, you also need to call **aclrtDeviceEnablePeerAccess** to enable cross-device data exchange. For details, see [Data Exchange Across Devices](05_multi_device_programming.md#data-exchange-across-devices).

<!-- npu="950,A3,910b,910,310p,310b" id3 -->
For the complete example code, see [Link](https://gitcode.com/cann/runtime/tree/master/example/1_basic_features/memory/8_physical_memory_sharing_withoutpid).
<!-- end id3 -->

1. In process A:

    **Note**: Process A must wait until process B completes the import before destroying the physical memory handle. If process A destroys it early, the import in process B will fail.

    ```c
    // Query the memory request granularity.
    const size_t dataSize = 1024 * sizeof(float);
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;
    prop.memAttr = ACL_HBM_MEM_NORMAL;
    size_t granularity = 0UL;
    aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);

    // Request physical memory based on the memory request granularity.
    size_t alignedSize = ((dataSize + granularity - 1U) / granularity) * granularity;
    aclrtDrvMemHandle handle = nullptr;
    aclrtMallocPhysical(&handle, alignedSize, &prop, 0);

    // Reserve virtual memory.
    void *virPtr;
    aclrtReserveMemAddress(&virPtr, alignedSize, 0, nullptr, 0);

    // Map the virtual memory to the physical memory.
    aclrtMapMem(virPtr, alignedSize, 0, handle, 0);
    aclrtMemAccessDesc desc = {};
    desc.flags = ACL_RT_MEM_ACCESS_FLAGS_READWRITE;
    desc.location.id = 0;
    desc.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    aclrtMemSetAccess(virPtr, alignedSize, &desc, 1);

    // Import the shared handle.
    uint64_t shareableHandle = 0ULL;
    aclrtMemExportToShareableHandle(handle, ACL_MEM_HANDLE_TYPE_NONE, ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION , &shareableHandle);

    // Pass the shared handle to process B.
    writeFile("file/vmm_mem", shareableHandle, sizeof(shareableHandle));

    // Use virPtr to perform copy, read, write, and other operations.
    ......

    // Unmap the virtual memory from the physical memory.
    aclrtUnmapMem(virPtr);
    // After the peer process finishes using them, release the virtual memory and physical memory.
    aclrtReleaseMemAddress(virPtr);
    aclrtFreePhysical(handle);
    ```

2. In process B:

    ```c
    uint64_t shareableHandle = 0ULL;
    // Obtain the shared handle from the file.
    readFile("file/vmm_mem", &shareableHandle, sizeof(shareableHandle));

    aclrtDrvMemHandle handle = nullptr;
    int32_t deviceId=0;
    aclrtMemImportFromShareableHandle(shareableHandle, deviceId, &handle);
    // Query the memory request granularity.
    const size_t data_size = 1024 * sizeof(float);
    aclrtPhysicalMemProp prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    prop.location.id = 0;
    prop.memAttr = ACL_HBM_MEM_NORMAL;
    size_t granularity = 0UL;
    aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    size_t alignedSize = ((data_size + granularity - 1U) / granularity) * granularity;

    // Reserve virtual memory based on the memory request granularity.
    void *virPtr = nullptr;
    aclrtReserveMemAddress(&virPtr, alignedSize, 0, nullptr, 0);
    // Map the virtual memory to the physical memory.
    aclrtMapMem(virPtr, alignedSize, 0, handle, 0);
    aclrtMemAccessDesc desc = {};
    desc.flags = ACL_RT_MEM_ACCESS_FLAGS_READWRITE;
    desc.location.id = 0;
    desc.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    aclrtMemSetAccess(virPtr,alignedSize, &desc, 1);

    // Use virPtr to perform copy, read, and write operations.
    ......

    // Unmap the virtual memory from the physical memory.
    aclrtUnmapMem(virPtr);
    // Release the virtual memory and physical memory.
    aclrtReleaseMemAddress(virPtr);
    aclrtFreePhysical(handle);
    ```
