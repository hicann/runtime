# 21. 快照管理

本章节描述 CANN Runtime 的快照管理接口，用于进程状态的锁定、备份、恢复及回调注册。

- [`aclError aclrtSnapShotProcessLock(int pid, void* reserve)`](#aclrtSnapShotProcessLock)：锁定当前进程，以阻止后续的运行时接口调用，包括Device设置/释放、内存的申请/释放/拷贝、Context/Stream/Event/Notify等资源的创建与销毁、以及部分任务下发接口。
- [`aclError aclrtSnapShotProcessBackup(int pid, aclrtSnapShotBackupArgs *args)`](#aclrtSnapShotProcessBackup)：备份快照进程中的Device资源，并将Device资源保存在Host侧，以便后续恢复。针对当前进程，支持多次备份，以最后一次生效。
- [`aclError aclrtSnapShotProcessRestore(int pid, aclrtSnapShotRestoreArgs *args)`](#aclrtSnapShotProcessRestore)：恢复快照进程中的Device资源。根据备份好的Device资源进行恢复，从最后一次备份点进行恢复。
- [`aclError aclrtSnapShotProcessUnlock(int pid, void* reserve)`](#aclrtSnapShotProcessUnlock)：解锁Device上的当前进程，同时解除运行时接口的阻塞调用。
- [`aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)`](#aclrtSnapShotCallbackRegister)：注册一个回调函数，该回调函数将在快照操作的不同阶段被调用。不支持重复注册。
- [`aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)`](#aclrtSnapShotCallbackUnregister)：取消注册回调函数。取消注册之后，对应快照阶段将不再调用该回调函数。

<a id="aclrtSnapShotProcessLock"></a>

## aclrtSnapShotProcessLock

```c
aclError aclrtSnapShotProcessLock(int pid, void* reserve)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1639 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1639 -->
<!-- npu="A3" id1640 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1640 -->
<!-- npu="910b" id1641 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1641 -->
<!-- npu="310b" id1642 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1642 -->
<!-- npu="310p" id1643 -->
- Atlas 推理系列产品：不支持
<!-- end id1643 -->
<!-- npu="910" id1644 -->
- Atlas 训练系列产品：不支持
<!-- end id1644 -->
<!-- npu="IPV350" id1645 -->
- IPV350：不支持
<!-- end id1645 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id1 -->

### 功能说明

锁定当前进程，以阻止后续的运行时接口调用，包括Device设置/释放、内存的申请/释放/拷贝、Context/Stream/Event/Notify等资源的创建与销毁、以及部分任务下发接口。

在调用此接口之前，必须确保当前进程处于RUNNING状态，当前进程默认是RUNNING状态；调用该接口后，当前进程将变为LOCKED状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 进程ID，当前只支持传入本进程的ID，不支持跨进程操作。 |
| reserve | 输入 | 预留参数，当前只支持传入NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSnapShotProcessBackup"></a>

## aclrtSnapShotProcessBackup

```c
aclError aclrtSnapShotProcessBackup(int pid, aclrtSnapShotBackupArgs *args)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1380 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1380 -->
<!-- npu="A3" id1381 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1381 -->
<!-- npu="910b" id1382 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1382 -->
<!-- npu="310b" id1383 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1383 -->
<!-- npu="310p" id1384 -->
- Atlas 推理系列产品：不支持
<!-- end id1384 -->
<!-- npu="910" id1385 -->
- Atlas 训练系列产品：不支持
<!-- end id1385 -->
<!-- npu="IPV350" id1386 -->
- IPV350：不支持
<!-- end id1386 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id2 -->

### 功能说明

备份快照进程中的Device资源，并将Device资源保存在Host侧，以便后续恢复。针对当前进程，支持多次备份，以最后一次生效。

在调用此接口之前，必须确保当前进程处于LOCKED状态；调用该接口后，当前进程将变为BACKED\_UP状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 进程ID，当前只支持传入本进程的ID，不支持跨进程操作。 |
| args | 输入 | 备份配置参数，类型为[aclrtSnapShotBackupArgs](25-04_Structs.md#aclrtSnapShotBackupArgs)，当前只支持传入NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSnapShotProcessRestore"></a>

## aclrtSnapShotProcessRestore

```c
aclError aclrtSnapShotProcessRestore(int pid, aclrtSnapShotRestoreArgs *args)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id3130 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3130 -->
<!-- npu="A3" id3131 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3131 -->
<!-- npu="910b" id3132 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3132 -->
<!-- npu="310b" id3133 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3133 -->
<!-- npu="310p" id3134 -->
- Atlas 推理系列产品：不支持
<!-- end id3134 -->
<!-- npu="910" id3135 -->
- Atlas 训练系列产品：不支持
<!-- end id3135 -->
<!-- npu="IPV350" id3136 -->
- IPV350：不支持
<!-- end id3136 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id3 -->

### 功能说明

恢复快照进程中的Device资源。根据备份好的Device资源进行恢复，从最后一次备份点进行恢复。

在调用该接口之前，必须确保当前进程处于BACKED\_UP状态；调用该接口后，当前进程将变为LOCKED状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 进程ID，当前只支持传入本进程的ID，不支持跨进程操作。 |
| args | 输入 | 恢复配置参数，类型为[aclrtSnapShotRestoreArgs](25-04_Structs.md#aclrtSnapShotRestoreArgs)，当前只支持传入NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

恢复和备份需要在同一个Device上（指Device ID相同）。恢复时，若Device被其他进程占用，则恢复失败。

<br>
<br>
<br>

<a id="aclrtSnapShotProcessUnlock"></a>

## aclrtSnapShotProcessUnlock

```c
aclError aclrtSnapShotProcessUnlock(int pid, void* reserve)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2822 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2822 -->
<!-- npu="A3" id2823 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2823 -->
<!-- npu="910b" id2824 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2824 -->
<!-- npu="310b" id2825 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2825 -->
<!-- npu="310p" id2826 -->
- Atlas 推理系列产品：不支持
<!-- end id2826 -->
<!-- npu="910" id2827 -->
- Atlas 训练系列产品：不支持
<!-- end id2827 -->
<!-- npu="IPV350" id2828 -->
- IPV350：不支持
<!-- end id2828 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id4 -->

### 功能说明

解锁Device上的当前进程，同时解除运行时接口的阻塞调用。

在调用此接口之前，必须确保当前进程处于LOCKED或BACKED\_UP状态；调用此接口后，当前进程将变为RUNNING状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 进程ID，当前只支持传入本进程的ID，不支持跨进程操作。 |
| reserve | 输入 | 预留参数，当前只支持传入NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSnapShotCallbackRegister"></a>

## aclrtSnapShotCallbackRegister

```c
aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2766 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2766 -->
<!-- npu="A3" id2767 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2767 -->
<!-- npu="910b" id2768 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2768 -->
<!-- npu="310b" id2769 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2769 -->
<!-- npu="310p" id2770 -->
- Atlas 推理系列产品：不支持
<!-- end id2770 -->
<!-- npu="910" id2771 -->
- Atlas 训练系列产品：不支持
<!-- end id2771 -->
<!-- npu="IPV350" id2772 -->
- IPV350：不支持
<!-- end id2772 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id5 -->

### 功能说明

注册一个回调函数，该回调函数将在快照操作的不同阶段被调用。不支持重复注册。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stage | 输入 | 指定触发回调的快照阶段。类型定义请参见[aclrtSnapShotStage](25-02_Enumerations.md#aclrtSnapShotStage)。 |
| callback | 输入 | 指向回调函数的指针。当指定的快照阶段到达时，系统将自动调用此函数。<br>函数定义如下：<br>typedef uint32_t (*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |
| args | 输入 | 用户自定义参数指针，在回调函数调用时传递，可以为NULL，表示不需要传递额外参数。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSnapShotCallbackUnregister"></a>

## aclrtSnapShotCallbackUnregister

```c
aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1772 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1772 -->
<!-- npu="A3" id1773 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1773 -->
<!-- npu="910b" id1774 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1774 -->
<!-- npu="310b" id1775 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1775 -->
<!-- npu="310p" id1776 -->
- Atlas 推理系列产品：不支持
<!-- end id1776 -->
<!-- npu="910" id1777 -->
- Atlas 训练系列产品：不支持
<!-- end id1777 -->
<!-- npu="IPV350" id1778 -->
- IPV350：不支持
<!-- end id1778 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id6 -->

### 功能说明

取消注册回调函数。取消注册之后，对应快照阶段将不再调用该回调函数。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stage | 输入 | 指定触发回调的快照阶段。类型定义请参见[aclrtSnapShotStage](25-02_Enumerations.md#aclrtSnapShotStage)。 |
| callback | 输入 | 待取消注册的回调函数指针。<br>函数定义如下：<br>typedef uint32_t (*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
