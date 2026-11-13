# 11-05 Unified Addressing

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-26T13:42:56.490Z pushedAt=2026-10-28T07:39:44.291Z -->

This topic describes the unified/managed memory APIs, which are used for memory allocation with automatic migration, prefetching, and attribute querying.

- [`aclError aclrtMemAllocManaged(void **ptr, uint64_t size, uint32_t flag)`](#aclrtMemAllocManaged): Requests Unified Virtual Memory (UVM) and returns the pointer to the requested memory through **\*ptr**. The requested memory size is rounded up to 2 MB alignment based on the user-specified size.
- [`aclError aclrtMemManagedAdvise(const void *const ptr, uint64_t size, aclrtMemManagedAdviseType advise, aclrtMemManagedLocation location)`](#aclrtMemManagedAdvise): Manages the policy attribute of UVM, supporting both setting and unsetting the policy attribute.
- [`aclError aclrtMemManagedGetAttr(aclrtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)`](#aclrtMemManagedGetAttr): Obtains the policy attribute value of UVM of a specified size.
- [`aclError aclrtMemManagedGetAttrs(aclrtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, size_t size, void **data, size_t *dataSizes)`](#aclrtMemManagedGetAttrs): Obtains the policy attribute values of UVM of a specified size.
- [`aclError aclrtMemManagedPrefetchAsync(const void* ptr, size_t size, aclrtMemManagedLocation location, uint32_t flags, aclrtStream stream)`](#aclrtMemManagedPrefetchAsync): Manages the prefetching of UVM.
- [`aclError aclrtMemManagedPrefetchBatchAsync(const void** ptrs, size_t* sizes, size_t count, aclrtMemManagedLocation* prefetchLocs, size_t* prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags, aclrtStream stream)`](#aclrtMemManagedPrefetchBatchAsync): Manages the batch prefetching of UVM.
- [`aclError aclrtMemP2PMap(void *devPtr, size_t size, int32_t dstDevId, uint64_t flags)`](#aclrtMemP2PMap): Establishes a memory page table mapping between two devices within the same process to enable cross-device memory access. Before performing this operation, call [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess) to enable data interaction between the two devices.
- [`aclError aclrtPointerGetAttributes(const void *ptr, aclrtPtrAttributes *attributes)`](#aclrtPointerGetAttributes): Obtains memory attribute information, including whether the memory resides on the host or device, the page table size, and other information.

<a class="method_anchor" id="aclrtMemAllocManaged"></a>

## aclrtMemAllocManaged

```c
aclError aclrtMemAllocManaged(void **ptr, uint64_t size, uint32_t flag)
```

**Caution: This API is a reserved API and is not supported yet.**

### Description

Requests Unified Virtual Memory (UVM) and returns the pointer to the requested memory through **\*ptr**. The requested memory size is rounded up to 2 MB alignment based on the user-specified size. To release the memory requested by this API, call the [aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree) API.

The memory requested by this API establishes the page table mapping from virtual memory to physical memory only when it is actually accessed. If the memory access occurs on the host, the host physical memory is mapped; if the memory access occurs on the device, the device physical memory is mapped. When the memory is subsequently used, each time the object accessing the memory changes, for example, from the host to a device, or from one device to another, a page fault is triggered on the new access object. The memory data must then be migrated to the new access object, and the page table mapping from virtual memory to physical memory must be re-established. At this point, the page table mapping on the previous access object becomes invalid and its physical memory is released. If the access object is changed frequently, page faults are triggered frequently, and memory data migration and page table mapping re-establishment occur frequently, which affects performance. To reduce the performance overhead caused by this situation, Runtime also provides the [aclrtMemManagedAdvise](#aclrtMemManagedAdvise) API to set the memory management policy.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Output | Pointer to the pointer to the requested memory. Because the host and device virtual addresses are uniformly addressed, this parameter does not distinguish the request location. |
| size | Input | Memory size, in bytes.<br>**size** cannot be set to **0**. A single application process can request up to 3 TB of UVM. |
| flag | Input | Memory flag.<br>Currently, **flag** can only be set to **ACL_RT_MEM_ATTACH_GLOBAL**, whose corresponding value is **1**. After **ACL_RT_MEM_ATTACH_GLOBAL** is set, the memory requested by this API can be accessed on both the device and host sides.<br>The macro is defined as follows:<br>#define ACL_RT_MEM_ATTACH_GLOBAL (0x01U) |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The memory allocated by this API is not initialized. It is recommended that you call the [aclrtMemset](11-03_memory_copy_and_set.md#aclrtMemset) API to initialize the memory before using it, so as to clear the random data in the memory.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemManagedAdvise"></a>

## aclrtMemManagedAdvise

```c
aclError aclrtMemManagedAdvise(const void *const ptr, uint64_t size, aclrtMemManagedAdviseType advise, aclrtMemManagedLocation location)
```

**Caution: This API is a reserved API and is not supported yet.**

### Description

Manages the policy attribute of UVM, supporting both setting and unsetting the policy attribute.

The memory operated by this API must be memory requested through the [aclrtMemAllocManaged](#aclrtMemAllocManaged) API. The set policy attribute values can be obtained using the [aclrtMemManagedGetAttr](#aclrtMemManagedGetAttr) and [aclrtMemManagedGetAttrs](#aclrtMemManagedGetAttrs) APIs.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Memory address for which the attribute is to be set. The address range must be within the UVM range, that is, [0x90000000000ULL, 0x90000000000ULL + 3TB). |
| size | Input | Memory size, in bytes, which must be 2MB-aligned. The value range is (0, 3TB]. |
| advise | Input | Memory policy attribute.<br>For details about the type definition, see [aclrtMemManagedAdviseType](25-02_Enumerations.md#aclrtMemManagedAdviseType). |
| location | Input | Location information of the physical memory. The **location** parameter contains two members: **id** and **type**.<br>For details about the type definition, see [aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemManagedGetAttr"></a>

## aclrtMemManagedGetAttr

```c
aclError aclrtMemManagedGetAttr(aclrtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)
```

**Caution: This API is a reserved API and is not supported yet.**

### Description

Obtains the policy attribute value of UVM of a specified size.

The memory operated by this API must be requested through the [aclrtMemAllocManaged](#aclrtMemAllocManaged) API. If the policy attribute values within the queried memory range are inconsistent, the query result is an invalid value.

Unlike the [aclrtMemManagedGetAttrs](#aclrtMemManagedGetAttrs) API, this API supports querying the value of only one memory policy attribute at a time.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| attribute | Input | Attribute to query. For details about the type definition, see [aclrtMemManagedRangeAttribute](25-02_Enumerations.md#aclrtMemManagedRangeAttribute). |
| ptr | Input | Start address of the memory whose attribute is to be queried. The range must be within the UVM range, that is, [0x90000000000ULL, 0x90000000000ULL + 3TB). |
| size | Input | Memory size of the attribute to be queried, in bytes. The value range is (0, 3TB]. |
| data | Output | Query result. |
| dataSize | Input | Memory size for storing the query result, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemManagedGetAttrs"></a>

## aclrtMemManagedGetAttrs

```c
aclError aclrtMemManagedGetAttrs(aclrtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, size_t size, void **data, size_t *dataSizes)
```

**Caution: This API is a reserved API and is not supported yet.**

### Description

Obtains the policy attribute values of UVM of a specified size.

The memory operated by this API must be requested through the [aclrtMemAllocManaged](#aclrtMemAllocManaged) API. If the policy attribute values within the queried memory range are inconsistent, the query result is an invalid value.

Unlike the [aclrtMemManagedGetAttr](#aclrtMemManagedGetAttr) API, this API supports querying the values of multiple memory policy attributes at a time.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| attributes | Input | Attribute array to be queried. For details about the type definition, see [aclrtMemManagedRangeAttribute](25-02_Enumerations.md#aclrtMemManagedRangeAttribute). |
| numAttributes | Input | Size of the attribute array to be queried. |
| ptr | Input | Start address of the memory whose attributes are to be queried. The range must be within the UVM memory range, that is, [0x90000000000ULL, 0x90000000000ULL + 3TB). |
| size | Input | Memory size of the attributes to be queried, in bytes. The value range is (0, 3TB]. |
| data | Output | Array of query results. |
| dataSizes | Input | Memory size for storing the query result array, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemManagedPrefetchAsync"></a>

## aclrtMemManagedPrefetchAsync

```c
aclError aclrtMemManagedPrefetchAsync(const void* ptr, size_t size, aclrtMemManagedLocation location, uint32_t flags, aclrtStream stream)
```

**Caution: This API is a reserved API and is not supported yet.**

### Description

Manages the prefetching of UVM.

The memory operated by this API must be requested through [aclrtMemAllocManaged](#aclrtMemAllocManaged). This is an asynchronous API. Calling this API only indicates that the task has been successfully dispatched, not that the task has been successfully executed. After calling this API, call a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory prefetch task has been executed.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr      |   Input    | Memory address to be prefetched. The address range must be within the UVM range, that is, [0x90000000000ULL, 0x90000000000ULL + 3TB). |
| size     |   Input    | Length of the memory to be prefetched, in bytes, which must be 2MB-aligned. The value range is (0, 3TB]. |
| location |   Input    | Location information of the physical memory. The **location** parameter contains two members: **id** and **type**. For details about the type definition, see [aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation). |
| flags    |   Input    | Reserved parameter, which is currently fixed to **0**.                                  |
| stream   |   Input    | Stream on which the memory prefetch task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemManagedPrefetchBatchAsync"></a>

## aclrtMemManagedPrefetchBatchAsync

```c
aclError aclrtMemManagedPrefetchBatchAsync(const void** ptrs, size_t* sizes, size_t count, aclrtMemManagedLocation* prefetchLocs, size_t* prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags, aclrtStream stream)
```

**Caution: This API is a reserved API and is not supported yet.**

### Description

Manages the batch prefetching of UVM.

The memory operated by this API must be requested through the [aclrtMemAllocManaged](#aclrtMemAllocManaged) API. This is an asynchronous API. Calling this API only indicates that the task has been successfully dispatched, not that the task has been successfully executed. After calling this API, you need to call a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory prefetch task has been completed.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptrs            |   Input    | Array of memory addresses to be prefetched. Each address range must be within the UVM range, that is, [0x90000000000ULL, 0x90000000000ULL + 3TB). |
| sizes           |   Input    | Array of memory prefetch lengths, used to store the length of each UVM segment to be prefetched, in bytes. Each segment length must be 2MB-aligned, with a value range of (0, 3TB]. |
| count           |   Input    | Length of the **ptrs** and **sizes** arrays.                                        |
| prefetchLocs    |   Input    | Array of physical memory location information. Each location information contains two members: **id** and **type**. For details about the type definition, see [aclrtMemManagedLocation](25-04_Structs.md#aclrtMemManagedLocation). |
| prefetchLocIdxs |   Input    | Array of physical memory prefetch information indexes, used to specify the prefetch range applicable to each physical address in the **prefetchLocs** array. For the physical address specified by **prefetchLocs[k]**, the UVM addresses of the elements from index **prefetchLocIdxs[k]** to index **prefetchLocIdxs[k+1]**-1 in the **ptrs** array are prefetched. For the physical address specified by **prefetchLocs[numPrefetchLocs-1]**, the UVM addresses of the elements from index **prefetchLocIdxs[numPrefetchLocs-1]** to index **count**-1 in the **ptrs** array are prefetched. |
| numPrefetchLocs |   Input    | Length of the **prefetchLocs** and **prefetchLocIdxs** arrays.                    |
| flags           |   Input    | Reserved parameter, which is currently fixed to **0**.                                  |
| stream          |   Input    | Stream on which the memory prefetch task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The data specified in **ptrs** is prefetched to the physical memory area specified in **prefetchLocs**. The size of each prefetch operation is specified by **sizes**. The **ptrs** and **sizes** arrays must have the same length specified by **count**.
- In a prefetch batch operation, each entry in the **prefetchLocs** array can be applied to multiple prefetch operations. Specifically, the **prefetchLocIdxs** array specifies the starting UVM address index to be prefetched for the corresponding physical address region. The **prefetchLocs** and **prefetchLocIdxs** arrays must have the same length specified by **numPrefetchLocs**. For example, if a batch contains 10 prefetch operations listed in **ptrs**/**sizes**, of which the first 6 need to be prefetched to the same physical memory area and the last 4 need to be prefetched to another physical memory area, then the value of **numPrefetchLocs** is **2**, the value of **prefetchLocIdxs** is **\{0,6\}**, and **prefetchLocs** contains the location information of two groups of physical memory. Note that the first entry of **prefetchLocIdxs** must be 0, each entry must be greater than the previous entry, and the last entry must be less than **count**. In addition, **numPrefetchLocs** must be less than or equal to **count**.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemP2PMap"></a>

## aclrtMemP2PMap

```c
aclError aclrtMemP2PMap(void *devPtr, size_t size, int32_t dstDevId, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id2605 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2605 -->
<!-- npu="A3" id2606 -->
- Atlas A3 products: Supported
<!-- end id2606 -->
<!-- npu="910b" id2607 -->
- Atlas A2 products: Supported
<!-- end id2607 -->
<!-- npu="310b" id2608 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2608 -->
<!-- npu="310p" id2609 -->
- Atlas inference products: Supported
<!-- end id2609 -->
<!-- npu="910" id2610 -->
- Atlas training products: Supported
<!-- end id2610 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-05_unified_addressing_res.md#id7 -->

### Description

Establishes a memory page table mapping between two devices in the same process to enable cross-device memory access. Before performing this operation, call [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess) to enable data interaction between the two devices.

After the page table mapping is established by calling this API, no memory page fault occurs during cross-device access, and the performance is better on the first memory access.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Input | Device memory address (for example, the device memory requested by calling **aclrtMalloc**), which refers to the memory address of the shared memory provider. |
| size | Input | Memory size, in bytes. |
| dstDevId | Input | Device ID, which refers to the ID of the shared memory consumer. |
| flags | Input | Reserved parameter, which is currently fixed to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
<br>
<br>
<br>

<a class="method_anchor" id="aclrtPointerGetAttributes"></a>

## aclrtPointerGetAttributes

```c
aclError aclrtPointerGetAttributes(const void *ptr, aclrtPtrAttributes *attributes)
```

### Applicable Products

<!-- npu="950" id1709 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1709 -->
<!-- npu="A3" id1710 -->
- Atlas A3 products: Supported
<!-- end id1710 -->
<!-- npu="910b" id1711 -->
- Atlas A2 products: Supported
<!-- end id1711 -->
<!-- npu="310b" id1712 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1712 -->
<!-- npu="310p" id1713 -->
- Atlas inference products: Supported
<!-- end id1713 -->
<!-- npu="910" id1714 -->
- Atlas training products: Supported
<!-- end id1714 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-05_unified_addressing_res.md#id8 -->

### Description

Obtains memory attribute information, including whether the memory resides on the host or device, the page table size, and other information.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Memory address.<br>Do not pass a device address mapped through the **aclrtHostRegister** API or a device address obtained through the **aclrtHostGetDevicePointer** API; otherwise, undefined behavior occurs.<br> |
| attributes | Output | Memory attribute information. For details about the type definition, see [aclrtPtrAttributes](25-04_Structs.md#aclrtPtrAttributes). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>
