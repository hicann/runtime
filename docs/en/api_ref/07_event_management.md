# 7. Event Management

<!-- md-trans-meta sourceCommit=09c468b359b0e393f15436d7e1fc8eb9a77bcab0 translatedAt=2026-11-06T11:15:43.792Z pushedAt=2026-11-09T08:03:47.093Z nl=2 -->

This section describes the event management APIs of CANN Runtime, used for event creation, recording, synchronization, timing, and cross-process sharing via IPC.

- [`aclError aclrtCreateEvent(aclrtEvent *event)`](#aclrtCreateEvent): Creates an event. The created event can be used in use cases such as measuring the elapsed time between two events and synchronizing tasks among multiple streams.
- [`aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEventWithFlag): Creates an event with a flag. Events with different flags serve different purposes. You can add multiple flags when creating an event (using bitwise OR operations) to realize the functions of those flags simultaneously.
- [`aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)`](#aclrtCreateEventExWithFlag): Creates an event with a flag. Events with different flags serve different purposes.
- [`aclError aclrtDestroyEvent(aclrtEvent event)`](#aclrtDestroyEvent): Destroys an event. You can call this API to destroy an event before it completes. In this case, this API does not block the thread waiting for the event to complete, and the resources related to the event are automatically released upon event completion.
- [`aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)`](#aclrtRecordEvent): Records an event in the specified stream. This is an asynchronous API.
- [`aclError aclrtRecordEventWithFlag(aclrtEvent event, aclrtStream stream, uint32_t flag)`](#aclrtRecordEventWithFlag): Records an event in the specified stream. This is an asynchronous API, an enhancement of [aclrtRecordEvent](#aclrtRecordEvent) and supports flag configuration. Different flags serve different use cases.
- [`aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)`](#aclrtResetEvent): Resets an event to restore its initial state, so that the event object can be reused. This is an asynchronous API.
- [`aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)`](#aclrtQueryEvent): Queries whether the event recorded by [aclrtRecordEvent](#aclrtRecordEvent) called in the same thread as this API has completed execution.
- [`aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)`](#aclrtQueryEventStatus): Queries the execution status of all tasks captured by the event. For details about event capture, see [aclrtRecordEvent](#aclrtRecordEvent).
- [`aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)`](#aclrtQueryEventWaitStatus): Queries whether all wait tasks corresponding to the event are complete after [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) is called.
- [`aclError aclrtSynchronizeEvent(aclrtEvent event)`](#aclrtSynchronizeEvent): Blocks the current thread until all tasks captured by the event complete.
- [`aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)`](#aclrtSynchronizeEventWithTimeout): Blocks the current thread until all tasks captured by the event complete (for details about event capture, see [aclrtRecordEvent](#aclrtRecordEvent)). This API is an enhanced version of [aclrtSynchronizeEvent](#aclrtSynchronizeEvent). It supports permanent wait or a specific timeout duration. If a specific timeout duration is configured, the application can exit on its own within the configured timeout duration when it becomes abnormal.
- [`aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)`](#aclrtEventElapsedTime): Calculates the elapsed time between two events.
- [`aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)`](#aclrtStreamWaitEvent): Blocks the execution of the specified stream until the specified event completes. This API supports the use case where multiple streams wait for the same event. This is an asynchronous API.
- [`aclError aclrtStreamWaitEventWithFlag(aclrtStream stream, aclrtEvent event, uint32_t timeout, uint32_t flag)`](#aclrtStreamWaitEventWithFlag): Blocks the execution of the specified stream until the specified event completes. This is an asynchronous API, an enhanced version of [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) and [aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout). It supports a configurable timeout duration and flag. Different flags serve different use cases.
- [`aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)`](#aclrtStreamWaitEventWithTimeout): Blocks the execution of the specified stream until the specified event completes or the wait times out. This API supports the use case where multiple streams wait for the same event. This is an asynchronous API.
- [`aclError aclrtSetOpWaitTimeout(uint32_t timeout)`](#aclrtSetOpWaitTimeout): Sets the timeout duration for waiting for event completion.
- [`aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)`](#aclrtEventGetTimestamp): Obtains the time point when the event execution completes (indicating the time elapsed since the AI processor system was started).
- [`aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)`](#aclrtGetEventId): Obtains the ID of a specified event.
- [`aclError aclrtGetEventAvailNum(uint32_t *eventCount)`](#aclrtGetEventAvailNum): Queries the number of available events on the current device.
- [`aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)`](#aclrtIpcGetEventHandle): Sets the specified event in the current process as an IPC (Inter-Process Communication) event and returns its handle to synchronize tasks across processes on the same device or on multiple devices.
- [`aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)`](#aclrtIpcOpenEventHandle): Obtains the handle information in the current process and returns the event pointer that can be used by the current process.

<a class="method_anchor" id="aclrtCreateEvent"></a>

## aclrtCreateEvent

```c
aclError aclrtCreateEvent(aclrtEvent *event)
```

### Applicable Products

<!-- npu="950" id687 -->
- Ascend 950PR&950DT products: Supported
<!-- end id687 -->
<!-- npu="A3" id688 -->
- Atlas A3 products: Supported
<!-- end id688 -->
<!-- npu="910b" id689 -->
- Atlas A2 products: Supported
<!-- end id689 -->
<!-- npu="310b" id690 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id690 -->
<!-- npu="310p" id691 -->
- Atlas inference products: Supported
<!-- end id691 -->
<!-- npu="910" id692 -->
- Atlas training products: Supported
<!-- end id692 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id1 -->

### Function

Creates an event. The created event can be used in use cases such as measuring the elapsed time between two events and synchronizing tasks among multiple streams.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Output | Pointer to the event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- An event created by this API cannot be used in the [aclrtResetEvent](#aclrtResetEvent) API. Otherwise, undefined behavior occurs.

- When an event is created by calling this API, event resources are not actually requested. Resources are requested only when [aclrtRecordEvent](#aclrtRecordEvent) is called. Therefore, calling [aclrtRecordEvent](#aclrtRecordEvent) may block the thread and the thread waits for event resources to be released.

- Different hardware models support different numbers of events.
  <!-- npu="950,A3,910b,310b" id15 -->
  - For the following products, the maximum number of events supported by a single device is 65536:

    <!-- npu="950" id18 -->
    Ascend 950PR&950DT products
    <!-- end id18 -->

    <!-- npu="A3" id19 -->
    Atlas A3 products
    <!-- end id19 -->

    <!-- npu="910b" id20 -->
    Atlas A2 products
    <!-- end id20 -->

    <!-- npu="310b" id21 -->
    Atlas 200I/500 A2 inference products
    <!-- end id21 -->

  <!-- end id15 -->
  <!-- npu="310p" id16 -->
  - For Atlas inference products, the maximum number of events supported by a single device is 1023.
  <!-- end id16 -->
  <!-- npu="910" id17 -->
  - For Atlas training products, the maximum number of events supported by a single device is 65535.
  <!-- end id17 -->
  <!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id23 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateEventWithFlag"></a>

## aclrtCreateEventWithFlag

```c
aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id2808 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2808 -->
<!-- npu="A3" id2809 -->
- Atlas A3 products: Supported
<!-- end id2809 -->
<!-- npu="910b" id2810 -->
- Atlas A2 products: Supported
<!-- end id2810 -->
<!-- npu="310b" id2811 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2811 -->
<!-- npu="310p" id2812 -->
- Atlas inference products: Supported
<!-- end id2812 -->
<!-- npu="910" id2813 -->
- Atlas training products: Supported
<!-- end id2813 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id2 -->

