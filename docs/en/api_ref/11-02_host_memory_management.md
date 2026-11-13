# 11-02 Host Memory Management

<!-- md-trans-meta sourceCommit=213bb540e7cb7a1b1c68c574dc99ea56a3468970 translatedAt=2026-10-26T12:38:09.638Z pushedAt=2026-10-28T06:47:49.639Z -->

This topic describes the APIs for allocating, releasing, and registering host memory, as well as for obtaining pointers.

- [`aclError aclrtMallocHost(void **hostPtr, size_t size)`](#aclrtMallocHost): Requests host memory (page-locked memory). The system ensures that the start address of the memory is 64-byte aligned.
- [`aclError aclrtMallocHostWithCfg(void **ptr, uint64_t size, aclrtMallocConfig *cfg)`](#aclrtMallocHostWithCfg): Requests Host memory (page-locked memory). The system ensures that the start address of the memory is 64-byte aligned.
- [`aclError aclrtFreeHost(void *hostPtr)`](#aclrtFreeHost): Releases the host memory requested by [aclrtMallocHost](#aclrtMallocHost) or [aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg).
- [`aclError aclrtFreeHostWithDevSync(void *hostPtr)`](#aclrtFreeHostWithDevSync): Releases the host memory requested by [aclrtMallocHost](#aclrtMallocHost) or [aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg).
- [`aclError aclrtHostRegister(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)`](#aclrtHostRegister): Registers host memory mapping as a device-accessible memory address and obtains the mapped device memory address. The mapped device memory address cannot be used for memory operations, such as memory copy.
- [`aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)`](#aclrtHostRegisterV2): Registers a host memory address.
- [`aclError aclrtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)`](#aclrtHostGetDevicePointer): Obtains the device memory address registered and mapped by **aclrtHostRegister** or **aclrtHostRegisterV2**. The mapped device memory address cannot be used for memory operations, such as memory copy.
- [`aclError aclrtHostGetDevicePointerAddrRange(aclrtAddrRange *addrRange, uint32_t *count)`](#aclrtHostGetDevicePointerAddrRange): Obtains the address range of the device memory address mapped from host memory.
- [`aclError aclrtHostMemMapCapabilities(uint32_t deviceId, aclrtHacType hacType, aclrtHostMemMapCapability *capabilities)`](#aclrtHostMemMapCapabilities): Queries whether the specified hardware driver accelerator supports accessing the memory registered through the [aclrtHostRegister](#aclrtHostRegister) API.
- [`aclError aclrtHostUnregister(void *ptr)`](#aclrtHostUnregister): Unregisters the host memory.

<a class="method_anchor" id="aclrtMallocHost"></a>

## aclrtMallocHost

```c
aclError aclrtMallocHost(void **hostPtr, size_t size)
```

### Applicable Products

<!-- npu="950" id1681 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1681 -->
<!-- npu="A3" id1682 -->
- Atlas A3 products: Supported
<!-- end id1682 -->
<!-- npu="910b" id1683 -->
- Atlas A2 products: Supported
<!-- end id1683 -->
<!-- npu="310b" id1684 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1684 -->
<!-- npu="310p" id1685 -->
- Atlas inference products: Supported
<!-- end id1685 -->
<!-- npu="910" id1686 -->
- Atlas training products: Supported
<!-- end id1686 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id1 -->

### Description

Requests host memory (page-locked memory). The system ensures that the start address of the memory is 64-byte aligned.

Memory requested through this API must be released through the [aclrtFreeHost](#aclrtFreeHost) API or the [aclrtFreeHostWithDevSync](#aclrtFreeHostWithDevSync) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| hostPtr | Output | Pointer to the pointer of the allocated memory. |
| size | Input | Size of the memory to be requested, in bytes.<br>The value of **size** cannot be 0. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Memory requested by this API is not initialized. It is recommended that you call the [aclrtMemset](11-03_memory_copy_and_set.md#aclrtMemset) API to initialize the memory and clear random values before using it.
- This API does not perform implicit device synchronization or stream synchronization internally. The result is returned immediately whether memory request succeeds or fails.
- Allocating excessive page-locked memory through the **aclrtMallocHost** API reduces the physical memory available to the operating system for paging, thereby degrading overall system performance.
- Frequently calling the **aclrtMallocHost** API to request memory and the [aclrtFreeHost](#aclrtFreeHost) API to release memory degrades performance. It is recommended that you pre-allocate or perform second management on memory in advance to avoid frequent memory request and release.
<!-- npu="310p,310b" id8 -->
- For the Ascend RC form and the control CPU open form, the host and the device are unified, so requesting host memory is equivalent to requesting device memory. In addition, memory is requested as normal pages. If a 64-byte aligned start address is required, you need to handle the alignment yourself.
<!-- end id8 -->
<!-- npu="310p,310b" id9 -->
- For the Ascend RC form and the control CPU open form, if you use this API to request a large block of memory and then divide and manage it yourself, each memory segment must meet the following requirements, where **len** indicates the size of a memory segment and **ALIGN\_UP\[len,k\]** indicates upward alignment to k bytes: \(\(len-1\)/k+1\)\*k:
    - The memory size is aligned upward to a multiple of 32 plus 32 bytes (m=ALIGN\_UP\[len,32\]+32 bytes).
    - The memory start address must satisfy 64-byte alignment (ALIGN\_UP\[m,64\]).
<!-- end id9 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMallocHostWithCfg"></a>

## aclrtMallocHostWithCfg

```c
aclError aclrtMallocHostWithCfg(void **ptr, uint64_t size, aclrtMallocConfig *cfg)
```

### Applicable Products

<!-- npu="950" id715 -->
- Ascend 950PR&950DT products: Supported
<!-- end id715 -->
<!-- npu="A3" id716 -->
- Atlas A3 products: Supported
<!-- end id716 -->
<!-- npu="910b" id717 -->
- Atlas A2 products: Supported
<!-- end id717 -->
<!-- npu="310b" id718 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id718 -->
<!-- npu="310p" id719 -->
- Atlas inference products: Supported
<!-- end id719 -->
<!-- npu="910" id720 -->
- Atlas training products: Supported
<!-- end id720 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id2 -->

### Description

Requests Host memory (page-locked memory). The system ensures that the start address of the memory is 64-byte aligned. Compared with the **aclrtMallocHost** API, this API also allows you to specify memory-related configuration information when requesting memory.

Memory requested through this API must be released through the [aclrtFreeHost](#aclrtFreeHost) API or the [aclrtFreeHostWithDevSync](#aclrtFreeHostWithDevSync) API.

<!-- npu="310p,310b" id10 -->
For the Ascend RC form and the control CPU open form, host and device are unified, so requesting host memory is equivalent to requesting device memory. In addition, memory is requested as normal pages. If a 64-byte aligned start address is required, you need to handle the alignment yourself.
<!-- end id10 -->

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Output | Pointer to the pointer of the requested memory. |
| size | Input | Size of the memory to be requested, in bytes.<br>The value of **size** cannot be 0. |
| cfg | Input | Memory configuration information. For details about the type definition, see [aclrtMallocConfig](25-04_Structs.md#aclrtMallocConfig).<br>If no configuration is specified, **NULL** can be passed here. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFreeHost"></a>

## aclrtFreeHost

```c
aclError aclrtFreeHost(void *hostPtr)
```

### Applicable Products

<!-- npu="950" id540 -->
- Ascend 950PR&950DT products: Supported
<!-- end id540 -->
<!-- npu="A3" id541 -->
- Atlas A3 products: Supported
<!-- end id541 -->
<!-- npu="910b" id542 -->
- Atlas A2 products: Supported
<!-- end id542 -->
<!-- npu="310b" id543 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id543 -->
<!-- npu="310p" id544 -->
- Atlas inference products: Supported
<!-- end id544 -->
<!-- npu="910" id545 -->
- Atlas training products: Supported
<!-- end id545 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id3 -->

### Description

Releases the host memory requested by [aclrtMallocHost](#aclrtMallocHost) or [aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg).

This API releases the passed-in memory immediately. It does not perform implicit device synchronization or stream synchronization internally, nor does it wait for the tasks that are using the memory to complete. The user must ensure that the memory pointer is no longer accessed after this API is called.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| hostPtr | Input | Pointer to the memory to be released. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFreeHostWithDevSync"></a>

## aclrtFreeHostWithDevSync

```c
aclError aclrtFreeHostWithDevSync(void *hostPtr)
```

### Applicable Products

<!-- npu="950" id778 -->
- Ascend 950PR&950DT products: Supported
<!-- end id778 -->
<!-- npu="A3" id779 -->
- Atlas A3 products: Supported
<!-- end id779 -->
<!-- npu="910b" id780 -->
- Atlas A2 products: Supported
<!-- end id780 -->
<!-- npu="310b" id781 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id781 -->
<!-- npu="310p" id782 -->
- Atlas inference products: Supported
<!-- end id782 -->
<!-- npu="910" id783 -->
- Atlas training products: Supported
<!-- end id783 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id4 -->

### Description

Releases the host memory requested by [aclrtMallocHost](#aclrtMallocHost) or [aclrtMallocHostWithCfg](#aclrtMallocHostWithCfg).

This API performs implicit device synchronization internally and waits for the tasks that use the memory to complete.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| hostPtr | Input | Pointer to the memory to be released. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostRegister"></a>

## aclrtHostRegister

```c
aclError aclrtHostRegister(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)
```

### Applicable Products

<!-- npu="950" id1576 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1576 -->
<!-- npu="A3" id1577 -->
- Atlas A3 products: Supported
<!-- end id1577 -->
<!-- npu="910b" id1578 -->
- Atlas A2 products: Supported
<!-- end id1578 -->
<!-- npu="310b" id1579 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1579 -->
<!-- npu="310p" id1580 -->
- Atlas inference products: Not supported
<!-- end id1580 -->
<!-- npu="910" id1581 -->
- Atlas training products: Not supported
<!-- end id1581 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id5 -->

### Description

Registers host memory mapping as a device-accessible memory address and obtains the mapped device memory address. This address can be accessed only on the device, for example, as a kernel function parameter for access by the AI Core on the device. If host-side memory processing is involved, use the original host memory address.

To unregister the host memory, call the [aclrtHostUnregister](#aclrtHostUnregister) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Host memory address.<br>It supports directly passing a host memory address requested by the **aclrtMallocHost** or **aclrtMallocHostWithCfg** API, and also supports passing the host memory address after an address offset. However, the offset memory address must meet the 4 KB page alignment requirement.<br>When the OS kernel version is 5.10 or earlier, using page-unlocked memory causes an exception. Therefore, you must call the **aclrtMallocHost** or **aclrtMallocHostWithCfg** API to request host page-locked memory.<br>When the OS kernel version is later than 5.10, host page-unlocked memory is supported. Therefore, you can call the **aclrtMallocHost** or **aclrtMallocHostWithCfg** API to request host page-locked memory, or use the **malloc** API to request host page-unlocked memory. Host memory requested by the **malloc** API does not require 4 KB page alignment. |
| size | Input | Memory size, in bytes. |
| type | Input | Memory registration type. For details about the type definition, see [aclrtHostRegisterType](25-02_Enumerations.md#aclrtHostRegisterType). |
| devPtr | Output | Device-accessible memory address to which the host memory is mapped. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostRegisterV2"></a>

## aclrtHostRegisterV2

```c
aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id1401 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1401 -->
<!-- npu="A3" id1402 -->
- Atlas A3 products: Supported
<!-- end id1402 -->
<!-- npu="910b" id1403 -->
- Atlas A2 products: Supported
<!-- end id1403 -->
<!-- npu="310b" id1404 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1404 -->
<!-- npu="310p" id1405 -->
- Atlas inference products: Not supported
<!-- end id1405 -->
<!-- npu="910" id1406 -->
- Atlas training products: Not supported
<!-- end id1406 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id6 -->

### Description

Registers a host memory address.

To unregister the host memory address, call the [aclrtHostUnregister](#aclrtHostUnregister) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Host memory address.<br>It supports directly passing a host memory address requested through the **aclrtMallocHost** or **aclrtMallocHostWithCfg** API, and also supports passing the host memory address after address offset, but the offset memory address must meet the 4 KB page alignment requirement.<br>When the OS kernel version is 5.10 or earlier, using page-unlocked memory causes exceptions, so you must call the **aclrtMallocHost** or **aclrtMallocHostWithCfg** API to request host page-locked memory.<br>When the OS kernel version is later than 5.10, page-unlocked host memory is supported, so you can call the **aclrtMallocHost** or **aclrtMallocHostWithCfg** API to request host page-locked memory, or use the **malloc** API to request host page-unlocked memory. Host memory requested through the **malloc** API does not require 4 KB page alignment. |
| size | Input | Memory size, in bytes. |
| flag | Input | Memory registration type.<br>The value is one of the following macros. A single macro or a bitwise OR of multiple macros is supported (for example, **ACL_HOST_REG_MAPPED \| ACL_HOST_REG_PINNED**):<br><br>  - **ACL_HOST_REG_MAPPED**: Registers the host memory mapping as a memory address accessible by the device, and then calls the [aclrtHostGetDevicePointer](#aclrtHostGetDevicePointer) API to obtain the mapped device memory address.<br>  - **ACL_HOST_REG_IOMEMORY**: Registers the I/O space (registers and cache) mapping of a third-party PCIe device on the host as accessible by the device, including read and write. Page-locked memory is not supported when this macro is used, so this macro cannot be combined with **ACL_HOST_REG_PINNED**. This is a reserved option, currently not supported.<br>  - **ACL_HOST_REG_READONLY**: Registers the host memory mapping as read-only for the device.<br>  - **ACL_HOST_REG_PINNED**: Registers the host page-unlocked memory as page-locked memory. Host page-unlocked memory can be requested through C/C++ standard library functions (such as **malloc**, **calloc**, and **new**) or the default **mmap** system call. This macro applies only to host page-unlocked memory; if host page-locked memory is passed, the API returns an error.<br><br>The macro definitions are as follows:<br>#define ACL_HOST_REG_MAPPED 0x2UL<br>#define ACL_HOST_REG_IOMEMORY 0x4UL<br>#define ACL_HOST_REG_READONLY 0x8UL<br>#define ACL_HOST_REG_PINNED 0x10000000UL |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostGetDevicePointer"></a>

## aclrtHostGetDevicePointer

```c
aclError aclrtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id1 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3 products: Supported
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2 products: Supported
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas inference products: Not supported
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas training products: Not supported
<!-- end id6 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id7 -->

### Description

Obtains the device memory address registered and mapped by **aclrtHostRegister** or **aclrtHostRegisterV2**. The mapped device memory address cannot be used for memory operations, such as memory copy.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| pHost | Input | Host memory address registered and mapped by **aclrtHostRegister** or **aclrtHostRegisterV2**. |
| pDevice | Output | Device memory address to which the host memory is mapped. |
| flag | Input | Reserved parameter, which is currently fixed to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostMemMapCapabilities"></a>

## aclrtHostMemMapCapabilities

```c
aclError aclrtHostMemMapCapabilities(uint32_t deviceId, aclrtHacType hacType, aclrtHostMemMapCapability *capabilities)
```

### Applicable Products

<!-- npu="950" id561 -->
- Ascend 950PR&950DT products: Supported
<!-- end id561 -->
<!-- npu="A3" id562 -->
- Atlas A3 products: Supported
<!-- end id562 -->
<!-- npu="910b" id563 -->
- Atlas A2 products: Supported
<!-- end id563 -->
<!-- npu="310b" id564 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id564 -->
<!-- npu="310p" id565 -->
- Atlas inference products: Supported
<!-- end id565 -->
<!-- npu="910" id566 -->
- Atlas training products: Supported
<!-- end id566 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id8 -->

### Description

Queries whether the specified hardware driver accelerator supports accessing the memory registered through the [aclrtHostRegister](#aclrtHostRegister) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After the user calls [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (Number of available devices - 1)]. |
| hacType | Input | Hardware Accelerator Controller (HAC) type. For details about the type definition, see [aclrtHacType](25-02_Enumerations.md#aclrtHacType). |
| capabilities | Output | Whether the memory registered through the **aclrtHostRegister** API can be accessed. For details about the type definition, see [aclrtHostMemMapCapability](25-02_Enumerations.md#aclrtHostMemMapCapability). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostUnregister"></a>

## aclrtHostUnregister

```c
aclError aclrtHostUnregister(void *ptr)
```

### Applicable Products

<!-- npu="950" id1898 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1898 -->
<!-- npu="A3" id1899 -->
- Atlas A3 products: Supported
<!-- end id1899 -->
<!-- npu="910b" id1900 -->
- Atlas A2 products: Supported
<!-- end id1900 -->
<!-- npu="310b" id1901 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1901 -->
<!-- npu="310p" id1902 -->
- Atlas inference products: Not supported
<!-- end id1902 -->
<!-- npu="910" id1903 -->
- Atlas training products: Not supported
<!-- end id1903 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id9 -->

### Description

Unregisters the host memory.

This API is used in pair with [aclrtHostRegister](#aclrtHostRegister) or [aclrtHostRegisterV2](#aclrtHostRegisterV2).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Host-side memory address. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtHostGetDevicePointerAddrRange"></a>

## aclrtHostGetDevicePointerAddrRange

```c
aclError aclrtHostGetDevicePointerAddrRange(aclrtAddrRange *addrRange, uint32_t *count)
```

### Applicable Products

<!-- npu="950" id974 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id974 -->
<!-- npu="A3" id975 -->
- Atlas A3 products: Not supported
<!-- end id975 -->
<!-- npu="910b" id976 -->
- Atlas A2 products: Not supported
<!-- end id976 -->
<!-- npu="310b" id977 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id977 -->
<!-- npu="310p" id978 -->
- Atlas inference products: Not supported
<!-- end id978 -->
<!-- npu="910" id979 -->
- Atlas training products: Not supported
<!-- end id979 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-02_host_memory_management_res.md#id10 -->

### Description

Obtains the address range of the device memory address mapped from host memory.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| addrRange | Output | Address range array, allocated by the caller.<br>For details about the type definition, see [aclrtAddrRange](25-04_Structs.md#aclrtAddrRange). |
| count | Input/Output | When **addrRange** is not empty, it serves as an input and indicates the length of the **addrRange** array; when **addrRange** is empty, it serves as an output and indicates the actual length of the returned array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
