# 11-04 Virtual Memory Management

<!-- md-trans-meta sourceCommit=520c3d830a4c38f0ac54928aeb209203279d2a03 translatedAt=2026-11-06T11:21:35.708Z pushedAt=2026-11-09T08:40:12.943Z nl=2 -->

This topic describes the virtual memory management APIs, including physical memory allocation, virtual address reservation, memory mapping, and cross-process sharing.

- [`aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)`](#aclrtMallocPhysical): Requests host or device physical memory and returns a physical memory handle.
- [`aclError aclrtFreePhysical(aclrtDrvMemHandle handle)`](#aclrtFreePhysical): Frees the physical memory requested through the [aclrtMallocPhysical](#aclrtMallocPhysical) API.
- [`aclError aclrtReserveMemAddress(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)`](#aclrtReserveMemAddress): Reserves virtual memory.
- [`aclError aclrtReserveMemAddressNoUCMemory(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)`](#aclrtReserveMemAddressNoUCMemory): Reserves virtual memory.
- [`aclError aclrtReleaseMemAddress(void *virPtr)`](#aclrtReleaseMemAddress): Releases the virtual memory requested through the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API.
- [`aclError aclrtMapMem(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)`](#aclrtMapMem): Maps virtual memory to physical memory.
- [`aclError aclrtMemMapNoAccess(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)`](#aclrtMemMapNoAccess): Maps virtual memory to physical memory.
- [`aclError aclrtUnmapMem(void *virPtr)`](#aclrtUnmapMem): Cancels the mapping between virtual memory and physical memory.
- [`aclError aclrtMemExportToShareableHandle(aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags, uint64_t *shareableHandle)`](#aclrtMemExportToShareableHandle): Exports the device physical memory handle obtained by the current process through the [aclrtMallocPhysical](#aclrtMallocPhysical) API, so that the device physical memory can be shared with other processes later.
- [`aclError aclrtMemSetPidToShareableHandle(uint64_t shareableHandle, int32_t *pid, size_t pidNum)`](#aclrtMemSetPidToShareableHandle): Sets a process trustlist for shared memory.
- [`aclError aclrtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle *handle)`](#aclrtMemImportFromShareableHandle): Obtains the information in **shareableHandle** in the current process and returns the handle in the current process, which is used to establish the mapping between virtual addresses and physical addresses in the current process.
- [`aclError aclrtMemExportToShareableHandleV2(aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType, void *shareableHandle)`](#aclrtMemExportToShareableHandleV2): Exports the device physical memory handle obtained by the current process through the [aclrtMallocPhysical](#aclrtMallocPhysical) API, so that the device physical memory can be shared with other processes later.
- [`aclError aclrtMemSetPidToShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, int32_t *pid, size_t pidNum)`](#aclrtMemSetPidToShareableHandleV2): Sets a process trustlist for shared memory.
- [`aclError aclrtMemImportFromShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle *handle);`](#aclrtMemImportFromShareableHandleV2): Obtains the information in **shareableHandle** in the current process and returns the handle in the current process, which is used to establish the mapping between virtual addresses and physical addresses in the current process.
- [`aclError aclrtMemGetAllocationGranularity(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option, size_t *granularity)`](#aclrtMemGetAllocationGranularity): Queries the memory request granularity.
- [`aclError aclrtMemSetAccess(void* virPtr, size_t size, aclrtMemAccessDesc* desc, size_t count)`](#aclrtMemSetAccess): Sets the access permission of the memory.
- [`aclError aclrtMemGetAccess(void *virPtr, aclrtMemLocation *location, uint64_t *flag)`](#aclrtMemGetAccess): Obtains the access permission of the memory.
- [`aclError aclrtMemRetainAllocationHandle(void* virPtr, aclrtDrvMemHandle *handle)`](#aclrtMemRetainAllocationHandle): Obtains the handle of the physical memory information based on the virtual memory address.
- [`aclError aclrtMemGetAllocationPropertiesFromHandle(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop)`](#aclrtMemGetAllocationPropertiesFromHandle): Queries the memory attribute information based on the handle of the physical memory information.
- [`aclError aclrtMemGetAddressRange(void *ptr, void **pbase, size_t *psize)`](#aclrtMemGetAddressRange): Obtains the start address of the memory block to which the address to be queried belongs, as well as the size of the memory block.
- [`aclError aclrtMemMapSelectedLink(void *virPtrDst, size_t size, void *virPtrSrc, uint32_t linkIdx)`](#aclrtMemMapSelectedLink): Maps the virtual address **virPtrSrc** to its correponding physical address. The HCCS link or SIO link can be selected through **linkIdx**.
- [`aclError aclrtMemMapSetLink(aclrtDrvMemHandle handle, aclrtMemLinkType adviceLink)`](#aclrtMemMapSetLink): Sets the access link type used by the physical memory handle during mapping.

<a class="method_anchor" id="aclrtMallocPhysical"></a>

## aclrtMallocPhysical

```c
aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id1492 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1492 -->
<!-- npu="A3" id1493 -->
- Atlas A3 products: Supported
<!-- end id1493 -->
<!-- npu="910b" id1494 -->
- Atlas A2 products: Supported
<!-- end id1494 -->
<!-- npu="310b" id1495 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1495 -->
<!-- npu="310p" id1496 -->
- Atlas inference products: Supported
<!-- end id1496 -->
<!-- npu="910" id1497 -->
- Atlas training products: Supported
<!-- end id1497 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id1 -->

### Description

Requests host or device physical memory and returns a physical memory handle.

This API can be used together with [aclrtReserveMemAddress](#aclrtReserveMemAddress) (to request virtual memory) and [aclrtMapMem](#aclrtMapMem) (to establish the mapping between virtual memory and physical memory), so as to request virtual memory with contiguous addresses and maximize the utilization of physical memory.

This API can be used together with [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) (to export the physical memory handle) and [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle) (to import the shareable handle) to implement physical memory sharing among multiple processes. In addition, virtual memory can also be used when physical memory is shared. For details, see the description of [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **handle** | Output | Handle that stores the physical memory information. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle). |
| **size** | Input | Physical memory size, in bytes.<br>Call [aclrtMemGetAllocationGranularity](#aclrtMemGetAllocationGranularity) first to obtain the memory request granularity, and then align **size** to the obtained granularity when calling this API to request physical memory, so as to save memory. |
| **prop** | Input | Physical memory attribute information. For details about the type definition, see [aclrtPhysicalMemProp](25-04_Structs.md#aclrtPhysicalMemProp). |
| **flags** | Input | Reserved parameter. Currently, it can only be set to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="310b" id1 -->
- For Atlas 200I/500 A2 inference products, the Ascend RC form does not support calling this API.
<!-- end id1 -->
<!-- npu="A3,910b,910,310p,310b" id33 -->
- For the following product models, when the memory location **aclrtPhysicalMemProp.location.type** is set to **ACL\_MEM\_LOCATION\_TYPE\_HOST\_NUMA** and the memory attribute type **aclrtPhysicalMemProp.memAttr** is a normal memory option (for example, **ACL\_MEM\_NORMAL**), requesting memory with this parameter combination is not supported.
    <!-- npu="A3" id38 -->
    - Atlas A3 products
    <!-- end id38 -->
    <!-- npu="910b" id39 -->
    - Atlas A2 products
    <!-- end id39 -->
    <!-- npu="310b" id40 -->
    - Atlas 200I/500 A2 inference products
    <!-- end id40 -->
    <!-- npu="310p" id41 -->
    - Atlas inference products
    <!-- end id41 -->
    <!-- npu="910" id42 -->
    - Atlas training products
    <!-- end id42 -->
<!-- end id33 -->
<!-- npu="A3" id2 -->
- For supernode products in Atlas A3 products, when the memory location **aclrtPhysicalMemProp.location.type** is set to **ACL\_MEM\_LOCATION\_TYPE\_HOST\_NUMA** and the memory attribute type **aclrtPhysicalMemProp.memAttr** is a P2P option (for example, **ACL\_MEM\_P2P\_HUGE**), the maximum memory size that can be requested varies depending on the server model and BIOS version. It is recommended to attempt the request through the **aclrtMallocPhysical** API according to the memory plan to confirm whether the memory is sufficient.
<!-- end id2 -->
- The memory attribute type **aclrtPhysicalMemProp.memAttr** currently supports only the following options:
    - **ACL\_MEM\_NORMAL**: normal memory.
    - **ACL\_MEM\_HUGE**: huge-page memory aligned to a 2 MB granularity.
    - **ACL\_MEM\_HUGE1G**: huge-page memory aligned to a 1 GB granularity, supported only on devices.

        <!-- npu="A3,910b" id3 -->
        Only Atlas A3 products and Atlas A2 products support this type.
        <!-- end id3 -->

        <!-- npu="950" id4 -->
        Ascend 950PR&950DT products do not support this type.
        <!-- end id4 -->

        <!-- npu="910,310p,310b" id5 -->
        Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products do not support this type.
        <!-- end id5 -->

    - **ACL\_MEM\_P2P\_NORMAL**: normal memory used for data replication between devices.
    - **ACL\_MEM\_P2P\_HUGE**: huge-page memory used for data replication between devices, with a memory request granularity of 2 MB.
    - **ACL\_MEM\_P2P\_HUGE1G**: huge-page memory used for data replication between devices, with a memory request granularity of 1 GB, supported only on devices.

        <!-- npu="A3" id6 -->
        Only some interconnect forms of Atlas A3 products support this type, subject to the actual return value of the API.
        <!-- end id6 -->

        <!-- npu="950,910b" id7 -->
        Ascend 950PR&950DT products and Atlas A2 products do not support this type.
        <!-- end id7 -->

        <!-- npu="910,310p,310b" id8 -->
        Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products do not support this type.
        <!-- end id8 -->

    - **ACL\_HBM\_MEM\_HUGE**: huge-page memory aligned to a 2 MB granularity.
    - **ACL\_HBM\_MEM\_HUGE1G**: huge-page memory aligned to a 1 GB granularity, supported only on devices.

        <!-- npu="950,A3,910b" id9 -->
        Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products support this type.
        <!-- end id9 -->

        <!-- npu="910,310p,310b" id10 -->
        Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products do not support this type.
        <!-- end id10 -->

    - **ACL\_HBM\_MEM\_NORMAL**: normal memory. The API internally requests huge-page memory based on the **ACL\_HBM\_MEM\_HUGE** type.
    - **ACL\_DDR\_MEM\_HUGE**: huge-page memory. Only host memory is supported.
    - **ACL\_DDR\_MEM\_NORMAL**: normal memory. Only host memory is supported.
    - **ACL\_DDR\_MEM\_P2P\_HUGE**: huge-page memory used for data replication between devices. Only host memory is supported.
    - **ACL\_DDR\_MEM\_P2P\_NORMAL**: normal memory used for data replication between devices. Only host memory is supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFreePhysical"></a>

## aclrtFreePhysical

```c
aclError aclrtFreePhysical(aclrtDrvMemHandle handle)
```

### Applicable Products

<!-- npu="950" id1947 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1947 -->
<!-- npu="A3" id1948 -->
- Atlas A3 products: Supported
<!-- end id1948 -->
<!-- npu="910b" id1949 -->
- Atlas A2 products: Supported
<!-- end id1949 -->
<!-- npu="310b" id1950 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1950 -->
<!-- npu="310p" id1951 -->
- Atlas inference products: Supported
<!-- end id1951 -->
<!-- npu="910" id1952 -->
- Atlas training products: Supported
<!-- end id1952 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id2 -->

### Description

Frees the physical memory requested through the [aclrtMallocPhysical](#aclrtMallocPhysical) API.

If a mapping exists between the physical memory and virtual memory, the physical memory is not actually freed here. The physical memory is truly freed only after [aclrtUnmapMem](#aclrtUnmapMem) is called to cancel the mapping between the physical memory and the virtual memory.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Information handle of the physical memory to be freed. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id11 -->
### Constraints

On Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id11 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtReserveMemAddress"></a>

## aclrtReserveMemAddress

```c
aclError aclrtReserveMemAddress(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id1142 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1142 -->
<!-- npu="A3" id1143 -->
- Atlas A3 products: Supported
<!-- end id1143 -->
<!-- npu="910b" id1144 -->
- Atlas A2 products: Supported
<!-- end id1144 -->
<!-- npu="310b" id1145 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1145 -->
<!-- npu="310p" id1146 -->
- Atlas inference products: Supported
<!-- end id1146 -->
<!-- npu="910" id1147 -->
- Atlas training products: Supported
<!-- end id1147 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id3 -->

### Description

Reserves virtual memory.

**This API must be used together with the following APIs** to request virtual memory with contiguous addresses and maximize the utilization of physical memory:

1. Request virtual memory (the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API).
2. Request physical memory (the [aclrtMallocPhysical](#aclrtMallocPhysical) API).
3. Map virtual memory to physical memory (the [aclrtMapMem](#aclrtMapMem) API).
4. Execute tasks (by calling specific task APIs).
5. Cancel the mapping between virtual memory and physical memory (the [aclrtUnmapMem](#aclrtUnmapMem) API).
6. Free physical memory (the [aclrtFreePhysical](#aclrtFreePhysical) API).
7. Release virtual memory (the [aclrtReleaseMemAddress](#aclrtReleaseMemAddress) API).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| virPtr | Output | Pointer to the pointer of the allocated virtual memory address. |
| size | Input | Virtual memory size, in bytes.<br>The value of **size** cannot be 0. |
| alignment | Input | Virtual address alignment value, which is reserved. Currently, it can only be set to **0**. |
| expectPtr | Input | Expected start address of the virtual memory to be returned.<br>The value options are as follows:<br>  - **nullptr**: The system automatically allocates a virtual address that complies with the alignment rule.<br>  - Non-**nullptr**: The start address is specified by the user. The address must be within the 8T range (16T-24T). The user must ensure that the specified address is not occupied and complies with the alignment rule; otherwise, reserving virtual memory fails and the API returns an error. The alignment rule is as follows: if the value of **size** is less than 1 GB, **expectPtr** must be aligned to a power of 2; if the value of **size** is greater than 1 GB, **expectPtr** must be aligned to 1 GB. **Caution:** Specifying the start address by the user is an experimental feature and may change in later versions. It is not supported for use in production environments. |
| flags | Input | Reserved parameter. It is recommended to set it to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="950" id13 -->
- For Ascend 950PR&950DT products, the **expectPtr** parameter can only be set to **nullptr**.
<!-- end id13 -->

<!-- npu="310b" id12 -->
- On Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id12 -->

- For the virtual memory reserved by this API, in a single-process scenario, only the [aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync) API is supported for data copy between two devices.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtReserveMemAddressNoUCMemory"></a>

## aclrtReserveMemAddressNoUCMemory

```c
aclError aclrtReserveMemAddressNoUCMemory(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
```

**Caution:** Specifying the start address by the user is an experimental feature. It may change in later versions and is not supported for use in production environments.

### Applicable Products

<!-- npu="950" id2192 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2192 -->
<!-- npu="A3" id2193 -->
- Atlas A3 products: Supported
<!-- end id2193 -->
<!-- npu="910b" id2194 -->
- Atlas A2 products: Not supported
<!-- end id2194 -->
<!-- npu="310b" id2195 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2195 -->
<!-- npu="310p" id2196 -->
- Atlas inference products: Not supported
<!-- end id2196 -->
<!-- npu="910" id2197 -->
- Atlas training products: Not supported
<!-- end id2197 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id4 -->

### Description

Reserves virtual memory.

This API is used in the same way as **aclrtReserveMemAddress**, with the following difference: Based on the environment variable **AUTO\_USE\_UC\_MEMORY**, which determines whether operators whose data migration does not pass through the L2 Cache are allowed, the virtual memory reserved by this API cannot be used as the input or output memory of such operators; otherwise, operator precision issues or exceptions may occur. For details about **AUTO\_USE\_UC\_MEMORY**, see [Environment Variable Reference](../env_vars/AUTO_USE_UC_MEMORY.md).

In addition, the start address of the virtual memory in this API does not support automatic allocation by the system and can only be specified by the user, and the address is recommended to be within the range of 40T to 224T.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **virPtr** | Output | Pointer to the pointer of the allocated virtual memory address. |
| **size** | Input | Size of the virtual memory, in bytes.<br>The value of **size** cannot be **0** and must be an integer multiple of 1 GB, with a minimum of 1 GB. |
| **alignment** | Input | Virtual address alignment value, which is reserved. Currently, it can only be set to **0**. |
| **expectPtr** | Input | Expected start address of the virtual memory to be returned.<br>The start address is specified by the user and is recommended to be within the range of 40T to 224T. The user must ensure that the specified address is not occupied; otherwise, virtual memory reservation fails and the API returns an error. |
| **flags** | Input | Reserved parameter. It is recommended to set it to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtReleaseMemAddress"></a>

## aclrtReleaseMemAddress

```c
aclError aclrtReleaseMemAddress(void *virPtr)
```

### Applicable Products

<!-- npu="950" id862 -->
- Ascend 950PR&950DT products: Supported
<!-- end id862 -->
<!-- npu="A3" id863 -->
- Atlas A3 products: Supported
<!-- end id863 -->
<!-- npu="910b" id864 -->
- Atlas A2 products: Supported
<!-- end id864 -->
<!-- npu="310b" id865 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id865 -->
<!-- npu="310p" id866 -->
- Atlas inference products: Supported
<!-- end id866 -->
<!-- npu="910" id867 -->
- Atlas training products: Supported
<!-- end id867 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id5 -->

### Description

Releases the virtual memory requested through the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API.

**This API must be used together with the following APIs** to request virtual memory with contiguous addresses and maximize the utilization of physical memory:

1. Request virtual memory (the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API).
2. Request physical memory (the [aclrtMallocPhysical](#aclrtMallocPhysical) API).
3. Map virtual memory to physical memory (the [aclrtMapMem](#aclrtMapMem) API).
4. Execute tasks (by calling specific task APIs).
5. Cancel the mapping between virtual memory and physical memory (the [aclrtUnmapMem](#aclrtUnmapMem) API).
6. Free physical memory (the [aclrtFreePhysical](#aclrtFreePhysical) API);
7. Release virtual memory (the [aclrtReleaseMemAddress](#aclrtReleaseMemAddress) API).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **virPtr** | Input | Pointer to the virtual memory address to be released. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="310b" id14 -->
- For Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id14 -->

- If a mapping relationship exists between the virtual memory and the physical memory, call [aclrtUnmapMem](#aclrtUnmapMem) to cancel the mapping between the virtual memory and the physical memory before releasing the virtual memory.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMapMem"></a>

## aclrtMapMem

```c
aclError aclrtMapMem(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id498 -->
- Ascend 950PR&950DT products: Supported
<!-- end id498 -->
<!-- npu="A3" id499 -->
- Atlas A3 products: Supported
<!-- end id499 -->
<!-- npu="910b" id500 -->
- Atlas A2 products: Supported
<!-- end id500 -->
<!-- npu="310b" id501 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id501 -->
<!-- npu="310p" id502 -->
- Atlas inference products: Supported
<!-- end id502 -->
<!-- npu="910" id503 -->
- Atlas training products: Supported
<!-- end id503 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id6 -->

### Description

Maps virtual memory to physical memory.

**This API must be used together with the following APIs** to request virtual memory with contiguous addresses and maximize the utilization of physical memory:

1. Request virtual memory (the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API).
2. Request physical memory (the [aclrtMallocPhysical](#aclrtMallocPhysical) API).
3. Map virtual memory to physical memory (the [aclrtMapMem](#aclrtMapMem) API).
4. Execute tasks (by calling the specific task APIs).
5. Cancel the mapping between virtual memory and physical memory (the [aclrtUnmapMem](#aclrtUnmapMem) API).
6. Free physical memory (the [aclrtFreePhysical](#aclrtFreePhysical) API).
7. Release virtual memory (the [aclrtReleaseMemAddress](#aclrtReleaseMemAddress) API).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **virPtr** | Input | Pointer to the virtual memory address to be mapped.<br>This address is not necessarily the start address. The user can also offset from the start address before mapping. |
| **size** | Input | Memory size to be mapped, in bytes.<br>The value of **size** here must be the same as that of the **size** parameter of the [aclrtMallocPhysical](#aclrtMallocPhysical) API, and must be aligned with **ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM** obtained by the [aclrtMemGetAllocationGranularity](#aclrtMemGetAllocationGranularity) API. |
| **offset** | Input | Physical memory offset, which can only be set to **0**. |
| **handle** | Input | Physical memory information handle. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle).<br>When a whole segment of virtual addresses reserved by the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API is managed and divided by the user, it cannot be bound to physical addresses requested on two devices at the same time.<br>When a whole segment of virtual addresses reserved by the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API is managed and divided by the user, it cannot be bound to the handles output by the [aclrtMallocPhysical](#aclrtMallocPhysical), [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle), and [aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2) APIs at the same time. |
| **flags** | Input | Reserved parameter, which can only be set to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id15 -->
### Constraints

For Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id15 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemMapNoAccess"></a>

## aclrtMemMapNoAccess

```c
aclError aclrtMemMapNoAccess(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id27 -->
- Ascend 950PR&950DT products: Supported
<!-- end id27 -->
<!-- npu="A3" id28 -->
- Atlas A3 products: Supported
<!-- end id28 -->
<!-- npu="910b" id29 -->
- Atlas A2 products: Supported
<!-- end id29 -->
<!-- npu="310b" id30 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id30 -->
<!-- npu="310p" id31 -->
- Atlas inference products: Supported
<!-- end id31 -->
<!-- npu="910" id32 -->
- Atlas training products: Supported
<!-- end id32 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id21 -->

### Description

Maps virtual memory to physical memory.
The difference between this API and the **aclrtMapMem** API is that after this API is successfully called, no accessible page table has been established on the target device, and the virtual address range is inaccessible. Therefore, you must first call the [aclrtMemSetAccess](#aclrtMemSetAccess) API to set the memory access permission, which triggers the establishment of an accessible page table on the device, before the virtual address range can be accessed.

**This API must be used together with the following APIs** to request virtual memory with contiguous addresses and maximize the utilization of physical memory:

1. Request virtual memory (the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API).
2. Request physical memory (the [aclrtMallocPhysical](#aclrtMallocPhysical) API).
3. Map virtual memory to physical memory (the [aclrtMemMapNoAccess](#aclrtMemMapNoAccess) API).
4. Set the access permission for the target device (the [aclrtMemSetAccess](#aclrtMemSetAccess) API).
5. Execute tasks (by calling specific task APIs).
6. Cancel the mapping between virtual memory and physical memory (the [aclrtUnmapMem](#aclrtUnmapMem) API).
7. Free physical memory (the [aclrtFreePhysical](#aclrtFreePhysical) API).
8. Release virtual memory (the [aclrtReleaseMemAddress](#aclrtReleaseMemAddress) API).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **virPtr** | Input | Pointer to the virtual memory address to be mapped.<br>This address is not necessarily the start address. The user can also offset from the start address before mapping. |
| **size** | Input | Size of the memory to be mapped, in bytes.<br>The value of **size** here must be the same as that of the **size** parameter of the [aclrtMallocPhysical](#aclrtMallocPhysical) API, and must be aligned with **ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM** obtained by the [aclrtMemGetAllocationGranularity](#aclrtMemGetAllocationGranularity) API. |
| **offset** | Input | Physical memory offset, which can only be set to **0** currently. |
| **handle** | Input | Handle of the physical memory information. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle).<br>When a whole segment of virtual addresses reserved through the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API is managed and divided by the user, it cannot be bound to physical addresses requested on two devices at the same time.<br>When a whole segment of virtual addresses reserved through the [aclrtReserveMemAddress](#aclrtReserveMemAddress) API is managed and divided by the user, it cannot be bound to the handles output by the [aclrtMallocPhysical](#aclrtMallocPhysical), [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle), and [aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2) APIs at the same time. |
| **flags** | Input | Reserved parameter, which can only be set to **0** currently. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950,A3,910b,310b" id34 -->
### Constraints

<!-- npu="310b" id35 -->
For Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id35 -->

<!-- npu="950,A3,910b" id36 -->
For Atlas A2 products, Atlas A3 products, and Ascend 950PR&950DT products, this API does not support devices in the PCIe interconnect form.
<!-- end id36 -->
<!-- end id34 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtUnmapMem"></a>

## aclrtUnmapMem

```c
aclError aclrtUnmapMem(void *virPtr)
```

### Applicable Products

<!-- npu="950" id3354 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3354 -->
<!-- npu="A3" id3355 -->
- Atlas A3 products: Supported
<!-- end id3355 -->
<!-- npu="910b" id3356 -->
- Atlas A2 products: Supported
<!-- end id3356 -->
<!-- npu="310b" id3357 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3357 -->
<!-- npu="310p" id3358 -->
- Atlas inference products: Supported
<!-- end id3358 -->
<!-- npu="910" id3359 -->
- Atlas training products: Supported
<!-- end id3359 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id7 -->

### Description

Cancels the mapping between virtual memory and physical memory established through [aclrtMapMem](#aclrtMapMem) or [aclrtMemMapNoAccess](#aclrtMemMapNoAccess).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| virPtr | Input | Pointer to the virtual memory address whose mapping is to be canceled. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id16 -->
### Constraints

For Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id16 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemExportToShareableHandle"></a>

## aclrtMemExportToShareableHandle

```c
aclError aclrtMemExportToShareableHandle(aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags, uint64_t *shareableHandle)
```

### Applicable Products

<!-- npu="950" id1940 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1940 -->
<!-- npu="A3" id1941 -->
- Atlas A3 products: Supported
<!-- end id1941 -->
<!-- npu="910b" id1942 -->
- Atlas A2 products: Supported
<!-- end id1942 -->
<!-- npu="310b" id1943 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1943 -->
<!-- npu="310p" id1944 -->
- Atlas inference products: Supported
<!-- end id1944 -->
<!-- npu="910" id1945 -->
- Atlas training products: Supported
<!-- end id1945 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id8 -->

### Description

Exports the device physical memory handle obtained by the current process through the [aclrtMallocPhysical](#aclrtMallocPhysical) API, so that the device physical memory can be shared with other processes later.

**This API must be used together with the following other key APIs** to implement memory sharing. The following uses processes A and B as an example to describe the API call flow for physical memory sharing between two processes:

1. In process A:
    1. Call [aclrtMallocPhysical](#aclrtMallocPhysical) to request physical memory.

        First call [aclrtMemGetAllocationGranularity](#aclrtMemGetAllocationGranularity) to obtain the memory request granularity, and then align **size** to the obtained memory request granularity when calling [aclrtMallocPhysical](#aclrtMallocPhysical) to request physical memory, so as to save memory.

        If address-contiguous virtual memory is required and physical memory needs to be utilized to the maximum extent, you can use [aclrtReserveMemAddress](#aclrtReserveMemAddress), [aclrtMapMem](#aclrtMapMem), and [aclrtMemSetAccess](#aclrtMemSetAccess) to request virtual memory, establish the mapping between virtual memory and physical memory, and set the access permission of the virtual memory.

    2. Call [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) to export the physical memory handle and output **shareableHandle**.

        When calling [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle), you can specify whether to enable process trustlist verification. If enabled, you need to separately call [aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle) to set the process ID of process B to the trustlist; otherwise, you do not need to call [aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle).

    3. Call [aclrtFreePhysical](#aclrtFreePhysical) to free the physical memory.

        After the memory is used, call [aclrtFreePhysical](#aclrtFreePhysical) in a timely manner to free the physical memory and destroy **shareableHandle**. If any process is still using **shareableHandle**, wait until **shareableHandle** is no longer in use before performing the destruction task.

        All processes involved in shared memory must free their physical memory. Only after all related processes complete the free operation can the physical memory actually be freed. After the physical memory is freed, the previously allocated memory is returned to the operating system, and any subsequent use of the handle will result in undefined behavior.

2. In process B:
    1. Call [aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid) to obtain the process ID of process B.

        When obtaining the process ID, this API has adapted to both physical machine and virtual machine scenarios. The user only needs to call this API to obtain the process ID and then use it together with other APIs to achieve physical memory sharing. If the user does not call this API and obtains the process ID by themselves, subsequent use of the process ID may be abnormal.

    2. Call [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle) to obtain the information in **shareableHandle** and return the handle in the current process.

        Before calling [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle), ensure that the physical memory to be shared exists and is not freed in advance.

        If you need to request virtual memory with contiguous addresses and maximize the utilization of physical memory addresses, you can use [aclrtReserveMemAddress](#aclrtReserveMemAddress), [aclrtMapMem](#aclrtMapMem), and [aclrtMemSetAccess](#aclrtMemSetAccess) to request virtual memory, establish the mapping between virtual memory and physical memory, and set the access permission of the virtual memory. For details, see the description of the corresponding APIs.

    3. Call [aclrtFreePhysical](#aclrtFreePhysical) to free the physical memory.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Handle that stores physical memory information. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle).<br>You must first call **aclrtMallocPhysical** in the current process to request physical memory. If the call succeeds, a handle is returned.<br>The handle and the shareable handle have a one-to-one mapping relationship. In the same process, one-to-many or many-to-one mapping is not allowed; otherwise, an error is reported. For example, repeatedly calling this API to export the handle returns an error. |
| handleType | Input | Reserved parameter. Currently, it must be set to **ACL_MEM_HANDLE_TYPE_NONE**.<br>For details about the type definition, see [aclrtMemHandleType](25-02_Enumerations.md#aclrtMemHandleType). |
| flags | Input | Whether to enable process trustlist validation.<br>The value is one of the following macros:<br><br>  - **ACL_RT_VMM_EXPORT_FLAG_DEFAULT**: enable process trustlist validation. This is the default value. When this value is set, you must separately call [aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle) to add the process ID that uses the shareable handle to the trustlist.<br>  - **ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION**: disable process trustlist validation. When this value is set, you do not need to call [aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle).<br><br><br>The macros are defined as follows:<br>#define ACL_RT_VMM_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL |
| shareableHandle | Output | Shareable handle that identifies the memory shared to other processes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="310b" id17 -->
- For Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id17 -->
<!-- npu="950,A3,910b,910,310p" id18 -->
- Cross-process physical memory sharing is supported within an AI Server. If the sharing is across devices, it must be used together with the [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess) API. An AI Server is a general term for a server form that typically consists of multiple devices.
<!-- end id18 -->
<!-- npu="910b,910,310p" id19 -->
- The Ascend virtualization instance scenario is not supported.
<!-- end id19 -->
- The computing power grouping scenario is not supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemSetPidToShareableHandle"></a>

## aclrtMemSetPidToShareableHandle

```c
aclError aclrtMemSetPidToShareableHandle(uint64_t shareableHandle, int32_t *pid, size_t pidNum)
```

### Applicable Products

<!-- npu="950" id1345 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1345 -->
<!-- npu="A3" id1346 -->
- Atlas A3 products: Supported
<!-- end id1346 -->
<!-- npu="910b" id1347 -->
- Atlas A2 products: Supported
<!-- end id1347 -->
<!-- npu="310b" id1348 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1348 -->
<!-- npu="310p" id1349 -->
- Atlas inference products: Supported
<!-- end id1349 -->
<!-- npu="910" id1350 -->
- Atlas training products: Supported
<!-- end id1350 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id9 -->

### Description

Sets a process trustlist for shared memory**.**

In the process that calls the **aclrtMemExportToShareableHandle** API, call this API to set a process trustlist. This API must be used together with other APIs to implement memory sharing. For details, see the description of the [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| shareableHandle | Input | Shareable handle exported through the [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) API. |
| pid | Input | Array used to store trustlisted process IDs.<br>The process ID can be obtained by calling the [aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid) API. In a docker scenario, the obtained ID is the process ID on the physical machine; in a non-docker scenario, the obtained ID is the process ID. |
| pidNum | Input | Number of trustlisted processes, which must be consistent with the size of the **pid** parameter array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemImportFromShareableHandle"></a>

## aclrtMemImportFromShareableHandle

```c
aclError aclrtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle *handle)
```

### Applicable Products

<!-- npu="950" id1478 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1478 -->
<!-- npu="A3" id1479 -->
- Atlas A3 products: Supported
<!-- end id1479 -->
<!-- npu="910b" id1480 -->
- Atlas A2 products: Supported
<!-- end id1480 -->
<!-- npu="310b" id1481 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1481 -->
<!-- npu="310p" id1482 -->
- Atlas inference products: Supported
<!-- end id1482 -->
<!-- npu="910" id1483 -->
- Atlas training products: Supported
<!-- end id1483 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id10 -->

### Description

Obtains the information in **shareableHandle** in the current process and returns the **handle** in the current process, which is used to establish the mapping between virtual addresses and physical addresses in the current process. This API also supports generating a **handle** on a specified device.

This API must be used together with other APIs to implement memory sharing. For the usage process, see the description of the [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **shareableHandle** | Input | Shareable handle to be shared, which must be consistent with **shareableHandle** exported by the [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) API.<br>The handle and shareable handle have a one-to-one mapping. In the same process, a one-to-many or many-to-one mapping is not allowed. |
| **deviceId** | Input | Device ID used to generate a handle.<br>After the user calls the [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) API to obtain the number of available devices, the value range of this device ID is [0, (Number of available devices - 1)]. |
| **handle** | Output | Physical memory handle of the current process. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Before calling this API, ensure that the physical memory to be shared exists and cannot be freed in advance.
- Calling **aclrtMemImportFromShareableHandle** and [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) in the same process is not supported. Only cross-process calls are supported.
- You can call [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle) on a device to export a handle, and then call this API to generate a handle on another device.
- After the memory is no longer in use, call [aclrtFreePhysical](#aclrtFreePhysical) in a timely manner to destroy the handle. The handle is actually destroyed only after all processes that call this API have destroyed **shareableHandle**.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemExportToShareableHandleV2"></a>

## aclrtMemExportToShareableHandleV2

```c
aclError aclrtMemExportToShareableHandleV2(aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType, void *shareableHandle)
```

### Applicable Products

<!-- npu="950" id1646 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1646 -->
<!-- npu="A3" id1647 -->
- Atlas A3 products: Supported
<!-- end id1647 -->
<!-- npu="910b" id1648 -->
- Atlas A2 products: Supported
<!-- end id1648 -->
<!-- npu="310b" id1649 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1649 -->
<!-- npu="310p" id1650 -->
- Atlas inference products: Supported
<!-- end id1650 -->
<!-- npu="910" id1651 -->
- Atlas training products: Supported
<!-- end id1651 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id11 -->

### Description

Exports the device physical memory handle obtained by the current process through the [aclrtMallocPhysical](#aclrtMallocPhysical) API, so that the device physical memory can be shared with other processes later.

This API is enhanced based on [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle). You can use the **shareType** parameter to specify exporting a shareable handle within an AI Server or a shareable handle across AI Servers. An AI Server is generally a collective term for a server form composed of multiple devices.

For the usage flow of this API, see [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle). However, this API must be used together with [aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2) to set the process trustlist and [aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2) to import the shareable handle.

### Parameter Description

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Handle that stores the physical memory information. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle).<br>You must first call **aclrtMallocPhysical** in the current process to request physical memory. If the call succeeds, a handle is returned.<br>A handle and a shareable handle have a one-to-one mapping. In the same process, one-to-many or many-to-one mapping is not allowed; otherwise, an error is reported. For example, an error is returned when this API is called repeatedly for export. |
| flags | Input | Whether to enable process trustlist validation.<br>The value is one of the following macros:<br><br>  - **ACL_RT_VMM_EXPORT_FLAG_DEFAULT**: enable process trustlist validation. This is the default value. When this value is set, you must separately call [aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2) to set the process ID that uses **shareableHandle** to the trustlist.<br>  - **ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION**: disable process trustlist validation. When this value is set, you do not need to call [aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2).<br><br><br>The macro definitions are as follows:<br>#define ACL_RT_VMM_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL |
| shareType | Input | Type of the exported shared handle. For details about the type definition, see [aclrtMemSharedHandleType](25-02_Enumerations.md#aclrtMemSharedHandleType). |
| shareableHandle | Output | Pointer to the shared handle. The memory it points to is provided by the caller, and its size is determined by **shareType**:<br>If the value of **shareType** is **ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT**, it points to a uint64_t variable.<br>If the value of **shareType** is **ACL_MEM_SHARE_HANDLE_TYPE_FABRIC**, it points to an **aclrtMemFabricHandle** struct.<br>typedef struct aclrtMemFabricHandle { <br>   uint8_t data[128];<br>} aclrtMemFabricHandle; |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="310b" id20 -->
- For Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id20 -->
<!-- npu="950,A3,910b,910,310p" id21 -->
- Cross-process sharing of physical memory is supported within an AI Server. If sharing across devices is required, this API must be used together with [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess).
<!-- end id21 -->
<!-- npu="A3" id22 -->
- Only Atlas A3 products support cross-process sharing of physical memory across AI Servers.
<!-- end id22 -->
<!-- npu="910b,910,310p" id23 -->
- The Ascend virtualization instance scenario is not supported.
<!-- end id23 -->
- The computing power grouping scenario is not supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemSetPidToShareableHandleV2"></a>

## aclrtMemSetPidToShareableHandleV2

```c
aclError aclrtMemSetPidToShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, int32_t *pid, size_t pidNum)
```

### Applicable Products

<!-- npu="950" id1366 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1366 -->
<!-- npu="A3" id1367 -->
- Atlas A3 products: Supported
<!-- end id1367 -->
<!-- npu="910b" id1368 -->
- Atlas A2 products: Supported
<!-- end id1368 -->
<!-- npu="310b" id1369 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1369 -->
<!-- npu="310p" id1370 -->
- Atlas inference products: Supported
<!-- end id1370 -->
<!-- npu="910" id1371 -->
- Atlas training products: Supported
<!-- end id1371 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id12 -->

### Description

Sets a process trustlist for shared memory**.**

This API is an enhancement of [aclrtMemSetPidToShareableHandle](#aclrtMemSetPidToShareableHandle). You can use the **shareType** parameter to specify exporting a shareable handle within an AI Server or exporting a shareable handle across AI Servers.

For the usage flow of this API, see [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle). However, this API must be used together with [aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2) to export the shareable handle and with [aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2) to import the shareable handle.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| shareableHandle | Input | Shareable handle exported through the **aclrtMemExportToShareableHandleV2** API, which is a pointer to the shareable handle. |
| shareType | Input | Type of the exported shared handle. For details about the type definition, see [aclrtMemSharedHandleType](25-02_Enumerations.md#aclrtMemSharedHandleType). |
| pid | Input | Array used to store trustlisted process IDs.<br>The process ID can be obtained by calling the [aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid) API. In a docker scenario, the obtained value is the process ID on the physical machine; in a non-docker scenario, the obtained value is the process ID. |
| pidNum | Input | Number of trustlisted processes, which must be consistent with the size of the **pid** array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemImportFromShareableHandleV2"></a>

## aclrtMemImportFromShareableHandleV2

```c
aclError aclrtMemImportFromShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle *handle)
```

### Applicable Products

<!-- npu="950" id827 -->
- Ascend 950PR&950DT products: Supported
<!-- end id827 -->
<!-- npu="A3" id828 -->
- Atlas A3 products: Supported
<!-- end id828 -->
<!-- npu="910b" id829 -->
- Atlas A2 products: Supported
<!-- end id829 -->
<!-- npu="310b" id830 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id830 -->
<!-- npu="310p" id831 -->
- Atlas inference products: Supported
<!-- end id831 -->
<!-- npu="910" id832 -->
- Atlas training products: Supported
<!-- end id832 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id13 -->

### Description

Obtains the information in **shareableHandle** in the current process and returns the handle in the current process, which is used to establish the mapping between virtual addresses and physical addresses in the current process.

This API is enhanced based on [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle). You can use the **shareType** parameter to specify exporting a shareable handle within an AI Server or exporting a shareable handle across AI Servers.

For the usage flow of this API, see [aclrtMemExportToShareableHandle](#aclrtMemExportToShareableHandle). However, this API must be used together with [aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2) to export the shareable handle and with [aclrtMemSetPidToShareableHandleV2](#aclrtMemSetPidToShareableHandleV2) to set the process trustlist.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| shareableHandle | Input | Shareable handle to be shared, which must be consistent with **shareableHandle** exported by [aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2).<br>A handle and a shareable handle have a one-to-one relationship. In the same process, one-to-many or many-to-one mapping is not allowed. |
| shareType | Input | Type of the exported shared handle. For details about the type definition, see [aclrtMemSharedHandleType](25-02_Enumerations.md#aclrtMemSharedHandleType). |
| flags | Input | Reserved parameter, which is fixed to **0**. |
| handle | Output | Physical memory handle of the current process. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Before calling this API, ensure that the physical memory to be shared exists and is not freed in advance.
- Calling [aclrtMemImportFromShareableHandleV2](#aclrtMemImportFromShareableHandleV2) and [aclrtMemExportToShareableHandleV2](#aclrtMemExportToShareableHandleV2) in the same process is not supported. Only cross-process calling is supported.
- After the memory is no longer used, call [aclrtFreePhysical](#aclrtFreePhysical) in a timely manner to destroy the handle. The handle is actually destroyed only after all processes that call this API have destroyed **shareableHandle**.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemGetAllocationGranularity"></a>

## aclrtMemGetAllocationGranularity

```c
aclError aclrtMemGetAllocationGranularity(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option, size_t *granularity)
```

### Applicable Products

<!-- npu="950" id995 -->
- Ascend 950PR&950DT products: Supported
<!-- end id995 -->
<!-- npu="A3" id996 -->
- Atlas A3 products: Supported
<!-- end id996 -->
<!-- npu="910b" id997 -->
- Atlas A2 products: Supported
<!-- end id997 -->
<!-- npu="310b" id998 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id998 -->
<!-- npu="310p" id999 -->
- Atlas inference products: Supported
<!-- end id999 -->
<!-- npu="910" id1000 -->
- Atlas training products: Supported
<!-- end id1000 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id14 -->

### Description

Queries the memory request granularity.

The system internally calculates the minimum granularity or recommended granularity based on the memory attribute information specified by the user, and returns the granularity through the **granularity** parameter. This granularity can be used as a multiple for alignment, address size, or address mapping.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| prop | Input | Physical memory attribute information. For details about the type definition, see [aclrtPhysicalMemProp](25-04_Structs.md#aclrtPhysicalMemProp). |
| option | Input | Minimum granularity or recommended granularity. For details about the type definition, see [aclrtMemGranularityOptions](25-02_Enumerations.md#aclrtMemGranularityOptions). |
| granularity | Output | Memory request granularity, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id24 -->
### Constraints

On Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id24 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemSetAccess"></a>

## aclrtMemSetAccess

```c
aclError aclrtMemSetAccess(void* virPtr, size_t size, aclrtMemAccessDesc* desc, size_t count)
```

### Applicable Products

<!-- npu="950" id2703 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2703 -->
<!-- npu="A3" id2704 -->
- Atlas A3 products: Supported
<!-- end id2704 -->
<!-- npu="910b" id2705 -->
- Atlas A2 products: Supported
<!-- end id2705 -->
<!-- npu="310b" id2706 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2706 -->
<!-- npu="310p" id2707 -->
- Atlas inference products: Supported
<!-- end id2707 -->
<!-- npu="910" id2708 -->
- Atlas training products: Supported
<!-- end id2708 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id15 -->

### Description

Sets the access permission of the memory.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **virPtr** | Input | Start address of the virtual memory.<br>It must be the same as the **virPtr** address of the [aclrtMapMem](#aclrtMapMem) or [aclrtMemMapNoAccess](#aclrtMemMapNoAccess) API. |
| **size** | Input | Length of the virtual memory.<br>It must be the same as the **size** of the [aclrtMapMem](#aclrtMapMem) or [aclrtMemMapNoAccess](#aclrtMemMapNoAccess) API. |
| **desc** | Input | Configuration information for memory access, including the memory access protection flag and memory location. For details about the type definition, see [aclrtMemAccessDesc](25-04_Structs.md#aclrtMemAccessDesc). |
| **count** | Input | Length of the **desc** array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemGetAccess"></a>

## aclrtMemGetAccess

```c
aclError aclrtMemGetAccess(void *virPtr, aclrtMemLocation *location, uint64_t *flag)
```

### Applicable Products

<!-- npu="950" id2675 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2675 -->
<!-- npu="A3" id2676 -->
- Atlas A3 products: Supported
<!-- end id2676 -->
<!-- npu="910b" id2677 -->
- Atlas A2 products: Supported
<!-- end id2677 -->
<!-- npu="310b" id2678 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2678 -->
<!-- npu="310p" id2679 -->
- Atlas inference products: Supported
<!-- end id2679 -->
<!-- npu="910" id2680 -->
- Atlas training products: Supported
<!-- end id2680 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id16 -->

### Description

Obtains the access permission of the memory.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **virPtr** | Input | Start address of the virtual memory.<br>It must be the same as the **virPtr** address of the [aclrtMapMem](#aclrtMapMem) API. |
| **location** | Input | Memory location. For details about the type definition, see [aclrtMemLocation](25-04_Structs.md#aclrtMemLocation).<br>Currently, **aclrtMemLocation.type** can only be set to **ACL_MEM_LOCATION_TYPE_HOST** or **ACL_MEM_LOCATION_TYPE_DEVICE**. When **aclrtMemLocation.type** is set to **ACL_MEM_LOCATION_TYPE_HOST**, [aclrtMemLocation](25-04_Structs.md#aclrtMemLocation).id is invalid and can be fixed to **0**. |
| **flag** | Output | Memory access protection flag. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemRetainAllocationHandle"></a>

## aclrtMemRetainAllocationHandle

```c
aclError aclrtMemRetainAllocationHandle(void* virPtr, aclrtDrvMemHandle *handle)
```

### Applicable Products

<!-- npu="950" id2626 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2626 -->
<!-- npu="A3" id2627 -->
- Atlas A3 products: Supported
<!-- end id2627 -->
<!-- npu="910b" id2628 -->
- Atlas A2 products: Supported
<!-- end id2628 -->
<!-- npu="310b" id2629 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2629 -->
<!-- npu="310p" id2630 -->
- Atlas inference products: Supported
<!-- end id2630 -->
<!-- npu="910" id2631 -->
- Atlas training products: Supported
<!-- end id2631 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id17 -->

### Description

Obtains the handle of the physical memory information based on the virtual memory address.

If this API is called multiple times, **aclrtFreePhysical** must be called the same number of times to free the physical memory handle.

If **ACL_ERROR_RT_FEATURE_NOT_SUPPORT** is returned when calling this API, the underlying driver does not support this feature. Upgrade the driver package to 26.0.RC1 or later. You can click [Link](https://www.hiascend.com/hardware/firmware-drivers/commercial), download the driver installation package of the corresponding version on the firmware and driver page, and install and upgrade it by referring to its documentation.
 
### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| virPtr | Input | Pointer to the pointer of the allocated virtual memory address.<br>It must be the same as the **virPtr** address of the [aclrtMapMem](#aclrtMapMem) API. |
| handle | Output | Handle that stores the physical memory information. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id25 -->
### Constraints

On Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id25 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemGetAllocationPropertiesFromHandle"></a>

## aclrtMemGetAllocationPropertiesFromHandle

```c
aclError aclrtMemGetAllocationPropertiesFromHandle(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop)
```

### Applicable Products

<!-- npu="950" id2437 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2437 -->
<!-- npu="A3" id2438 -->
- Atlas A3 products: Supported
<!-- end id2438 -->
<!-- npu="910b" id2439 -->
- Atlas A2 products: Supported
<!-- end id2439 -->
<!-- npu="310b" id2440 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2440 -->
<!-- npu="310p" id2441 -->
- Atlas inference products: Supported
<!-- end id2441 -->
<!-- npu="910" id2442 -->
- Atlas training products: Supported
<!-- end id2442 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id18 -->

### Description

Queries the memory attribute information based on the handle of the physical memory information.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Handle that stores the physical memory information. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle).<br>You can query the attribute information of the physical memory requested through the **aclrtMallocPhysical** API. |
| prop | Output | Physical memory attribute information. For details about the type definition, see [aclrtPhysicalMemProp](25-04_Structs.md#aclrtPhysicalMemProp). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id26 -->
### Constraints

On Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id26 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemGetAddressRange"></a>

## aclrtMemGetAddressRange

```c
aclError aclrtMemGetAddressRange(void *ptr, void **pbase, size_t *psize)
```

### Applicable Products

<!-- npu="950" id974 -->
- Ascend 950PR&950DT products: Supported
<!-- end id974 -->
<!-- npu="A3" id975 -->
- Atlas A3 products: Supported
<!-- end id975 -->
<!-- npu="910b" id976 -->
- Atlas A2 products: Supported
<!-- end id976 -->
<!-- npu="310b" id977 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id977 -->
<!-- npu="310p" id978 -->
- Atlas inference products: Supported
<!-- end id978 -->
<!-- npu="910" id979 -->
- Atlas training products: Supported
<!-- end id979 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id19 -->

### Description

Obtains the start address of the memory block to which the address to be queried belongs, as well as the size of the memory block.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Memory address to be queried. |
| pbase | Output | Start address of the memory block to which the address to be queried belongs. |
| psize | Output | Size of the memory block to which the address to be queried belongs, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Reference Information

| Usage Scenario | Behavior of the **aclrtMemGetAddressRange** API |
| --- | --- |
| Querying device memory returned by the **aclrtMalloc** or **aclrtMallocWithCfg** API. | Returns the start address and size of the memory block. |
| Querying host memory returned by the **aclrtMallocHost** or **aclrtMallocHostWithCfg** API. | Returns the start address and size of the memory block. |
| Querying a virtual memory address that has been mapped by the **aclrtReserveMemAddress**, **aclrtMallocPhysical**, or **aclrtMapMem** API. | Returns the start address and size of the mapped memory block. |

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemMapSelectedLink"></a>

## aclrtMemMapSelectedLink

```c
aclError aclrtMemMapSelectedLink(void *virPtrDst, size_t size, void *virPtrSrc, uint32_t linkIdx)
```

### Applicable Products

<!-- npu="950" id652 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id652 -->
<!-- npu="A3" id653 -->
- Atlas A3 products: Supported
<!-- end id653 -->
<!-- npu="910b" id654 -->
- Atlas A2 products: Not supported
<!-- end id654 -->
<!-- npu="310b" id655 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id655 -->
<!-- npu="310p" id656 -->
- Atlas inference products: Not supported
<!-- end id656 -->
<!-- npu="910" id657 -->
- Atlas training products: Not supported
<!-- end id657 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id20 -->

### Description

Maps virtual address **virPtrSrc** to its correponding physical address. The HCCS link or SIO link can be selected through **linkIdx**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| virPtrDst | Input | Virtual memory address to be mapped.<br> Reserve the virtual address memory in advance through the **aclrtReserveMemAddress** API, and then pass the start address of the virtual memory as an input parameter to this API. Offsetting the start address of the virtual memory before passing it to this API is not supported.|
| size | Input | Virtual memory size, in bytes.<br> The virtual memory sizes at **virPtrDst** and **virPtrSrc** must be consistent and equal to **size**. |
| virPtrSrc | Input | Virtual memory address that has a mapping to physical memory.<br> Complete the mapping between virtual memory and physical memory in advance through the **aclrtMapMem** API, and then pass the start address of the virtual memory as an input parameter to this API. Offsetting the start address of the virtual memory before passing it to this API is not supported.|
| linkIdx | Input | Link identifier.<br> -  **ACL_RT_MEM_LINK_IDX_0**: small input output (SIO), indicating an intra-chip connection mode through which two DIEs are connected.<br> -  **ACL_RT_MEM_LINK_IDX_1**: Huawei Cache Coherence System (HCCS). HCCS is Huawei's cache coherence system used for high-speed interconnection between CPUs and NPUs. <br> <br> The macro definitions are as follows:<br> ``` #define ACL_RT_MEM_LINK_IDX_0 0U    // SIO ``` <br> ```#define ACL_RT_MEM_LINK_IDX_1 1U    // HCCS``` |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

If the start address of the **virPtrSrc** virtual memory is mapped to multiple different physical memory addresses after offsetting, when the **aclrtMemMapSelectedLink** API is called to map **virPtrDst** to **virPtrSrc**, **virPtrDst** is also mapped to these different physical memory addresses, and the address offset of **virPtrDst** remains consistent with that of **virPtrSrc**. In this scenario, the **aclrtUnmapMem** API must be called multiple times to cancel the mappings between **virPtrDst** and the multiple physical memory addresses.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemMapSetLink"></a>

## aclrtMemMapSetLink

```c
aclError aclrtMemMapSetLink(aclrtDrvMemHandle handle, aclrtMemLinkType adviceLink)
```

### Applicable Products

<!-- npu="950" id3361 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3361 -->
<!-- npu="A3" id3362 -->
- Atlas A3 products: Supported
<!-- end id3362 -->
<!-- npu="910b" id3363 -->
- Atlas A2 products: Not supported
<!-- end id3363 -->
<!-- npu="310b" id3364 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3364 -->
<!-- npu="310p" id3365 -->
- Atlas inference products: Not supported
<!-- end id3365 -->
<!-- npu="910" id3366 -->
- Atlas training products: Not supported
<!-- end id3366 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-04_virtual_memory_management_res.md#id22 -->

### Description

Sets the access link type used by the physical memory during mapping.

To specify the access link type, first call [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle) to obtain the physical memory handle, then call this API to set the access link type of the handle, and finally call [aclrtMapMem](#aclrtMapMem) to establish the mapping between virtual memory and physical memory.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Physical memory information handle. For details about the type definition, see [aclrtDrvMemHandle](25-05_Typedefs.md#aclrtDrvMemHandle).<br>This handle must be obtained through the [aclrtMemImportFromShareableHandle](#aclrtMemImportFromShareableHandle) API. |
| adviceLink | Input | Memory access link type. For details about the type definition, see [aclrtMemLinkType](25-02_Enumerations.md#aclrtMemLinkType). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950,A3" id37 -->
### Constraints

<!-- npu="950" id3368 -->
- For Ascend 950PR&950DT products, **adviceLink** supports the following values:
    - **ACL_RT_MEM_ACCESS_UB_ONE_PORT_PATH**: unified bus (UB) single-port path: full mesh (FM) connection mode, with no hierarchy and full point-to-point direct connection.
    - **ACL_RT_MEM_ACCESS_UB_MULTI_PORT_PATH**: unified bus (UB) multi-port path: CLOS connection mode, with hierarchical structured interconnection.
<!-- end id3368 -->
<!-- npu="A3" id3369 -->
- For Atlas A3 products, **adviceLink** supports the following values:
    - **ACL_RT_MEM_ACCESS_LINK_SIO**: SIO channel, an intra-chip connection mode through which two DIEs are connected.
    - **ACL_RT_MEM_ACCESS_LINK_HCCS**: Huawei Cache Coherence System (HCCS) channel, used for high-speed interconnection between CPUs and NPUs.
<!-- end id3369 -->
If the current product does not support the access link type specified by **adviceLink**, the [ACL_ERROR_RT_LINK_TYPE_NOT_SUPPORTED](25-01_aclError.md) error code is returned.
<!-- end id37 -->
