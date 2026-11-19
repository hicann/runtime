# Page Table Alignment Requirements for Inter-Process IPC Memory Sharing

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:58:44.065Z pushedAt=2026-10-22T09:12:03.291Z -->

## Symptoms

**Symptom 1: An error is reported when IPC APIs are called, indicating that the page table is not aligned**

When using Runtime IPC APIs for inter-process memory sharing, calling `aclrtIpcMemGetExportKey` or `aclrtIpcMemImportByKey` reports an error, indicating that the shared memory page table is not aligned.

Example of the error code:

```cpp
// Process A: allocates memory and exports the IPC key.
void *ptrA = nullptr;
aclrtSetDevice(0);
aclrtMalloc(&ptrA, 1024);  // Allocate 1024 bytes of memory.

char key[65];
aclrtIpcMemGetExportKey(ptrA, 1024, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
// ✗ May fail: The memory page table is not aligned.
```

## Possible Causes

1. **Unaligned memory allocation**: When device memory is allocated through the `aclrtMalloc` API, for performance reasons, the memory may be carved out from a larger underlying memory block, resulting in a memory address that is not page-table-aligned.
2. **Page table alignment security check**: The IPC API checks whether the shared memory is page-table-aligned. If it is not, the API intercepts the request and reports an error to prevent information leakage caused by cross-process multi-mapping of memory.
3. **Different page table sizes for different memory types**: The page table size of normal page memory is 4 KB, while huge page memory supports page table sizes of 2 MB or 1 GB.

## Handling

**Solution 1: Use the memory allocation rules of the aclrtMalloc API**

Allocate memory according to the memory allocation rules to ensure page table alignment.

```cpp
// Correct example: use an appropriate memory allocation flag.
void *ptrA = nullptr;
aclrtSetDevice(0);

// For small memory (less than 2 MB), use normal page memory allocation.
aclrtMalloc(&ptrA, 4096, ACL_MEM_MALLOC_HUGE_FIRST);  // ✓ Allocate 4 KB-aligned memory.

char key[65];
aclrtIpcMemGetExportKey(ptrA, 4096, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);  // ✓ Success
```

**Solution 2: Allocate huge page memory to ensure alignment**

For scenarios that require huge page memory, use the huge page memory allocation flag.

```cpp
// Correct example: allocate huge page memory (2 MB or 1 GB aligned).
void *ptrA = nullptr;
aclrtSetDevice(0);

// Allocate 2 MB huge page memory.
size_t largePageSize = 2 * 1024 * 1024;  // 2 MB
aclrtMalloc(&ptrA, largePageSize, ACL_MEM_MALLOC_HUGE_ONLY);  // ✓ Force the use of huge page memory.

char key[65];
aclrtIpcMemGetExportKey(ptrA, largePageSize, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
```

**Solution 3: Use the VMM API to implement inter-process sharing**

If memory alignment cannot be guaranteed, you can use the Virtual Memory Management (VMM) API, which provides more flexible memory management and sharing capabilities.

```cpp
// Process A: use the VMM API.
const size_t dataSize = 1024 * sizeof(float);
aclrtPhysicalMemProp prop = {};
prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
prop.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
prop.location.id = 0;
prop.memAttr = ACL_HBM_MEM_NORMAL;

// Query the memory request granularity.
size_t granularity = 0UL;
aclrtMemGetAllocationGranularity(&prop, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);

// Request physical memory based on the memory request granularity (automatically aligned).
size_t alignedSize = ((dataSize + granularity - 1U) / granularity) * granularity;
aclrtDrvMemHandle handle = nullptr;
aclrtMallocPhysical(&handle, alignedSize, &prop, 0);

// Reserve virtual memory.
void *virPtr;
aclrtReserveMemAddress(&virPtr, alignedSize, 0, nullptr, 0);

// Map the virtual memory to the physical memory.
aclrtMapMem(virPtr, alignedSize, 0, handle, 0);

// Export the shared handle.
uint64_t shareableHandle = 0ULL;
aclrtMemExportToShareableHandle(handle, ACL_MEM_HANDLE_TYPE_NONE,
                                ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION, &shareableHandle);
```

**Solution 4: Check the memory alignment status**

Before exporting the IPC key, you can check the memory alignment status first.

```cpp
void *ptrA = nullptr;
aclrtSetDevice(0);
aclrtMalloc(&ptrA, size, ACL_MEM_MALLOC_HUGE_FIRST);

// Check whether the memory address is aligned (example: 4 KB alignment).
if ((uintptr_t)ptrA % 4096 != 0) {
    // The memory is not aligned. Adjust the allocation policy or use the VMM API.
    printf("Warning: Memory not page-aligned, consider using VMM interface\n");
    aclrtFree(ptrA);
    // Switch to the VMM solution or adjust the allocation size.
} else {
    char key[65];
    aclrtIpcMemGetExportKey(ptrA, size, key, 65, ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
}
```

## Related Issues

- [Issue #148: Stream Ordered Memory Allocation for IPC Memory Pool Sharing](https://gitcode.com/cann/runtime/issues/148)
