# 12. Execution Control

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:24:53.866Z pushedAt=2026-11-09T09:12:51.191Z nl=2 -->

This chapter describes the execution control APIs of CANN Runtime, including callback function launch, host function subscription, timeout setting, and asynchronous Reduce operations.

- [`aclError aclrtLaunchCallback(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType, aclrtStream stream)`](#aclrtLaunchCallback): Delivers a host callback task to the task queue of a stream. When the system internally executes this callback task, it runs the callback function in the thread registered on the stream (this thread is created by the user and registered through the [aclrtSubscribeReport](#aclrtSubscribeReport) API).
- [`aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream)`](#aclrtSubscribeReport): Registers the thread that processes callback functions on the stream.
- [`aclError aclrtProcessReport(int32_t timeout)`](#aclrtProcessReport): Sets the timeout duration and waits for the callback task delivered by the [aclrtLaunchCallback](#aclrtLaunchCallback) API to be executed.
- [`aclError aclrtUnSubscribeReport(uint64_t threadId, aclrtStream stream)`](#aclrtUnSubscribeReport): Cancels thread registration so that callback functions on the stream are no longer processed by the specified thread.
- [`aclError aclrtGetOpTimeOutInterval(uint64_t *interval)`](#aclrtGetOpTimeOutInterval): Obtains the minimum interval of the operator timeout configuration supported by the hardware, in microseconds.
- [`aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)`](#aclrtSetOpExecuteTimeOut): Sets the timeout duration for operator execution, in seconds. If this API is called multiple times within a process, the last configured duration takes effect.
- [`aclError aclrtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)`](#aclrtSetOpExecuteTimeOutV2): Sets the timeout duration for operator execution, in microseconds.
- [`aclError aclrtSetOpExecuteTimeOutWithMs(uint32_t timeout)`](#aclrtSetOpExecuteTimeOutWithMs): Sets the timeout duration for operator execution, in milliseconds.
- [`aclError aclrtGetOpExecuteTimeout(uint32_t *const timeoutMs)`](#aclrtGetOpExecuteTimeout): Obtains the timeout duration for operator execution.
- [`aclError aclrtGetThreadLastTaskId(uint32_t *taskId)`](#aclrtGetThreadLastTaskId): Obtains the ID of the last task delivered by the current thread.
- [`aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void *reserve)`](#aclrtReduceAsync): Performs a Reduce operation, including SUM, MIN, MAX. This is an asynchronous API.
- [`aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)`](#aclrtLaunchHostFunc): Delivers a host callback task to the task queue of a stream. When the system internally executes this callback task, it runs the callback function in the thread registered on the stream (this thread is created and registered within this API), and the callback task blocks the execution of subsequent tasks on this stream by default.
- [`aclError aclrtRandomNumAsync(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve)`](#aclrtRandomNumAsync): Delivers and executes a random number generation task. This is an asynchronous API.
- [`aclError aclrtTaskUpdateAsync(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream)`](#aclrtTaskUpdateAsync): Refreshes the information of the target task. This is an asynchronous API.

<a class="method_anchor" id="aclrtLaunchCallback"></a>

## aclrtLaunchCallback

```c
aclError aclrtLaunchCallback(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2773 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2773 -->
<!-- npu="A3" id2774 -->
- Atlas A3 products: Supported
<!-- end id2774 -->
<!-- npu="910b" id2775 -->
- Atlas A2 products: Supported
<!-- end id2775 -->
<!-- npu="310b" id2776 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2776 -->
<!-- npu="310p" id2777 -->
- Atlas inference products: Supported
<!-- end id2777 -->
<!-- npu="910" id2778 -->
- Atlas training products: Supported
<!-- end id2778 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id1 -->

### Description

Delivers a host callback task to the task queue of a stream. When the system internally executes this callback task, it runs the callback function in the thread registered on the stream (this thread is created by the user and registered through the [aclrtSubscribeReport](#aclrtSubscribeReport) API). This is an asynchronous API.

**This API must be used with the following APIs** to implement the callback function in asynchronous scenarios:

1. Define and implement the callback function. The function prototype is: typedef void \(\*aclrtCallback\)\(void \*userData\);
2. Create a thread. In the thread function, call [aclrtProcessReport](#aclrtProcessReport) to set the timeout duration (which must be called in a loop) and wait for the callback task to be executed;
3. Call [aclrtSubscribeReport](#aclrtSubscribeReport) to bind the thread created in step 2 to the stream. The callback function delivered on this stream will be executed in the bound thread.
4. Execute asynchronous tasks (for example, asynchronous inference tasks) on the specified stream.
5. Call [aclrtLaunchCallback](#aclrtLaunchCallback) to deliver a callback task to the task queue of the stream, triggering the thread registered in step 2 to process the callback function. Each call to aclrtLaunchCallback triggers one execution of the callback function.
6. After all asynchronous tasks are executed, cancel the thread registration (using [aclrtUnSubscribeReport](#aclrtUnSubscribeReport)).

This API implements the callback function in asynchronous scenarios. The difference from [aclrtLaunchHostFunc](#aclrtLaunchHostFunc), another API that implements the callback function in asynchronous scenarios, is as follows: when aclrtLaunchHostFunc is used, the callback function is executed in the thread registered on the stream (this thread is created and registered internally by the API), and the callback task blocks the execution of subsequent tasks on this stream by default.

For the same stream, the two sets of APIs that implement the callback function in asynchronous scenarios cannot be used together. Otherwise, exceptions may occur.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| fn | Input | Callback function to add.<br>The prototype of the callback function is as follows:<br>typedef void (*aclrtCallback)(void*userData) |
| userData | Input | Pointer to the user data to be passed to the callback function. |
| blockType | Input | Specifies whether the callback task blocks the execution of subsequent tasks on this stream.<br>typedef enum aclrtCallbackBlockType {<br>   ACL_CALLBACK_NO_BLOCK,  //Non-blocking<br>   ACL_CALLBACK_BLOCK,  //Blocking<br>} aclrtCallbackBlockType; |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The callback function involves shared resources (for example, locks). Therefore, use the callback function with caution. Do not call APIs for resource application, resource release, stream synchronization, device synchronization, task delivery, or task termination; otherwise, errors or deadlocks may occur.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSubscribeReport"></a>

## aclrtSubscribeReport

```c
aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2010 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2010 -->
<!-- npu="A3" id2011 -->
- Atlas A3 products: Supported
<!-- end id2011 -->
<!-- npu="910b" id2012 -->
- Atlas A2 products: Supported
<!-- end id2012 -->
<!-- npu="310b" id2013 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2013 -->
<!-- npu="310p" id2014 -->
- Atlas inference products: Supported
<!-- end id2014 -->
<!-- npu="910" id2015 -->
- Atlas training products: Supported
<!-- end id2015 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id2 -->

### Description

Registers the thread that processes callback functions on a stream.

**This API must be used with the following APIs** to implement the callback function in asynchronous scenarios:

1. Define and implement the callback function. The function prototype is: typedef void \(\*aclrtCallback\)\(void \*userData\);
2. Create a thread. In the thread function, call [aclrtProcessReport](#aclrtProcessReport) to set the timeout duration (which must be called in a loop) and wait for the callback task to be executed.
3. Call [aclrtSubscribeReport](#aclrtSubscribeReport) to bind the thread created in step 2 to the stream. The callback function delivered on this stream will be executed in the bound thread.
4. Execute asynchronous tasks (for example, asynchronous inference tasks) on the specified stream.
5. Call [aclrtLaunchCallback](#aclrtLaunchCallback) to deliver a callback task to the task queue of the stream, triggering the thread registered in step 2 to process the callback function. Each call to aclrtLaunchCallback triggers one execution of the callback function.
6. After all asynchronous tasks are executed, cancel the thread registration (using [aclrtUnSubscribeReport](#aclrtUnSubscribeReport)).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| threadId | Input | ID of the specified thread. |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

aclrtSubscribeReport can be called multiple times to register the same thread that processes the callback function for multiple streams (only multiple streams within the same device are supported). To ensure that tasks in a stream are executed in the call order, registering multiple threads that process the callback function for the same stream by calling aclrtSubscribeReport is not supported. Within the same process, when registering the thread for the callback function on different devices, the same thread ID cannot be specified.

<!-- npu="950,A3,910b,910,310p,310b" id8 -->
If the number of threads registered by calling this API within a single process exceeds a certain limit, the API returns a failure. Considering the thread switching performance overhead of the operating system, it is recommended that the number of threads registered by calling aclrtSubscribeReport be kept at 32 or fewer. The currently supported maximum number of threads is 1024.
<!-- end id8 -->

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id15 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtProcessReport"></a>

## aclrtProcessReport

```c
aclError aclrtProcessReport(int32_t timeout)
```

### Applicable Products

<!-- npu="950" id1359 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1359 -->
<!-- npu="A3" id1360 -->
- Atlas A3 products: Supported
<!-- end id1360 -->
<!-- npu="910b" id1361 -->
- Atlas A2 products: Supported
<!-- end id1361 -->
<!-- npu="310b" id1362 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1362 -->
<!-- npu="310p" id1363 -->
- Atlas inference products: Supported
<!-- end id1363 -->
<!-- npu="910" id1364 -->
- Atlas training products: Supported
<!-- end id1364 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id3 -->

### Description

Sets the timeout duration and waits for the callback task delivered by the [aclrtLaunchCallback](#aclrtLaunchCallback) API to be executed.

**This API must be used with the following APIs** to implement the callback function in asynchronous scenarios:

1. Define and implement the callback function. The function prototype is: typedef void \(\*aclrtCallback\)\(void \*userData\);
2. Create a thread. In the thread function, call [aclrtProcessReport](#aclrtProcessReport) to set the timeout duration (which must be called in a loop) and wait for the callback task to be executed.
3. Call [aclrtSubscribeReport](#aclrtSubscribeReport) to bind the thread created in step 2 to the stream. The callback function delivered on this stream will be executed in the bound thread.
4. Execute asynchronous tasks (for example, asynchronous inference tasks) on the specified stream.
5. Call [aclrtLaunchCallback](#aclrtLaunchCallback) to deliver a callback task to the task queue of the stream, triggering the thread registered in step 2 to process the callback function. Each call to aclrtLaunchCallback triggers one execution of the callback function.
6. After all asynchronous tasks are executed, cancel the thread registration (using [aclrtUnSubscribeReport](#aclrtUnSubscribeReport)).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| timeout | Input | Timeout duration. Unit: millisecond.<br>Value range:<br><br>  - `-1`: Wait indefinitely.<br>  - Greater than 0 (excluding `0`): Wait for the specified duration. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtUnSubscribeReport"></a>

## aclrtUnSubscribeReport

```c
aclError aclrtUnSubscribeReport(uint64_t threadId, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2143 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2143 -->
<!-- npu="A3" id2144 -->
- Atlas A3 products: Supported
<!-- end id2144 -->
<!-- npu="910b" id2145 -->
- Atlas A2 products: Supported
<!-- end id2145 -->
<!-- npu="310b" id2146 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2146 -->
<!-- npu="310p" id2147 -->
- Atlas inference products: Supported
<!-- end id2147 -->
<!-- npu="910" id2148 -->
- Atlas training products: Supported
<!-- end id2148 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id4 -->

### Description

Cancels thread registration so that callback functions on the stream are no longer processed by the specified thread.

**This API must be used with the following APIs** to implement the callback function in asynchronous scenarios:

1. Define and implement a callback function. The function prototype is: typedef void \(\*aclrtCallback\)\(void \*userData\);
2. Create a thread. In the thread function, call [aclrtProcessReport](#aclrtProcessReport) to set the timeout duration (which must be called in a loop) and wait for the callback task to be executed.
3. Call [aclrtSubscribeReport](#aclrtSubscribeReport) to bind the thread created in step 2 to the stream. The callback function delivered on this stream will be executed in the bound thread.
4. Execute asynchronous tasks (for example, asynchronous inference tasks) on the specified stream.
5. Call [aclrtLaunchCallback](#aclrtLaunchCallback) to deliver a callback task to the task queue of the stream, triggering the thread registered in step 2 to process the callback function. Each call to aclrtLaunchCallback triggers one execution of the callback function.
6. After all asynchronous tasks are executed, cancel the thread registration (using [aclrtUnSubscribeReport](#aclrtUnSubscribeReport)).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| threadId | Input | ID of the specified thread. |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetOpTimeOutInterval"></a>

## aclrtGetOpTimeOutInterval

```c
aclError aclrtGetOpTimeOutInterval(uint64_t *interval)
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
- Atlas 200I/500 A2 inference products: Supported
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas inference products: Supported
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas training products: Supported
<!-- end id6 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id5 -->

### Description

Obtains the minimum interval of the operator timeout configuration supported by the hardware, in microseconds.

<!-- npu="910,310p,310b" id9 -->
For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, calling this API can only obtain the minimum time interval of AI Core operators.
<!-- end id9 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id16 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| interval | Output | Minimum interval. Unit: microsecond.<br>The user-configurable and effective timeout duration is interval × N, where N is an integer in the range [1, 254]. If the configured timeout duration is not equal to interval × N, it is rounded up to interval × N. For example, if interval = 100 microseconds and the configured timeout duration is 50 microseconds, the effective timeout duration is 100 × 1 = 100 microseconds. If the configured timeout duration is 30000 microseconds, the effective timeout duration is 100 × 254 = 25400 microseconds. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetOpExecuteTimeOut"></a>

## aclrtSetOpExecuteTimeOut

```c
aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)
```

### Applicable Products

<!-- npu="950" id547 -->
- Ascend 950PR&950DT products: Supported
<!-- end id547 -->
<!-- npu="A3" id548 -->
- Atlas A3 products: Supported
<!-- end id548 -->
<!-- npu="910b" id549 -->
- Atlas A2 products: Supported
<!-- end id549 -->
<!-- npu="310b" id550 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id550 -->
<!-- npu="310p" id551 -->
- Atlas inference products: Supported
<!-- end id551 -->
<!-- npu="910" id552 -->
- Atlas training products: Supported
<!-- end id552 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id6 -->

### Description

Sets the timeout duration for operator execution, in seconds. If this API is called multiple times within a process, the last configured duration takes effect.

If a timeout duration is carried when the operator is delivered, that timeout duration takes precedence over the one set by this API.

<!-- npu="950,A3,910b" id10 -->
For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, it is recommended to use the aclrtSetOpExecuteTimeOutV2 API, which returns the timeout duration that actually takes effect.
<!-- end id10 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| timeout | Input | Timeout duration to set, in seconds.<br>When this parameter is set to `0`, the maximum timeout duration is used. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950,A3,910b,910,310p,310b" id11 -->
### Constraints

- If this API is not called, the default timeout durations of AI Core operators and AI CPU operators vary by product:
    <!-- npu="950" id12 -->
    - For Ascend 950PR&950DT products, the default timeout duration of AI Core operators and AI CPU operators is 1,091 seconds.
    <!-- end id12 -->
    <!-- npu="A3" id13 -->
    - For Atlas A3 products, the default timeout duration of AI Core operators and AI CPU operators is 1,091 seconds.
    <!-- end id13 -->
    <!-- npu="910b" id14 -->
    - For Atlas A2 products, the default timeout duration of AI Core operators and AI CPU operators is 1,091 seconds.
    <!-- end id14 -->
    <!-- npu="310b" id15 -->
    - For Atlas 200I/500 A2 inference products, in Ascend EP form, the default timeout duration of AI Core operators and AI CPU operators is 1,091 seconds; in Ascend RC form, the default timeout duration of AI Core operators is 1,091 seconds, and the default timeout duration of AI CPU operators is 28 seconds.
    <!-- end id15 -->
    <!-- npu="310p" id16 -->
    - For Atlas inference products, the default timeout duration of AI Core operators is 547 seconds, and the default timeout duration of AI CPU operators is 28 seconds.
    <!-- end id16 -->
    <!-- npu="910" id17 -->
    - For Atlas training products, the default timeout duration of AI Core operators is 68 seconds, and the default timeout duration of AI CPU operators is 28 seconds.
    <!-- end id17 -->

- Due to architectural differences among product models, the maximum timeout durations of AI Core operators and AI CPU operators differ:
    <!-- npu="950,A3,910b" id18 -->
    - For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, the maximum timeout duration of AI Core operators and AI CPU operators is interval \* 254, in microseconds. The interval can be obtained by calling the aclrtGetOpTimeOutInterval API.
    <!-- end id18 -->   
    <!-- npu="310b" id19 -->
    - For Atlas 200I/500 A2 inference products, the maximum timeout duration of AI Core operators and AI CPU operators is 1,091 seconds.
    <!-- end id19 -->
    <!-- npu="310p" id20 -->
    - For Atlas inference products, the maximum timeout duration of AI Core operators is 547 seconds, and the maximum timeout duration of AI CPU operators cannot be set.
    <!-- end id20 -->
    <!-- npu="910" id21 -->
    - For Atlas training products, the maximum timeout duration of AI Core operators and AI CPU operators is 2,176 seconds.
    <!-- end id21 -->
<!-- end id11 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetOpExecuteTimeOutV2"></a>

## aclrtSetOpExecuteTimeOutV2

```c
aclError aclrtSetOpExecuteTimeOutV2(uint64_t timeout,  uint64_t *actualTimeout)
```

### Applicable Products

<!-- npu="950" id1254 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1254 -->
<!-- npu="A3" id1255 -->
- Atlas A3 products: Supported
<!-- end id1255 -->
<!-- npu="910b" id1256 -->
- Atlas A2 products: Supported
<!-- end id1256 -->
<!-- npu="310b" id1257 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1257 -->
<!-- npu="310p" id1258 -->
- Atlas inference products: Supported
<!-- end id1258 -->
<!-- npu="910" id1259 -->
- Atlas training products: Supported
<!-- end id1259 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id7 -->

### Description

Sets the timeout duration for operator execution, in microseconds. If a timeout duration is carried when the operator is delivered, that timeout duration takes precedence over the timeout duration set by this API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| timeout | Input | Timeout duration, in microseconds.<br>When this parameter is set to 0, the maximum timeout duration is used.<br>When the time interval obtained by calling the aclrtGetOpTimeOutInterval API is less than 100,000 microseconds and the timeout parameter is set to 0, the AI Core operator never times out. |
| actualTimeout | Output | Returns the timeout duration that actually takes effect, in microseconds.<br> If the AI Core operator never times out, the value output by this parameter is the maximum value of `uint64_t`. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="950,A3,910b" id22 -->
For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, when the time interval obtained by calling the aclrtGetOpTimeoutInterval API is less than 100,000 microseconds and the timeout parameter is set to 0, AI Core operators never time out. In this case, the value output by the actualTimeout parameter is the maximum value of uint64\_t.
<!-- end id22 -->

<!-- npu="910,310p" id23 -->
For Atlas inference products and Atlas training products, this API can only set the execution timeout of AI Core operators.
<!-- end id23 -->

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id17 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetOpExecuteTimeOutWithMs"></a>

## aclrtSetOpExecuteTimeOutWithMs

```c
aclError aclrtSetOpExecuteTimeOutWithMs(uint32_t timeout)
```

### Applicable Products

<!-- npu="950" id1884 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1884 -->
<!-- npu="A3" id1885 -->
- Atlas A3 products: Not supported
<!-- end id1885 -->
<!-- npu="910b" id1886 -->
- Atlas A2 products: Not supported
<!-- end id1886 -->
<!-- npu="310b" id1887 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1887 -->
<!-- npu="310p" id1888 -->
- Atlas inference products: Not supported
<!-- end id1888 -->
<!-- npu="910" id1889 -->
- Atlas training products: Not supported
<!-- end id1889 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id8 -->

### Description

Sets the timeout duration for operator execution, in milliseconds.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| timeout | Input | Timeout duration to set, in milliseconds. When this parameter is set to `0` uses the maximum timeout duration. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id18 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetOpExecuteTimeout"></a>

## aclrtGetOpExecuteTimeout

```c
aclError aclrtGetOpExecuteTimeout(uint32_t *const timeoutMs)
```

### Applicable Products

<!-- npu="950" id449 -->
- Ascend 950PR&950DT products: Supported
<!-- end id449 -->
<!-- npu="A3" id450 -->
- Atlas A3 products: Supported
<!-- end id450 -->
<!-- npu="910b" id451 -->
- Atlas A2 products: Supported
<!-- end id451 -->
<!-- npu="310b" id452 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id452 -->
<!-- npu="310p" id453 -->
- Atlas inference products: Supported
<!-- end id453 -->
<!-- npu="910" id454 -->
- Atlas training products: Supported
<!-- end id454 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id9 -->

### Description

Obtains the timeout duration for operator execution.

<!-- npu="950,A3,910b" id24 -->
For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, if the operator never times out, the value output by this parameter is the maximum value of uint32_t.
<!-- end id24 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| timeoutMs | Output | Timeout duration, in milliseconds.<br>If a set API (for example, aclrtSetOpExecuteTimeOut) has been called to set the timeout duration, the actual hardware timeout duration is returned; otherwise, the default timeout duration is returned. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetThreadLastTaskId"></a>

## aclrtGetThreadLastTaskId

```c
aclError aclrtGetThreadLastTaskId(uint32_t *taskId)
```

### Applicable Products

<!-- npu="950" id3333 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3333 -->
<!-- npu="A3" id3334 -->
- Atlas A3 products: Supported
<!-- end id3334 -->
<!-- npu="910b" id3335 -->
- Atlas A2 products: Supported
<!-- end id3335 -->
<!-- npu="310b" id3336 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3336 -->
<!-- npu="310p" id3337 -->
- Atlas inference products: Supported
<!-- end id3337 -->
<!-- npu="910" id3338 -->
- Atlas training products: Supported
<!-- end id3338 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id10 -->

### Description

Obtains the ID of the last task delivered by the current thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| taskId | Output | ID of the last task delivered by the current thread.<br>Here, a task refers to a task delivered by a stream explicitly created by the user. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtReduceAsync"></a>

## aclrtReduceAsync

```c
aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void *reserve)
```

### Applicable Products

<!-- npu="950" id2122 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2122 -->
<!-- npu="A3" id2123 -->
- Atlas A3 products: Supported
<!-- end id2123 -->
<!-- npu="910b" id2124 -->
- Atlas A2 products: Supported
<!-- end id2124 -->
<!-- npu="310b" id2125 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2125 -->
<!-- npu="310p" id2126 -->
- Atlas inference products: Supported
<!-- end id2126 -->
<!-- npu="910" id2127 -->
- Atlas training products: Supported
<!-- end id2127 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id11 -->

### Description

Performs a Reduce operation, including SUM, MIN, and MAX. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Destination memory address pointer. |
| src | Input | Source memory address pointer. |
| count | Input | Source memory size, in bytes. |
| kind | Input | Operation type. See [aclrtReduceKind](25-02_Enumerations.md#aclrtReduceKind) for the type definition. |
| type | Input | Data type. See [aclDataType](25-02_Enumerations.md#aclDataType) for the type definition. |
| stream | Input | Stream on which the Reduce operation task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |
| reserve | Input | Reserved parameter. Currently, pass NULL. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

`dst` and `src` must be on the same device as the device where the stream resides.

<!-- npu="950" id25 -->
Ascend 950PR&950DT products support the following data types: int8, int16, int32, uint32, fp16, fp32, bf16.
<!-- end id25 -->

<!-- npu="A3" id26 -->
Atlas A3 products support the following data types: int8, int16, int32, fp16, fp32, bf16.
<!-- end id26 -->

<!-- npu="910b" id27 -->
Atlas A2 products support the following data types: int8, int16, int32, fp16, fp32, bf16.
<!-- end id27 -->

<!-- npu="310b" id28 -->
Atlas 200I/500 A2 inference products support the following data types: int8, int16, int32, fp16, fp32.
<!-- end id28 -->

<!-- npu="310p" id29 -->
Atlas inference products support the following data types: fp32, fp16, int16.
<!-- end id29 -->

<!-- npu="910" id30 -->
Atlas training products support only the fp32 type.
<!-- end id30 -->

<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id19 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtLaunchHostFunc"></a>

## aclrtLaunchHostFunc

```c
aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)
```

### Applicable Products

<!-- npu="950" id1975 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1975 -->
<!-- npu="A3" id1976 -->
- Atlas A3 products: Supported
<!-- end id1976 -->
<!-- npu="910b" id1977 -->
- Atlas A2 products: Supported
<!-- end id1977 -->
<!-- npu="310b" id1978 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1978 -->
<!-- npu="310p" id1979 -->
- Atlas inference products: Supported
<!-- end id1979 -->
<!-- npu="910" id1980 -->
- Atlas training products: Supported
<!-- end id1980 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id12 -->

### Description

Delivers a host callback task to the task queue of a stream. When the system internally executes this callback task, it runs the callback function in the thread registered on the stream (this thread is created and registered within this API), and the callback task blocks the execution of subsequent tasks on this stream by default. This is an asynchronous API.

This API implements the callback function in asynchronous scenarios. It differs from the other set of APIs that implement the callback function in asynchronous scenarios ([aclrtLaunchCallback](#aclrtLaunchCallback), [aclrtSubscribeReport](#aclrtSubscribeReport), [aclrtProcessReport](#aclrtProcessReport), and [aclrtUnSubscribeReport](#aclrtUnSubscribeReport)) in the following ways: when using APIs such as aclrtLaunchCallback, the thread registered on the stream must be created by the user and registered through the [aclrtSubscribeReport](#aclrtSubscribeReport) API. In addition, you can specify whether the callback task blocks the execution of subsequent tasks on this stream.

For the same stream, the two sets of APIs that implement the callback function in asynchronous scenarios cannot be used together. Otherwise, exceptions may occur.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream that executes the callback task. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |
| fn | Input | Callback function to be added.<br>The prototype of the callback function is:<br>typedef void (*aclrtHostFunc)(void*args) |
| args | Input | User data to be passed to the callback function. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The callback function involves shared resources (for example, locks). Therefore, use the callback function with caution. Do not call APIs for resource application, resource release, stream synchronization, device synchronization, task delivery, or task termination; otherwise, errors or deadlocks may occur.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtRandomNumAsync"></a>

## aclrtRandomNumAsync

```c
aclError aclrtRandomNumAsync(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve)
```

### Applicable Products

<!-- npu="950" id2948 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2948 -->
<!-- npu="A3" id2949 -->
- Atlas A3 products: Supported
<!-- end id2949 -->
<!-- npu="910b" id2950 -->
- Atlas A2 products: Supported
<!-- end id2950 -->
<!-- npu="310b" id2951 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2951 -->
<!-- npu="310p" id2952 -->
- Atlas inference products: Not supported
<!-- end id2952 -->
<!-- npu="910" id2953 -->
- Atlas training products: Not supported
<!-- end id2953 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id13 -->

### Description

Delivers and executes a random number generation task. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| taskInfo | Input | Random number generation task information. See [aclrtRandomNumTaskInfo](25-04_Structs.md#aclrtRandomNumTaskInfo) for the type definition. |
| stream | Input | Stream on which the random number generation task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |
| reserve | Input | Reserved parameter. Currently, pass NULL. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtTaskUpdateAsync"></a>

## aclrtTaskUpdateAsync

```c
aclError aclrtTaskUpdateAsync(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream)
```

### Applicable Products

<!-- npu="950" id3018 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3018 -->
<!-- npu="A3" id3019 -->
- Atlas A3 products: Supported
<!-- end id3019 -->
<!-- npu="910b" id3020 -->
- Atlas A2 products: Supported
<!-- end id3020 -->
<!-- npu="310b" id3021 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3021 -->
<!-- npu="310p" id3022 -->
- Atlas inference products: Supported
<!-- end id3022 -->
<!-- npu="910" id3023 -->
- Atlas training products: Not supported
<!-- end id3023 -->
<!-- @ref: runtime/res/docs/zh/api_ref/12_execution_control_res.md#id14 -->

### Description

Refreshes the information of the target task. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| taskStream | Input | Stream where the target task resides. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>Only a stream bound to a model is supported here. To bind a model to a stream, call [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream). |
| taskId | Input | ID of the target task.<br>Call [aclrtGetThreadLastTaskId](#aclrtGetThreadLastTaskId) to obtain the task ID. |
| info | Input | Configuration information. See [aclrtTaskUpdateInfo](25-04_Structs.md#aclrtTaskUpdateInfo) for the type definition. |
| execStream | Input | Stream that executes the task refresh. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="950" id31 -->
### Constraints

Ascend 950PR&950DT products do not support updating ACL_RT_UPDATE_RANDOM_TASK (random number generation task).
<!-- end id31 -->
