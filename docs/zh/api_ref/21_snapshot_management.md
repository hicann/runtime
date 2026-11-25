# 21. 快照管理

本章节描述CANN Runtime的快照管理接口，用于目标进程状态的锁定、备份、恢复和查询，以及本进程的回调注册与注销。

- [`aclError aclrtSnapShotProcessLock(int pid, void* reserve)`](#aclrtSnapShotProcessLock)：锁定目标进程，以阻止目标进程后续的运行时接口调用，包括Device设置/释放、内存的申请/释放/拷贝、Context/Stream/Event/Notify等资源的创建与销毁、以及部分任务下发接口。
- [`aclError aclrtSnapShotProcessBackup(int pid, aclrtSnapShotBackupArgs *args)`](#aclrtSnapShotProcessBackup)：备份目标进程中的Device资源，并将Device资源保存在Host侧，以便后续恢复。针对目标进程，支持多次备份，以最后一次生效。
- [`aclError aclrtSnapShotProcessRestore(int pid, aclrtSnapShotRestoreArgs *args)`](#aclrtSnapShotProcessRestore)：恢复目标进程中的Device资源。根据备份好的Device资源进行恢复，从最后一次备份点进行恢复。
- [`aclError aclrtSnapShotProcessUnlock(int pid, void* reserve)`](#aclrtSnapShotProcessUnlock)：解锁Device上的目标进程，同时解除目标进程中运行时接口的阻塞调用。
- [`aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)`](#aclrtSnapShotCallbackRegister)：在本进程注册一个回调函数，该回调函数将在本进程快照操作的不同阶段被调用。不支持重复注册。
- [`aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)`](#aclrtSnapShotCallbackUnregister)：取消注册本进程的回调函数。取消注册之后，本进程对应快照阶段将不再调用该回调函数。
- [`aclError aclrtSnapshotProcessGetState(int pid, aclrtProcessState* state)`](#aclrtSnapshotProcessGetState)：查询目标进程的快照状态。
- [`aclError aclrtSnapshotProcessGetRestoreThreadId(int pid, int* tid)`](#aclrtSnapshotProcessGetRestoreThreadId)：查询目标进程的快照线程ID。

## 跨进程调用约束

- 调用方与目标进程须位于同一台Linux主机，且处于相同的PID和文件系统视图中，另外，调用方的有效用户须与目标进程相同，或为root用户。
- 目标进程须已初始化Runtime。目标用户须有可访问的家目录，且能在其中创建或写入快照服务目录。
- 跨进程接口同步返回，会等待任务执行完成。通信中断时，已开始的操作仍会继续执行。

<a class="method_anchor" id="aclrtSnapShotProcessLock"></a>

## aclrtSnapShotProcessLock

```c
aclError aclrtSnapShotProcessLock(int pid, void* reserve)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1639 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id1639 -->
<!-- npu="A3" id1640 -->
- Atlas A3系列产品：支持
<!-- end id1640 -->
<!-- npu="910b" id1641 -->
- Atlas A2系列产品：支持
<!-- end id1641 -->
<!-- npu="310b" id1642 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id1642 -->
<!-- npu="310p" id1643 -->
- Atlas推理系列产品：不支持
<!-- end id1643 -->
<!-- npu="910" id1644 -->
- Atlas训练系列产品：不支持
<!-- end id1644 -->
<!-- npu="IPV350" id1645 -->
- IPV350：不支持
<!-- end id1645 -->
<!-- npu="5162A" id5001 -->
- Hisilicon5162A：不支持
<!-- end id5001 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id1 -->

### 功能说明

锁定目标进程，以阻止目标进程后续的运行时接口调用，包括Device设置/释放、内存的申请/释放/拷贝、Context/Stream/Event/Notify等资源的创建与销毁、以及部分任务下发接口。

目标进程的快照状态初始为RUNNING。调用此接口之前，必须确保目标进程处于RUNNING状态；调用成功后，目标进程将变为LOCKED状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 目标进程ID，必须大于0。支持本进程及满足本章跨进程调用约束的其他进程。 |
| reserve | 输入 | 预留参数，当前只支持传入NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotProcessBackup"></a>

## aclrtSnapShotProcessBackup

```c
aclError aclrtSnapShotProcessBackup(int pid, aclrtSnapShotBackupArgs *args)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1380 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id1380 -->
<!-- npu="A3" id1381 -->
- Atlas A3系列产品：支持
<!-- end id1381 -->
<!-- npu="910b" id1382 -->
- Atlas A2系列产品：支持
<!-- end id1382 -->
<!-- npu="310b" id1383 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id1383 -->
<!-- npu="310p" id1384 -->
- Atlas推理系列产品：不支持
<!-- end id1384 -->
<!-- npu="910" id1385 -->
- Atlas训练系列产品：不支持
<!-- end id1385 -->
<!-- npu="IPV350" id1386 -->
- IPV350：不支持
<!-- end id1386 -->
<!-- npu="5162A" id5002 -->
- Hisilicon5162A：不支持
<!-- end id5002 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id2 -->

### 功能说明

备份目标进程中的Device资源，并将Device资源保存在Host侧，以便后续恢复。针对目标进程，支持多次备份，以最后一次生效。

在调用此接口之前，必须确保目标进程处于LOCKED状态；调用成功后，目标进程将变为BACKED\_UP状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 目标进程ID，必须大于0。支持本进程及满足本章跨进程调用约束的其他进程。 |
| args | 输入 | 备份配置参数，类型为[aclrtSnapShotBackupArgs](25-04_Structs.md#aclrtSnapShotBackupArgs)。传入NULL时走旧Runtime备份流程；传入非NULL时走驱动Device内存快照流程，并要求驱动支持Device内存快照能力。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotProcessRestore"></a>

## aclrtSnapShotProcessRestore

```c
aclError aclrtSnapShotProcessRestore(int pid, aclrtSnapShotRestoreArgs *args)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id3130 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id3130 -->
<!-- npu="A3" id3131 -->
- Atlas A3系列产品：支持
<!-- end id3131 -->
<!-- npu="910b" id3132 -->
- Atlas A2系列产品：支持
<!-- end id3132 -->
<!-- npu="310b" id3133 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id3133 -->
<!-- npu="310p" id3134 -->
- Atlas推理系列产品：不支持
<!-- end id3134 -->
<!-- npu="910" id3135 -->
- Atlas训练系列产品：不支持
<!-- end id3135 -->
<!-- npu="IPV350" id3136 -->
- IPV350：不支持
<!-- end id3136 -->
<!-- npu="5162A" id5003 -->
- Hisilicon5162A：不支持
<!-- end id5003 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id3 -->

### 功能说明

恢复目标进程中的Device资源。根据备份好的Device资源进行恢复，从最后一次备份点进行恢复。

在调用该接口之前，必须确保目标进程处于BACKED\_UP状态；调用成功后，目标进程将变为LOCKED状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 目标进程ID，必须大于0。支持本进程及满足本章跨进程调用约束的其他进程。 |
| args | 输入 | 恢复配置参数，类型为[aclrtSnapShotRestoreArgs](25-04_Structs.md#aclrtSnapShotRestoreArgs)。传入NULL时走旧Runtime恢复流程；传入非NULL时走驱动Device内存快照流程，并要求驱动支持Device内存快照能力。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

恢复和备份需要在同一个Device上（指Device ID相同）。恢复时，若Device被其他进程占用，则恢复失败。`args`传入非NULL时，恢复前会先检查驱动Device内存快照能力，再检查备份版本信息：Runtime 使用的 HAL API 版本、驱动 API 版本必须分别与备份时一致。版本校验通过后，继续重新打开 Device。备份版本信息无效或版本不匹配时，返回 `ACL_ERROR_SNAPSHOT_RESTORE_FAILED`（507909）；版本查询失败时，返回对应错误。`args`传入NULL时，走旧Runtime恢复流程，不执行上述Device内存快照兼容性和版本一致性检查。

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotProcessUnlock"></a>

## aclrtSnapShotProcessUnlock

```c
aclError aclrtSnapShotProcessUnlock(int pid, void* reserve)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2822 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id2822 -->
<!-- npu="A3" id2823 -->
- Atlas A3系列产品：支持
<!-- end id2823 -->
<!-- npu="910b" id2824 -->
- Atlas A2系列产品：支持
<!-- end id2824 -->
<!-- npu="310b" id2825 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id2825 -->
<!-- npu="310p" id2826 -->
- Atlas推理系列产品：不支持
<!-- end id2826 -->
<!-- npu="910" id2827 -->
- Atlas训练系列产品：不支持
<!-- end id2827 -->
<!-- npu="IPV350" id2828 -->
- IPV350：不支持
<!-- end id2828 -->
<!-- npu="5162A" id5004 -->
- Hisilicon5162A：不支持
<!-- end id5004 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id4 -->

### 功能说明

解锁Device上的目标进程，同时解除目标进程中运行时接口的阻塞调用。

在调用此接口之前，必须确保目标进程处于LOCKED或BACKED\_UP状态；调用成功后，目标进程将变为RUNNING状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 目标进程ID，必须大于0。支持本进程及满足本章跨进程调用约束的其他进程。 |
| reserve | 输入 | 预留参数，当前只支持传入NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotCallbackRegister"></a>

## aclrtSnapShotCallbackRegister

```c
aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2766 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id2766 -->
<!-- npu="A3" id2767 -->
- Atlas A3系列产品：支持
<!-- end id2767 -->
<!-- npu="910b" id2768 -->
- Atlas A2系列产品：支持
<!-- end id2768 -->
<!-- npu="310b" id2769 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id2769 -->
<!-- npu="310p" id2770 -->
- Atlas推理系列产品：不支持
<!-- end id2770 -->
<!-- npu="910" id2771 -->
- Atlas训练系列产品：不支持
<!-- end id2771 -->
<!-- npu="IPV350" id2772 -->
- IPV350：不支持
<!-- end id2772 -->
<!-- npu="5162A" id5005 -->
- Hisilicon5162A：不支持
<!-- end id5005 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id5 -->

### 功能说明

在本进程注册一个回调函数，该回调函数将在本进程快照操作的不同阶段被调用。不支持重复注册。不支持为其他进程注册回调；其他进程对本进程发起跨进程快照操作时，触发的是本进程内预先注册的回调。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stage | 输入 | 指定触发回调的快照阶段。类型定义请参见[aclrtSnapShotStage](25-02_Enumerations.md#aclrtSnapShotStage)。 |
| callback | 输入 | 指向回调函数的指针。当指定的快照阶段到达时，系统将自动调用此函数。<br>函数定义如下：<br>typedef uint32_t (*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |
| args | 输入 | 用户自定义参数指针，在回调函数调用时传递，可以为NULL，表示不需要传递额外参数。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 回调函数仅可用于业务自身状态的备份与恢复。
- 禁止在回调函数内调用Runtime接口（包括但不限于快照管理接口，例如回调函数的注册与注销、进程锁定与解锁、异步拷贝等），否则可能导致进程挂死或未定义行为。

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapShotCallbackUnregister"></a>

## aclrtSnapShotCallbackUnregister

```c
aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1772 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id1772 -->
<!-- npu="A3" id1773 -->
- Atlas A3系列产品：支持
<!-- end id1773 -->
<!-- npu="910b" id1774 -->
- Atlas A2系列产品：支持
<!-- end id1774 -->
<!-- npu="310b" id1775 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id1775 -->
<!-- npu="310p" id1776 -->
- Atlas推理系列产品：不支持
<!-- end id1776 -->
<!-- npu="910" id1777 -->
- Atlas训练系列产品：不支持
<!-- end id1777 -->
<!-- npu="IPV350" id1778 -->
- IPV350：不支持
<!-- end id1778 -->
<!-- npu="5162A" id5006 -->
- Hisilicon5162A：不支持
<!-- end id5006 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id6 -->

### 功能说明

取消注册本进程的回调函数。取消注册之后，本进程对应快照阶段将不再调用该回调函数。不支持注销其他进程的回调。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stage | 输入 | 指定触发回调的快照阶段。类型定义请参见[aclrtSnapShotStage](25-02_Enumerations.md#aclrtSnapShotStage)。 |
| callback | 输入 | 待取消注册的回调函数指针。<br>函数定义如下：<br>typedef uint32_t (*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapshotProcessGetState"></a>

## aclrtSnapshotProcessGetState

```c
aclError aclrtSnapshotProcessGetState(int pid, aclrtProcessState* state)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1779 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id1779 -->
<!-- npu="A3" id1780 -->
- Atlas A3系列产品：支持
<!-- end id1780 -->
<!-- npu="910b" id1781 -->
- Atlas A2系列产品：支持
<!-- end id1781 -->
<!-- npu="310b" id1782 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id1782 -->
<!-- npu="310p" id1783 -->
- Atlas推理系列产品：不支持
<!-- end id1783 -->
<!-- npu="910" id1784 -->
- Atlas训练系列产品：不支持
<!-- end id1784 -->
<!-- npu="IPV350" id1785 -->
- IPV350：不支持
<!-- end id1785 -->
<!-- npu="5162A" id5007 -->
- Hisilicon5162A：不支持
<!-- end id5007 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id7 -->

### 功能说明

查询目标进程的快照状态。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 目标进程ID，必须大于0。支持本进程及满足本章跨进程调用约束的其他进程。 |
| state | 输出 | 目标进程的快照状态，不得为NULL。成功时写入状态，失败时保持原值。状态含义参见[aclrtProcessState](25-02_Enumerations.md#aclrtProcessState)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSnapshotProcessGetRestoreThreadId"></a>

## aclrtSnapshotProcessGetRestoreThreadId

```c
aclError aclrtSnapshotProcessGetRestoreThreadId(int pid, int* tid)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id1786 -->
- Ascend 950PR系列产品：支持
- Ascend 950DT系列产品：不支持
<!-- end id1786 -->
<!-- npu="A3" id1787 -->
- Atlas A3系列产品：支持
<!-- end id1787 -->
<!-- npu="910b" id1788 -->
- Atlas A2系列产品：支持
<!-- end id1788 -->
<!-- npu="310b" id1789 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id1789 -->
<!-- npu="310p" id1790 -->
- Atlas推理系列产品：不支持
<!-- end id1790 -->
<!-- npu="910" id1791 -->
- Atlas训练系列产品：不支持
<!-- end id1791 -->
<!-- npu="IPV350" id1792 -->
- IPV350：不支持
<!-- end id1792 -->
<!-- npu="5162A" id5008 -->
- Hisilicon5162A：不支持
<!-- end id5008 -->
<!-- @ref: runtime/res/docs/zh/api_ref/21_snapshot_management_res.md#id8 -->

### 功能说明

查询目标进程中执行跨进程快照操作的线程ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| pid | 输入 | 目标进程ID，必须大于0。支持本进程及满足本章跨进程调用约束的其他进程。 |
| tid | 输出 | 目标进程所在PID命名空间中的Linux线程ID，不得为NULL。成功时写入大于0的TID，失败时保持原值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。