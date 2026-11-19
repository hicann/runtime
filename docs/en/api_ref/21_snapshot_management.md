# 21. Snapshot Management

<!-- md-trans-meta sourceCommit=6b0fd8c6df946e4dd62a62605cdf0121a78564f1 translatedAt=2026-11-11T07:11:07.802Z pushedAt=2026-11-17T01:35:21.813Z nl=2 -->

This section describes the snapshot management APIs of CANN Runtime, which lock, back up, and restore processes, and register callbacks.

- [`aclError aclrtSnapShotProcessLock(int pid, void* reserve)`](#aclrtSnapShotProcessLock): Locks the current process to block subsequent runtime API calls, including device setting/release, memory allocation/release/copy, creation and destruction of resources such as context/stream/event/notify, and some task delivery APIs.
- [`aclError aclrtSnapShotProcessBackup(int pid, aclrtSnapShotBackupArgs *args)`](#aclrtSnapShotProcessBackup): Backs up the device resources in a snapshot process and saves them on the host for subsequent restore. Multiple backups are supported for a process, and the last one takes effect.
- [`aclError aclrtSnapShotProcessRestore(int pid, aclrtSnapShotRestoreArgs *args)`](#aclrtSnapShotProcessRestore): Restores the device resources in a snapshot process based on the backup, starting from the last backup.
- [`aclError aclrtSnapShotProcessUnlock(int pid, void* reserve)`](#aclrtSnapShotProcessUnlock): Unlocks the current process on the device and unblocks the runtime API calls.
- [`aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)`](#aclrtSnapShotCallbackRegister): Registers a callback function, which will be called at different stages of the snapshot operation. Repeated registration is not supported.
- [`aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)`](#aclrtSnapShotCallbackUnregister): Unregisters a callback function. After unregistration, the callback function will no longer be called at the corresponding snapshot stage.

<a id="aclrtSnapShotProcessLock"></a>

## aclrtSnapShotProcessLock

```c
aclError aclrtSnapShotProcessLock(int pid, void* reserve)
```

**Note: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1639 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id1639 -->
<!-- npu="A3" id1640 -->
- Atlas A3 products: Supported
<!-- end id1640 -->
<!-- npu="910b" id1641 -->
- Atlas A2 products: Supported
<!-- end id1641 -->
<!-- npu="310b" id1642 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1642 -->
<!-- npu="310p" id1643 -->
- Atlas inference products: Not supported
<!-- end id1643 -->
<!-- npu="910" id1644 -->
- Atlas training products: Not supported
<!-- end id1644 -->
<!-- npu="IPV350" id1645 -->
- IPV350: Not supported
<!-- end id1645 -->
<!-- npu="5162A" id5001 -->
- Hisilicon5162A: Not supported
<!-- end id5001 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id1 -->

### Function

Locks the current process to block subsequent runtime API calls, including device setting/release, memory allocation/release/copy, creation and destruction of resources such as context/stream/event/notify, and some task delivery APIs.

Before calling this API, ensure that the current process is in the RUNNING state (this is the default state). After calling this API, the current process transitions to the LOCKED status.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| pid | Input | Process ID. Currently, only the ID of the current process is supported. Cross-process operations are not supported. |
| reserve | Input | Reserved parameter. Currently, only NULL is supported. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a id="aclrtSnapShotProcessBackup"></a>

## aclrtSnapShotProcessBackup

```c
aclError aclrtSnapShotProcessBackup(int pid, aclrtSnapShotBackupArgs *args)
```

**Note: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1380 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id1380 -->
<!-- npu="A3" id1381 -->
- Atlas A3 products: Supported
<!-- end id1381 -->
<!-- npu="910b" id1382 -->
- Atlas A2 products: Supported
<!-- end id1382 -->
<!-- npu="310b" id1383 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1383 -->
<!-- npu="310p" id1384 -->
- Atlas inference products: Not supported
<!-- end id1384 -->
<!-- npu="910" id1385 -->
- Atlas training products: Not supported
<!-- end id1385 -->
<!-- npu="IPV350" id1386 -->
- IPV350: Not supported
<!-- end id1386 -->
<!-- npu="5162A" id5002 -->
- Hisilicon5162A: Not supported
<!-- end id5002 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id2 -->

### Function

Backs up the device resources in a snapshot process and saves them on the host for subsequent restore. For the current process, multiple backups are supported, and only the last backup takes effect.

Before calling this API, ensure that the current process is in the LOCKED state. After calling this API, the current process transitions to the BACKED\_UP state.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| pid | Input | Process ID. Currently, only the ID of the current process is supported. Cross-process operations are not supported. |
| args | Input | Backup arguments, of the [aclrtSnapShotBackupArgs](25-04_Structs.md#aclrtSnapShotBackupArgs) type. When NULL is passed, the legacy Runtime backup process is used; when a non-NULL value is passed, the driver's device memory snapshot process is used, and the driver must support the device memory snapshot capability. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a id="aclrtSnapShotProcessRestore"></a>

## aclrtSnapShotProcessRestore

```c
aclError aclrtSnapShotProcessRestore(int pid, aclrtSnapShotRestoreArgs *args)
```

**Note: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id3130 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id3130 -->
<!-- npu="A3" id3131 -->
- Atlas A3 products: Supported
<!-- end id3131 -->
<!-- npu="910b" id3132 -->
- Atlas A2 products: Supported
<!-- end id3132 -->
<!-- npu="310b" id3133 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3133 -->
<!-- npu="310p" id3134 -->
- Atlas inference products: Not supported
<!-- end id3134 -->
<!-- npu="910" id3135 -->
- Atlas training products: Not supported
<!-- end id3135 -->
<!-- npu="IPV350" id3136 -->
- IPV350: Not supported
<!-- end id3136 -->
<!-- npu="5162A" id5003 -->
- Hisilicon5162A: Not supported
<!-- end id5003 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id3 -->

### Function

Restores the device resources in a snapshot process based on the backup, starting from the last backup.

Before calling this API, ensure that the current process is in the BACKED\_UP status. After calling this API, the current process transitions to the LOCKED status.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| pid | Input | Process ID. Currently, only the ID of the current process is supported. Cross-process operations are not supported. |
| args | Input | Restoration arguments, of the [aclrtSnapShotRestoreArgs](25-04_Structs.md#aclrtSnapShotRestoreArgs) type. When NULL is passed, the legacy Runtime restoration process is used; when a non-NULL value is passed, the driver's device memory snapshot process is used, and the driver must support the device memory snapshot capability. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Restoration and backup must be performed on the same device (that is, with the same device ID). During restoration, if the device is occupied by another process, the restoration fails. When `args` is not NULL, before restoration, the driver's device memory snapshot capability is checked, and then the backup version information is checked: the HAL API version used by Runtime and the driver API version must be consistent with those at backup time. After the version check passes, the device is restarted. If the backup version information is invalid or the versions do not match, `ACL_ERROR_SNAPSHOT_RESTORE_FAILED` (507909) is returned; if the version query fails, the corresponding error is returned. When `args` is NULL, the legacy Runtime restoration process is used, and the preceding device memory snapshot compatibility and version consistency checks are not performed.

<br>
<br>
<br>

<a id="aclrtSnapShotProcessUnlock"></a>

## aclrtSnapShotProcessUnlock

```c
aclError aclrtSnapShotProcessUnlock(int pid, void* reserve)
```

**Note: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id2822 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id2822 -->
<!-- npu="A3" id2823 -->
- Atlas A3 products: Supported
<!-- end id2823 -->
<!-- npu="910b" id2824 -->
- Atlas A2 products: Supported
<!-- end id2824 -->
<!-- npu="310b" id2825 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2825 -->
<!-- npu="310p" id2826 -->
- Atlas inference products: Not supported
<!-- end id2826 -->
<!-- npu="910" id2827 -->
- Atlas training products: Not supported
<!-- end id2827 -->
<!-- npu="IPV350" id2828 -->
- IPV350: Not supported
<!-- end id2828 -->
<!-- npu="5162A" id5004 -->
- Hisilicon5162A: Not supported
<!-- end id5004 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id4 -->

### Function

Unlocks the current process on a device and unblocks runtime API calls.

Before calling this API, ensure that the current process is in the LOCKED or BACKED\_UP status. After calling this API, the current process transitions to the RUNNING status.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| pid | Input | Process ID. Currently, only the ID of the current process is supported. Cross-process operations are not supported. |
| reserve | Input | Reserved parameter. Currently, only NULL is supported. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a id="aclrtSnapShotCallbackRegister"></a>

## aclrtSnapShotCallbackRegister

```c
aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)
```

**Note: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id2766 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id2766 -->
<!-- npu="A3" id2767 -->
- Atlas A3 products: Supported
<!-- end id2767 -->
<!-- npu="910b" id2768 -->
- Atlas A2 products: Supported
<!-- end id2768 -->
<!-- npu="310b" id2769 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2769 -->
<!-- npu="310p" id2770 -->
- Atlas inference products: Not supported
<!-- end id2770 -->
<!-- npu="910" id2771 -->
- Atlas training products: Not supported
<!-- end id2771 -->
<!-- npu="IPV350" id2772 -->
- IPV350: Not supported
<!-- end id2772 -->
<!-- npu="5162A" id5005 -->
- Hisilicon5162A: Not supported
<!-- end id5005 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id5 -->

### Function

Registers a callback function that is called at different stages of snapshot operations. Repeated registration is not supported.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stage | Input | Snapshot stage that triggers the callback. For the type definition, see [aclrtSnapShotStage](25-02_Enumerations.md#aclrtSnapShotStage). |
| callback | Input | Pointer to the callback function. The system automatically calls this function when the specified snapshot stage is reached.<br>The function is defined as follows:<br>typedef uint32_t (*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |
| args | Input | Pointer to user-defined parameters, which is passed when the callback function is called. It can be NULL, indicating that no additional parameters need to be passed. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The callback function can only be used to back up and restore the service's own state.
- It is prohibited to call Runtime APIs inside a callback function (including but not limited to snapshot management APIs, such as callback function registration and unregistration, process lock and unlock, and asynchronous copy); otherwise, the process may hang or undefined behavior may occur.

<br>
<br>
<br>

<a id="aclrtSnapShotCallbackUnregister"></a>

## aclrtSnapShotCallbackUnregister

```c
aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)
```

**Note: This API is an experimental feature and may change in future releases. Do not use it in production.**

### Applicable Products

<!-- npu="950" id1772 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id1772 -->
<!-- npu="A3" id1773 -->
- Atlas A3 products: Supported
<!-- end id1773 -->
<!-- npu="910b" id1774 -->
- Atlas A2 products: Supported
<!-- end id1774 -->
<!-- npu="310b" id1775 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1775 -->
<!-- npu="310p" id1776 -->
- Atlas inference products: Not supported
<!-- end id1776 -->
<!-- npu="910" id1777 -->
- Atlas training products: Not supported
<!-- end id1777 -->
<!-- npu="IPV350" id1778 -->
- IPV350: Not supported
<!-- end id1778 -->
<!-- npu="5162A" id5006 -->
- Hisilicon5162A: Not supported
<!-- end id5006 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id6 -->

### Function

Unregisters a callback function. After unregistration, the callback function is no longer called in the corresponding snapshot stage.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stage | Input | Snapshot stage that triggers the callback. For the type definition, see [aclrtSnapShotStage](25-02_Enumerations.md#aclrtSnapShotStage). |
| callback | Input | Pointer to the callback function to unregister.<br>The function is defined as follows:<br>typedef uint32_t (*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).
