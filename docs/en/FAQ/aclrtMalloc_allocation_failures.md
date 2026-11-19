# Common Causes of the aclrtMalloc Memory Request Failure

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:52:31.796Z pushedAt=2026-10-23T07:17:30.979Z -->

## Symptoms

**Symptom 1: An error code indicating memory request failure is returned when the aclrtMalloc API is called to request the device memory**

When the **aclrtMalloc** API is called to request the device memory, error code 207001 (**ACL_ERROR_RT_MEMORY_ALLOCATION**) is returned, indicating that memory request failed.

Example of the error log:

```text
aclrtMalloc failed, ret = 207001, size=10485760
[ERROR] RUNTIME: Failed to allocate device memory, device_id=0, size=10485760
```

## Possible Causes

1. **Insufficient device memory or unreasonable size requested**: The device memory is heavily occupied, the requested size exceeds the total device memory capacity, or concurrent requests exceed the system resource limit, so the remaining capacity cannot meet the request.
2. **Improper memory allocation policy configuration**: A huge page policy (such as **ACL_MEM_MALLOC_HUGE_ONLY**) is forcibly used, but the huge page memory is insufficient.

## Handling

### Cause 1: Insufficient Device Memory or Unreasonable Size Requested

**Solution**:

- Check memory capacity: use the npu-smi tool to view the device memory usage.
- Free allocated memory: call **aclrtFree** to release memory that is no longer in use.
- Reduce the requested size: optimize the service logic to reduce the amount of memory requested at one time.
- Check the **size** parameter: confirm that the requested size is reasonable and does not exceed the total device memory capacity.
- Preallocate and reuse: preallocate a fixed memory pool during initialization and reuse it in the service logic.

Command example:

```bash
# View the device memory usage.
npu-smi info -t memory

# Output example:
# Device ID: 0
# HBM Total: 32GB
# HBM Used: 28GB
# HBM Free: 4GB
```

Example code:

```c
// Check the memory usage and then request memory properly.
void* devPtr = nullptr;
size_t size = 1024 * 1024;  // 1MB

// Release the memory that is no longer in use.
if (oldDevPtr != nullptr) {
    aclrtFree(oldDevPtr);
    oldDevPtr = nullptr;
}

// Request new memory.
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
```

### Cause 2: Improper Memory Allocation Policy Configuration

**Solution**:

- Understand the policy meanings:
  - **ACL_MEM_MALLOC_HUGE_FIRST**: Prefer huge pages, and fall back to normal pages when huge pages are insufficient (recommended).
  - **ACL_MEM_MALLOC_HUGE_ONLY**: Use huge pages only, and report an error when huge pages are insufficient.
  - **ACL_MEM_MALLOC_NORMAL_ONLY**: Use normal pages only.
- Select an appropriate policy: Choose one based on the actual memory capacity and performance requirements.
- Adjust the policy to **HUGE_FIRST**: Avoid request failures caused by forcing huge pages.

Policy selection recommendations:

```c
// Recommended policy: prefer huge pages, and fall back to normal pages when huge pages are insufficient.
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);

// Not recommended: use huge pages only, which fails when huge pages are insufficient.
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);  // May fail

// Normal page policy: suitable for small memory blocks or memory-constrained scenarios.
aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
```

## Related Issues

- [Issue #476: Constraints for Requesting Huge Page Memory in aclrtMallocPhysical](https://gitcode.com/cann/runtime/issues/476)
