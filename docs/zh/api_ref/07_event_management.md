# 7. Event管理

本章节描述 CANN Runtime 的 Event 管理接口，用于事件的创建、记录、同步、计时及 IPC 跨进程共享。

- [`aclError aclrtCreateEvent(aclrtEvent *event)`](#aclrtCreateEvent)：创建Event，创建出来的Event可用于统计两个Event之间的耗时、多Stream之间的任务同步等场景。
- [`aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEventWithFlag)：创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。
- [`aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEventExWithFlag)：创建带flag的Event，不同flag的Event用于不同的功能。
- [`aclError aclrtDestroyEvent(aclrtEvent event)`](#aclrtDestroyEvent)：销毁Event，支持在Event未完成前调用本接口销毁Event。此时，本接口不会阻塞线程等Event完成，Event相关资源会在Event完成时被自动释放。
- [`aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)`](#aclrtRecordEvent)：在指定Stream中记录一个Event。异步接口。
- [`aclError aclrtRecordEventWithFlag(aclrtEvent event, aclrtStream stream, uint32_t flag)`](#aclrtRecordEventWithFlag)：在指定的Stream中记录一个Event。异步接口。该接口是在[aclrtRecordEvent](#aclrtRecordEvent)接口基础上进行了增强，支持配置flag，不同的flag用于不同的使用场景。
- [`aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)`](#aclrtResetEvent)：复位Event，恢复Event初始状态，便于Event对象重复使用。异步接口。
- [`aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)`](#aclrtQueryEvent_deprecated)：查询与本接口在同一线程中的[aclrtRecordEvent](#aclrtRecordEvent)接口所记录的Event是否执行完成。
- [`aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)`](#aclrtQueryEventStatus)：查询该Event捕获的所有任务的执行状态。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节。
- [`aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)`](#aclrtQueryEventWaitStatus)：调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口后查询该Event对应的等待任务是否都执行完成。
- [`aclError aclrtSynchronizeEvent(aclrtEvent event)`](#aclrtSynchronizeEvent)：阻塞当前线程运行直到Event捕获的所有任务都执行完成。
- [`aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)`](#aclrtSynchronizeEventWithTimeout)：阻塞当前线程运行直到Event捕获的所有任务都执行完成（具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节），该接口是在接口[aclrtSynchronizeEvent](#aclrtSynchronizeEvent)基础上进行了增强，支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则当应用程序异常时可根据所设置的超时时间自行退出。
- [`aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)`](#aclrtEventElapsedTime)：统计两个Event之间的耗时。
- [`aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)`](#aclrtStreamWaitEvent)：阻塞指定Stream的运行，直到指定的Event完成，支持多个Stream等待同一个Event的场景。异步接口。
- [`aclError aclrtStreamWaitEventWithFlag(aclrtStream stream, aclrtEvent event, uint32_t timeout, uint32_t flag)`](#aclrtStreamWaitEventWithFlag)：阻塞指定Stream的运行，直到指定的Event完成。异步接口。该接口是在接口[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)、[aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout)基础上进行了增强，支持用户配置具体的超时时间，同时还可以配置flag，不同的flag用于不同的使用场景。
- [`aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)`](#aclrtStreamWaitEventWithTimeout)：阻塞指定Stream的运行，直到指定的Event完成或等待超时，支持多个Stream等待同一个Event的场景。异步接口。
- [`aclError aclrtSetOpWaitTimeout(uint32_t timeout)`](#aclrtSetOpWaitTimeout)：本接口用于设置等待Event完成的超时时间。
- [`aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)`](#aclrtEventGetTimestamp)：获取Event的执行结束时间点（表示从AI处理器系统启动以来的时间）。
- [`aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)`](#aclrtGetEventId)：获取指定Event的ID。
- [`aclError aclrtGetEventAvailNum(uint32_t *eventCount)`](#aclrtGetEventAvailNum)：查询当前Device上可用的Event数量。
- [`aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)`](#aclrtIpcGetEventHandle)：将本进程中的指定Event设置为IPC（Inter-Process Communication） Event，并返回其handle（即Event句柄），用于在跨进程场景下实现任务同步，支持同一个Device内的多个进程以及跨Device的多个进程。
- [`aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)`](#aclrtIpcOpenEventHandle)：在本进程中获取handle的信息，并返回本进程可以使用的Event指针。

<a id="aclrtCreateEvent"></a>

## aclrtCreateEvent

```c
aclError aclrtCreateEvent(aclrtEvent *event)
```

### 产品支持情况

<!-- npu="950" id687 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id687 -->
<!-- npu="A3" id688 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id688 -->
<!-- npu="910b" id689 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id689 -->
<!-- npu="310b" id690 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id690 -->
<!-- npu="310p" id691 -->
- Atlas 推理系列产品：支持
<!-- end id691 -->
<!-- npu="910" id692 -->
- Atlas 训练系列产品：支持
<!-- end id692 -->
<!-- npu="IPV350" id693 -->
- IPV350：不支持
<!-- end id693 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id1 -->

### 功能说明

创建Event，创建出来的Event可用于统计两个Event之间的耗时、多Stream之间的任务同步等场景。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输出 | Event的指针。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 采用本API创建的Event不支持在[aclrtResetEvent](#aclrtResetEvent)接口中使用，否则会导致未定义的行为。

- 调用本接口创建Event时，并不会实际申请Event资源，只有在调用[aclrtRecordEvent](#aclrtRecordEvent)接口时，才会进行资源申请，因此在调用[aclrtRecordEvent](#aclrtRecordEvent)时，可能会出现线程阻塞，等待Event资源的释放。

- 不同型号的硬件支持的Event数量不同。
  <!-- npu="950,A3,910b,310b" id15 -->
  - 对于以下产品型号，单个Device支持的Event最大数为65536：

    <!-- npu="950" id18 -->
    Ascend 950PR/Ascend 950DT
    <!-- end id18 -->

    <!-- npu="A3" id19 -->
    Atlas A3 训练系列产品/Atlas A3 推理系列产品
    <!-- end id19 -->

    <!-- npu="910b" id20 -->
    Atlas A2 训练系列产品/Atlas A2 推理系列产品
    <!-- end id20 -->

    <!-- npu="310b" id21 -->
    Atlas 200I/500 A2 推理产品
    <!-- end id21 -->

  <!-- end id15 -->
  <!-- npu="310p" id16 -->
  - 对于Atlas 推理系列产品，单个Device支持的Event最大数为1023。
  <!-- end id16 -->
  <!-- npu="910" id17 -->
  - 对于Atlas 训练系列产品，单个Device支持的Event最大数为65535。
  <!-- end id17 -->
  <!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id23 -->

<br>
<br>
<br>

<a id="aclrtCreateEventWithFlag"></a>

## aclrtCreateEventWithFlag

```c
aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id2808 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2808 -->
<!-- npu="A3" id2809 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2809 -->
<!-- npu="910b" id2810 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2810 -->
<!-- npu="310b" id2811 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2811 -->
<!-- npu="310p" id2812 -->
- Atlas 推理系列产品：支持
<!-- end id2812 -->
<!-- npu="910" id2813 -->
- Atlas 训练系列产品：支持
<!-- end id2813 -->
<!-- npu="IPV350" id2814 -->
- IPV350：不支持
<!-- end id2814 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id2 -->

### 功能说明

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输出 | Event的指针。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| flag | 输入 | Event指针的flag。<br>当前支持将flag设置为如下宏：<br><br>  - ACL_EVENT_TIME_LINE：使能该bit表示创建的Event需要记录时间戳信息。注意：使能时间戳功能会影响Event相关接口的性能。<br>  - ACL_EVENT_SYNC：使能该bit表示创建的Event支持多Stream间的同步。<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS：使能该bit表示创建的Event用于跟踪stream的任务执行进度。<br>  - ACL_EVENT_EXTERNAL：使能该bit表示创建的Event用于任务捕获场景下的任务更新功能，相关说明请参见[aclmdlRICaptureBegin](15_model_running_instance__management.md#aclmdlRICaptureBegin)。注意：该flag不支持与其他flag进行位或操作。<br>  - ACL_EVENT_DEVICE_USE_ONLY：使能该bit表示创建的Event仅在Device上调用。<br><br><br>宏的定义如下：<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_EXTERNAL  0x00000020U<br>#define ACL_EVENT_DEVICE_USE_ONLY  0x00000010U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="950,A3,910b,310p,310b" id22 -->
- 各产品型号对ACL\_EVENT\_DEVICE\_USE\_ONLY的支持情况不同：

  <!-- npu="950,A3,910b" id23 -->
  对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持该flag。
  <!-- end id23 -->

  <!-- npu="310b" id24 -->
  对于Atlas 200I/500 A2 推理产品，不支持该flag。
  <!-- end id24 -->

  <!-- npu="310p" id25 -->
  对于Atlas 推理系列产品，支持该flag。
  <!-- end id25 -->
<!-- end id22 -->

- 若flag参数值**不包含**ACL\_EVENT\_SYNC宏，则不支持在以下API中使用本接口创建的Event：[aclrtResetEvent](#aclrtResetEvent)、[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)、[aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus)。若flag参数值**包含**ACL\_EVENT\_SYNC宏或者flag设置为ACL\_EVENT\_EXTERNAL时，则创建出来的Event数量受限。
不同型号的硬件支持的Event数量不同。
  <!-- npu="950,A3,910b,310b" id26 -->
  - 对于以下产品型号，单个Device支持的Event最大数为65536：

    <!-- npu="950" id27 -->
    Ascend 950PR/Ascend 950DT
    <!-- end id27 -->

    <!-- npu="A3" id28 -->
    Atlas A3 训练系列产品/Atlas A3 推理系列产品
    <!-- end id28 -->

    <!-- npu="910b" id29 -->
    Atlas A2 训练系列产品/Atlas A2 推理系列产品
    <!-- end id29 -->

    <!-- npu="310b" id30 -->
    Atlas 200I/500 A2 推理产品
    <!-- end id30 -->
  <!-- end id26 -->

  <!-- npu="310p" id31 -->
  - 对于Atlas 推理系列产品，单个Device支持的Event最大数为1023。
  <!-- end id31 -->
  <!-- npu="910" id32 -->
  - 对于Atlas 训练系列产品，单个Device支持的Event最大数为65535。
  <!-- end id32 -->

<br>
<br>
<br>

<a id="aclrtCreateEventExWithFlag"></a>

## aclrtCreateEventExWithFlag

```c
aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id2780 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2780 -->
<!-- npu="A3" id2781 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2781 -->
<!-- npu="910b" id2782 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2782 -->
<!-- npu="310b" id2783 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2783 -->
<!-- npu="310p" id2784 -->
- Atlas 推理系列产品：支持
<!-- end id2784 -->
<!-- npu="910" id2785 -->
- Atlas 训练系列产品：支持
<!-- end id2785 -->
<!-- npu="IPV350" id2786 -->
- IPV350：不支持
<!-- end id2786 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id3 -->

### 功能说明

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。创建Event时，Event资源不受硬件限制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输出 | Event的指针。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| flag | 输入 | Event指针的flag。<br>flag为bitmap，支持将flag设置为单个宏、或者对多个宏进行或操作。<br>当前支持将flag设置为如下宏：<br><br>  - ACL_EVENT_TIME_LINE：使能该bit表示创建的Event需要记录时间戳信息。注意：使能时间戳功能会影响Event相关接口的性能。<br>  - ACL_EVENT_SYNC：使能该bit表示创建的Event支持多Stream间的同步。<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS：使能该bit表示创建的Event用于跟踪stream的任务执行进度。<br>  - ACL_EVENT_IPC：使能该bit表示创建的Event用于进程间通信，详细说明请参见[aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle)。注意：该flag不支持与其他flag进行位或操作。Ascend 950DT不支持使用本flag创建Event。本flag创建出来的Event不支持在以下接口或场景中使用：[aclrtResetEvent](#aclrtResetEvent)、[aclrtQueryEvent](#aclrtQueryEvent_deprecated)、[aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus)、[aclrtEventElapsedTime](#aclrtEventElapsedTime)、[aclrtEventGetTimestamp](#aclrtEventGetTimestamp)、[aclrtGetEventId](#aclrtGetEventId)、模型捕获场景（参见[aclmdlRICaptureBegin](15_model_running_instance__management.md#aclmdlRICaptureBegin)中的说明），否则返回报错。<br><br><br>宏的定义如下：<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_IPC 0x00000040U |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 采用本API创建的Event，不支持在以下接口中使用：[aclrtResetEvent](#aclrtResetEvent)、[aclrtQueryEvent](#aclrtQueryEvent_deprecated)、[aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus)，否则返回报错。

- 若flag参数值**不包含**ACL\_EVENT\_SYNC宏，则不支持在[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口中使用本接口创建的Event。若flag参数值**包含**ACL\_EVENT\_SYNC宏，并不会实际申请Event资源，只有在调用[aclrtRecordEvent](#aclrtRecordEvent)接口时，才会进行资源申请，因此在调用[aclrtRecordEvent](#aclrtRecordEvent)时，可能会出现线程阻塞，等待Event资源的释放。

- 不同型号的硬件支持的Event数量不同。
  <!-- npu="950,A3,910b,310b" id33 -->
  - 对于以下产品型号，单个Device支持的Event最大数为65536：

    <!-- npu="950" id34 -->
    Ascend 950PR/Ascend 950DT
    <!-- end id34 -->

    <!-- npu="A3" id35 -->
    Atlas A3 训练系列产品/Atlas A3 推理系列产品
    <!-- end id35 -->

    <!-- npu="910b" id36 -->
    Atlas A2 训练系列产品/Atlas A2 推理系列产品
    <!-- end id36 -->

    <!-- npu="310b" id37 -->
    Atlas 200I/500 A2 推理产品
    <!-- end id37 -->
  <!-- end id33 -->

  <!-- npu="310p" id38 -->
  - 对于Atlas 推理系列产品，单个Device支持的Event最大数为1023。
  <!-- end id38 -->
  <!-- npu="910" id39 -->
  - 对于Atlas 训练系列产品，单个Device支持的Event最大数为65535。
  <!-- end id39 -->

<br>
<br>
<br>

<a id="aclrtDestroyEvent"></a>

## aclrtDestroyEvent

```c
aclError aclrtDestroyEvent(aclrtEvent event)
```

### 产品支持情况

<!-- npu="950" id1338 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1338 -->
<!-- npu="A3" id1339 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1339 -->
<!-- npu="910b" id1340 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1340 -->
<!-- npu="310b" id1341 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1341 -->
<!-- npu="310p" id1342 -->
- Atlas 推理系列产品：支持
<!-- end id1342 -->
<!-- npu="910" id1343 -->
- Atlas 训练系列产品：支持
<!-- end id1343 -->
<!-- npu="IPV350" id1344 -->
- IPV350：不支持
<!-- end id1344 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id4 -->

### 功能说明

销毁Event，支持在Event未完成前调用本接口销毁Event。此时，本接口不会阻塞线程等Event完成，Event相关资源会在Event完成时被自动释放。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 待销毁的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

在调用aclrtDestroyEvent接口销毁指定Event时，需确保其它接口没有正在使用该Event。

<br>
<br>
<br>

<a id="aclrtRecordEvent"></a>

## aclrtRecordEvent

```c
aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id981 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id981 -->
<!-- npu="A3" id982 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id982 -->
<!-- npu="910b" id983 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id983 -->
<!-- npu="310b" id984 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id984 -->
<!-- npu="310p" id985 -->
- Atlas 推理系列产品：支持
<!-- end id985 -->
<!-- npu="910" id986 -->
- Atlas 训练系列产品：支持
<!-- end id986 -->
<!-- npu="IPV350" id987 -->
- IPV350：不支持
<!-- end id987 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id5 -->

### 功能说明

在指定Stream中记录一个Event。异步接口。

aclrtRecordEvent接口与aclrtStreamWaitEvent接口配合使用时，主要用于多Stream之间同步等待的场景。

调用aclrtRecordEvent接口时，会捕获当前Stream上已下发的任务，并记录到Event事件中，因此后续若调用[aclrtQueryEventStatus](#aclrtQueryEventStatus)或[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口时，会检查或等待该Event事件中所捕获的任务都已经完成。

另外，对于使用[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)创建的Event：

- aclrtRecordEvent接口支持对同一个Event多次record实现Event复用，每次Record会重新捕获当前Stream上已下发的任务，并覆盖保存到Event中。在调用aclrtStreamWaitEvent接口时，会使用最近一次Event中所保存的任务，且不会被后续的aclrtRecordEvent调用影响。
- 在首次调用aclrtRecordEvent接口前，由于Event中没有任务，因此调用aclrtQueryEventStatus接口时会返回ACL\_EVENT\_RECORDED\_STATUS\_COMPLETE。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 待记录的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream1。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtRecordEventWithFlag"></a>

## aclrtRecordEventWithFlag

```c
aclError aclrtRecordEventWithFlag(aclrtEvent event, aclrtStream stream, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas 推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas 训练系列产品：不支持
<!-- end id6 -->
<!-- npu="IPV350" id7 -->
- IPV350：不支持
<!-- end id7 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id6 -->

### 功能说明

在指定的Stream中记录一个Event。异步接口。
该接口是在[aclrtRecordEvent](#aclrtRecordEvent)接口基础上进行了增强，支持配置flag，不同的flag用于不同的使用场景。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: |---|
| event | 输入 | 待记录的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。<br>当flag为ACL_EVENT_RECORD_EXTERNAL时，event仅支持通过[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建，且flag必须为ACL_EVENT_SYNC，其他flag或其他创建Event的接口均不支持。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>当flag为ACL_EVENT_RECORD_EXTERNAL时，仅支持在图捕获（ACL Graph）场景下使用，且stream参数处指定的Stream必须是正处于捕获状态。 |
| flag | 输入 | 指定记录动作的行为。flag取值如下：<br>- 当flag为ACL_EVENT_RECORD_DEFAULT时，表示默认行为，适用于普通场景，等价于[aclrtRecordEvent](#aclrtRecordEvent)接口。<br>- 当flag为ACL_EVENT_RECORD_EXTERNAL时，仅适用于图捕获场景，当用户正在把Stream上的任务捕获成计算图时，带上这个flag，本次记录的事件对外部可见，用于实现图和外部Stream之间做同步、以及实现图和图之间做同步。非图捕获场景下，flag为ACL_EVENT_RECORD_EXTERNAL时，返回报错。<br><br>  宏定义如下：<br>#define ACL_EVENT_RECORD_DEFAULT 0x00U <br> #define ACL_EVENT_RECORD_EXTERNAL 0x01U<br> |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

当flag为ACL_EVENT_RECORD_EXTERNAL时，存在如下约束：

- 对于同一个图，在图捕获过程中，同一event不允许同时进行Record和Wait操作。
- 若event在通过本接口记录之前已被[aclrtRecordEvent](#aclrtRecordEvent)记录过，则本接口返回错误。

<br>
<br>
<br>

<a id="aclrtResetEvent"></a>

## aclrtResetEvent

```c
aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id246 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id246 -->
<!-- npu="A3" id247 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id247 -->
<!-- npu="910b" id248 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id248 -->
<!-- npu="310b" id249 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id249 -->
<!-- npu="310p" id250 -->
- Atlas 推理系列产品：支持
<!-- end id250 -->
<!-- npu="910" id251 -->
- Atlas 训练系列产品：支持
<!-- end id251 -->
<!-- npu="IPV350" id252 -->
- IPV350：不支持
<!-- end id252 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id7 -->

### 功能说明

复位Event，恢复Event初始状态，便于Event对象重复使用。异步接口。

对于多个Stream间任务同步的场景，通常在调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口之后再复位Event。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 待复位的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>多个Stream间任务同步的场景，例如，Stream2中的任务依赖Stream1中的任务时，此处配置为Stream2。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

仅支持复位由[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag)接口创建的、带有ACL\_EVENT\_SYNC标志的Event。

**注意** ，在多个Stream中的任务需要等待同一个Event的情况下，不建议使用调用此接口来复位Event。如图所示，如果在stream2中的aclrtStreamWaitEvent接口之后调用aclrtResetEvent接口，Event将被复位，这会导致stream3中的aclrtStreamWaitEvent接口无法成功。

![](figures/event_wait_diagram.png)

<br>
<br>
<br>

<a id="aclrtQueryEvent_deprecated"></a>

## aclrtQueryEvent（废弃）

```c
aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)
```

**须知：此接口后续版本会废弃，请使用[aclrtQueryEventStatus](#aclrtQueryEventStatus)接口。**

### 产品支持情况

<!-- npu="950" id820 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id820 -->
<!-- npu="A3" id821 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id821 -->
<!-- npu="910b" id822 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id822 -->
<!-- npu="310b" id823 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id823 -->
<!-- npu="310p" id824 -->
- Atlas 推理系列产品：支持
<!-- end id824 -->
<!-- npu="910" id825 -->
- Atlas 训练系列产品：支持
<!-- end id825 -->
<!-- npu="IPV350" id826 -->
- IPV350：不支持
<!-- end id826 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id8 -->

### 功能说明

查询与本接口在同一线程中的[aclrtRecordEvent](#aclrtRecordEvent)接口所记录的Event是否执行完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定待查询的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| status | 输出 | Event状态的指针。类型定义请参见[aclrtEventStatus](25-02_Enumerations.md#aclrtEventStatus)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtQueryEventStatus"></a>

## aclrtQueryEventStatus

```c
aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
```

### 产品支持情况

<!-- npu="950" id3095 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3095 -->
<!-- npu="A3" id3096 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3096 -->
<!-- npu="910b" id3097 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3097 -->
<!-- npu="310b" id3098 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3098 -->
<!-- npu="310p" id3099 -->
- Atlas 推理系列产品：支持
<!-- end id3099 -->
<!-- npu="910" id3100 -->
- Atlas 训练系列产品：支持
<!-- end id3100 -->
<!-- npu="IPV350" id3101 -->
- IPV350：不支持
<!-- end id3101 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id9 -->

### 功能说明

查询该Event捕获的所有任务的执行状态。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定待查询的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| status | 输出 | Event状态的指针。类型定义请参见[aclrtEventRecordedStatus](25-02_Enumerations.md#aclrtEventRecordedStatus)。<br>如果该Event捕获的所有任务都已经执行完成则返回ACL_EVENT_RECORDED_STATUS_COMPLETE，如果有任何一个任务未执行完成则返回ACL_EVENT_RECORDED_STATUS_NOT_READY。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

如果用户在不同线程上分别调用[aclrtRecordEvent](#aclrtRecordEvent)和aclrtQueryEventStatus，可能由于多线程导致这两个API的执行时间乱序，进而导致查询到的Event对象的完成状态不符合预期。

<br>
<br>
<br>

<a id="aclrtQueryEventWaitStatus"></a>

## aclrtQueryEventWaitStatus

```c
aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)
```

### 产品支持情况

<!-- npu="950" id225 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id225 -->
<!-- npu="A3" id226 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id226 -->
<!-- npu="910b" id227 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id227 -->
<!-- npu="310b" id228 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id228 -->
<!-- npu="310p" id229 -->
- Atlas 推理系列产品：支持
<!-- end id229 -->
<!-- npu="910" id230 -->
- Atlas 训练系列产品：支持
<!-- end id230 -->
<!-- npu="IPV350" id231 -->
- IPV350：不支持
<!-- end id231 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id10 -->

### 功能说明

调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口后查询该Event对应的等待任务是否都执行完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定待查询的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| status | 输出 | Event状态的指针。类型定义请参见[aclrtEventWaitStatus](25-02_Enumerations.md#aclrtEventWaitStatus)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

通过[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建的Event，不支持调用本接口。

<br>
<br>
<br>

<a id="aclrtSynchronizeEvent"></a>

## aclrtSynchronizeEvent

```c
aclError aclrtSynchronizeEvent(aclrtEvent event)
```

### 产品支持情况

<!-- npu="950" id911 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id911 -->
<!-- npu="A3" id912 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id912 -->
<!-- npu="910b" id913 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id913 -->
<!-- npu="310b" id914 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id914 -->
<!-- npu="310p" id915 -->
- Atlas 推理系列产品：支持
<!-- end id915 -->
<!-- npu="910" id916 -->
- Atlas 训练系列产品：支持
<!-- end id916 -->
<!-- npu="IPV350" id917 -->
- IPV350：不支持
<!-- end id917 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id11 -->

### 功能说明

阻塞当前线程运行直到Event捕获的所有任务都执行完成。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSynchronizeEventWithTimeout"></a>

## aclrtSynchronizeEventWithTimeout

```c
aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id1793 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1793 -->
<!-- npu="A3" id1794 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1794 -->
<!-- npu="910b" id1795 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1795 -->
<!-- npu="310b" id1796 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1796 -->
<!-- npu="310p" id1797 -->
- Atlas 推理系列产品：支持
<!-- end id1797 -->
<!-- npu="910" id1798 -->
- Atlas 训练系列产品：支持
<!-- end id1798 -->
<!-- npu="IPV350" id1799 -->
- IPV350：不支持
<!-- end id1799 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id12 -->

### 功能说明

阻塞当前线程运行直到Event捕获的所有任务都执行完成（具体见[aclrtRecordEvent](#aclrtRecordEvent)接口参考Event捕获的细节），该接口是在接口[aclrtSynchronizeEvent](#aclrtSynchronizeEvent)基础上进行了增强，支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则当应用程序异常时可根据所设置的超时时间自行退出。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待，和接口[aclrtSynchronizeEvent](#aclrtSynchronizeEvent)功能一样。<br>  - >0：配置具体的超时时间，单位是毫秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id24 -->

<br>
<br>
<br>

<a id="aclrtEventElapsedTime"></a>

## aclrtEventElapsedTime

```c
aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)
```

### 产品支持情况

<!-- npu="950" id1667 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1667 -->
<!-- npu="A3" id1668 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1668 -->
<!-- npu="910b" id1669 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1669 -->
<!-- npu="310b" id1670 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1670 -->
<!-- npu="310p" id1671 -->
- Atlas 推理系列产品：支持
<!-- end id1671 -->
<!-- npu="910" id1672 -->
- Atlas 训练系列产品：支持
<!-- end id1672 -->
<!-- npu="IPV350" id1673 -->
- IPV350：不支持
<!-- end id1673 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id13 -->

### 功能说明

统计两个Event之间的耗时。

本接口需与其它关键接口配合使用，接口调用顺序：调用[aclrtCreateEvent](#aclrtCreateEvent)/[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag)接口创建Event**--\>**调用[aclrtRecordEvent](#aclrtRecordEvent)接口在同一个Stream中记录起始Event、结尾Event**--\>**调用[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)接口阻塞应用程序运行，直到指定Stream中的所有任务都完成**--\>**调用aclrtEventElapsedTime接口统计两个Event之间的耗时

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ms | 输出 | 表示两个Event之间耗时的指针，单位为毫秒。 |
| startEvent | 输入 | 起始Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| endEvent | 输入 | 结尾Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtStreamWaitEvent"></a>

## aclrtStreamWaitEvent

```c
aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)
```

### 产品支持情况

<!-- npu="950" id64 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id64 -->
<!-- npu="A3" id65 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id65 -->
<!-- npu="910b" id66 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id66 -->
<!-- npu="310b" id67 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id67 -->
<!-- npu="310p" id68 -->
- Atlas 推理系列产品：支持
<!-- end id68 -->
<!-- npu="910" id69 -->
- Atlas 训练系列产品：支持
<!-- end id69 -->
<!-- npu="IPV350" id70 -->
- IPV350：不支持
<!-- end id70 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id14 -->

### 功能说明

阻塞指定Stream的运行，直到指定的Event完成，支持多个Stream等待同一个Event的场景。异步接口。

提交到Stream上的所有后续任务都需要等待Event捕获的任务都完成后才能开始执行。具体见[aclrtRecordEvent](#aclrtRecordEvent)接口了解Event捕获的细节。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream2。 |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

一个进程内，调用[aclInit](02_initialization_and_deinitialization.md#aclInit)接口初始化后，若再调用[aclrtSetOpWaitTimeout](#aclrtSetOpWaitTimeout)接口设置超时时间，那么本进程内后续调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口下发的任务支持在所设置的超时时间内等待，若等待的时间超过所设置的超时时间，则在调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）后，会返回报错。

<br>
<br>
<br>

<a id="aclrtStreamWaitEventWithFlag"></a>

## aclrtStreamWaitEventWithFlag

```c
aclError aclrtStreamWaitEventWithFlag(aclrtStream stream, aclrtEvent event, uint32_t timeout, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id8 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id8 -->
<!-- npu="A3" id9 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id9 -->
<!-- npu="910b" id10 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id10 -->
<!-- npu="310b" id11 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id11 -->
<!-- npu="310p" id12 -->
- Atlas 推理系列产品：不支持
<!-- end id12 -->
<!-- npu="910" id13 -->
- Atlas 训练系列产品：不支持
<!-- end id13 -->
<!-- npu="IPV350" id14 -->
- IPV350：不支持
<!-- end id14 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id15 -->

### 功能说明

阻塞指定Stream的运行，直到指定的Event完成。异步接口。
该接口是在接口[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)、[aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout)基础上进行了增强，支持用户配置具体的超时时间，同时还可以配置flag，不同的flag用于不同的使用场景。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
|stream|输入| 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>当flag为ACL_EVENT_WAIT_EXTERNAL时，仅支持在图捕获（ACL Graph）场景下使用，且stream参数处指定的Stream必须是正处于捕获状态。|
|event|输入| 需等待的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。<br>当flag为ACL_EVENT_WAIT_EXTERNAL时，event仅支持通过[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建，且flag必须为ACL_EVENT_SYNC。其他flag或其他创建Event的接口均不支持。|
|timeout|输入| 超时时间，单位为秒。<br>当flag为ACL_EVENT_WAIT_DEFAULT时，功能等价于[aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout)接口，但本接口timeout参数类型为uint32_t。<br>当flag为ACL_EVENT_WAIT_EXTERNAL时，timeout参数仅支持设置为0，表示永不超时。|
|flag|输入| 指定等待动作的行为。flag取值如下：<br>- 当flag为ACL_EVENT_WAIT_DEFAULT时，表示默认标记，适用于普通场景，等价于[aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout)接口。<br>- 当flag为ACL_EVENT_WAIT_EXTERNAL时，图捕获场景专用，当用户正在把Stream上的任务捕获成计算图时，带上这个flag，表示本次等待一个图之外的事件，用于实现图和外部Stream之间做同步、以及实现图和图之间做同步。<br><br>宏定义如下：<br>#define ACL_EVENT_WAIT_DEFAULT 0x00U<br>#define ACL_EVENT_WAIT_EXTERNAL 0x01U<br> |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

当flag为ACL_EVENT_WAIT_EXTERNAL时，存在如下约束：

- 对于同一个图，在图捕获过程中，同一event不允许同时进行Record和Wait操作。
- 若event在通过本接口记录之前已被[aclrtRecordEvent](#aclrtRecordEvent)记录过，则本接口返回错误。

<br>
<br>
<br>

<a id="aclrtStreamWaitEventWithTimeout"></a>

## aclrtStreamWaitEventWithTimeout

```c
aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)
```

### 产品支持情况

<!-- npu="950" id2129 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2129 -->
<!-- npu="A3" id2130 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2130 -->
<!-- npu="910b" id2131 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2131 -->
<!-- npu="310b" id2132 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2132 -->
<!-- npu="310p" id2133 -->
- Atlas 推理系列产品：支持
<!-- end id2133 -->
<!-- npu="910" id2134 -->
- Atlas 训练系列产品：支持
<!-- end id2134 -->
<!-- npu="IPV350" id2135 -->
- IPV350：不支持
<!-- end id2135 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id16 -->

### 功能说明

阻塞指定Stream的运行，直到指定的Event完成或等待超时。支持多个Stream等待同一个Event，若等待超时则返回错误码。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream2。 |
| event | 输入 | 需等待的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| timeout | 输入 | 超时时间。<br>取值>=0，用于配置具体的超时时间，单位是秒。0代表永不超时。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetOpWaitTimeout"></a>

## aclrtSetOpWaitTimeout

```c
aclError aclrtSetOpWaitTimeout(uint32_t timeout)
```

### 产品支持情况

<!-- npu="950" id414 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id414 -->
<!-- npu="A3" id415 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id415 -->
<!-- npu="910b" id416 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id416 -->
<!-- npu="310b" id417 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id417 -->
<!-- npu="310p" id418 -->
- Atlas 推理系列产品：不支持
<!-- end id418 -->
<!-- npu="910" id419 -->
- Atlas 训练系列产品：支持
<!-- end id419 -->
<!-- npu="IPV350" id420 -->
- IPV350：不支持
<!-- end id420 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id17 -->

### 功能说明

本接口用于设置等待Event完成的超时时间。

不调用本接口，则默认不超时；一个进程内多次调用本接口，则以最后一次设置的时间为准。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeout | 输入 | 设置超时时间，单位为秒。<br>将该参数设置为0时，表示不超时。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

一个进程内，调用[aclInit](02_initialization_and_deinitialization.md#aclInit)接口初始化后，若再调用[aclrtSetOpWaitTimeout](#aclrtSetOpWaitTimeout)接口设置超时时间，那么本进程内后续调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口下发的任务支持在所设置的超时时间内等待，若等待的时间超过所设置的超时时间，则在调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）后，会返回报错。

<br>
<br>
<br>

<a id="aclrtEventGetTimestamp"></a>

## aclrtEventGetTimestamp

```c
aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)
```

### 产品支持情况

<!-- npu="950" id2409 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2409 -->
<!-- npu="A3" id2410 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2410 -->
<!-- npu="910b" id2411 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2411 -->
<!-- npu="310b" id2412 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2412 -->
<!-- npu="310p" id2413 -->
- Atlas 推理系列产品：支持
<!-- end id2413 -->
<!-- npu="910" id2414 -->
- Atlas 训练系列产品：支持
<!-- end id2414 -->
<!-- npu="IPV350" id2415 -->
- IPV350：不支持
<!-- end id2415 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id18 -->

### 功能说明

获取Event的执行结束时间点（表示从AI处理器系统启动以来的时间）。

本接口需与其它关键接口配合使用，接口调用顺序：调用[aclrtCreateEvent](#aclrtCreateEvent)/[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag)接口创建Event**--\>**调用[aclrtRecordEvent](#aclrtRecordEvent)接口在Stream中记录Event**\>**调用[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)接口阻塞应用程序运行，直到指定Stream中的所有任务都完成**--\>**调用aclrtEventGetTimestamp接口获取Event的执行时间。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 查询的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| timestamp | 输出 | Event执行结束的时间点，单位为微秒。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetEventId"></a>

## aclrtGetEventId

```c
aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)
```

### 产品支持情况

<!-- npu="950" id127 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id127 -->
<!-- npu="A3" id128 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id128 -->
<!-- npu="910b" id129 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id129 -->
<!-- npu="310b" id130 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id130 -->
<!-- npu="310p" id131 -->
- Atlas 推理系列产品：支持
<!-- end id131 -->
<!-- npu="910" id132 -->
- Atlas 训练系列产品：支持
<!-- end id132 -->
<!-- npu="IPV350" id133 -->
- IPV350：不支持
<!-- end id133 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id19 -->

### 功能说明

获取指定Event的ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定要查询的Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| eventId | 输出 | Event ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetEventAvailNum"></a>

## aclrtGetEventAvailNum

```c
aclError aclrtGetEventAvailNum(uint32_t *eventCount)
```

### 产品支持情况

<!-- npu="950" id617 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id617 -->
<!-- npu="A3" id618 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id618 -->
<!-- npu="910b" id619 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id619 -->
<!-- npu="310b" id620 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id620 -->
<!-- npu="310p" id621 -->
- Atlas 推理系列产品：支持
<!-- end id621 -->
<!-- npu="910" id622 -->
- Atlas 训练系列产品：支持
<!-- end id622 -->
<!-- npu="IPV350" id623 -->
- IPV350：不支持
<!-- end id623 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id20 -->

### 功能说明

查询当前Device上可用的Event数量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| eventCount | 输出 | Event数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtIpcGetEventHandle"></a>

## aclrtIpcGetEventHandle

```c
aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)
```

### 产品支持情况

<!-- npu="950" id1891 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id1891 -->
<!-- npu="A3" id1892 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1892 -->
<!-- npu="910b" id1893 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1893 -->
<!-- npu="310b" id1894 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1894 -->
<!-- npu="310p" id1895 -->
- Atlas 推理系列产品：不支持
<!-- end id1895 -->
<!-- npu="910" id1896 -->
- Atlas 训练系列产品：不支持
<!-- end id1896 -->
<!-- npu="IPV350" id1897 -->
- IPV350：不支持
<!-- end id1897 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id21 -->

### 功能说明

将本进程中的指定Event设置为IPC（Inter-Process Communication） Event，并返回其handle（即Event句柄），用于在跨进程场景下实现任务同步，支持同一个Device内的多个进程以及跨Device的多个进程。

**本接口需与以下其它关键接口配合使用**，此处以A进程、B进程为例：

<a id="li288673614297"></a>
<a id="li288673614297"></a>

1. A进程中：
    1. 调用[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建flag为ACL\_EVENT\_IPC的Event。
    2. 调用aclrtIpcGetEventHandle接口获取用于进程间通信的Event句柄。
    3. 调用[aclrtRecordEvent](#aclrtRecordEvent)接口在Stream中插入[1.a](#li288673614297)中创建的Event。

2. B进程中：
    1. 调用[aclrtIpcOpenEventHandle](#aclrtIpcOpenEventHandle)接口获取A进程中的Event句柄信息，并返回本进程可以使用的Event指针。
    2. 调用[aclrtStreamWaitEvent](#aclrtStreamWaitEvent)接口阻塞指定Stream的运行，直到指定的Event完成。
    3. Event使用完成后，调用[aclrtDestroyEvent](#aclrtDestroyEvent)接口销毁Event。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| event | 输入 | 指定Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。<br>仅支持通过[aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag)接口创建的、flag为ACL_EVENT_IPC的Event。 |
| handle | 输出 | 进程间通信的Event句柄。类型定义请参见[aclrtIpcEventHandle](25-04_Structs.md#aclrtIpcEventHandle)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtIpcOpenEventHandle"></a>

## aclrtIpcOpenEventHandle

```c
aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)
```

### 产品支持情况

<!-- npu="950" id2164 -->
- Ascend 950PR：支持
- Ascend 950DT：不支持
<!-- end id2164 -->
<!-- npu="A3" id2165 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2165 -->
<!-- npu="910b" id2166 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2166 -->
<!-- npu="310b" id2167 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2167 -->
<!-- npu="310p" id2168 -->
- Atlas 推理系列产品：不支持
<!-- end id2168 -->
<!-- npu="910" id2169 -->
- Atlas 训练系列产品：不支持
<!-- end id2169 -->
<!-- npu="IPV350" id2170 -->
- IPV350：不支持
<!-- end id2170 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id22 -->

### 功能说明

在本进程中获取handle的信息，并返回本进程可以使用的Event指针。

本接口需与其它接口配合使用，以便实现不同进程间的任务同步，请参见[aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle)接口处的说明。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | Event句柄。类型定义请参见[aclrtIpcEventHandle](25-04_Structs.md#aclrtIpcEventHandle)。<br>必须先调用[aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle)接口获取指定Event的句柄，再作为入参传入。 |
| event | 输出 | Event指针。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
