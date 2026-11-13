# 21. Snapshot Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:33:44.655Z pushedAt=2026-11-09T10:39:05.144Z nl=2 -->

This section describes the snapshot management APIs of CANN Runtime, which lock, back up, and restore processes, and register callbacks.

- [`aclError aclrtSnapShotProcessLock(int pid, void* reserve)`](#aclrtSnapShotProcessLock): Locks the current process to block subsequent runtime API calls, including device setting/release, memory allocation/release/copy, creation and destruction of resources such as context/stream/event/notify, and some task delivery APIs.
- [`aclError aclrtSnapShotProcessBackup(int pid, aclrtSnapShotBackupArgs *args)`](#aclrtSnapShotProcessBackup): Backs up the device resources in a snapshot process and saves them on the host for subsequent restore. Multiple backups are supported for a process, and the last one takes effect.
- [`aclError aclrtSnapShotProcessRestore(int pid, aclrtSnapShotRestoreArgs *args)`](#aclrtSnapShotProcessRestore): Restores the device resources in a snapshot process based on the backup, starting from the last backup.
- [`aclError aclrtSnapShotProcessUnlock(int pid, void* reserve)`](#aclrtSnapShotProcessUnlock): Unlocks the current process on the device and unblocks the runtime API calls.
- [`aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)`](#aclrtSnapShotCallbackRegister): Registers a callback function, which will be called at different stages of the snapshot operation. Repeated registration is not supported.
- [`aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)`](#aclrtSnapShotCallbackUnregister): Unregisters a callback function. After unregistration, the callback function will no longer be called at the corresponding snapshot stage.

<a class="method_anchor" id="aclrtSnapShotProcessLock"></a>

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

<a class="method_anchor" id="aclrtSnapShotProcessBackup"></a>

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
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id2 -->

### Function

Backs up the device resources in a snapshot process and saves them on the host for subsequent restore. For the current process, multiple backups are supported, and only the last backup takes effect.

Before calling this API, ensure that the current process is in the LOCKED state. After calling this API, the current process transitions to the BACKED\_UP state.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| pid | Input | Process ID. Currently, only the ID of the current process is supported. Cross-process operations are not supported. |
| args | Input | Backup arguments, of type [aclrtSnapShotBackupArgs](25-04_Structs.md#aclrtSnapShotBackupArgs). Currently, only NULL is supported. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotProcessRestore"></a>

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
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id3 -->

### Function

Restores the device resources in a snapshot process based on the backup, starting from the last backup.

Before calling this API, ensure that the current process is in the BACKED\_UP status. After calling this API, the current process transitions to the LOCKED status.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| pid | Input | Process ID. Currently, only the ID of the current process is supported. Cross-process operations are not supported. |
| args | Input | Restore arguments, of type [aclrtSnapShotRestoreArgs](25-04_Structs.md#aclrtSnapShotRestoreArgs). Currently, only NULL is supported. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Restore and backup must be performed on the same device (with the same device ID). During restore, if the device is occupied by another process, the restore fails.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotProcessUnlock"></a>

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

<a class="method_anchor" id="aclrtSnapShotCallbackRegister"></a>

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

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotCallbackUnregister"></a>

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
