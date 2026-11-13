# 6. Stream Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-26T13:45:37.433Z pushedAt=2026-10-28T03:34:22.380Z -->

This topic describes the stream management APIs of CANN Runtime, which are used for creating, destroying, synchronizing, and querying streams, as well as configuring the attributes of streams.

- [`aclError aclrtCreateStream(aclrtStream *stream)`](#aclrtCreateStream): Creates a stream.
- [`aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)`](#aclrtCreateStreamWithConfig): Creates a stream in the current process or thread.
- [`aclError aclrtDestroyStream(aclrtStream stream)`](#aclrtDestroyStream): Destroys a stream created via [aclrtCreateStream](#aclrtCreateStream) or [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig). If there are unfinished tasks on the stream, the API waits for the tasks to complete before destroying the stream.
- [`aclError aclrtDestroyStreamForce(aclrtStream stream)`](#aclrtDestroyStreamForce): Destroys a stream created via [aclrtCreateStream](#aclrtCreateStream) or [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig). If there are unfinished tasks on the stream, the API does not wait for the tasks to complete and forcibly destroys the stream.
- [`aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)`](#aclrtSetStreamOverflowSwitch): Enables or disables overflow detection for a specified stream in saturation mode when an upper-level training framework (for example, PyTorch) is connected . After the feature is disabled, whether a task overflows cannot be obtained through the overflow detection operator.
- [`aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)`](#aclrtGetStreamOverflowSwitch): Obtains whether the overflow detection feature is currently enabled for a specified stream.
- [`aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)`](#aclrtSetStreamFailureMode): Specifies the task scheduling mode when multiple tasks are dispatched on a stream, so as to control whether to continue executing the next task after a certain task fails.
- [`aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)`](#aclrtStreamQuery): Queries the execution status of all tasks on a specified stream.
- [`aclError aclrtSynchronizeStream(aclrtStream stream)`](#aclrtSynchronizeStream): Blocks the current thread on the host side until all tasks in the specified stream are completed.
- [`aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)`](#aclrtSynchronizeStreamWithTimeout): Blocks the current thread on the host side until all tasks in the specified stream are completed. This API is an enhancement of [aclrtSynchronizeStream](#aclrtSynchronizeStream) and supports a user-specified timeout, allowing the application to exit on its own after the specified timeout when an exception occurs.
- [`aclError aclrtNonBlockingLaunchBegin(aclrtStream stream, uint64_t flag)`](#aclrtNonBlockingLaunchBegin): Marks the start point of asynchronous task execution on the specified stream. This API is used together with [aclrtNonBlockingLaunchEnd](#aclrtNonBlockingLaunchEnd).
- [`aclError aclrtNonBlockingLaunchEnd(aclrtStream stream, uint64_t flag)`](#aclrtNonBlockingLaunchEnd): Marks the end point of asynchronous task execution on the specified stream. This API is used together with [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin).
- [`aclError aclrtStreamAbort(aclrtStream stream)`](#aclrtStreamAbort): Aborts the task being executed on the specified stream and discards the tasks that have been dispatched but not yet executed on the specified stream. During the execution of this API, newly dispatched tasks on the specified stream no longer take effect.
- [`aclError aclrtStreamGetId(aclrtStream stream, int32_t *streamId)`](#aclrtStreamGetId): Obtains the ID of the specified stream.
- [`aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)`](#aclrtGetStreamAvailableNum): Obtains the number of remaining available streams on the current device.
- [`aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)`](#aclrtSetStreamAttribute): Sets the stream attribute.
- [`aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)`](#aclrtGetStreamAttribute): Obtains the stream attribute value.
- [`aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)`](#aclrtActiveStream): Activates the stream. This is an asynchronous API.
- [`aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)`](#aclrtSwitchStream): Switches between streams based on conditions. This is an asynchronous API.
- [`aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)`](#aclrtRegStreamStateCallback): Registers a stream state callback function. Duplicate registration is not supported.
- [`aclError aclrtStreamStop(aclrtStream stream)`](#aclrtStreamStop): Only stops the task being executed on the specified stream without cleaning up the task.
- [`aclError aclrtPersistentTaskClean(aclrtStream stream)`](#aclrtPersistentTaskClean): Cleans up tasks on a stream of the **ACL\_STREAM\_PERSISTENT** type. It is applicable to scenarios where tasks are re-dispatched without deleting the stream of this type.
- [`aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)`](#aclrtStreamGetPriority): Obtains the priority of the specified stream.
- [`aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)`](#aclrtStreamGetFlags): Obtains the flag set when the stream is created.

<a class="method_anchor" id="aclrtCreateStream"></a>

## aclrtCreateStream

```c
aclError aclrtCreateStream(aclrtStream *stream)
```

### Applicable Products

<!-- npu="950" id2591 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2591 -->
<!-- npu="A3" id2592 -->
- Atlas A3 products: Supported
<!-- end id2592 -->
<!-- npu="910b" id2593 -->
- Atlas A2 products: Supported
<!-- end id2593 -->
<!-- npu="310b" id2594 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2594 -->
<!-- npu="310p" id2595 -->
- Atlas inference products: Supported
<!-- end id2595 -->
<!-- npu="910" id2596 -->
- Atlas training products: Supported
<!-- end id2596 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id1 -->

### Description

Creates a stream.

This API does not support setting the priority of a stream. If the priority is not set, the stream priority defaults to the highest. To set the priority when creating a stream, use [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig).

If the stream creation API is not explicitly called, each context corresponds to a default stream. The default stream is implicitly created by calling [aclrtSetDevice](04_device_management.md#aclrtSetDevice) or [aclrtCreateContext](05_context_management.md#aclrtCreateContext). The priority of the default stream cannot be set and is the highest. The default stream is suitable for simple applications without complex interaction logic. However, its drawback is that in multi-threaded programming, the execution result depends on the thread scheduling order. Explicitly created streams are suitable for large-scale applications with complex interaction logic and help improve the readability and maintainability of the program. **Explicit creation is recommended.**

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Output | Pointer to the stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Different hardware models support different maximum numbers of streams. If multiple streams (including the default stream) already exist, only *N* streams can be explicitly created, where *N* = maximum number of streams - number of existing streams. For example, if the maximum number of streams is 1024 and two streams already exist, only 1022 streams can be explicitly created by calling this API.

<!-- npu="950,A3,910b" id1 -->
- For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, the maximum number of streams is 1984.
<!-- end id1 -->
<!-- npu="310b" id2 -->
- For Atlas 200I/500 A2 inference products, the maximum number of streams is 512.
<!-- end id2 -->
<!-- npu="310p" id3 -->
- For Atlas inference products, the maximum number of streams is 1024.
<!-- end id3 -->
<!-- npu="910" id4 -->
- For Atlas training products, the maximum number of streams is 2048.

    In a multi-process scenario, if the total number of streams created at one time approaches 2048, stream creation may fail. In this case, it is recommended to: (1) clean up redundant streams to reduce unnecessary streams; (2) adjust the code logic to create streams in batches, for example, create some streams in the first batch, then create more streams in the second batch, and so on, until the total number of streams approaches 2048.
<!-- end id4 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id23 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateStreamWithConfig"></a>

## aclrtCreateStreamWithConfig

```c
aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id3137 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3137 -->
<!-- npu="A3" id3138 -->
- Atlas A3 products: Supported
<!-- end id3138 -->
<!-- npu="910b" id3139 -->
- Atlas A2 products: Supported
<!-- end id3139 -->
<!-- npu="310b" id3140 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3140 -->
<!-- npu="310p" id3141 -->
- Atlas inference products: Supported
<!-- end id3141 -->
<!-- npu="910" id3142 -->
- Atlas training products: Supported
<!-- end id3142 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id2 -->

### Description

Creates a stream in the current process or thread.

Compared with [aclrtCreateStream](#aclrtCreateStream), this API can create a stream that dispatches tasks quickly, but it increases memory consumption or CPU performance consumption.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Output | Pointer to the stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| priority | Input | Priority. |
| flag | Input | Flag of the stream pointer.<br>**flag** supports configuring a single macro as well as configuring multiple macros with bitwise OR. For macros that do not support bitwise OR, this API returns an error. A stream created with other values is equivalent to a stream created through the **aclrtCreateStream** API.<br>For details about the **flag** parameter values, see the flag value description. |

### flag Value Description

- **ACL\_STREAM\_FAST\_LAUNCH**: For a stream created with this flag, tasks are dispatched faster when the stream is used.

    Compared with a stream created via the [aclrtCreateStream](#aclrtCreateStream) API, which applies for internal system resources only when the stream is used and therefore increases the task dispatch duration, a stream created in **ACL\_STREAM\_FAST\_LAUNCH** mode via this API pre-applies internal system resources when the stream is created. As a result, the stream creation duration increases while the task dispatch duration decreases. Overall, in scenarios where a stream is created once and used multiple times, the total duration is shortened, but pre-applying internal resources during stream creation increases memory consumption.

    Macro definition: `#define ACL_STREAM_FAST_LAUNCH 0x00000001U`

- **ACL\_STREAM\_FAST\_SYNC**: For a stream created with this flag, when the [aclrtSynchronizeStream](#aclrtSynchronizeStream) API is called, the current thread is blocked and actively queries the task execution status, returning immediately once the task is completed.

    Compared with a stream created via the [aclrtCreateStream](#aclrtCreateStream) API, which passively waits for the notification of task execution completion on the device when the [aclrtSynchronizeStream](#aclrtSynchronizeStream) API is called and therefore has a long waiting time, a stream created in **ACL\_STREAM\_FAST\_SYNC** mode via this API has no passive waiting, so the total duration is shortened, but the active query operation increases CPU performance consumption.

    Macro definition: `#define ACL_STREAM_FAST_SYNC 0x00000002U`

- **ACL\_STREAM\_PERSISTENT**: For a stream created with this flag, tasks dispatched on the stream are not executed immediately, and task-related resources are not destroyed immediately after task execution completes; they are destroyed only when the stream is destroyed. A stream created in this mode is used to bind with a model and is suitable for model construction scenarios. For details about model construction APIs, see [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream).

    Macro definition: `#define ACL_STREAM_PERSISTENT 0x00000004U`

- **ACL\_STREAM\_HUGE**: Compared with other flags, a stream created with this flag can accommodate a larger maximum number of Tasks.

    <!-- npu="950,A3,910b,910,310p,310b" id5 -->
    In the current version, setting this flag does not take effect.
    <!-- end id5 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id24 -->

    Macro definition: `#define ACL_STREAM_HUGE 0x00000008U`

- **ACL\_STREAM\_CPU\_SCHEDULE**: The stream created with this flag is used to carry AI CPU scheduling-related tasks in queue-based model inference scenarios. This is a reserved feature.

    Macro definition: `#define ACL_STREAM_CPU_SCHEDULE 0x00000010U`

    <!-- npu="950,A3,910b,310p" id6 -->
- **ACL\_STREAM\_DEVICE\_USE\_ONLY**: The stream created with this flag is invoked only on the device.

    Macro definition: `#define ACL_STREAM_DEVICE_USE_ONLY 0x00000020U`

    Only the following models support **ACL\_STREAM\_DEVICE\_USE\_ONLY**:

    <!-- npu="950" id7 -->
    Ascend 950PR&950DT products
    <!-- end id7 -->

    <!-- npu="A3" id8 -->
    Atlas A3 products
    <!-- end id8 -->

    <!-- npu="910b" id9 -->
    Atlas A2 products
    <!-- end id9 -->

    <!-- npu="310p" id10 -->
    Atlas inference products
    <!-- end id10 -->
    <!-- end id6 -->

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyStream"></a>

## aclrtDestroyStream

```c
aclError aclrtDestroyStream(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3347 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3347 -->
<!-- npu="A3" id3348 -->
- Atlas A3 products: Supported
<!-- end id3348 -->
<!-- npu="910b" id3349 -->
- Atlas A2 products: Supported
<!-- end id3349 -->
<!-- npu="310b" id3350 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3350 -->
<!-- npu="310p" id3351 -->
- Atlas inference products: Supported
<!-- end id3351 -->
<!-- npu="910" id3352 -->
- Atlas training products: Supported
<!-- end id3352 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id3 -->

### Description

Destroys a stream. If there are unfinished tasks on the stream, the API waits for the tasks to complete before destroying the stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to be destroyed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Before calling **aclrtDestroyStream** to destroy a specified stream, call [aclrtSynchronizeStream](#aclrtSynchronizeStream) to ensure that all tasks on the stream are completed.
- When calling **aclrtDestroyStream** to destroy a specified stream, ensure that the stream is in the current context.
- When calling **aclrtDestroyStream** to destroy a specified stream, ensure that no other API is using the stream.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyStreamForce"></a>

## aclrtDestroyStreamForce

```c
aclError aclrtDestroyStreamForce(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3522 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3522 -->
<!-- npu="A3" id3523 -->
- Atlas A3 products: Supported
<!-- end id3523 -->
<!-- npu="910b" id3524 -->
- Atlas A2 products: Supported
<!-- end id3524 -->
<!-- npu="310b" id3525 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3525 -->
<!-- npu="310p" id3526 -->
- Atlas inference products: Supported
<!-- end id3526 -->
<!-- npu="910" id3527 -->
- Atlas training products: Supported
<!-- end id3527 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id4 -->

### Description

Destroys a stream created via [aclrtCreateStream](#aclrtCreateStream) or [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig). If there are unfinished tasks on the stream, the API does not wait for the tasks to complete and forcibly destroys the stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to be destroyed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

When calling this API to destroy a specified stream, ensure that the stream is in the current context.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetStreamOverflowSwitch"></a>

## aclrtSetStreamOverflowSwitch

```c
aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id2227 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2227 -->
<!-- npu="A3" id2228 -->
- Atlas A3 products: Supported
<!-- end id2228 -->
<!-- npu="910b" id2229 -->
- Atlas A2 products: Supported
<!-- end id2229 -->
<!-- npu="310b" id2230 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2230 -->
<!-- npu="310p" id2231 -->
- Atlas inference products: Not supported
<!-- end id2231 -->
<!-- npu="910" id2232 -->
- Atlas training products: Not supported
<!-- end id2232 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id5 -->

### Description

Enables or disables overflow detection for a specified stream when an upper-level training framework (for example, PyTorch) is connected. After the feature is disabled, whether a task overflows cannot be obtained through the overflow detection operator.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to be operated. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| flag | Input | Overflow detection feature. The value range is as follows: <br><br>  - **0**: disable<br>  - **1**: enable |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- After this API is called to enable or disable the overflow detection feature, the setting takes effect only on subsequently dispatched tasks; tasks that have already been dispatched remain unchanged.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetStreamOverflowSwitch"></a>

## aclrtGetStreamOverflowSwitch

```c
aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)
```

### Applicable Products

<!-- npu="950" id309 -->
- Ascend 950PR&950DT products: Supported
<!-- end id309 -->
<!-- npu="A3" id310 -->
- Atlas A3 products: Supported
<!-- end id310 -->
<!-- npu="910b" id311 -->
- Atlas A2 products: Supported
<!-- end id311 -->
<!-- npu="310b" id312 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id312 -->
<!-- npu="310p" id313 -->
- Atlas inference products: Not supported
<!-- end id313 -->
<!-- npu="910" id314 -->
- Atlas training products: Not supported
<!-- end id314 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id6 -->

### Description

Obtains whether the overflow detection feature is enabled for a specified stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to be operated on. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| flag | Output | Overflow detection feature. The value range is as follows:<br><br>  - **0**: disabled<br>  - **1**: enabled |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetStreamFailureMode"></a>

## aclrtSetStreamFailureMode

```c
aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)
```

### Applicable Products

<!-- npu="950" id1107 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1107 -->
<!-- npu="A3" id1108 -->
- Atlas A3 products: Supported
<!-- end id1108 -->
<!-- npu="910b" id1109 -->
- Atlas A2 products: Supported
<!-- end id1109 -->
<!-- npu="310b" id1110 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1110 -->
<!-- npu="310p" id1111 -->
- Atlas inference products: Supported
<!-- end id1111 -->
<!-- npu="910" id1112 -->
- Atlas training products: Supported
<!-- end id1112 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id7 -->

### Description

Specify the task scheduling mode when multiple tasks are dispatched on a stream, so as to control whether to continue executing the next task after a certain task fails.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to be operated. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| mode | Input | Task scheduling mode specified when multiple tasks are dispatched on a stream, so as to control whether to continue executing the next task after a certain task fails.<br>The value range is as follows:<br><br>  - **ACL_CONTINUE_ON_FAILURE**: After a task fails, continue executing the next task. This is the default value.<br>  - **ACL_STOP_ON_FAILURE**: After a task fails, stop executing subsequent tasks, which is usually called stop-on-error. After stop-on-error is triggered, dispatching new tasks is no longer supported. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API can be called only once for a specified stream to set the task scheduling mode.
<!-- npu="950,A3,910b,910,310p,310b" id13 -->
- When the stop-on-error mode is set on a stream, other streams in the context where the stream resides are also in stop-on-error mode.
<!-- end id13 -->
<!-- npu="950,A3,910b" id11 -->
- For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, specifying the default stream (that is, passing **NULL** to the stream parameter) is supported.
<!-- end id11 -->
<!-- npu="910,310p,310b" id12 -->
- For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, specifying the default stream (that is, passing **NULL** to the stream parameter) is not supported.
<!-- end id12 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id25 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamQuery"></a>

## aclrtStreamQuery

```c
aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)
```

### Applicable Products

<!-- npu="950" id1310 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1310 -->
<!-- npu="A3" id1311 -->
- Atlas A3 products: Supported
<!-- end id1311 -->
<!-- npu="910b" id1312 -->
- Atlas A2 products: Supported
<!-- end id1312 -->
<!-- npu="310b" id1313 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1313 -->
<!-- npu="310p" id1314 -->
- Atlas inference products: Supported
<!-- end id1314 -->
<!-- npu="910" id1315 -->
- Atlas training products: Supported
<!-- end id1315 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id8 -->

### Description

Queries the execution status of all tasks on a specified stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Pointer to the stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| status | Output | Task status on the stream. For details about the type definition, see [aclrtStreamStatus](25-02_Enumerations.md#aclrtStreamStatus). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

For a stream created in the following manner, the status found through this API has no actual service semantics: call **aclrtCreateStreamWithConfig** and set **flag** to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_DEVICE_USE_ONLY**, or **ACL_STREAM_CPU_SCHEDULE**.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSynchronizeStream"></a>

## aclrtSynchronizeStream

```c
aclError aclrtSynchronizeStream(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2612 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2612 -->
<!-- npu="A3" id2613 -->
- Atlas A3 products: Supported
<!-- end id2613 -->
<!-- npu="910b" id2614 -->
- Atlas A2 products: Supported
<!-- end id2614 -->
<!-- npu="310b" id2615 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2615 -->
<!-- npu="310p" id2616 -->
- Atlas inference products: Supported
<!-- end id2616 -->
<!-- npu="910" id2617 -->
- Atlas training products: Supported
<!-- end id2617 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id9 -->

### Description

Blocks the current thread on the host side until all tasks in the specified stream are completed.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream on which all tasks need to be completed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

A stream created in the following manner does not trigger any service processing logic, and the API returns success directly: call **aclrtCreateStreamWithConfig** and set **flag** to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_DEVICE_USE_ONLY**, or **ACL_STREAM_CPU_SCHEDULE**.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSynchronizeStreamWithTimeout"></a>

## aclrtSynchronizeStreamWithTimeout

```c
aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id1982 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1982 -->
<!-- npu="A3" id1983 -->
- Atlas A3 products: Supported
<!-- end id1983 -->
<!-- npu="910b" id1984 -->
- Atlas A2 products: Supported
<!-- end id1984 -->
<!-- npu="310b" id1985 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1985 -->
<!-- npu="310p" id1986 -->
- Atlas inference products: Supported
<!-- end id1986 -->
<!-- npu="910" id1987 -->
- Atlas training products: Supported
<!-- end id1987 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id10 -->

### Description

Blocks the current thread on the host side until all tasks in the specified stream are completed. This API is enhanced based on [aclrtSynchronizeStream](#aclrtSynchronizeStream) and supports a user-specified timeout, allowing the application to exit on its own according to the configured timeout when an exception occurs.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream on which all tasks need to be completed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| timeout | Input | Timeout of the API.<br>The value options are as follows:<br><br>  - **-1**: permanent waiting, which is the same as the [aclrtSynchronizeStream](#aclrtSynchronizeStream) API.<br>  - **>0**: specific timeout, in milliseconds. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

A stream created in the following manner does not trigger any service processing logic, and the API returns success directly: call **aclrtCreateStreamWithConfig** and set **flag** to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_DEVICE_USE_ONLY**, or **ACL_STREAM_CPU_SCHEDULE**.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtNonBlockingLaunchBegin"></a>

## aclrtNonBlockingLaunchBegin

```c
aclError aclrtNonBlockingLaunchBegin(aclrtStream stream, uint64_t flag)
```

### Applicable Products

<!-- npu="950" id3600 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3600 -->
<!-- npu="A3" id3601 -->
- Atlas A3 products: Supported
<!-- end id3601 -->
<!-- npu="910b" id3602 -->
- Atlas A2 products: Supported
<!-- end id3602 -->
<!-- npu="310b" id3603 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3603 -->
<!-- npu="310p" id3604 -->
- Atlas inference products: Not supported
<!-- end id3604 -->
<!-- npu="910" id3605 -->
- Atlas training products: Not supported
<!-- end id3605 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id29 -->

### Description

Marks the start point of asynchronous task execution on the specified stream. When the `ASCEND_RT_LAUNCH_BLOCKING` environment variable is set to **1**, or when the specified stream is set to synchronous mode through the [aclrtSetStreamAttribute](#aclrtSetStreamAttribute) API, the related APIs on the specified stream adopt synchronous mode. In a single-thread task dispatching scenario, if a previously dispatched task depends on a subsequent task that has not yet been dispatched, synchronous waiting prevents the subsequent task from being dispatched, resulting in a deadlock. In this case, you can call this API and the [aclrtNonBlockingLaunchEnd](#aclrtNonBlockingLaunchEnd) API to mark the start point and end point on the specified stream, respectively. Tasks dispatched through the following APIs between the start point and the end point remain in asynchronous mode:

- aclrtLaunchKernel
- aclrtLaunchKernelV2
- aclrtLaunchKernelWithConfig
- aclrtLaunchKernelWithHostArgs
- aclrtLaunchKernelWithArgsArray
- aclrtLaunchSIMTKernelWithArgsArray
- aclrtLaunchSIMTKernelWithHostArgs
- aclmdlRIExecuteAsync

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. When **NULL** is passed, the default stream of the current context is used. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| flag | Input | Reserved parameter, which is currently fixed to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) API is not supported for binding the stream of a model running instance.
- The stream specified by the **stream** parameter must not be in the capture state.
- The [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig) API is not supported for creating a stream with **flag** set to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_CPU_SCHEDULE**, or **ACL_STREAM_DEVICE_USE_ONLY**.
- This API takes effect only on the APIs mentioned above.
- The asynchronous mode set by this API takes precedence over the `ASCEND_RT_LAUNCH_BLOCKING` environment variable and the `ACL_STREAM_LAUNCH_BLOCKING_MODE` attribute set through the [aclrtSetStreamAttribute](#aclrtSetStreamAttribute) API.
- This API and the [aclrtNonBlockingLaunchEnd](#aclrtNonBlockingLaunchEnd) API must be used in pairs, and the stream in the two APIs must be the same.
- It is recommended to call this API and the [aclrtNonBlockingLaunchEnd](#aclrtNonBlockingLaunchEnd) API in pairs in the same thread.
- Nested calls are supported. Each call to this API must be paired with a corresponding call to the [aclrtNonBlockingLaunchEnd](#aclrtNonBlockingLaunchEnd) API. The following is an example of two-level nested calls:

    ```c
    aclrtNonBlockingLaunchBegin(stream, 0); // Start of the outer layer.
    aclrtNonBlockingLaunchBegin(stream, 0); // Start of the inner layer.
    aclrtNonBlockingLaunchEnd(stream, 0);   // End of the inner layer.
    aclrtNonBlockingLaunchEnd(stream, 0);   // End of the outer layer.
    ```

<br>
<br>
<br>

<a class="method_anchor" id="aclrtNonBlockingLaunchEnd"></a>

## aclrtNonBlockingLaunchEnd

```c
aclError aclrtNonBlockingLaunchEnd(aclrtStream stream, uint64_t flag)
```

### Applicable Products

<!-- npu="950" id3607 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3607 -->
<!-- npu="A3" id3608 -->
- Atlas A3 products: Supported
<!-- end id3608 -->
<!-- npu="910b" id3609 -->
- Atlas A2 products: Supported
<!-- end id3609 -->
<!-- npu="310b" id3610 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3610 -->
<!-- npu="310p" id3611 -->
- Atlas inference products: Not supported
<!-- end id3611 -->
<!-- npu="910" id3612 -->
- Atlas training products: Not supported
<!-- end id3612 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id30 -->

### Description

Marks the end point of asynchronous task execution on the specified stream. When the `ASCEND_RT_LAUNCH_BLOCKING` environment variable is set to **1**, or when the specified stream is set to synchronous mode through the [aclrtSetStreamAttribute](#aclrtSetStreamAttribute) API, the related APIs on the specified stream adopt synchronous mode. In a single-thread task dispatching scenario, if a previously dispatched task depends on a subsequent task that has not yet been dispatched, synchronous waiting prevents the subsequent task from being dispatched, resulting in a deadlock. In this case, you can call the [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin) API and this API to mark the start point and end point on the specified stream, respectively. Tasks dispatched through the following APIs between the start point and the end point remain in asynchronous mode:

- aclrtLaunchKernel
- aclrtLaunchKernelV2
- aclrtLaunchKernelWithConfig
- aclrtLaunchKernelWithHostArgs
- aclrtLaunchKernelWithArgsArray
- aclrtLaunchSIMTKernelWithArgsArray
- aclrtLaunchSIMTKernelWithHostArgs
- aclmdlRIExecuteAsync

After this API is called, if there is no longer any unfinished [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin) API call and the current stream needs to be synchronized, this API waits until the tasks already dispatched on the specified stream before the call are completed before returning. If there is still an unfinished [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin) API call, the related APIs on the specified stream continue to use the asynchronous mode and do not perform synchronous waiting.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. When **NULL** is passed in, the default stream of the current context is used. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| flag | Input | Reserved parameter, which is currently fixed to **0**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) API is not supported for binding the stream of a model running instance.
- The stream specified by the **stream** parameter must be a stream that is not in the capture state.
- The [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig) API is not supported for creating a stream with **flag** set to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_CPU_SCHEDULE**, or **ACL_STREAM_DEVICE_USE_ONLY**.
- This API takes effect only on the APIs mentioned above.
- The [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin) API and this API must be used in pairs, and the stream in the two APIs must be the same. If the [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin) API is not called first, this API returns a failure.
- It is recommended to call the [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin) API and this API in pairs in the same thread.
- Nested calls are supported. Synchronous waiting may be performed only when all [aclrtNonBlockingLaunchBegin](#aclrtNonBlockingLaunchBegin) API calls have ended.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamAbort"></a>

## aclrtStreamAbort

```c
aclError aclrtStreamAbort(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id946 -->
- Ascend 950PR&950DT products: Supported
<!-- end id946 -->
<!-- npu="A3" id947 -->
- Atlas A3 products: Supported
<!-- end id947 -->
<!-- npu="910b" id948 -->
- Atlas A2 products: Supported
<!-- end id948 -->
<!-- npu="310b" id949 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id949 -->
<!-- npu="310p" id950 -->
- Atlas inference products: Not supported
<!-- end id950 -->
<!-- npu="910" id951 -->
- Atlas training products: Not supported
<!-- end id951 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id11 -->

### Description

Aborts the task being executed on the specified stream and discards the tasks that have been dispatched but not yet executed on the specified stream. During the execution of this API, newly dispatched tasks on the specified stream no longer take effect.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream on which tasks are to be stopped. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The stream bound to a model running instance by using [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) is not supported.
- If other streams depend on the stream specified in this API (for example, synchronization waiting between two Streams is implemented by using [aclrtRecordEvent](07_event_management.md#aclrtRecordEvent), [aclrtStreamWaitEvent](07_event_management.md#aclrtStreamWaitEvent), and other APIs), the execution of the other streams may be stuck. In this case, you need to explicitly call this API to clear the tasks on the other streams.
- If a synchronization waiting API (for example, [aclrtSynchronizeStream](#aclrtSynchronizeStream), [aclrtSynchronizeEvent](07_event_management.md#aclrtSynchronizeEvent), and others) is called while this API is clearing the tasks on the specified stream, the synchronization waiting API exits and returns the error **ACL\_ERROR\_RT\_STREAM\_ABORT**.
<!-- npu="950" id14 -->
- For Ascend 950PR&950DT products, streams created in the following manner are not supported: calling **aclrtCreateStreamWithConfig** with **flag** set to **ACL_STREAM_PERSISTENT**.
<!-- end id14 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id26 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamGetId"></a>

## aclrtStreamGetId

```c
aclError aclrtStreamGetId(aclrtStream stream, int32_t *streamId)
```

### Applicable Products

<!-- npu="950" id1933 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1933 -->
<!-- npu="A3" id1934 -->
- Atlas A3 products: Supported
<!-- end id1934 -->
<!-- npu="910b" id1935 -->
- Atlas A2 products: Supported
<!-- end id1935 -->
<!-- npu="310b" id1936 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1936 -->
<!-- npu="310p" id1937 -->
- Atlas inference products: Supported
<!-- end id1937 -->
<!-- npu="910" id1938 -->
- Atlas training products: Supported
<!-- end id1938 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id12 -->

### Description

Obtains the ID of a specified stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream to be queried. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>If **NULL** is passed in, the ID of the default stream is obtained. |
| streamId | Output | Stream ID. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetStreamAvailableNum"></a>

## aclrtGetStreamAvailableNum

```c
aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)
```

### Applicable Products

<!-- npu="950" id960 -->
- Ascend 950PR&950DT products: Supported
<!-- end id960 -->
<!-- npu="A3" id961 -->
- Atlas A3 products: Supported
<!-- end id961 -->
<!-- npu="910b" id962 -->
- Atlas A2 products: Supported
<!-- end id962 -->
<!-- npu="310b" id963 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id963 -->
<!-- npu="310p" id964 -->
- Atlas inference products: Supported
<!-- end id964 -->
<!-- npu="910" id965 -->
- Atlas training products: Supported
<!-- end id965 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id13 -->

### Description

Obtains the number of remaining available streams on the current device.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| streamCount | Output | Number of streams. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetStreamAttribute"></a>

## aclrtSetStreamAttribute

```c
aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

### Applicable Products

<!-- npu="950" id1065 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1065 -->
<!-- npu="A3" id1066 -->
- Atlas A3 products: Supported
<!-- end id1066 -->
<!-- npu="910b" id1067 -->
- Atlas A2 products: Supported
<!-- end id1067 -->
<!-- npu="310b" id1068 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1068 -->
<!-- npu="310p" id1069 -->
- Atlas inference products: Supported
<!-- end id1069 -->
<!-- npu="910" id1070 -->
- Atlas training products: Supported
<!-- end id1070 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id14 -->

### Description

Sets the stream attribute.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| stmAttrType | Input | Attribute type. For details about the type definition, see [aclrtStreamAttr](25-02_Enumerations.md#aclrtStreamAttr). |
| value | Input | Attribute value. For details about the type definition, see [aclrtStreamAttrValue](25-04_Structs.md#aclrtStreamAttrValue). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Overflow detection attribute: After this API is called to enable or disable the overflow detection feature, it takes effect only on subsequently dispatched tasks; already dispatched tasks remain unchanged.
<!-- npu="950,A3,910b" id3618 -->
- `ACL_STREAM_LAUNCH_BLOCKING_MODE` attribute: Only Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products support setting this attribute. Setting this attribute is not supported for a stream bound to a model running instance through the [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) API. Setting this attribute is not supported for a Stream created by calling the [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig) API with **flag** set to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_CPU_SCHEDULE**, or **ACL_STREAM_DEVICE_USE_ONLY**. When setting this attribute, the stream specified by the **stream** parameter must not be in the capture state.
<!-- end id3618 -->
<!-- npu="950,A3,910b,910,310p,310b" id15 -->
- When the stop-on-error mode is set on a stream, the other streams in the context to which this stream belongs are also in stop-on-error mode.
<!-- end id15 -->
<!-- npu="950,A3,910b" id16 -->
- For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, specifying the default stream (that is, passing **NULL** to the **stream** parameter) is supported. Setting **Failure Mode** for the default stream is not supported.
<!-- end id16 -->
<!-- npu="910,310p,310b" id17 -->
- For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, specifying the default stream (that is, passing **NULL** to the **stream** parameter) is not supported.
<!-- end id17 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id27 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetStreamAttribute"></a>

## aclrtGetStreamAttribute

```c
aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

### Applicable Products

<!-- npu="950" id2976 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2976 -->
<!-- npu="A3" id2977 -->
- Atlas A3 products: Supported
<!-- end id2977 -->
<!-- npu="910b" id2978 -->
- Atlas A2 products: Supported
<!-- end id2978 -->
<!-- npu="310b" id2979 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2979 -->
<!-- npu="310p" id2980 -->
- Atlas inference products: Supported
<!-- end id2980 -->
<!-- npu="910" id2981 -->
- Atlas training products: Supported
<!-- end id2981 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id15 -->

### Description

Obtains the stream attribute value.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| stmAttrType | Input | Attribute type. For details about the type definition, see [aclrtStreamAttr](25-02_Enumerations.md#aclrtStreamAttr). |
| value | Output | Attribute value. For details about the type definition, see [aclrtStreamAttrValue](25-04_Structs.md#aclrtStreamAttrValue). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950,A3,910b,910,310p,310b" id18 -->
### Constraints

<!-- npu="950,A3,910b" id19 -->
For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, specifying the default stream (that is, passing **NULL** to the **stream** parameter) is supported.
<!-- end id19 -->

<!-- npu="910,310p,310b" id20 -->
For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, specifying the default stream (that is, passing **NULL** to the **stream** parameter) is not supported.
<!-- end id20 -->
<!-- npu="950,A3,910b" id3619 -->
- `ACL_STREAM_LAUNCH_BLOCKING_MODE` attribute: Only Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products support obtaining this attribute value. Obtaining this attribute value is not supported for a stream bound to a model running instance using the [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) API. Obtaining this attribute value is not supported for a stream created by calling the [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig) API with **flag** set to **ACL_STREAM_PERSISTENT**, **ACL_STREAM_CPU_SCHEDULE**, or **ACL_STREAM_DEVICE_USE_ONLY**. When this attribute value is obtained, the stream specified by the **stream** parameter must not be in the capture state.
<!-- end id3619 -->
<!-- end id18 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id28 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtActiveStream"></a>

## aclrtActiveStream

```c
aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id337 -->
- Ascend 950PR&950DT products: Supported
<!-- end id337 -->
<!-- npu="A3" id338 -->
- Atlas A3 products: Not supported
<!-- end id338 -->
<!-- npu="910b" id339 -->
- Atlas A2 products: Supported
<!-- end id339 -->
<!-- npu="310b" id340 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id340 -->
<!-- npu="310p" id341 -->
- Atlas inference products: Supported
<!-- end id341 -->
<!-- npu="910" id342 -->
- Atlas training products: Supported
<!-- end id342 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id16 -->

### Description

Activates a stream. This is an asynchronous API.

Tasks on the activated stream are executed in parallel with tasks on the current stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| activeStream | Input | Stream to be activated. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>Only streams bound to a model are supported here. To bind a model to a stream, call the [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) API. |
| stream | Input | Stream on which the activation task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>Only streams bound to a model are supported here. To bind a model to a stream, call the [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) API. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSwitchStream"></a>

## aclrtSwitchStream

```c
aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2213 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2213 -->
<!-- npu="A3" id2214 -->
- Atlas A3 products: Not supported
<!-- end id2214 -->
<!-- npu="910b" id2215 -->
- Atlas A2 products: Supported
<!-- end id2215 -->
<!-- npu="310b" id2216 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2216 -->
<!-- npu="310p" id2217 -->
- Atlas inference products: Supported
<!-- end id2217 -->
<!-- npu="910" id2218 -->
- Atlas training products: Supported
<!-- end id2218 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id17 -->

### Description

Switches between streams based on conditions. This is an asynchronous API.

After a successful switch, only the tasks on the target stream are executed, and the tasks on the current stream stop executing.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| leftValue | Input | Device memory address of the left-value data. |
| cond | Input | Comparison condition between the left-value data and the right-value data. For details about the type definition, see [aclrtCondition](25-02_Enumerations.md#aclrtCondition). |
| rightValue | Input | Device memory address of the right-value data. |
| dataType | Input | Data type of the left-value data and the right-value data. For details about the type definition, see [aclrtCompareDataType](25-02_Enumerations.md#aclrtCompareDataType). |
| trueStream | Input | Based on the condition specified by **cond**, the tasks on **trueStream** are executed when the condition is met. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| falseStream | Input | Reserved parameter, currently fixed to **NULL**.<br>For the value description, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| stream | Input | Stream on which the switching task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtRegStreamStateCallback"></a>

## aclrtRegStreamStateCallback

```c
aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)
```

### Applicable Products

<!-- npu="950" id1919 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1919 -->
<!-- npu="A3" id1920 -->
- Atlas A3 products: Supported
<!-- end id1920 -->
<!-- npu="910b" id1921 -->
- Atlas A2 products: Supported
<!-- end id1921 -->
<!-- npu="310b" id1922 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1922 -->
<!-- npu="310p" id1923 -->
- Atlas inference products: Supported
<!-- end id1923 -->
<!-- npu="910" id1924 -->
- Atlas training products: Supported
<!-- end id1924 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id18 -->

### Description

Registers a stream state callback function. Duplicate registration is not supported.

When the stream state changes (for example, when APIs such as [aclrtCreateStream](#aclrtCreateStream) and [aclrtDestroyStream](#aclrtDestroyStream) are called), the Runtime module triggers the invocation of this callback function. The streams here include explicitly created streams as well as the default stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| regName | Input | Unique registration name, which cannot be empty. The input string is guaranteed to end with **\0**. |
| callback | Input | Callback function. If **callback** is not NULL, the callback function is registered; if it is NULL, the callback function is unregistered. |
| args | Input | Pointer to the user data to be passed to the callback function. |

<br>
The prototype of the callback function is as follows:

```c
typedef enum {
    ACL_RT_STREAM_STATE_CREATE_POST = 1,  // After the create API (for example, aclrtCreateStream) is called
    ACL_RT_STREAM_STATE_DESTROY_PRE,  // Before the destroy API (for example, aclrtDestroyStream) is called
} aclrtStreamState;
typedef void (*aclrtStreamStateCallback)(aclrtStream stm, aclrtStreamState state, void *args);
```

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamStop"></a>

## aclrtStreamStop

```c
aclError aclrtStreamStop(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2500 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2500 -->
<!-- npu="A3" id2501 -->
- Atlas A3 products: Supported
<!-- end id2501 -->
<!-- npu="910b" id2502 -->
- Atlas A2 products: Supported
<!-- end id2502 -->
<!-- npu="310b" id2503 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2503 -->
<!-- npu="310p" id2504 -->
- Atlas inference products: Not supported
<!-- end id2504 -->
<!-- npu="910" id2505 -->
- Atlas training products: Not supported
<!-- end id2505 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id19 -->

### Description

Only stops the task currently being executed on the specified stream, without clearing the task.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream whose task is to be stopped. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The stream bound to a model running instance via [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) is not supported.
- The default stream (that is, when **NULL** is passed to the **stream** parameter) is not supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtPersistentTaskClean"></a>

## aclrtPersistentTaskClean

```c
aclError aclrtPersistentTaskClean(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id428 -->
- Ascend 950PR&950DT products: Supported
<!-- end id428 -->
<!-- npu="A3" id429 -->
- Atlas A3 products: Supported
<!-- end id429 -->
<!-- npu="910b" id430 -->
- Atlas A2 products: Supported
<!-- end id430 -->
<!-- npu="310b" id431 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id431 -->
<!-- npu="310p" id432 -->
- Atlas inference products: Not supported
<!-- end id432 -->
<!-- npu="910" id433 -->
- Atlas training products: Not supported
<!-- end id433 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id20 -->

### Description

Cleans tasks on a stream of the **ACL\_STREAM\_PERSISTENT** type, applicable to scenarios where tasks are re-dispatched without deleting the stream of that type.

A stream of the **ACL\_STREAM\_PERSISTENT** type must be created by calling the [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamGetPriority"></a>

## aclrtStreamGetPriority

```c
aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)
```

### Applicable Products

<!-- npu="950" id3088 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3088 -->
<!-- npu="A3" id3089 -->
- Atlas A3 products: Supported
<!-- end id3089 -->
<!-- npu="910b" id3090 -->
- Atlas A2 products: Supported
<!-- end id3090 -->
<!-- npu="310b" id3091 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3091 -->
<!-- npu="310p" id3092 -->
- Atlas inference products: Supported
<!-- end id3092 -->
<!-- npu="910" id3093 -->
- Atlas training products: Supported
<!-- end id3093 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id21 -->

### Description

Obtains the priority of a specified stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>If **NULL** is passed in, the priority of the default stream is obtained. |
| priority | Output | Priority. The smaller the number, the higher the priority.<br>For details about the value range of the priority, see the description of the **priority** parameter in [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtStreamGetFlags"></a>

## aclrtStreamGetFlags

```c
aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)
```

### Applicable Products

<!-- npu="950" id1562 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1562 -->
<!-- npu="A3" id1563 -->
- Atlas A3 products: Supported
<!-- end id1563 -->
<!-- npu="910b" id1564 -->
- Atlas A2 products: Supported
<!-- end id1564 -->
<!-- npu="310b" id1565 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1565 -->
<!-- npu="310p" id1566 -->
- Atlas inference products: Supported
<!-- end id1566 -->
<!-- npu="910" id1567 -->
- Atlas training products: Supported
<!-- end id1567 -->
<!-- @ref: runtime/res/docs/zh/api_ref/06_stream_management_res.md#id22 -->

### Description

Obtains the flag set when the stream is created.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>If **NULL** is passed in, the flag of the default stream is obtained. |
| flags | Output | Pointer to the found flag value.<br>For details about the flag value, see the description of the **flag** parameter in [aclrtCreateStreamWithConfig](#aclrtCreateStreamWithConfig). If multiple flags are configured when the stream is created, the returned value is the result of the bitwise OR operation on each flag. For example, if **0x01U** and **0x02U** are configured, **0x03U** is returned. If no flag is configured when the stream is created, **0** is returned.<br>For the default stream, the flag value may differ across product models. The value obtained by this API prevails. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
