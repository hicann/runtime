# 11. Memory Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:18:32.745Z pushedAt=2026-11-09T08:24:12.872Z nl=2 -->

This chapter describes the memory management APIs of CANN Runtime, covering device memory allocation, host memory management, memory copy, virtual memory, unified memory, cache operations, and IPC memory sharing.

## Memory Usage Notes

Each product model has some notes on memory usage, as shown below.

| Model | Notes |
| --- | --- |
| All models | - If media data processing is involved, because media data processing has higher requirements on the memory used to store input and output data, a dedicated memory allocation API must be called, for example, hi_mpi_dvpp_malloc.<br>  - The memory allocated by calling the dedicated memory allocation API can meet the requirements of media data processing and can also be used in other tasks. For example, from the performance perspective, to reduce copies, the output of media data processing is used as the input of model inference to implement memory reuse.<br>  - However, because the address space accessible to media data processing is limited, to ensure sufficient memory during media data processing, for functions other than media data processing (for example, model loading), it is recommended to call the APIs under [Memory Management](11_memory_management.md) to allocate memory, for example, the [aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc) API and the [aclrtMallocHost](11-02_host_memory_management.md#aclrtMallocHost) API. |
| Ascend 950PR&950DT products<br>Atlas A3 products<br>Atlas A2 products | - If huge-page memory on the device is requested, note that in the current version, the system reserves huge-page memory in advance to prevent it from running out. Before using huge-page memory, you can call the [aclrtGetMemInfo](11-01_device_memory_malloc_and_free.md#aclrtGetMemInfo) API to query the free huge-page memory.<br>  - In the Ascend EP form, when the device executes an inference or training task for the first time after startup, the system package is loaded onto the device, occupying part of the device memory (about 300 MB, varying with different AI processors). This memory is released only when the device is restarted. |

---

This category contains the following subcategories:

- [11-01 Device Memory Allocation and Deallocation](11-01_device_memory_malloc_and_free.md)
- [11-02 Host Memory Management](11-02_host_memory_management.md)
- [11-03 Memory Copy and Setup](11-03_memory_copy_and_set.md)
- [11-04 Virtual Memory Management](11-04_virtual_memory_management.md)
- [11-05 Unified Addressing](11-05_unified_addressing.md)
- [11-06 CMO Cache Operation](11-06_CMO_memory_operation.md)
- [11-07 IPC Inter-Process Memory Sharing](11-07_IPC_memory_sharing.md)
- [11-08 Custom Memory Allocator](11-08_custom_memory_allocator.md)
- [11-09 Stream Memory Operation](11-09_stream_memory_operation.md)
- [11-10 Ordered Stream Memory Allocation](11-10_ordered_stream_memory_allocation.md)
- [11-11 Device Variable Memory Operation](11-11_device_variable_memory_operation.md)
