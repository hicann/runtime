# 11-07 IPC Inter-Process Memory Sharing

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:22:42.809Z pushedAt=2026-11-09T09:04:15.896Z nl=2 -->

This chapter describes the IPC (Inter-Process Communication) inter-process memory sharing APIs, which are used for cross-process memory export and import.

- [`aclError aclrtIpcMemGetExportKey(void *devPtr, size_t size, char *key, size_t len, uint64_t flags)`](#aclrtIpcMemGetExportKey): Sets the specified device memory as IPC (Inter-Process Communication) shared memory in the current process and returns the shared memory key for subsequent sharing of the memory with other processes.
- [`aclError aclrtIpcMemSetImportPid(const char *key, int32_t *pid, size_t num)`](#aclrtIpcMemSetImportPid): Sets the process trustlist for IPC shared memory.
- [`aclError aclrtIpcMemImportPidInterServer(const char *key, aclrtServerPid *serverPids, size_t num)`](#aclrtIpcMemImportPidInterServer): Sets the process trustlists for IPC shared memory in batches for the supernode products in Atlas A3 products.
- [`aclError aclrtIpcMemImportByKey(void **devPtr, const char *key, uint64_t flags)`](#aclrtIpcMemImportByKey): Imports the key information in the current process and returns the device memory address pointer that the current process can use.
- [`aclError aclrtIpcMemSetAttr(const char *key, aclrtIpcMemAttrType type, uint64_t attr)`](#aclrtIpcMemSetAttr): Sets the attribute information of IPC shared memory.
- [`aclError aclrtIpcMemClose(const char *key)`](#aclrtIpcMemClose): Closes the IPC shared memory. This API must be called in both the process that calls [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) and the process that calls [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey).

<a class="method_anchor" id="aclrtIpcMemGetExportKey"></a>

## aclrtIpcMemGetExportKey

```c
aclError aclrtIpcMemGetExportKey(void *devPtr, size_t size, char *key, size_t len, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id1275 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1275 -->
<!-- npu="A3" id1276 -->
- Atlas A3 products: Supported
<!-- end id1276 -->
<!-- npu="910b" id1277 -->
- Atlas A2 products: Supported
<!-- end id1277 -->
<!-- npu="310b" id1278 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1278 -->
<!-- npu="310p" id1279 -->
- Atlas inference products: Supported
<!-- end id1279 -->
<!-- npu="910" id1280 -->
- Atlas training products: Supported
<!-- end id1280 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-07_IPC_memory_sharing_res.md#id1 -->

### Description

Sets the specified device memory in the current process as IPC (Inter-Process Communication) shared memory and returns the shared memory key for subsequent sharing of the memory with other processes.

**This API must be used together with the following other key APIs** to achieve memory sharing. The following uses processes A and B as an example to describe the API call procedure for memory sharing between two processes:

1. In process A:
    1. Call [aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc) to allocate memory.
    2. Call [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) to export the shared memory key.

        When calling [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey), you can specify whether to enable process trustlist validation. If enabled, you must separately call [aclrtIpcMemSetImportPid](#aclrtIpcMemSetImportPid) to set the process ID of process B to the trustlist; otherwise, there is no need to call [aclrtIpcMemSetImportPid](#aclrtIpcMemSetImportPid).

    3. Call [aclrtIpcMemClose](#aclrtIpcMemClose) to close the IPC shared memory.

        After process B calls [aclrtIpcMemClose](#aclrtIpcMemClose) to close the IPC shared memory, process A closes the IPC shared memory; otherwise, an exception may occur.

    4. Call [aclrtFree](11-01_device_memory_malloc_and_free.md#aclrtFree) to free the memory.

2. In process B:
    1. Call the [aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid) API to obtain the process ID of process B.

        When obtaining the process ID, this API has internally adapted to physical machine and virtual machine scenarios. You only need to call this API to obtain the process ID and then use it together with other APIs to achieve memory sharing. If you do not call this API and obtain the process ID by yourself, subsequent use of the process ID may be abnormal.

    2. Call [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) to obtain the key information and return the device memory address pointer that can be used by the current process.

        Before calling the [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) API, ensure that the memory to be shared exists and must not be released in advance.

    3. Call the [aclrtIpcMemClose](#aclrtIpcMemClose) API to close the IPC shared memory.

        Each successful call to the [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) API must be followed by a call to the [aclrtIpcMemClose](#aclrtIpcMemClose) API, and the key passed to the two APIs must be the same. That is, the two APIs must be called in pairs.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Input | Device memory address. |
| size | Input | Memory size, in bytes. |
| key | Output | Shared memory key, which is a character array of length `len`. |
| len | Input | Length of the key, fixed to 65. |
| flags | Input | Whether to enable process trustlist validation.<br>The value is one of the following macros:<br><br>  - ACL_RT_IPC_MEM_EXPORT_FLAG_DEFAULT: default value, which enables process trustlist validation. When this value is configured, call [aclrtIpcMemSetImportPid](#aclrtIpcMemSetImportPid) separately to add the process ID that uses the shared memory key to the trustlist.<br>  - ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION: disables process trustlist validation. When this value is configured, there is no need to call [aclrtIpcMemSetImportPid](#aclrtIpcMemSetImportPid).<br><br><br>The macros are defined as follows:<br>#define ACL_RT_IPC_MEM_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

When two processes on different devices share memory through IPC, as shown in the following figure, process A on Device 0 shares memory with process B on Device 1 through IPC, and process B uses this shared memory address.

![](figures/IPC_shared_memory_diagram.png)

When process B uses the shared memory address, note the following requirements (these requirements do not apply when two processes on the same device share memory through IPC):

<!-- npu="310p" id1 -->
- On Atlas inference products, when calling the [aclrtMalloc](11-01_device_memory_malloc_and_free.md#aclrtMalloc) API to allocate device memory, select the P2P type for policy, for example ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P.
<!-- end id1 -->
- During memory copy, the copy direction cannot be automatically determined based on the source memory address pointer and the destination memory address pointer. Memory copy operations in the Host-\>Device or Device-\>Host direction are not supported, for both synchronous and asynchronous copy. Synchronous memory copy within the same device is not supported, but asynchronous memory copy within the same device is supported.
- Cross-chip access by the cube unit and vector unit is supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtIpcMemSetImportPid"></a>

## aclrtIpcMemSetImportPid

```c
aclError aclrtIpcMemSetImportPid(const char *key, int32_t *pid, size_t num)
```

### Applicable Products

<!-- npu="950" id1191 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1191 -->
<!-- npu="A3" id1192 -->
- Atlas A3 products: Supported
<!-- end id1192 -->
<!-- npu="910b" id1193 -->
- Atlas A2 products: Supported
<!-- end id1193 -->
<!-- npu="310b" id1194 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1194 -->
<!-- npu="310p" id1195 -->
- Atlas inference products: Supported
<!-- end id1195 -->
<!-- npu="910" id1196 -->
- Atlas training products: Supported
<!-- end id1196 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-07_IPC_memory_sharing_res.md#id2 -->

### Description

Sets the process trustlist for IPC shared memory.

Use this interface together with other interfaces to achieve the purpose of memory sharing. For details, refer to the description of the [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) interface.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| key | Input | Memory key obtained through the [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) API. |
| pid | Input | Array used to store the trustlisted process IDs.<br>The process ID can be obtained by calling the [aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid) API. In a Docker scenario, the obtained ID is the process ID on the physical machine; in a non-Docker scenario, the obtained ID is the process ID. |
| num | Input | Number of trustlist processes, which must be consistent with the size of the pid parameter array. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtIpcMemImportPidInterServer"></a>

## aclrtIpcMemImportPidInterServer

```c
aclError aclrtIpcMemImportPidInterServer(const char *key, aclrtServerPid *serverPids, size_t num)
```

### Applicable Products

<!-- npu="950" id519 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id519 -->
<!-- npu="A3" id520 -->
- Atlas A3 products: Supported
<!-- end id520 -->
<!-- npu="910b" id521 -->
- Atlas A2 products: Not supported
<!-- end id521 -->
<!-- npu="310b" id522 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id522 -->
<!-- npu="310p" id523 -->
- Atlas inference products: Not supported
<!-- end id523 -->
<!-- npu="910" id524 -->
- Atlas training products: Not supported
<!-- end id524 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-07_IPC_memory_sharing_res.md#id3 -->

### Description

Sets the process trustlists for IPC shared memory in batches.

<!-- npu="A3" id2 -->
This API applies only to the supernode products in Atlas A3 products.
<!-- end id2 -->

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| key | Input | Name used for inter-process sharing.<br>You must first call [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) to obtain the shared memory key, and then pass it as an input parameter. |
| serverPids | Input | Trustlist information array. For the type definition, see [aclrtServerPid](25-04_Structs.md#aclrtServerPid). |
| num | Input | Size of the serverPids array. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtIpcMemImportByKey"></a>

## aclrtIpcMemImportByKey

```c
aclError aclrtIpcMemImportByKey(void **devPtr, const char *key, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id568 -->
- Ascend 950PR&950DT products: Supported
<!-- end id568 -->
<!-- npu="A3" id569 -->
- Atlas A3 products: Supported
<!-- end id569 -->
<!-- npu="910b" id570 -->
- Atlas A2 products: Supported
<!-- end id570 -->
<!-- npu="310b" id571 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id571 -->
<!-- npu="310p" id572 -->
- Atlas inference products: Supported
<!-- end id572 -->
<!-- npu="910" id573 -->
- Atlas training products: Supported
<!-- end id573 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-07_IPC_memory_sharing_res.md#id4 -->

### Description

Imports the key information in the current process and returns the device memory address pointer that the current process can use.

This API must be used together with other APIs to achieve memory sharing. For the procedure of using them together, see the description of [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey).

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Output | Device memory address pointer. |
| key | Input | Shared memory key.<br>You must first call [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) to obtain the shared memory key, and then pass it as an input parameter. |
| flags | Input | Whether to enable data interaction between two devices.<br>The value is one of the following macros:<br><br>  - ACL_RT_IPC_MEM_IMPORT_FLAG_DEFAULT: default value, which disables data interaction between two devices. When this value is configured, you must separately call [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess) to enable data interaction between the two devices.<br>  - ACL_RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS: enables data interaction between two devices. When this value is configured, you do not need to call [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess).<br><br><br>The macros are defined as follows:<br>#define ACL_RT_IPC_MEM_IMPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS 0x1UL |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtIpcMemSetAttr"></a>

## aclrtIpcMemSetAttr

```c
aclError aclrtIpcMemSetAttr(const char *key, aclrtIpcMemAttrType type, uint64_t attr)
```

### Applicable Products

<!-- npu="950" id421 -->
- Ascend 950PR&950DT products: Supported
<!-- end id421 -->
<!-- npu="A3" id422 -->
- Atlas A3 products: Supported
<!-- end id422 -->
<!-- npu="910b" id423 -->
- Atlas A2 products: Not supported
<!-- end id423 -->
<!-- npu="310b" id424 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id424 -->
<!-- npu="310p" id425 -->
- Atlas inference products: Not supported
<!-- end id425 -->
<!-- npu="910" id426 -->
- Atlas training products: Not supported
<!-- end id426 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-07_IPC_memory_sharing_res.md#id5 -->

### Description

Sets the attribute information of IPC shared memory.

<!-- npu="A3" id3 -->
For Atlas A3 products, to set the attribute information of IPC shared memory, in the process that calls the [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) API, call the aclrtIpcMemSetAttr API first, and then call the [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) API. The key in the two APIs must be consistent.
<!-- end id3 -->

<!-- npu="950" id4 -->
For Ascend 950PR&950DT products, to set the attribute information of IPC shared memory, in the process that calls the [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) API, call the aclrtIpcMemSetAttr API first, and then call the [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) API. The key in the two APIs must be consistent.

When the aclrtIpcMemSetAttr API is called multiple times for the same key to set attr, the attr value set last takes effect.
<!-- end id4 -->

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| key | Input | Shared memory key.<br>You must first call [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) to obtain the shared memory key, and then pass it as an input parameter. |
| type | Input | Memory mapping type. For the type definition, see [aclrtIpcMemAttrType](25-02_Enumerations.md#aclrtIpcMemAttrType).<br>Currently, it can be configured as ACL_RT_IPC_MEM_ATTR_ACCESS_LINK, which is used to specify the access link type during cross-chip access. |
| attr | Input | Attribute. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950,A3" id7 -->
### Constraints

<!-- npu="950" id5 -->
- For Ascend 950PR&950DT products, attr supports the following values:
    - ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_UB_ONE_PORT_PATH (value 2): UB (Unified Bus) single-port path: FM (Full Mesh) connection mode, with no hierarchy and full point-to-point direct connection.
    - ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_UB_MULTI_PORT_PATH (value 3): UB (Unified Bus) multi-port path: CLOS connection mode, with hierarchical structured interconnection.

    If any other value is passed, the [ACL_ERROR_RT_LINK_TYPE_NOT_SUPPORTED](25-01_aclError.md) error code is returned.
<!-- end id5 -->
<!-- npu="A3" id6 -->
- For Atlas A3 products, attr supports the following values:
    - ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_SIO (value 0): SIO channel, an on-chip connection mode used to connect two dies.
    - ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_HCCS (value 1): HCCS channel. HCCS is the Huawei Cache Coherence System (HCCS), used for high-speed interconnection between CPU and NPU.

    If any other value is passed, the [ACL_ERROR_RT_FEATURE_NOT_SUPPORT](25-01_aclError.md) error code is returned.
<!-- end id6 -->
<!-- end id7 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtIpcMemClose"></a>

## aclrtIpcMemClose

```c
aclError aclrtIpcMemClose(const char *key)
```

### Applicable Products

<!-- npu="950" id1303 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1303 -->
<!-- npu="A3" id1304 -->
- Atlas A3 products: Supported
<!-- end id1304 -->
<!-- npu="910b" id1305 -->
- Atlas A2 products: Supported
<!-- end id1305 -->
<!-- npu="310b" id1306 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1306 -->
<!-- npu="310p" id1307 -->
- Atlas inference products: Supported
<!-- end id1307 -->
<!-- npu="910" id1308 -->
- Atlas training products: Supported
<!-- end id1308 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-07_IPC_memory_sharing_res.md#id6 -->

### Description

Closes the IPC shared memory. This API must be called in the process that calls [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) and in the process that calls [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey).

For the same shared memory key, the process that calls [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) can call aclrtIpcMemClose only after all processes that call [aclrtIpcMemImportByKey](#aclrtIpcMemImportByKey) have called aclrtIpcMemClose. Otherwise, an exception may occur.

This API must be used together with other APIs to achieve memory sharing. For details, see the description of the [aclrtIpcMemGetExportKey](#aclrtIpcMemGetExportKey) API.

### Parameters

| Parameter Name | Input/Output | Description |
| --- | :---: | --- |
| key | Input | Shared memory key obtained through the aclrtIpcMemGetExportKey API. |

### Return Values

Returns 0 on success and other values on failure. For details, see [aclError](25-01_aclError.md#aclError).
