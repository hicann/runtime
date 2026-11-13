# 8. Notify Management

<!-- md-trans-meta sourceCommit=09c468b359b0e393f15436d7e1fc8eb9a77bcab0 translatedAt=2026-11-06T11:17:26.989Z pushedAt=2026-11-09T08:15:13.936Z nl=2 -->

This topic describes the Notify management APIs of CANN Runtime, which are used to create, record, wait for/reset, and share Notify across processes.

- [`aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)`](#aclrtCreateNotify): Creates a Notify.
- [`aclError aclrtDestroyNotify(aclrtNotify notify)`](#aclrtDestroyNotify): Destroys a Notify.
- [`aclError aclrtRecordNotify(aclrtNotify notify, aclrtStream stream)`](#aclrtRecordNotify): Records a Notify on a specified stream. This is an asynchronous API.
- [`aclError aclrtWaitAndResetNotify(aclrtNotify notify, aclrtStream stream, uint32_t timeout)`](#aclrtWaitAndResetNotify): Blocks the execution of a specified stream until the specified Notify completes, and then resets the Notify. This is an asynchronous API.
- [`aclError aclrtGetNotifyId(aclrtNotify notify, uint32_t *notifyId)`](#aclrtGetNotifyId): Obtains the ID of a specified Notify.
- [`aclError aclrtNotifyBatchReset(aclrtNotify *notifies, size_t num)`](#aclrtNotifyBatchReset): Resets Notifies in batches.
- [`aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flags)`](#aclrtNotifyGetExportKey): Sets a specified Notify in the current process as an Inter-Process Communication (IPC) Notify and returns the key (that is, the shared name of the Notify), which is used to implement task synchronization between different processes on multiple devices.
- [`aclError aclrtNotifySetImportPid(aclrtNotify notify, int32_t *pid, size_t num)`](#aclrtNotifySetImportPid): Sets the process trustlist for a shared Notify.
- [`aclError aclrtNotifySetImportPidInterServer(aclrtNotify notify, aclrtServerPid *serverPids, size_t num)`](#aclrtNotifySetImportPidInterServer): Sets the process trustlist for a shared Notify.
- [`aclError aclrtNotifyImportByKey(aclrtNotify *notify, const char *key, uint64_t flags)`](#aclrtNotifyImportByKey): Obtains the information of the key in the current process and returns the Notify pointer that can be used in the current process.

<a class="method_anchor" id="aclrtCreateNotify"></a>

## aclrtCreateNotify

```c
aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)
```

### Applicable Products

<!-- npu="950" id2549 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2549 -->
<!-- npu="A3" id2550 -->
- Atlas A3 products: Supported
<!-- end id2550 -->
<!-- npu="910b" id2551 -->
- Atlas A2 products: Supported
<!-- end id2551 -->
<!-- npu="310b" id2552 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2552 -->
<!-- npu="310p" id2553 -->
- Atlas inference products: Supported
<!-- end id2553 -->
<!-- npu="910" id2554 -->
- Atlas training products: Supported
<!-- end id2554 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id1 -->

### Description

Creates a Notify.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Output | Pointer to the Notify. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |
| flag | Input | Flag of the Notify pointer.<br>Currently, the flag can be set to the following macros:<br><br>  - **ACL_NOTIFY_DEFAULT**: Enabling this bit indicates that the created Notify is called on the host by default.<br><br><br>  - **ACL_NOTIFY_DEVICE_USE_ONLY**: Enabling this bit indicates that the created Notify is called only on the device.<br><br><br>The macro definitions are as follows:<br>#define ACL_NOTIFY_DEFAULT 0x00000000U<br>#define ACL_NOTIFY_DEVICE_USE_ONLY 0x00000001U |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id11 -->
The number of Notifies supported varies with the hardware model.
<!-- npu="950" id1 -->
- For Ascend 950PR&950DT products, the maximum number of Notifies supported by a single device is 65,535.
<!-- end id1 -->
<!-- npu="A3,910b" id2 -->
- For Atlas A3 products and Atlas A2 products, the maximum number of Notifies supported by a single device is 8192.
<!-- end id2 -->
<!-- npu="310b" id3 -->
- For Atlas 200I/500 A2 inference products, the maximum number of Notifies supported by a single device is 2048.
<!-- end id3 -->
<!-- npu="910,310p" id4 -->
- For Atlas inference products and Atlas training products, the maximum number of Notifies supported by a single device is 1024.
<!-- end id4 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id12 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyNotify"></a>

## aclrtDestroyNotify

```c
aclError aclrtDestroyNotify(aclrtNotify notify)
```

### Applicable Products

<!-- npu="950" id1660 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1660 -->
<!-- npu="A3" id1661 -->
- Atlas A3 products: Supported
<!-- end id1661 -->
<!-- npu="910b" id1662 -->
- Atlas A2 products: Supported
<!-- end id1662 -->
<!-- npu="310b" id1663 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1663 -->
<!-- npu="310p" id1664 -->
- Atlas inference products: Supported
<!-- end id1664 -->
<!-- npu="910" id1665 -->
- Atlas training products: Supported
<!-- end id1665 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id2 -->

### Description

Destroys a Notify.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Input | Notify to be destroyed. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtRecordNotify"></a>

## aclrtRecordNotify

```c
aclError aclrtRecordNotify(aclrtNotify notify, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2577 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2577 -->
<!-- npu="A3" id2578 -->
- Atlas A3 products: Supported
<!-- end id2578 -->
<!-- npu="910b" id2579 -->
- Atlas A2 products: Supported
<!-- end id2579 -->
<!-- npu="310b" id2580 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2580 -->
<!-- npu="310p" id2581 -->
- Atlas inference products: Supported
<!-- end id2581 -->
<!-- npu="910" id2582 -->
- Atlas training products: Supported
<!-- end id2582 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id3 -->

### Description

Records a Notify on a specified stream. This is an asynchronous API.

When used in conjunction with **aclrtWaitAndResetNotify**, **aclrtRecordNotify** is mainly used for synchronization waiting between multiple streams.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Input | Notify to be recorded. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>In a multi-stream synchronization waiting scenario, for example, where Stream2 waits for Stream1, set this parameter to Stream1. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtWaitAndResetNotify"></a>

## aclrtWaitAndResetNotify

```c
aclError aclrtWaitAndResetNotify(aclrtNotify notify, aclrtStream stream, uint32_t timeout)
```

### Applicable Products

<!-- npu="950" id1002 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1002 -->
<!-- npu="A3" id1003 -->
- Atlas A3 products: Supported
<!-- end id1003 -->
<!-- npu="910b" id1004 -->
- Atlas A2 products: Supported
<!-- end id1004 -->
<!-- npu="310b" id1005 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1005 -->
<!-- npu="310p" id1006 -->
- Atlas inference products: Supported
<!-- end id1006 -->
<!-- npu="910" id1007 -->
- Atlas training products: Supported
<!-- end id1007 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id4 -->

### Description

Blocks the execution of the specified stream until the specified Notify is complete, and then resets the Notify. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Input | Notify to wait for. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>In a multi-stream synchronous waiting scenario, for example, when Stream2 waits for Stream1, set this parameter to Stream2. |
| timeout | Input | Timeout period for waiting.<br>The value options are as follows:<br><br>  - **0**: permanent waiting.<br>  - **>0**: specific timeout period, in milliseconds. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetNotifyId"></a>

## aclrtGetNotifyId

```c
aclError aclrtGetNotifyId(aclrtNotify notify, uint32_t *notifyId)
```

### Applicable Products

<!-- npu="950" id3501 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3501 -->
<!-- npu="A3" id3502 -->
- Atlas A3 products: Supported
<!-- end id3502 -->
<!-- npu="910b" id3503 -->
- Atlas A2 products: Supported
<!-- end id3503 -->
<!-- npu="310b" id3504 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3504 -->
<!-- npu="310p" id3505 -->
- Atlas inference products: Supported
<!-- end id3505 -->
<!-- npu="910" id3506 -->
- Atlas training products: Supported
<!-- end id3506 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id5 -->

### Description

Obtains the ID of a specified Notify.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Input | Notify to be queried. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |
| notifyId | Output | Notify ID. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtNotifyBatchReset"></a>

## aclrtNotifyBatchReset

```c
aclError aclrtNotifyBatchReset(aclrtNotify *notifies, size_t num)
```

### Applicable Products

<!-- npu="950" id442 -->
- Ascend 950PR&950DT products: Supported
<!-- end id442 -->
<!-- npu="A3" id443 -->
- Atlas A3 products: Supported
<!-- end id443 -->
<!-- npu="910b" id444 -->
- Atlas A2 products: Supported
<!-- end id444 -->
<!-- npu="310b" id445 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id445 -->
<!-- npu="310p" id446 -->
- Atlas inference products: Not supported
<!-- end id446 -->
<!-- npu="910" id447 -->
- Atlas training products: Not supported
<!-- end id447 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id6 -->

### Description

Resets Notifies in batches.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notifies | Input | Notify array. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |
| num | Input | Length of the Notify array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This operation is not supported in the Ascend virtualization instance scenario.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtNotifyGetExportKey"></a>

## aclrtNotifyGetExportKey

```c
aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id3165 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id3165 -->
<!-- npu="A3" id3166 -->
- Atlas A3 products: Supported
<!-- end id3166 -->
<!-- npu="910b" id3167 -->
- Atlas A2 products: Supported
<!-- end id3167 -->
<!-- npu="310b" id3168 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3168 -->
<!-- npu="310p" id3169 -->
- Atlas inference products: Supported
<!-- end id3169 -->
<!-- npu="910" id3170 -->
- Atlas training products: Supported
<!-- end id3170 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id7 -->

### Description

Sets a specified Notify in the current process as an Inter-Process Communication (IPC) Notify and returns a key (that is, the shared name of the Notify), which is used to implement task synchronization between different processes on multiple devices.

**This API must be used in conjunction with the following other key APIs** to achieve inter-process task synchronization on multiple devices. The following uses process A on Device 0 and process B on Device 1 as an example to describe the API call flow for task synchronization between the two processes:

1. In process A:
    1. Call [aclrtCreateNotify](#aclrtCreateNotify) to create a Notify.
    2. Call [aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey) to export the key (that is, the shared name of the Notify).

        When calling [aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey), you can specify whether to enable process trustlist verification. If enabled, you need to separately call [aclrtNotifySetImportPid](#aclrtNotifySetImportPid) to set the ID of process B to the trustlist; otherwise, there is no need to call [aclrtNotifySetImportPid](#aclrtNotifySetImportPid).

    3. Call [aclrtWaitAndResetNotify](#aclrtWaitAndResetNotify) to dispatch a wait task.
    4. Call [aclrtDestroyNotify](#aclrtDestroyNotify) to destroy the Notify.

        All processes involved in the IPC Notify must release the Notify. The Notify is actually released only after all processes involved in the IPC Notify have completed the release operation.

2. In process B:
    1. Call [aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid) to obtain the ID of process B.

        When obtaining the process ID, this API has adapted to both physical machine and virtual machine scenarios. The user only needs to call this API to obtain the process ID and then use it together with other APIs to achieve memory sharing. If the user does not call this API and obtains the process ID by themselves, subsequent use of the process ID may be abnormal.

    2. Call [aclrtNotifyImportByKey](#aclrtNotifyImportByKey) to obtain the key information and return the Notify pointer that can be used by the current process. It is recommended that **flag** use **ACL\_RT\_NOTIFY\_IMPORT\_FLAG\_ENABLE\_PEER\_ACCESS** to enable data interaction between two devices.

        Before calling [aclrtNotifyImportByKey](#aclrtNotifyImportByKey), ensure that the IPC Notify has not been released in advance.

    3. Call [aclrtRecordNotify](#aclrtRecordNotify) to dispatch a Record task.
    4. Call [aclrtDestroyNotify](#aclrtDestroyNotify) to destroy the Notify.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Input | Notify. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |
| key | Output | Shared name of the Notify. |
| len | Input | Length of the Notify shared name, with a minimum length of 65. |
| flags | Input | Whether to enable process trustlist validation.<br>The value is one of the following macros:<br><br>  - **ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT**: enable process trustlist validation. This is the default value. When this value is set, you must separately call [aclrtNotifySetImportPid](#aclrtNotifySetImportPid) to add the process ID that uses the Notify shared name to the trustlist.<br>  - **ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION**: disable process trustlist validation. When this value is set, you do not need to call [aclrtNotifySetImportPid](#aclrtNotifySetImportPid).<br><br><br>The macros are defined as follows:<br>#define ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x02UL |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This operation is not supported in the Ascend virtualization instance scenario.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtNotifySetImportPid"></a>

## aclrtNotifySetImportPid

```c
aclError aclrtNotifySetImportPid(aclrtNotify notify, int32_t *pid, size_t num)
```

### Applicable Products

<!-- npu="950" id1807 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id1807 -->
<!-- npu="A3" id1808 -->
- Atlas A3 products: Supported
<!-- end id1808 -->
<!-- npu="910b" id1809 -->
- Atlas A2 products: Supported
<!-- end id1809 -->
<!-- npu="310b" id1810 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1810 -->
<!-- npu="310p" id1811 -->
- Atlas inference products: Supported
<!-- end id1811 -->
<!-- npu="910" id1812 -->
- Atlas training products: Supported
<!-- end id1812 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id8 -->

### Description

Sets the process trustlist for a shared Notify.

This API must be used in conjunction with other APIs to achieve task synchronization between different processes on multiple devices. For details, see the description of the [aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Input | Notify. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify).<br>It must be consistent with the Notify in the [aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey) API. |
| pid | Input | Array used to store trustlisted process IDs.<br>The process ID can be obtained by calling the [aclrtDeviceGetBareTgid](04_device_management.md#aclrtDeviceGetBareTgid) API. In a docker scenario, the obtained ID is the process ID on the physical machine; in a non-docker scenario, the obtained ID is the process ID. |
| num | Input | Number of trustlisted processes, which must be consistent with the size of the **pid** parameter array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="910b,910,310p" id5 -->
### Constraints

This operation is not supported in the Ascend virtualization instance scenario.
<!-- end id5 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtNotifySetImportPidInterServer"></a>

## aclrtNotifySetImportPidInterServer

```c
aclError aclrtNotifySetImportPidInterServer(aclrtNotify notify, aclrtServerPid *serverPids, size_t num)
```

### Applicable Products

<!-- npu="950" id3270 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3270 -->
<!-- npu="A3" id3271 -->
- Atlas A3 products: Supported
<!-- end id3271 -->
<!-- npu="910b" id3272 -->
- Atlas A2 products: Not supported
<!-- end id3272 -->
<!-- npu="310b" id3273 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3273 -->
<!-- npu="310p" id3274 -->
- Atlas inference products: Not supported
<!-- end id3274 -->
<!-- npu="910" id3275 -->
- Atlas training products: Not supported
<!-- end id3275 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id9 -->

### Description

Sets the process trustlist of a shared Notify.

<!-- npu="A3" id6 -->
This API applies only to the super node products in the Atlas A3 products.
<!-- end id6 -->

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Input | Notify. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify).<br>You must first call [aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey) to obtain the shared name of the specified Notify, and then pass it as an input parameter. |
| serverPids | Input | Trustlist information array. For details about the type definition, see [aclrtServerPid](25-04_Structs.md#aclrtServerPid). |
| num | Input | Size of the **serverPids** array. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtNotifyImportByKey"></a>

## aclrtNotifyImportByKey

```c
aclError aclrtNotifyImportByKey(aclrtNotify *notify, const char *key, uint64_t flags)
```

### Applicable Products

<!-- npu="950" id2101 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id2101 -->
<!-- npu="A3" id2102 -->
- Atlas A3 products: Supported
<!-- end id2102 -->
<!-- npu="910b" id2103 -->
- Atlas A2 products: Supported
<!-- end id2103 -->
<!-- npu="310b" id2104 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2104 -->
<!-- npu="310p" id2105 -->
- Atlas inference products: Supported
<!-- end id2105 -->
<!-- npu="910" id2106 -->
- Atlas training products: Supported
<!-- end id2106 -->
<!-- @ref: runtime/res/docs/zh/api_ref/08_notify_management_res.md#id10 -->

### Description

Obtains the key information in the current process and returns a Notify pointer that can be used in the current process.

This API must be used in conjunction with other APIs to achieve task synchronization between different processes on multiple devices. For details, see the description of the [aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| notify | Output | Notify pointer. For details about the type definition, see [aclrtNotify](25-05_Typedefs.md#aclrtNotify). |
| key | Input | Shared name of the Notify.<br>You must first call the [aclrtNotifyGetExportKey](#aclrtNotifyGetExportKey) API to obtain the shared name of the specified Notify, and then pass it as an input parameter. |
| flags | Input | Whether to enable data interaction between two devices.<br>The value is one of the following macros:<br><br>  - **ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT**: disable data interaction between two devices. This is the default value. When this value is set, you must separately call the [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess) API to enable data interaction between two devices.<br>  - **ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS**: enable data interaction between two devices. When this value is set, there is no need to call the [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess) API.<br><br><br>The macro definitions are as follows:<br>#define ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS 0x02UL |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="910b,910,310p" id7 -->
### Constraints

This operation is not supported in the Ascend virtualization instance scenario.
<!-- end id7 -->