### Function

Creates an event with a flag. Events with different flags serve different purposes. You can add multiple flags when creating an event (using bitwise OR operations) to realize the functions of those flags simultaneously.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Output | Pointer to the event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| flag | Input | Flag of the event pointer.<br>Currently, it can be set to the following macros:<br><br>  - ACL_EVENT_TIME_LINE: If this bit is set, the created event needs to record timestamp information. Note that enabling timestamps affects the performance of event-related APIs.<br>  - ACL_EVENT_SYNC: If this bit is set, the created event supports synchronization between multiple streams.<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS: If this bit is set, the created event is used to track the task execution progress of a stream.<br>  - ACL_EVENT_EXTERNAL: If this bit is set, the created event is used for task updates in task captures. For details, see [aclmdlRICaptureBegin](15_model_running_instance_management.md#aclmdlRICaptureBegin). Note that this flag does not support bitwise OR operations with other flags.<br>  - ACL_EVENT_DEVICE_USE_ONLY: If this bit is set, the created event can only be called on the device. Note that this flag does not support bitwise OR operations with other flags.<br><br><br>The macros are defined as follows:<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_EXTERNAL  0x00000020U<br>#define ACL_EVENT_DEVICE_USE_ONLY  0x00000010U |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="950,A3,910b,310p,310b" id22 -->
- Support for ACL\_EVENT\_DEVICE\_USE\_ONLY varies by product model:

  <!-- npu="950,A3,910b" id23 -->
  Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products: Supported
  <!-- end id23 -->

  <!-- npu="310p" id25 -->
  Atlas inference products: Supported
  <!-- end id25 -->

  <!-- npu="310b" id24 -->
  Atlas 200I/500 A2 inference products and Atlas training products: Not supported
  <!-- end id24 -->

<!-- end id22 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id26 -->

- If the flag value **does not include** the ACL_EVENT_SYNC macro, the event created by this API cannot be used in the following APIs: [aclrtResetEvent](#aclrtResetEvent), [aclrtStreamWaitEvent](#aclrtStreamWaitEvent). If the flag value **includes** the ACL_EVENT_SYNC macro or the flag is set to `ACL_EVENT_EXTERNAL`, only a limited number of events can be created.
The allowed number of events varies by hardware model.
  <!-- npu="950,A3,910b,310b" id26 -->
  - For the following product models, the maximum allowed number of events by a single device is 65536:

    <!-- npu="950" id27 -->
    Ascend 950PR&950DT products
    <!-- end id27 -->

    <!-- npu="A3" id28 -->
    Atlas A3 products
    <!-- end id28 -->

    <!-- npu="910b" id29 -->
    Atlas A2 products
    <!-- end id29 -->

    <!-- npu="310b" id30 -->
    Atlas 200I/500 A2 inference products
    <!-- end id30 -->
  <!-- end id26 -->

  <!-- npu="310p" id31 -->
  - For Atlas inference products, the maximum allowed number of events by a single device is 1023.
  <!-- end id31 -->
  <!-- npu="910" id32 -->
  - For Atlas training products, the maximum allowed number of events by a single device is 65535.
  <!-- end id32 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateEventExWithFlag"></a>

## aclrtCreateEventExWithFlag

```c
aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id2780 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2780 -->
<!-- npu="A3" id2781 -->
- Atlas A3 products: Supported
<!-- end id2781 -->
<!-- npu="910b" id2782 -->
- Atlas A2 products: Supported
<!-- end id2782 -->
<!-- npu="310b" id2783 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2783 -->
<!-- npu="310p" id2784 -->
- Atlas inference products: Supported
<!-- end id2784 -->
<!-- npu="910" id2785 -->
- Atlas training products: Supported
<!-- end id2785 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id3 -->

### Function

Creates an event with a flag. Events with different flags serve different purposes. You can add multiple flags (using the bitwise OR operation) when creating an event to realize the functions of those flags simultaneously. When creating an event, the event resources are not limited by hardware.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Output | Pointer to the event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| flag | Input | Flag of the event.<br>The flag is a bitmap. It can be set to a single macro or the result of the OR operation on multiple macros.<br>Currently, the flag can be set to the following macros:<br><br>  - ACL_EVENT_TIME_LINE: Enabling this bit indicates that the created event needs to record timestamp information. Note that enabling timestamps affects the performance of event-related APIs.<br>  - ACL_EVENT_SYNC: Enabling this bit indicates that the created event supports synchronization between multiple streams.<br>  - ACL_EVENT_CAPTURE_STREAM_PROGRESS: Enabling this bit indicates that the created event is used to track the task execution progress of a stream.<br>  - ACL_EVENT_IPC: Enabling this bit indicates that the created event is used for inter-process communication (IPC). For details, see [aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle). Note that this flag cannot be combined with other flags using the bitwise OR operation. Ascend 950DT products do not support creating an event with this flag. The event created with this flag cannot be used in the following APIs or use cases: [aclrtResetEvent](#aclrtResetEvent), [aclrtQueryEvent](#aclrtQueryEvent), [aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus), [aclrtEventElapsedTime](#aclrtEventElapsedTime), [aclrtEventGetTimestamp](#aclrtEventGetTimestamp), [aclrtGetEventId](#aclrtGetEventId), or model capture (see the description in [aclmdlRICaptureBegin](15_model_running_instance_management.md#aclmdlRICaptureBegin)). Otherwise, an error is returned.<br><br><br>The macros are defined as follows:<br>#define ACL_EVENT_TIME_LINE 0x00000008U<br>#define ACL_EVENT_SYNC 0x00000001U<br>#define ACL_EVENT_CAPTURE_STREAM_PROGRESS 0x00000002U<br>#define ACL_EVENT_IPC 0x00000040U |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The event created using this API cannot be used in the following APIs: [aclrtResetEvent](#aclrtResetEvent), [aclrtQueryEvent](#aclrtQueryEvent), and [aclrtQueryEventWaitStatus](#aclrtQueryEventWaitStatus). Otherwise, an error is returned.

- If the flag value **does not include** the macro ACL_EVENT_SYNC, the event created by this API cannot be used in [aclrtStreamWaitEvent](#aclrtStreamWaitEvent). If the flag value **includes** the macro ACL_EVENT_SYNC, the event resources are not actually requested. They are requested only when [aclrtRecordEvent](#aclrtRecordEvent) is called. Therefore, when [aclrtRecordEvent](#aclrtRecordEvent) is called, the thread may be blocked, waiting for the event resources to be released.

- The allowed number of events varies by hardware model.
  <!-- npu="950,A3,910b,310b" id33 -->
  - For the following products, the maximum allowed number of events by a single device is 65536:

    <!-- npu="950" id34 -->
    Ascend 950PR&950DT products
    <!-- end id34 -->

    <!-- npu="A3" id35 -->
    Atlas A3 products
    <!-- end id35 -->

    <!-- npu="910b" id36 -->
    Atlas A2 products
    <!-- end id36 -->

    <!-- npu="310b" id37 -->
    Atlas 200I/500 A2 inference products
    <!-- end id37 -->
  <!-- end id33 -->

  <!-- npu="310p" id38 -->
  - For Atlas inference products, the maximum allowed number of events by a single device is 1023.
  <!-- end id38 -->
  <!-- npu="910" id39 -->
  - For Atlas training products, the maximum allowed number of events by a single device is 65535.
  <!-- end id39 -->
  <!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id25 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyEvent"></a>

## aclrtDestroyEvent

```c
aclError aclrtDestroyEvent(aclrtEvent event)
```

### Applicable Products

<!-- npu="950" id1338 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1338 -->
<!-- npu="A3" id1339 -->
- Atlas A3 products: Supported
<!-- end id1339 -->
<!-- npu="910b" id1340 -->
- Atlas A2 products: Supported
<!-- end id1340 -->
<!-- npu="310b" id1341 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1341 -->
<!-- npu="310p" id1342 -->
- Atlas inference products: Supported
<!-- end id1342 -->
<!-- npu="910" id1343 -->
- Atlas training products: Supported
<!-- end id1343 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id4 -->

### Function

Destroys an event. You can call this API to destroy an event before it completes. In this case, the API does not block the thread waiting for the event to complete, and event resources are automatically released when the event completes.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to destroy. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

When calling aclrtDestroyEvent to destroy an event, make sure that no other API is using the event.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtRecordEvent"></a>

## aclrtRecordEvent

```c
aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id981 -->
- Ascend 950PR&950DT products: Supported
<!-- end id981 -->
<!-- npu="A3" id982 -->
- Atlas A3 products: Supported
<!-- end id982 -->
<!-- npu="910b" id983 -->
- Atlas A2 products: Supported
<!-- end id983 -->
<!-- npu="310b" id984 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id984 -->
<!-- npu="310p" id985 -->
- Atlas inference products: Supported
<!-- end id985 -->
<!-- npu="910" id986 -->
- Atlas training products: Supported
<!-- end id986 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id5 -->

### Function

Records an event in the specified stream. This is an asynchronous API.

aclrtRecordEvent works in pairs with aclrtStreamWaitEvent for synchronization waits between multiple streams.

When aclrtRecordEvent is called, it captures the tasks already issued on the current stream and records them in an event. Therefore, when [aclrtQueryEventStatus](#aclrtQueryEventStatus) or [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) is called later, it checks or waits until all tasks captured in the event are complete.

In addition, for an event created by using [aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag):

- aclrtRecordEvent supports recording the same event multiple times to reuse the event. Each record re-captures the tasks that have been issued on the current stream and overwrites those saved in the event. When aclrtStreamWaitEvent is called, the tasks saved in the most recent record prevail and are not affected by subsequent aclrtRecordEvent calls.
- Prior to the first call to aclrtRecordEvent, the event contains no tasks. Therefore, calling aclrtQueryEventStatus returns ACL_EVENT_RECORDED_STATUS_COMPLETE.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to be recorded. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| stream | Input | Specified stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>In multi-stream synchronization waits, for example, if Stream2 waits for Stream1, set this parameter to Stream1. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtRecordEventWithFlag"></a>

## aclrtRecordEventWithFlag

```c
aclError aclrtRecordEventWithFlag(aclrtEvent event, aclrtStream stream, uint32_t flag)
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
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id6 -->

### Function

Records an event in the specified stream. This is an asynchronous API.
This API is an enhancement of [aclrtRecordEvent](#aclrtRecordEvent) and supports flag configuration. Different flags serve different purposes.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: |---|
| event | Input | Event to be recorded. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent).<br>When the flag is ACL_EVENT_RECORD_EXTERNAL, the event can be created only by calling [aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag), and the flag must be ACL_EVENT_SYNC. Other flags or other event creation APIs are not supported. |
| stream | Input | Specified stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>When the flag is ACL_EVENT_RECORD_EXTERNAL, this parameter can be used only during graph capture (ACL Graph), and the stream specified by stream must be in the capturing state. |
| flag | Input | Specifies the behavior of the record action. Options:<br>- ACL_EVENT_RECORD_DEFAULT: The default behavior applies. It works for common use cases and is equivalent to [aclrtRecordEvent](#aclrtRecordEvent).<br>- ACL_EVENT_RECORD_EXTERNAL: It applies only to graph capture. When tasks on a stream are being captured into a computation graph, set this flag to make the recorded event visible externally. It facilitates synchronization between the graph and an external stream, and between graphs. Beyond graph capture, an error is returned when the flag is ACL_EVENT_RECORD_EXTERNAL.<br><br>  Macro definitions are as follows:<br>#define ACL_EVENT_RECORD_DEFAULT 0x00U <br> #define ACL_EVENT_RECORD_EXTERNAL 0x01U<br> |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API has the following constraints:

- For the same graph, during capture, the same event can be issued only once as a record operation with the flag ACL_EVENT_RECORD_EXTERNAL or a wait operation with the flag ACL_EVENT_WAIT_EXTERNAL.
- For the Record operation of the same event, switching the flag between ACL_EVENT_RECORD_DEFAULT and ACL_EVENT_RECORD_EXTERNAL is not allowed. When this API is called for the first time, the association between the event and the Record flag is established at the call entry. The API return value does not affect the validity of the association.
- Issuing a Record operation with the flag ACL_EVENT_RECORD_EXTERNAL in a subgraph is not supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtResetEvent"></a>

## aclrtResetEvent

```c
aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id246 -->
- Ascend 950PR&950DT products: Supported
<!-- end id246 -->
<!-- npu="A3" id247 -->
- Atlas A3 products: Supported
<!-- end id247 -->
<!-- npu="910b" id248 -->
- Atlas A2 products: Supported
<!-- end id248 -->
<!-- npu="310b" id249 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id249 -->
<!-- npu="310p" id250 -->
- Atlas inference products: Supported
<!-- end id250 -->
<!-- npu="910" id251 -->
- Atlas training products: Supported
<!-- end id251 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id7 -->

### Function

Resets an event and restores it to the initial state so that the event object can be reused. This is an asynchronous API.

For task synchronization between multiple streams, the event is usually reset after [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to be reset. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| stream | Input | Stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>For task synchronization between multiple streams, for example, when tasks in Stream2 depend on tasks in Stream1, set this parameter to Stream2. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Only the events created by calling [aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag) with the ACL\_EVENT\_SYNC flag can be reset.

**Note**: When tasks in multiple streams need to wait for the same event, resetting the event by calling this API is not recommended. As shown in the figure, if aclrtResetEvent is called after aclrtStreamWaitEvent in stream2, the event is reset. As a result, aclrtStreamWaitEvent in stream3 cannot succeed.

![](figures/event_wait_diagram.png)

<br>
<br>
<br>

<a class="method_anchor" id="aclrtQueryEvent"></a>

## aclrtQueryEvent (Deprecated)

```c
aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)
```

**Note: This API will be deprecated in future releases. Use [aclrtQueryEventStatus](#aclrtQueryEventStatus) instead.**

### Applicable Products

<!-- npu="950" id820 -->
- Ascend 950PR&950DT products: Supported
<!-- end id820 -->
<!-- npu="A3" id821 -->
- Atlas A3 products: Supported
<!-- end id821 -->
<!-- npu="910b" id822 -->
- Atlas A2 products: Supported
<!-- end id822 -->
<!-- npu="310b" id823 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id823 -->
<!-- npu="310p" id824 -->
- Atlas inference products: Supported
<!-- end id824 -->
<!-- npu="910" id825 -->
- Atlas training products: Supported
<!-- end id825 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id8 -->

### Function

Queries whether the event recorded by [aclrtRecordEvent](#aclrtRecordEvent) in the same thread as this API completes execution.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to query. For details about the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| status | Output | Pointer to the event status. For details about the type definition, see [aclrtEventStatus](25-02_Enumerations.md#aclrtEventStatus). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtQueryEventStatus"></a>

## aclrtQueryEventStatus

```c
aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
```

### Applicable Products

<!-- npu="950" id3095 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3095 -->
<!-- npu="A3" id3096 -->
- Atlas A3 products: Supported
<!-- end id3096 -->
<!-- npu="910b" id3097 -->
- Atlas A2 products: Supported
<!-- end id3097 -->
<!-- npu="310b" id3098 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3098 -->
<!-- npu="310p" id3099 -->
- Atlas inference products: Supported
<!-- end id3099 -->
<!-- npu="910" id3100 -->
- Atlas training products: Supported
<!-- end id3100 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id9 -->

### Function

Queries the execution status of all tasks captured by the event. For details, see the [aclrtRecordEvent](#aclrtRecordEvent) API Reference.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to query. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| status | Output | Pointer to the event status. For the type definition, see [aclrtEventRecordedStatus](25-02_Enumerations.md#aclrtEventRecordedStatus).<br>ACL_EVENT_RECORDED_STATUS_COMPLETE is returned if all tasks captured by the event complete. ACL_EVENT_RECORDED_STATUS_NOT_READY is returned if any task does not complete. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

If you call [aclrtRecordEvent](#aclrtRecordEvent) and aclrtQueryEventStatus in different threads, multithreading may disrupt the execution order of the two APIs. As a result, the completion status of the queried event may not meet expectations.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtQueryEventWaitStatus"></a>

## aclrtQueryEventWaitStatus

```c
aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)
```

### Applicable Products

<!-- npu="950" id225 -->
- Ascend 950PR&950DT products: Supported
<!-- end id225 -->
<!-- npu="A3" id226 -->
- Atlas A3 products: Supported
<!-- end id226 -->
<!-- npu="910b" id227 -->
- Atlas A2 products: Supported
<!-- end id227 -->
<!-- npu="310b" id228 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id228 -->
<!-- npu="310p" id229 -->
- Atlas inference products: Supported
<!-- end id229 -->
<!-- npu="910" id230 -->
- Atlas training products: Supported
<!-- end id230 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id10 -->

### Function

Queries whether all tasks waiting on the event have completed after [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) is called.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to query. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| status | Output | Pointer to the event status. For the type definition, see [aclrtEventWaitStatus](25-02_Enumerations.md#aclrtEventWaitStatus). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API is not supported for events created by calling [aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSynchronizeEvent"></a>

## aclrtSynchronizeEvent

```c
aclError aclrtSynchronizeEvent(aclrtEvent event)
```

### Applicable Products

<!-- npu="950" id911 -->
- Ascend 950PR&950DT products: Supported
<!-- end id911 -->
<!-- npu="A3" id912 -->
- Atlas A3 products: Supported
<!-- end id912 -->
<!-- npu="910b" id913 -->
- Atlas A2 products: Supported
<!-- end id913 -->
<!-- npu="310b" id914 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id914 -->
<!-- npu="310p" id915 -->
- Atlas inference products: Supported
<!-- end id915 -->
<!-- npu="910" id916 -->
- Atlas training products: Supported
<!-- end id916 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id11 -->

### Function

Blocks the current thread until all tasks captured by the event complete. For details about event capture, see [aclrtRecordEvent](#aclrtRecordEvent).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to wait on. For details about the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSynchronizeEventWithTimeout"></a>

## aclrtSynchronizeEventWithTimeout

```c
aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id1793 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1793 -->
<!-- npu="A3" id1794 -->
- Atlas A3 products: Supported
<!-- end id1794 -->
<!-- npu="910b" id1795 -->
- Atlas A2 products: Supported
<!-- end id1795 -->
<!-- npu="310b" id1796 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1796 -->
<!-- npu="310p" id1797 -->
- Atlas inference products: Supported
<!-- end id1797 -->
<!-- npu="910" id1798 -->
- Atlas training products: Supported
<!-- end id1798 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id12 -->

### Function

Blocks the current thread until all tasks captured by the event complete (see [aclrtRecordEvent](#aclrtRecordEvent) for details about event capture). This API is an enhancement of [aclrtSynchronizeEvent](#aclrtSynchronizeEvent) and supports permanent waiting or a configured specific timeout duration. For a configured timeout duration, the application exits automatically after that duration when an exception occurs.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to wait on. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| timeout | Input | Timeout duration of the API.<br>The values are described as follows:<br><br>  - `-1`: permanent waiting, with the same function as [aclrtSynchronizeEvent](#aclrtSynchronizeEvent).<br>  - `>0`: specific timeout duration, in milliseconds. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id24 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtEventElapsedTime"></a>

## aclrtEventElapsedTime

```c
aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)
```

### Applicable Products

<!-- npu="950" id1667 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1667 -->
<!-- npu="A3" id1668 -->
- Atlas A3 products: Supported
<!-- end id1668 -->
<!-- npu="910b" id1669 -->
- Atlas A2 products: Supported
<!-- end id1669 -->
<!-- npu="310b" id1670 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1670 -->
<!-- npu="310p" id1671 -->
- Atlas inference products: Supported
<!-- end id1671 -->
<!-- npu="910" id1672 -->
- Atlas training products: Supported
<!-- end id1672 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id13 -->

### Function

Measures the elapsed time between two events.

This API must be used together with other key APIs. API call order: Call [aclrtCreateEvent](#aclrtCreateEvent)/[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag) to create an event event --\> **Call [aclrtRecordEvent](#aclrtRecordEvent) to record the start and end events in the same stream** --\> **Call [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream) to block the application until all tasks in the specified stream complete** --\> Call aclrtEventElapsedTime to measure the elapsed time between the two events

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| ms | Output | Pointer to the elapsed time between two events, in milliseconds. |
| startEvent | Input | Start event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| endEvent | Input | End event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamWaitEvent"></a>

## aclrtStreamWaitEvent

```c
aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)
```

### Applicable Products

<!-- npu="950" id64 -->
- Ascend 950PR&950DT products: Supported
<!-- end id64 -->
<!-- npu="A3" id65 -->
- Atlas A3 products: Supported
<!-- end id65 -->
<!-- npu="910b" id66 -->
- Atlas A2 products: Supported
<!-- end id66 -->
<!-- npu="310b" id67 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id67 -->
<!-- npu="310p" id68 -->
- Atlas inference products: Supported
<!-- end id68 -->
<!-- npu="910" id69 -->
- Atlas training products: Supported
<!-- end id69 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id14 -->

### Function

Blocks the execution of the specified stream until the specified event completes. Multiple streams can wait for the same event. This is an asynchronous API.

All subsequent tasks submitted to the stream start executing only after the tasks captured by the event complete. For details about event capture, see [aclrtRecordEvent](#aclrtRecordEvent).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specified stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>In a multi-stream synchronization wait use case, for example, Stream2 waiting for Stream1, set this parameter to Stream2. |
| event | Input | Event to wait on. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Within a process, after [aclInit](02_initialization_and_deinitialization.md#aclInit) is called for initialization, if [aclrtSetOpWaitTimeout](#aclrtSetOpWaitTimeout) is called to set the timeout duration, tasks subsequently dispatched by calling [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) in this process support waiting within the set timeout duration. If the wait time exceeds the set timeout duration, an error is returned after a synchronous API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) is called.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamWaitEventWithFlag"></a>

## aclrtStreamWaitEventWithFlag

```c
aclError aclrtStreamWaitEventWithFlag(aclrtStream stream, aclrtEvent event, uint32_t timeout, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id8 -->
- Ascend 950PR&950DT products: Supported
<!-- end id8 -->
<!-- npu="A3" id9 -->
- Atlas A3 products: Supported
<!-- end id9 -->
<!-- npu="910b" id10 -->
- Atlas A2 products: Supported
<!-- end id10 -->
<!-- npu="310b" id11 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id11 -->
<!-- npu="310p" id12 -->
- Atlas inference products: Not supported
<!-- end id12 -->
<!-- npu="910" id13 -->
- Atlas training products: Not supported
<!-- end id13 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id15 -->

### Function

Blocks the specified stream until the specified event completes. This is an asynchronous API.
This API is an enhancement of [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) and [aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout). It allows you to configure a specific timeout duration and a flag. Different flags serve different purposes.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
|stream|Input| Specified stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>When flag is `ACL_EVENT_WAIT_EXTERNAL`, this parameter can be used only in graph capture (ACL Graph) use cases, and the stream specified by `stream` must be in the capturing state.|
|event|Input| Event to wait on. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent).<br>When `flag` is `ACL_EVENT_WAIT_EXTERNAL`, the event can be created only by calling [aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag), and `flag` must be `ACL_EVENT_SYNC`. Other flags or other APIs for creating events are not supported.|
|timeout|Input| Timeout duration, in milliseconds.<br>When flag is `ACL_EVENT_WAIT_DEFAULT`, the function is equivalent to the [aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout) API, but the `timeout` parameter of this API is of the uint32_t type.<br>When flag is `ACL_EVENT_WAIT_EXTERNAL`, the `timeout` parameter can only be set to 0, which means it never times out.|
|flag|Input| Behavior of the wait action. The value of `flag` is as follows:<br>- When `flag` is `ACL_EVENT_WAIT_DEFAULT`, it is the default flag, applicable to common use cases, and equivalent to [aclrtStreamWaitEventWithTimeout](#aclrtStreamWaitEventWithTimeout).<br>- When `flag` is `ACL_EVENT_WAIT_EXTERNAL`, it is dedicated to graph capture use cases. When you are capturing tasks on a stream into a computation graph, this flag indicates that the wait is for an event outside the graph. It is used to synchronize a graph with an external stream, or a graph with another graph.<br><br>Macro definitions:<br>#define ACL_EVENT_WAIT_DEFAULT 0x00U<br>#define ACL_EVENT_WAIT_EXTERNAL 0x01U<br> |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The constraints of this API are as follows:

- For the same graph, during capture, only one wait operation with the ACL_EVENT_WAIT_EXTERNAL flag or one record operation with the ACL_EVENT_RECORD_EXTERNAL flag can be issued for the same event.
- The flag of a wait operation on the same event cannot switch between ACL_EVENT_WAIT_DEFAULT and ACL_EVENT_WAIT_EXTERNAL. When this API is called for the first time, the association between the event and the wait flag is established at the API entry, and the API return value does not affect the validity of the association.
- Issuing a wait operation with the ACL_EVENT_WAIT_EXTERNAL flag in a subgraph is not supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamWaitEventWithTimeout"></a>

## aclrtStreamWaitEventWithTimeout

```c
aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id2129 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2129 -->
<!-- npu="A3" id2130 -->
- Atlas A3 products: Supported
<!-- end id2130 -->
<!-- npu="910b" id2131 -->
- Atlas A2 products: Supported
<!-- end id2131 -->
<!-- npu="310b" id2132 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2132 -->
<!-- npu="310p" id2133 -->
- Atlas inference products: Supported
<!-- end id2133 -->
<!-- npu="910" id2134 -->
- Atlas training products: Supported
<!-- end id2134 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id16 -->

### Function

Blocks the execution of the specified stream until the specified event completes or the wait times out. Multiple streams can wait on the same event. If the wait times out, an error code is returned.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specified stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>When multiple streams wait synchronously, for example, when Stream2 waits for Stream1, set this parameter to Stream2. |
| event | Input | Event to wait on. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| timeout | Input | Timeout duration.<br>A value greater than or equal to 0 is used to configure the specific timeout duration, in milliseconds. 0 means no timeout. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetOpWaitTimeout"></a>

## aclrtSetOpWaitTimeout

```c
aclError aclrtSetOpWaitTimeout(uint32_t timeout)
```

### Applicable Products

<!-- npu="950" id414 -->
- Ascend 950PR&950DT products: Supported
<!-- end id414 -->
<!-- npu="A3" id415 -->
- Atlas A3 products: Supported
<!-- end id415 -->
<!-- npu="910b" id416 -->
- Atlas A2 products: Supported
<!-- end id416 -->
<!-- npu="310b" id417 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id417 -->
<!-- npu="310p" id418 -->
- Atlas inference products: Not supported
<!-- end id418 -->
<!-- npu="910" id419 -->
- Atlas training products: Supported
<!-- end id419 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id17 -->

### Function

Sets the timeout duration for waiting for an event to complete.

If this API is not called, no timeout is applied by default. If this API is called multiple times in a process, the last setting takes effect.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| timeout | Input | Timeout duration, in seconds.<br>`0` indicates that it never times out. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

In a process, after [aclInit](02_initialization_and_deinitialization.md#aclInit) is called for initialization, if [aclrtSetOpWaitTimeout](#aclrtSetOpWaitTimeout) is called to set the timeout duration, tasks subsequently issued by calling [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) in the process support waiting within the set timeout duration. If the wait time exceeds the set timeout duration, an error is returned after a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) is called.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtEventGetTimestamp"></a>

## aclrtEventGetTimestamp

```c
aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)
```

### Applicable Products

<!-- npu="950" id2409 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2409 -->
<!-- npu="A3" id2410 -->
- Atlas A3 products: Supported
<!-- end id2410 -->
<!-- npu="910b" id2411 -->
- Atlas A2 products: Supported
<!-- end id2411 -->
<!-- npu="310b" id2412 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2412 -->
<!-- npu="310p" id2413 -->
- Atlas inference products: Supported
<!-- end id2413 -->
<!-- npu="910" id2414 -->
- Atlas training products: Supported
<!-- end id2414 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id18 -->

### Function

Obtains the time when an event completed (time elapsed since the AI processor system started).

This API must be used together with other key APIs. The API call order is as follows: Call [aclrtCreateEvent](#aclrtCreateEvent)/[aclrtCreateEventWithFlag](#aclrtCreateEventWithFlag) to create an event --\> Call [aclrtRecordEvent](#aclrtRecordEvent) to record the event in a stream --\> Call [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream) to block the running of the application until all tasks in the specified stream complete --\> Call aclrtEventGetTimestamp to obtain the event completion time

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to query. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| timestamp | Output | Time when the event completed execution, in microseconds. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetEventId"></a>

## aclrtGetEventId

```c
aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)
```

### Applicable Products

<!-- npu="950" id127 -->
- Ascend 950PR&950DT products: Supported
<!-- end id127 -->
<!-- npu="A3" id128 -->
- Atlas A3 products: Supported
<!-- end id128 -->
<!-- npu="910b" id129 -->
- Atlas A2 products: Supported
<!-- end id129 -->
<!-- npu="310b" id130 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id130 -->
<!-- npu="310p" id131 -->
- Atlas inference products: Supported
<!-- end id131 -->
<!-- npu="910" id132 -->
- Atlas training products: Supported
<!-- end id132 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id19 -->

### Function

Obtains the ID of a specified event.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Event to query. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| eventId | Output | Event ID. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetEventAvailNum"></a>

## aclrtGetEventAvailNum

```c
aclError aclrtGetEventAvailNum(uint32_t *eventCount)
```

### Applicable Products

<!-- npu="950" id617 -->
- Ascend 950PR&950DT products: Supported
<!-- end id617 -->
<!-- npu="A3" id618 -->
- Atlas A3 products: Supported
<!-- end id618 -->
<!-- npu="910b" id619 -->
- Atlas A2 products: Supported
<!-- end id619 -->
<!-- npu="310b" id620 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id620 -->
<!-- npu="310p" id621 -->
- Atlas inference products: Supported
<!-- end id621 -->
<!-- npu="910" id622 -->
- Atlas training products: Supported
<!-- end id622 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id20 -->

### Function

Queries the number of available events on the current device.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| eventCount | Output | Number of events. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtIpcGetEventHandle"></a>

## aclrtIpcGetEventHandle

```c
aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)
```

### Applicable Products

<!-- npu="950" id1891 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id1891 -->
<!-- npu="A3" id1892 -->
- Atlas A3 products: Supported
<!-- end id1892 -->
<!-- npu="910b" id1893 -->
- Atlas A2 products: Supported
<!-- end id1893 -->
<!-- npu="310b" id1894 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1894 -->
<!-- npu="310p" id1895 -->
- Atlas inference products: Not supported
<!-- end id1895 -->
<!-- npu="910" id1896 -->
- Atlas training products: Not supported
<!-- end id1896 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id21 -->

### Function

Sets the specified event in the current process as an Inter-Process Communication (IPC) event and returns its handle. The handle is used to synchronize tasks across processes, and supports multiple processes on the same device and across devices.

**This API must be used together with the following other key APIs.** The following uses process A and process B as an example:

1. In process A:
    1. Call [aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag) to create an event with `flag` set to `ACL_EVENT_IPC`.
    2. Call aclrtIpcGetEventHandle to obtain the event handle for inter-process communication.
    3. Call [aclrtRecordEvent](#aclrtRecordEvent) to insert the created event whose flag is `ACL_EVENT_IPC` into the Stream.

2. In process B:
    1. Call [aclrtIpcOpenEventHandle](#aclrtIpcOpenEventHandle) to obtain the information about the event handle in process A, and return the event pointer that can be used by the current process.
    2. Call [aclrtStreamWaitEvent](#aclrtStreamWaitEvent) to block the execution of the specified Stream until the specified event completes.
    3. After the event is used, call [aclrtDestroyEvent](#aclrtDestroyEvent) to destroy the event.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| event | Input | Specified event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent).<br>Only events created by calling [aclrtCreateEventExWithFlag](#aclrtCreateEventExWithFlag) with `flag` set to `ACL_EVENT_IPC` are supported. |
| handle | Output | Event handle used for inter-process communication. For the type definition, see [aclrtIpcEventHandle](25-04_Structs.md#aclrtIpcEventHandle). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtIpcOpenEventHandle"></a>

## aclrtIpcOpenEventHandle

```c
aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)
```

### Applicable Products

<!-- npu="950" id2164 -->
- Ascend 950PR products: Supported
- Ascend 950DT products: Not supported
<!-- end id2164 -->
<!-- npu="A3" id2165 -->
- Atlas A3 products: Supported
<!-- end id2165 -->
<!-- npu="910b" id2166 -->
- Atlas A2 products: Supported
<!-- end id2166 -->
<!-- npu="310b" id2167 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2167 -->
<!-- npu="310p" id2168 -->
- Atlas inference products: Not supported
<!-- end id2168 -->
<!-- npu="910" id2169 -->
- Atlas training products: Not supported
<!-- end id2169 -->
<!-- @ref: runtime/res/docs/zh/api_ref/07_event_management_res.md#id22 -->

### Function

Obtains handle information in the current process and returns the event pointer that can be used in the current process.

This API must be used together with other APIs to synchronize tasks across processes. For details, see  [aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Event handle. For the type definition, see [aclrtIpcEventHandle](25-04_Structs.md#aclrtIpcEventHandle).<br>Call [aclrtIpcGetEventHandle](#aclrtIpcGetEventHandle) to obtain the handle of the specified event first, and then pass it as an input parameter. |
| event | Output | Event pointer. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).
