# How to Select an Appropriate Memory Allocation Policy

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T10:05:06.148Z pushedAt=2026-10-23T06:32:39.177Z -->

## Symptoms

**Symptom 1: Poor memory allocation performance**

Memory allocation is slow and access performance is low because the selected page type does not suit the service scenario.

Typical scenario example:

```c
// Configure the HUGE_ONLY policy for a small memory block, which actually occupies far more than required.
aclrtMalloc(&devPtr, 1024, ACL_MEM_MALLOC_HUGE_ONLY);  // Actually occupies 2 MB (aligned to a huge page)
```

**Symptom 2: Memory request failure**

Memory requesting fails after a specific policy is configured, for example, when huge pages are forcibly used but huge page memory is insufficient.

**Symptom 3: Poor performance in P2P scenarios**

In cross-device copy scenarios, the normal policy is used instead of the P2P policy, resulting in poor performance.

## Possible Causes

1. **Improper selection between normal pages and huge pages**: The performance feature and capacity usage differences between normal pages and huge pages are not understood.
2. **P2P policy not used in P2P scenarios**: The normal policy is used in cross-device copy scenarios, resulting in poor performance.
3. **Frequent memory request and release**: Memory is not pre-allocated and reused, resulting in performance loss.

## Handling

### Cause 1: Improper Selection Between Normal Pages and Huge Pages

**Solution**:

- Understand the features of page types:
  - **Normal pages (4 KB)**: suitable for small, short-lived, and numerous memory requests, reducing alignment waste.
  - **2-MB huge pages**: suitable for large, long-resident, and frequently accessed memory, reducing page table entries and expanding TLB coverage.
  - **1-GB huge pages**: suitable for very large, long-resident, and performance-sensitive memory (supported by some products).
- Select a strategy based on data size:
  - ≤ 1 MB: use **ACL_MEM_MALLOC_NORMAL_ONLY** or **HUGE_FIRST** (automatically falled back to normal pages).
  - >1 MB: use **ACL_MEM_MALLOC_HUGE_FIRST** (huge pages preferred).
- Understand the **HUGE_FIRST** mechanism: When the requested size is ≤ 1 MB, normal pages are used even if **HUGE_FIRST** is configured.

Policy selection examples:

```c
// Small memory block (≤ 1 MB): normal pages or HUGE_FIRST (automatic fallback)
size_t smallSize = 1024 * 100;  // 100 KB
aclrtMalloc(&ptr1, smallSize, ACL_MEM_MALLOC_NORMAL_ONLY);      // Normal page, occupying about 100 KB
aclrtMalloc(&ptr2, smallSize, ACL_MEM_MALLOC_HUGE_FIRST);       // Automatically uses a normal page

// Large memory block (> 1 MB): huge pages preferred
size_t largeSize = 1024 * 1024 * 10;  // 10 MB
aclrtMalloc(&ptr3, largeSize, ACL_MEM_MALLOC_HUGE_FIRST);       // Huge page, occupying about 10 MB (aligned to 2 MB)
aclrtMalloc(&ptr4, largeSize, ACL_MEM_MALLOC_HUGE_ONLY);        // Huge page only; an error is reported when insufficient

// Forced huge page scenario: strong dependency on huge page performance
aclrtMalloc(&ptr5, largeSize, ACL_MEM_MALLOC_HUGE_ONLY);        // An error is reported when huge pages are insufficient, exposing the problem as early as possible.
```

### Cause 2: No Corresponding Policy Used in P2P Scenarios

**Solution**:

- Understand P2P scenarios: cross-device data copy, where the memory must support cross-device access.
- Use P2P policies: select a policy with the P2P suffix (**HUGE_FIRST_P2P**, **HUGE_ONLY_P2P**, or **NORMAL_ONLY_P2P**)
- Match memory attributes to the access path: P2P Policies ensure that memory attributes match cross-device access.

Example of a P2P policy:

```c
// Cross-device copy scenario
aclrtSetDevice(0);
aclrtDeviceEnablePeerAccess(1, 0);  // Enable P2P from Device 0 to 1.

aclrtSetDevice(1);
aclrtDeviceEnablePeerAccess(0, 0);  // Enable P2P from Device 1 to 0.

// Request memory for P2P on Device 0.
aclrtSetDevice(0);
void* dev0Mem = nullptr;
aclrtMalloc(&dev0Mem, size, ACL_MEM_MALLOC_HUGE_FIRST_P2P);  // P2P policy

// Request memory for P2P on Device 1.
aclrtSetDevice(1);
void* dev1Mem = nullptr;
aclrtMalloc(&dev1Mem, size, ACL_MEM_MALLOC_HUGE_FIRST_P2P);  // P2P policy

// Copy across devices.
aclrtMemcpy(dev1Mem, size, dev0Mem, size, ACL_MEMCPY_DEVICE_TO_DEVICE);
```

### Cause 3: Frequent Memory Request and Release

**Solution**:

- Memory pool pre-allocation: pre-allocate fixed-size memory during the initialization phase.
- Reuse on the service side: avoid frequent calls to **aclrtMalloc**/**aclrtFree**.
- Performance overhead reduction: pre-allocation and reuse can significantly improve performance.

Memory pool example:

```c
// Pre-allocate a memory pool during the initialization phase.
#define POOL_SIZE 10
#define MEMORY_BLOCK_SIZE (1024 * 1024)  // 1MB

void* memoryPool[POOL_SIZE];
bool memoryPoolUsed[POOL_SIZE] = {false};

void InitMemoryPool() {
    for (int i = 0; i < POOL_SIZE; i++) {
        aclrtMalloc(&memoryPool[i], MEMORY_BLOCK_SIZE, ACL_MEM_MALLOC_HUGE_FIRST);
        memoryPoolUsed[i] = false;
    }
}

// Request memory in the service (obtain it from the pool).
void* AllocateFromPool() {
    for (int i = 0; i < POOL_SIZE; i++) {
        if (!memoryPoolUsed[i]) {
            memoryPoolUsed[i] = true;
            return memoryPool[i];
        }
    }
    return nullptr;  // The pool is full.
}

// Release the memory in the service (return it to the pool).
void ReleaseToPool(void* ptr) {
    for (int i = 0; i < POOL_SIZE; i++) {
        if (memoryPool[i] == ptr) {
            memoryPoolUsed[i] = false;
            return;
        }
    }
}

// Release the pool in the cleanup phase.
void CleanupMemoryPool() {
    for (int i = 0; i < POOL_SIZE; i++) {
        if (memoryPool[i] != nullptr) {
            aclrtFree(memoryPool[i]);
        }
    }
}
```

## Related Issues

- [Issue #476: Huge Page Memory Request Limit of aclrtMallocPhysical](https://gitcode.com/cann/runtime/issues/476)
