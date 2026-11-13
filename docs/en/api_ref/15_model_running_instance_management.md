# 15. Model Running Instance Management

<!-- md-trans-meta sourceCommit=592d153befca8bbb9089ee4e63722c39aabe7552 translatedAt=2026-11-06T11:27:38.392Z pushedAt=2026-11-09T09:18:16.176Z nl=2 -->

This section describes CANN Runtime's model running instance management APIs, which are used for RI capture, construction, execution, and task management.

- [`aclError aclmdlRICaptureBegin(aclrtStream stream, aclmdlRICaptureMode mode)`](#aclmdlRICaptureBegin): Starts capturing the tasks dispatched on the stream.
- [`aclError aclmdlRICaptureGetInfo(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)`](#aclmdlRICaptureGetInfo): Obtains the capture information of the stream, including the capture status and the model running instance.
- [`aclError aclmdlRICaptureThreadExchangeMode(aclmdlRICaptureMode *mode)`](#aclmdlRICaptureThreadExchangeMode): Switches the capture mode of the current thread.
- [`aclError aclmdlRICaptureEnd(aclrtStream stream, aclmdlRI *modelRI)`](#aclmdlRICaptureEnd): Ends the capture operation on the stream and obtains the model running instance, which is used to temporarily store the captured tasks.
- [`aclError aclmdlRICaptureTaskGrpBegin(aclrtStream stream)`](#aclmdlRICaptureTaskGrpBegin): Marks the beginning of a task group.
- [`aclError aclmdlRICaptureTaskGrpEnd(aclrtStream stream, aclrtTaskGrp *handle)`](#aclmdlRICaptureTaskGrpEnd): Marks the end of a task group.
- [`aclError aclmdlRICaptureTaskUpdateBegin(aclrtStream stream, aclrtTaskGrp handle)`](#aclmdlRICaptureTaskUpdateBegin): Marks the beginning of the tasks to be updated.
- [`aclError aclmdlRICaptureTaskUpdateEnd(aclrtStream stream)`](#aclmdlRICaptureTaskUpdateEnd): Marks the end of the tasks to be updated.
- [`aclError aclmdlRIDebugJsonPrint(aclmdlRI modelRI, const char *path, uint32_t flags)`](#aclmdlRIDebugJsonPrint): In maintenance and test scenarios, exports model running instance information to a file in JSON format, including Model ID, Stream ID, Task ID, Task Type, and other information.
- [`aclError aclmdlRIDebugPrint(aclmdlRI modelRI)`](#aclmdlRIDebugPrint): In maintenance and test scenarios, this API prints internal model information, including Device ID, Stream ID, Task ID, and other information.
- [`aclError aclmdlRIBuildBegin(aclmdlRI *modelRI, uint32_t flag)`](#aclmdlRIBuildBegin): Starts building a model running instance.
- [`aclError aclmdlRIBindStream(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)`](#aclmdlRIBindStream): Binds a model running instance to a stream.
- [`aclError aclmdlRIEndTask(aclmdlRI modelRI, aclrtStream stream)`](#aclmdlRIEndTask): Marks the end of task dispatch on the stream.
- [`aclError aclmdlRIBuildEnd(aclmdlRI modelRI, void *reserve)`](#aclmdlRIBuildEnd): Ends building a model running instance.
- [`aclError aclmdlRIUnbindStream(aclmdlRI modelRI, aclrtStream stream)`](#aclmdlRIUnbindStream): Unbinds a model running instance from a stream.
- [`aclError aclmdlRIExecute(aclmdlRI modelRI, int32_t timeout)`](#aclmdlRIExecute): Executes the model.
- [`aclError aclmdlRIExecuteAsync(aclmdlRI modelRI, aclrtStream stream)`](#aclmdlRIExecuteAsync): Executes the model. This is an asynchronous API.
- [`aclError aclmdlRIDestroy(aclmdlRI modelRI)`](#aclmdlRIDestroy): Destroys a model running instance.
- [`aclError aclmdlRISetName(aclmdlRI modelRI, const char *name)`](#aclmdlRISetName): Sets the name of the model running instance. If the name is set multiple times for the same model running instance, the last setting takes effect.
- [`aclError aclmdlRIGetName(aclmdlRI modelRI, uint32_t maxLen, char *name)`](#aclmdlRIGetName): Obtains the name of the model running instance. If aclmdlRISetName is not called, this API returns an empty string.
- [`aclError aclmdlRIGetId(aclmdlRI modelRI, uint32_t *modelRIId)`](#aclmdlRIGetId): Obtains the ID of the model running instance.
- [`aclError aclrtCheckArchCompatibility(const char *socVersion, int32_t *canCompatible)`](#aclrtCheckArchCompatibility): Determines whether operator instructions are compatible based on the AI processor version.
- [`aclError aclmdlRIAbort(aclmdlRI modelRI)`](#aclmdlRIAbort): Stops the model running instance that is being executed.
- [`aclError aclmdlRIGetStreams(aclmdlRI modelRI, aclrtStream *streams, uint32_t *numStreams)`](#aclmdlRIGetStreams): Obtains the streams associated with the model running instance.
- [`aclError aclmdlRIGetTasksByStream(aclrtStream stream, aclmdlRITask *tasks, uint32_t *numTasks)`](#aclmdlRIGetTasksByStream): Obtains all tasks in the specified stream.
- [`aclError aclmdlRITaskGetSeqId(aclmdlRITask task, uint32_t *id)`](#aclmdlRITaskGetSeqId): Obtains the task sequence ID.
- [`aclError aclmdlRITaskGetParams(aclmdlRITask task, aclmdlRITaskParams* params)`](#aclmdlRITaskGetParams): Gets the parameter information of a task.
- [`aclError aclmdlRITaskSetParams(aclmdlRITask task, aclmdlRITaskParams* params)`](#aclmdlRITaskSetParams): Sets the parameter information of a task.
- [`aclError aclmdlRIKernelTaskGetAttribute(aclmdlRITask task, aclrtLaunchKernelAttrId attrId, aclrtLaunchKernelAttrValue *attrValue)`](#aclmdlRIKernelTaskGetAttribute): Queries the attribute configuration of a KernelTask.

- [`aclError aclmdlRITaskDisable(aclmdlRITask task)`](#aclmdlRITaskDisable): Sets a specified task to the disabled state, indicating that the task no longer participates in scheduling.
- [`aclError aclmdlRIUpdate(aclmdlRI modelRI)`](#aclmdlRIUpdate): Updates a specified model.
- [`aclError aclmdlRITaskGetType(aclmdlRITask task, aclmdlRITaskType *type)`](#aclmdlRITaskGetType): Gets the task type.
- [`aclError aclmdlRIDestroyRegisterCallback(aclmdlRI modelRI, aclrtCallback func, void *userData)`](#aclmdlRIDestroyRegisterCallback): Registers a callback function that is invoked when the model running instance is destroyed.
- [`aclError aclmdlRIDestroyUnregisterCallback(aclmdlRI modelRI, aclrtCallback func)`](#aclmdlRIDestroyUnregisterCallback): Unregisters the callback function registered through [aclmdlRIDestroyRegisterCallback](#aclmdlRIDestroyRegisterCallback).
- [`aclError aclmdlRICondHandleCreate(aclmdlRI modelRI, uint32_t defaultLaunchValue, aclmdlRICondHandleFlag flag, aclmdlRICondHandle *handle)`](#aclmdlRICondHandleCreate): Creates a condition handle on a specified model running instance for subsequent conditional task execution.
- [`aclError aclmdlRICondHandleGetCondPtr(aclmdlRICondHandle handle, uint64_t **ptr)`](#aclmdlRICondHandleGetCondPtr): Gets the Device memory pointer of a condition handle, which stores the condition value used to select the model running instance for execution when a conditional task is executed.
- [`aclError aclmdlRIAddCondTask(aclmdlRICondTaskParams params, aclrtStream stream, uint32_t flags)`](#aclmdlRIAddCondTask): Dispatches a conditional task on the stream.
- [`aclError aclmdlRICaptureToModelRIBegin(aclrtStream stream, aclmdlRI modelRI, aclmdlRICaptureMode mode)`](#aclmdlRICaptureToModelRIBegin): Starts capturing tasks dispatched on the stream into the specified model running instance.

<a class="method_anchor" id="aclmdlRICaptureBegin"></a>

## aclmdlRICaptureBegin

```c
aclError aclmdlRICaptureBegin(aclrtStream stream, aclmdlRICaptureMode mode)
```

### Applicable Products

<!-- npu="950" id1009 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1009 -->
<!-- npu="A3" id1010 -->
- Atlas A3 products: Supported
<!-- end id1010 -->
<!-- npu="910b" id1011 -->
- Atlas A2 products: Supported
<!-- end id1011 -->
<!-- npu="310b" id1012 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1012 -->
<!-- npu="310p" id1013 -->
- Atlas inference products: Supported
<!-- end id1013 -->
<!-- npu="910" id1014 -->
- Atlas training products: Not supported
<!-- end id1014 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id1 -->

### Function

Starts capturing the tasks dispatched on a stream.

Between the aclmdlRICaptureBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) APIs, all tasks dispatched on the specified stream are not executed immediately. Instead, they are temporarily stored in the internal model running instance of the system. These tasks are actually executed only when the model is executed by calling the [aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync) API, which reduces the task dispatch overhead on the host side. After all tasks are executed, if the internal model is no longer needed, call the [aclmdlRIDestroy](#aclmdlRIDestroy) API to destroy the resource in a timely manner.

aclmdlRICaptureBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) must be used in pairs, and the stream specified in the two APIs must be the same. Between these two APIs, you can call [aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo) to obtain capture information and call [aclmdlRICaptureThreadExchangeMode](#aclmdlRICaptureThreadExchangeMode) to switch the capture mode of the current thread. In addition, after calling [aclmdlRICaptureEnd](#aclmdlRICaptureEnd), you can call [aclmdlRIDebugPrint](#aclmdlRIDebugPrint) to print model information, which helps locate issues in maintenance and test scenarios.

For tasks captured between aclmdlRICaptureBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd), to update a task (including the task itself and its parameter information), you need to dispatch the tasks that may be updated later between [aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin) and [aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd) to mark the tasks with a task group, and then update the input information of the tasks between [aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin) and [aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd).

Tasks captured between aclmdlRICaptureBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) are temporarily stored in the internal model running instance in the system. As the number of tasks increases, event derivation and operations on internal tasks cause more streams to enter the capture state, and stream resources are continuously consumed. This may eventually lead to insufficient concurrent scheduling resources. Therefore, you need to plan the use of scheduling resources in advance.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| mode | Input | Capture mode, which limits the scope of non-secure functions (including aclrtMemset, aclrtMemcpy, aclrtMemcpy2d, and APIs that perform asynchronous memory copy operations using non-Host pinned memory, such as aclrtMemcpyAsync).<br>For the type definition, see [aclmdlRICaptureMode](25-02_Enumerations.md#aclmdlRICaptureMode). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureGetInfo"></a>

## aclmdlRICaptureGetInfo

```c
aclError aclmdlRICaptureGetInfo(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)
```

### Applicable Products

<!-- npu="950" id750 -->
- Ascend 950PR&950DT products: Supported
<!-- end id750 -->
<!-- npu="A3" id751 -->
- Atlas A3 products: Supported
<!-- end id751 -->
<!-- npu="910b" id752 -->
- Atlas A2 products: Supported
<!-- end id752 -->
<!-- npu="310b" id753 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id753 -->
<!-- npu="310p" id754 -->
- Atlas inference products: Supported
<!-- end id754 -->
<!-- npu="910" id755 -->
- Atlas training products: Not supported
<!-- end id755 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id2 -->

### Function

Obtains the capture information of a stream, including the capture status and the model running instance.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| status | Output | Capture status of the tasks on the stream. See [aclmdlRICaptureStatus](25-02_Enumerations.md#aclmdlRICaptureStatus) for the type definition. |
| modelRI | Output | Model running instance, which is used to temporarily store the captured tasks. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition.<br>If the stream specified by this API is not in the capture state, the modelRI returned here is invalid. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureThreadExchangeMode"></a>

## aclmdlRICaptureThreadExchangeMode

```c
aclError aclmdlRICaptureThreadExchangeMode(aclmdlRICaptureMode *mode)
```

### Applicable Products

<!-- npu="950" id2388 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2388 -->
<!-- npu="A3" id2389 -->
- Atlas A3 products: Supported
<!-- end id2389 -->
<!-- npu="910b" id2390 -->
- Atlas A2 products: Supported
<!-- end id2390 -->
<!-- npu="310b" id2391 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2391 -->
<!-- npu="310p" id2392 -->
- Atlas inference products: Supported
<!-- end id2392 -->
<!-- npu="910" id2393 -->
- Atlas training products: Not supported
<!-- end id2393 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id3 -->

### Function

Switches the capture mode of the current thread.

Calling this API sets the capture mode of the calling thread to the value contained in \*mode and returns the mode previously set for the thread through \*mode.

It is recommended to call this API between [aclmdlRICaptureBegin](#aclmdlRICaptureBegin) and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) to switch the mode of the current thread. The configuration of each capture mode is described as follows. In the descriptions, "other threads" refers to threads that have not called aclmdlRICaptureBegin and are not in the capture state.

- If aclmdlRICaptureBegin sets the capture mode to ACL\_MODEL\_RI\_CAPTURE\_MODE\_RELAXED (hereinafter referred to as RELAXED mode), all threads can call non-secure functions. In this case, even if this API is called in other threads (threads not in the capture state) to set the capture mode to another value, the setting does not take effect, and other threads still operate in RELAXED mode.
- If aclmdlRICaptureBegin sets the capture mode to ACL\_MODEL\_RI\_CAPTURE\_MODE\_THREAD\_LOCAL (hereinafter referred to as THREAD\_LOCAL mode), the current thread is prohibited from calling non-secure functions, but other threads can call non-secure functions. If the current thread needs to call a non-secure function, call this API to switch the current thread mode to RELAXED mode.
- If aclmdlRICaptureBegin sets the capture mode to ACL\_MODEL\_RI\_CAPTURE\_MODE\_GLOBAL (hereinafter referred to as GLOBAL mode), no thread can call non-secure functions. If the current thread needs to call a non-secure function, call this API to switch to RELAXED mode. If other threads need to call a non-secure function, call this API to switch to RELAXED mode or THREAD\_LOCAL mode.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| mode | Input&Output | Capture mode, which limits the scope of non-secure functions (including aclrtMemset, aclrtMemcpy, aclrtMemcpy2d, and APIs that perform asynchronous memory copy operations using non-Host pinned memory, such as aclrtMemcpyAsync).<br>For the type definition, see [aclmdlRICaptureMode](25-02_Enumerations.md#aclmdlRICaptureMode). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureEnd"></a>

## aclmdlRICaptureEnd

```c
aclError aclmdlRICaptureEnd(aclrtStream stream, aclmdlRI *modelRI)
```

### Applicable Products

<!-- npu="950" id3067 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3067 -->
<!-- npu="A3" id3068 -->
- Atlas A3 products: Supported
<!-- end id3068 -->
<!-- npu="910b" id3069 -->
- Atlas A2 products: Supported
<!-- end id3069 -->
<!-- npu="310b" id3070 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3070 -->
<!-- npu="310p" id3071 -->
- Atlas inference products: Supported
<!-- end id3071 -->
<!-- npu="910" id3072 -->
- Atlas training products: Not supported
<!-- end id3072 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id4 -->

### Function

Ends the capture action on a stream and obtains a model running instance, which is used to temporarily store the captured tasks.

This API must be used together with other APIs to capture the tasks dispatched on the stream, temporarily store them in an internally created model, and use them for subsequent task execution, thereby reducing the task dispatch overhead on the host side. For the usage flow, see the description of the [aclmdlRICaptureBegin](#aclmdlRICaptureBegin) API.

In the [aclmdlRICaptureBegin](#aclmdlRICaptureBegin) API, if mode is set to a value other than ACL\_MODEL\_RI\_CAPTURE\_MODE\_RELAXED, this API and the [aclmdlRICaptureBegin](#aclmdlRICaptureBegin) API must be called in the same thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| modelRI | Output | Model running instance, which is used to temporarily store the captured tasks. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI).<br>When the main capture started by [aclmdlRICaptureBegin](#aclmdlRICaptureBegin) is ended, this parameter must be a non-null pointer used to return the model running instance.<br>When the sub-model capture bound by [aclmdlRICaptureToModelRIBegin](#aclmdlRICaptureToModelRIBegin) is ended, this parameter can be set to nullptr. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureTaskGrpBegin"></a>

## aclmdlRICaptureTaskGrpBegin

```c
aclError aclmdlRICaptureTaskGrpBegin(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id344 -->
- Ascend 950PR&950DT products: Supported
<!-- end id344 -->
<!-- npu="A3" id345 -->
- Atlas A3 products: Supported
<!-- end id345 -->
<!-- npu="910b" id346 -->
- Atlas A2 products: Supported
<!-- end id346 -->
<!-- npu="310b" id347 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id347 -->
<!-- npu="310p" id348 -->
- Atlas inference products: Supported
<!-- end id348 -->
<!-- npu="910" id349 -->
- Atlas training products: Not supported
<!-- end id349 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id5 -->

### Function

Marks the beginning of a task group.

This API is used in pairs with the [aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd) API. The tasks between these two APIs form a task group. Currently, only single-operator tasks can be issued between these two APIs.

If the API returns ACL\_ERROR\_RT\_TASK\_TYPE\_NOT\_SUPPORT when a task is dispatched, the single-operator task is not supported. You can check the application logs for detailed error information.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specifies the stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>The stream here must be in the capture state. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureTaskGrpEnd"></a>

## aclmdlRICaptureTaskGrpEnd

```c
aclError aclmdlRICaptureTaskGrpEnd(aclrtStream stream, aclrtTaskGrp *handle)
```

### Applicable Products

<!-- npu="950" id1037 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1037 -->
<!-- npu="A3" id1038 -->
- Atlas A3 products: Supported
<!-- end id1038 -->
<!-- npu="910b" id1039 -->
- Atlas A2 products: Supported
<!-- end id1039 -->
<!-- npu="310b" id1040 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1040 -->
<!-- npu="310p" id1041 -->
- Atlas inference products: Supported
<!-- end id1041 -->
<!-- npu="910" id1042 -->
- Atlas training products: Not supported
<!-- end id1042 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id6 -->

### Function

Marks the end of a task group.

The [aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin) API and this API are used in pairs. The tasks between these two APIs form a task group. Currently, only tasks that dispatch single-operator calls are supported between these two APIs.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>The stream here must be the same as the stream specified in the [aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin) API. |
| handle | Output | Handle that identifies the task group. See [aclrtTaskGrp](25-05_Typedefs.md#aclrtTaskGrp) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureTaskUpdateBegin"></a>

## aclmdlRICaptureTaskUpdateBegin

```c
aclError aclmdlRICaptureTaskUpdateBegin(aclrtStream stream, aclrtTaskGrp handle)
```

### Applicable Products

<!-- npu="950" id1429 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1429 -->
<!-- npu="A3" id1430 -->
- Atlas A3 products: Supported
<!-- end id1430 -->
<!-- npu="910b" id1431 -->
- Atlas A2 products: Supported
<!-- end id1431 -->
<!-- npu="310b" id1432 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1432 -->
<!-- npu="310p" id1433 -->
- Atlas inference products: Supported
<!-- end id1433 -->
<!-- npu="910" id1434 -->
- Atlas training products: Not supported
<!-- end id1434 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id7 -->

### Function

Marks the start of the tasks to be updated.

This API is used in pairs with [aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd). The tasks between these two APIs need to be updated.

The number and types of tasks between aclmdlRICaptureTaskUpdateBegin and [aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd) must be consistent with those between [aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin) and [aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd).

If ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT is returned during task update, it indicates that the underlying driver does not support this feature and the driver package needs to be upgraded. You can click [Link](https://www.hiascend.com/hardware/firmware-drivers/commercial) to download the driver installation package of the corresponding version on the "Firmware and Drivers" page, and install and upgrade it by referring to its documentation.

<!-- npu="A3,910b" id1 -->
- For Atlas A2 products and Atlas A3 products, upgrade the driver package to 25.0.RC1 or later.
<!-- end id1 -->
<!-- npu="310p" id2 -->
- For Atlas inference products, upgrade the driver package to 26.0.RC1 or later.
<!-- end id2 -->

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>The stream here must not be in the capture state. |
| handle | Input | Handle that identifies the task group. For the type definition, see [aclrtTaskGrp](25-05_Typedefs.md#aclrtTaskGrp).<br>Call [aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin) and [aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd) in advance to mark the task group, obtain the task group handle through aclmdlRICaptureTaskGrpEnd, and then pass it as an input parameter here. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="A3,910b" id3 -->
### Constraints

For Atlas A2 products and Atlas A3 products, if the Ascend HDK version bundled with CANN is earlier than 25.5.X (excluding this version), the maximum number of tasks that can be updated simultaneously on a single Device is 1024\*1024. If this specification is exceeded, an error is reported for the tasks during the execution phase.
<!-- end id3 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureTaskUpdateEnd"></a>

## aclmdlRICaptureTaskUpdateEnd

```c
aclError aclmdlRICaptureTaskUpdateEnd(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id15 -->
- Ascend 950PR&950DT products: Supported
<!-- end id15 -->
<!-- npu="A3" id16 -->
- Atlas A3 products: Supported
<!-- end id16 -->
<!-- npu="910b" id17 -->
- Atlas A2 products: Supported
<!-- end id17 -->
<!-- npu="310b" id18 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id18 -->
<!-- npu="310p" id19 -->
- Atlas inference products: Supported
<!-- end id19 -->
<!-- npu="910" id20 -->
- Atlas training products: Not supported
<!-- end id20 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id8 -->

### Function

Marks the end of the tasks to be updated.

The [aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin) API and this API are used in pairs. The tasks between these two APIs need to be updated.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>The stream here must be the same as the stream specified in the [aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin) API. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

The task to be updated uses an asynchronous API. A successful return from this API does not mean that the task update is complete.

### Constraints

A single Device supports updating a maximum of 1024\*1024 tasks simultaneously. If this limit is exceeded, an error is reported during task execution.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIDebugJsonPrint"></a>

## aclmdlRIDebugJsonPrint

```c
aclError aclmdlRIDebugJsonPrint(aclmdlRI modelRI, const char *path, uint32_t flags)
```

### Applicable Products

<!-- npu="950" id302 -->
- Ascend 950PR&950DT products: Supported
<!-- end id302 -->
<!-- npu="A3" id303 -->
- Atlas A3 products: Supported
<!-- end id303 -->
<!-- npu="910b" id304 -->
- Atlas A2 products: Supported
<!-- end id304 -->
<!-- npu="310b" id305 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id305 -->
<!-- npu="310p" id306 -->
- Atlas inference products: Supported
<!-- end id306 -->
<!-- npu="910" id307 -->
- Atlas training products: Not supported
<!-- end id307 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id9 -->

### Function

In maintenance and test scenarios, this API exports the model running instance information to a file in JSON format, including the Model ID, Stream ID, Task ID, Task Type, and other information. You can then view the visualization information of the model through tracing (for example, chrome://tracing/).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance that temporarily stores the captured tasks. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition.<br>Ensure that modelRI is valid. |
| path | Input | Path of the file to be exported, including the file name.<br>The file path must exist and have read and write permissions. Otherwise, this API returns a failure. |
| flags | Input | Configuration options.<br>The value is one of the following macros:<br><br>  - ACL_MDLRI_DEBUG_JSON_PRINT_SUMMARY: Prints the basic information of modelRI, such as Model ID, Stream ID, and Task ID.<br>  - ACL_MDLRI_DEBUG_JSON_PRINT_VERBOSE: In addition to the basic information, prints the kernel function parameter information of the AI Core operators in modelRI.<br><br><br>The macros are defined as follows:<br>#define ACL_MDLRI_DEBUG_JSON_PRINT_SUMMARY 0x0UL<br>#define ACL_MDLRI_DEBUG_JSON_PRINT_VERBOSE 0x1UL |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIDebugPrint"></a>

## aclmdlRIDebugPrint

```c
aclError aclmdlRIDebugPrint(aclmdlRI modelRI)
```

### Applicable Products

<!-- npu="950" id3515 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3515 -->
<!-- npu="A3" id3516 -->
- Atlas A3 products: Supported
<!-- end id3516 -->
<!-- npu="910b" id3517 -->
- Atlas A2 products: Supported
<!-- end id3517 -->
<!-- npu="310b" id3518 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3518 -->
<!-- npu="310p" id3519 -->
- Atlas inference products: Supported
<!-- end id3519 -->
<!-- npu="910" id3520 -->
- Atlas training products: Not supported
<!-- end id3520 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id10 -->

### Function

In maintenance and test scenarios, this API prints internal model information, including Device ID, Stream ID, Task ID, and other information.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance used to temporarily store the captured tasks. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI).<br>Model information can be printed only after the [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) API. Pass the model running instance output by the [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) API as the input parameter of this API, and ensure that modelRI is valid. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIBuildBegin"></a>

## aclmdlRIBuildBegin

```c
aclError aclmdlRIBuildBegin(aclmdlRI *modelRI, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id2402 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2402 -->
<!-- npu="A3" id2403 -->
- Atlas A3 products: Supported
<!-- end id2403 -->
<!-- npu="910b" id2404 -->
- Atlas A2 products: Supported
<!-- end id2404 -->
<!-- npu="310b" id2405 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2405 -->
<!-- npu="310p" id2406 -->
- Atlas inference products: Supported
<!-- end id2406 -->
<!-- npu="910" id2407 -->
- Atlas training products: Supported
<!-- end id2407 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id11 -->

### Function

Starts building a model running instance.

After the [aclmdlRIBuildBegin](#aclmdlRIBuildBegin) API, first call the [aclmdlRIBindStream](#aclmdlRIBindStream) API to bind the model running instance to a stream, then dispatch tasks on the specified stream. After all tasks are dispatched, call the [aclmdlRIEndTask](#aclmdlRIEndTask) API to mark the end of task dispatch on the stream, and then call the [aclmdlRIBuildEnd](#aclmdlRIBuildEnd) API to finish model building. At this point, the tasks dispatched on the specified stream are not executed immediately. They are actually executed only when the [aclmdlRIExecute](#aclmdlRIExecute) or [aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync) API is called to perform model inference.

After all tasks are executed, if the model running instance is no longer needed, call the [aclmdlRIUnbindStream](#aclmdlRIUnbindStream) API to unbind the model running instance from the stream. Call the [aclmdlRIDestroy](#aclmdlRIDestroy) API to destroy the resource in a timely manner.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance, which is used to temporarily store the compiled tasks. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI). |
| flag | Input | Reserved parameter. It is fixed to 0. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIBindStream"></a>

## aclmdlRIBindStream

```c
aclError aclmdlRIBindStream(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id1625 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1625 -->
<!-- npu="A3" id1626 -->
- Atlas A3 products: Supported
<!-- end id1626 -->
<!-- npu="910b" id1627 -->
- Atlas A2 products: Supported
<!-- end id1627 -->
<!-- npu="310b" id1628 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1628 -->
<!-- npu="310p" id1629 -->
- Atlas inference products: Supported
<!-- end id1629 -->
<!-- npu="910" id1630 -->
- Atlas training products: Supported
<!-- end id1630 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id12 -->

### Function

Binds a model running instance to a stream.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI).<br>The modelRI here must be consistent with the modelRI in the [aclmdlRIBuildBegin](#aclmdlRIBuildBegin) API. |
| stream | Input | Specified stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>The stream here must be created as an ACL_STREAM_PERSISTENT stream by calling the [aclrtCreateStreamWithConfig](06_stream_management.md#aclrtCreateStreamWithConfig) API.<br>Passing NULL is not supported, and binding one stream to multiple modelRIs is not supported. |
| flag | Input | Marks whether the stream runs from the start of model execution.<br><br>  - ACL_MODEL_STREAM_FLAG_HEAD: Head stream, which runs from the start of model execution.<br>  - ACL_MODEL_STREAM_FLAG_DEFAULT: Stream activated by a branch operator or loop operator during model execution. It can be activated later by calling the [aclrtActiveStream](06_stream_management.md#aclrtActiveStream) API.<br><br>The macro definitions are as follows:<br>#define ACL_MODEL_STREAM_FLAG_HEAD  0x00000000U <br>#define ACL_MODEL_STREAM_FLAG_DEFAULT 0x7FFFFFFFU |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIEndTask"></a>

## aclmdlRIEndTask

```c
aclError aclmdlRIEndTask(aclmdlRI modelRI, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2899 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2899 -->
<!-- npu="A3" id2900 -->
- Atlas A3 products: Supported
<!-- end id2900 -->
<!-- npu="910b" id2901 -->
- Atlas A2 products: Supported
<!-- end id2901 -->
<!-- npu="310b" id2902 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2902 -->
<!-- npu="310p" id2903 -->
- Atlas inference products: Supported
<!-- end id2903 -->
<!-- npu="910" id2904 -->
- Atlas training products: Supported
<!-- end id2904 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id13 -->

### Function

Marks the end of task dispatch on a stream.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI).<br>The modelRI here must be consistent with the modelRI in the [aclmdlRIBuildBegin](#aclmdlRIBuildBegin) API. |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIBuildEnd"></a>

## aclmdlRIBuildEnd

```c
aclError aclmdlRIBuildEnd(aclmdlRI modelRI, void *reserve)
```

### Applicable Products

<!-- npu="950" id29 -->
- Ascend 950PR&950DT products: Supported
<!-- end id29 -->
<!-- npu="A3" id30 -->
- Atlas A3 products: Supported
<!-- end id30 -->
<!-- npu="910b" id31 -->
- Atlas A2 products: Supported
<!-- end id31 -->
<!-- npu="310b" id32 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id32 -->
<!-- npu="310p" id33 -->
- Atlas inference products: Supported
<!-- end id33 -->
<!-- npu="910" id34 -->
- Atlas training products: Supported
<!-- end id34 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id14 -->

### Function

Ends building a model running instance.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI).<br>The modelRI here must be consistent with the modelRI in the [aclmdlRIBuildBegin](#aclmdlRIBuildBegin) API. |
| reserve | Input | Reserved parameter. Currently fixed to NULL. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

After this API is called, you are not allowed to dispatch tasks to the stream bound to the model running instance; otherwise, subsequent model execution will be abnormal.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIUnbindStream"></a>

## aclmdlRIUnbindStream

```c
aclError aclmdlRIUnbindStream(aclmdlRI modelRI, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id722 -->
- Ascend 950PR&950DT products: Supported
<!-- end id722 -->
<!-- npu="A3" id723 -->
- Atlas A3 products: Supported
<!-- end id723 -->
<!-- npu="910b" id724 -->
- Atlas A2 products: Supported
<!-- end id724 -->
<!-- npu="310b" id725 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id725 -->
<!-- npu="310p" id726 -->
- Atlas inference products: Supported
<!-- end id726 -->
<!-- npu="910" id727 -->
- Atlas training products: Supported
<!-- end id727 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id15 -->

### Function

Unbinds a model running instance from a stream.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI).<br>The modelRI here must be consistent with the modelRI in the [aclmdlRIBuildBegin](#aclmdlRIBuildBegin) API. |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIExecute"></a>

## aclmdlRIExecute

```c
aclError aclmdlRIExecute(aclmdlRI modelRI, int32_t timeout)
```

### Applicable Products

<!-- npu="950" id582 -->
- Ascend 950PR&950DT products: Supported
<!-- end id582 -->
<!-- npu="A3" id583 -->
- Atlas A3 products: Supported
<!-- end id583 -->
<!-- npu="910b" id584 -->
- Atlas A2 products: Supported
<!-- end id584 -->
<!-- npu="310b" id585 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id585 -->
<!-- npu="310p" id586 -->
- Atlas inference products: Supported
<!-- end id586 -->
<!-- npu="910" id587 -->
- Atlas training products: Supported
<!-- end id587 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id16 -->

### Function

Executes the model.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI).<br>modelRI can be obtained in the following ways:<br><br>  - Call APIs such as [aclmdlRIBuildBegin](#aclmdlRIBuildBegin) and [aclmdlRIBuildEnd](#aclmdlRIBuildEnd) to build a model running instance, and then pass it to this API. |
| timeout | Input | Timeout period.<br>The value is described as follows:<br><br>  - -1: Wait indefinitely.<br>  - >0: Specify the timeout period in milliseconds. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIExecuteAsync"></a>

## aclmdlRIExecuteAsync

```c
aclError aclmdlRIExecuteAsync(aclmdlRI modelRI, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2906 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2906 -->
<!-- npu="A3" id2907 -->
- Atlas A3 products: Supported
<!-- end id2907 -->
<!-- npu="910b" id2908 -->
- Atlas A2 products: Supported
<!-- end id2908 -->
<!-- npu="310b" id2909 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2909 -->
<!-- npu="310p" id2910 -->
- Atlas inference products: Supported
<!-- end id2910 -->
<!-- npu="910" id2911 -->
- Atlas training products: Not supported
<!-- end id2911 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id17 -->

### Function

Executes the model. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition.<br>modelRI can be obtained in the following ways:<br><br>  - After calling [aclmdlRICaptureBegin](#aclmdlRICaptureBegin) to capture the tasks dispatched to the stream, call [aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo) to obtain the model running instance, and then pass it to this API.<br>  - Call [aclmdlRIBuildBegin](#aclmdlRIBuildBegin), [aclmdlRIBuildEnd](#aclmdlRIBuildEnd), and other APIs to build the model running instance, and then pass it to this API. |
| stream | Input | Specified stream used to execute the model inference task. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIDestroy"></a>

## aclmdlRIDestroy

```c
aclError aclmdlRIDestroy(aclmdlRI modelRI)
```

### Applicable Products

<!-- npu="950" id99 -->
- Ascend 950PR&950DT products: Supported
<!-- end id99 -->
<!-- npu="A3" id100 -->
- Atlas A3 products: Supported
<!-- end id100 -->
<!-- npu="910b" id101 -->
- Atlas A2 products: Supported
<!-- end id101 -->
<!-- npu="310b" id102 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id102 -->
<!-- npu="310p" id103 -->
- Atlas inference products: Supported
<!-- end id103 -->
<!-- npu="910" id104 -->
- Atlas training products: Supported
<!-- end id104 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id18 -->

### Function

Destroys a model running instance.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRISetName"></a>

## aclmdlRISetName

```c
aclError aclmdlRISetName(aclmdlRI modelRI, const char *name)
```

### Applicable Products

<!-- npu="950" id2171 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2171 -->
<!-- npu="A3" id2172 -->
- Atlas A3 products: Supported
<!-- end id2172 -->
<!-- npu="910b" id2173 -->
- Atlas A2 products: Supported
<!-- end id2173 -->
<!-- npu="310b" id2174 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2174 -->
<!-- npu="310p" id2175 -->
- Atlas inference products: Supported
<!-- end id2175 -->
<!-- npu="910" id2176 -->
- Atlas training products: Supported
<!-- end id2176 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id19 -->

### Function

Sets the name of a model running instance. If the name is set multiple times for the same model running instance, the last setting takes effect.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition.<br>modelRI can be obtained in the following ways:<br><br>  - After calling [aclmdlRICaptureBegin](#aclmdlRICaptureBegin) to capture the tasks dispatched to the stream, call [aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo) to obtain the model running instance, and then pass it to this API.<br>  - Call [aclmdlRIBuildBegin](#aclmdlRIBuildBegin), [aclmdlRIBuildEnd](#aclmdlRIBuildEnd), and other APIs to build the model running instance, and then pass it to this API. |
| name | Input | Name. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIGetName"></a>

## aclmdlRIGetName

```c
aclError aclmdlRIGetName(aclmdlRI modelRI, uint32_t maxLen, char *name)
```

### Applicable Products

<!-- npu="950" id2759 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2759 -->
<!-- npu="A3" id2760 -->
- Atlas A3 products: Supported
<!-- end id2760 -->
<!-- npu="910b" id2761 -->
- Atlas A2 products: Supported
<!-- end id2761 -->
<!-- npu="310b" id2762 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2762 -->
<!-- npu="310p" id2763 -->
- Atlas inference products: Supported
<!-- end id2763 -->
<!-- npu="910" id2764 -->
- Atlas training products: Supported
<!-- end id2764 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id20 -->

### Function

Obtains the name of the model running instance. If aclmdlRISetName is not called, this API returns an empty string.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |
| maxLen | Input | Maximum memory length, in bytes, allocated by the user for storing the name. |
| name | Output | Name of the model running instance.<br>The maximum length of name is 512 bytes. Any part exceeding 512 bytes is truncated and returned. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIGetId"></a>

## aclmdlRIGetId

```c
aclError aclmdlRIGetId(aclmdlRI modelRI, uint32_t *modelRIId)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id869 -->
- Ascend 950PR&950DT products: Supported
<!-- end id869 -->
<!-- npu="A3" id870 -->
- Atlas A3 products: Supported
<!-- end id870 -->
<!-- npu="910b" id871 -->
- Atlas A2 products: Supported
<!-- end id871 -->
<!-- npu="310b" id872 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id872 -->
<!-- npu="310p" id873 -->
- Atlas inference products: Supported
<!-- end id873 -->
<!-- npu="910" id874 -->
- Atlas training products: Not supported
<!-- end id874 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id21 -->

### Function

Obtains the ID of the model running instance.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |
| modelRIId | Output | ID of the model running instance. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCheckArchCompatibility"></a>

## aclrtCheckArchCompatibility

```c
aclError aclrtCheckArchCompatibility(const char *socVersion, int32_t *canCompatible)
```

### Applicable Products

<!-- npu="950" id2927 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2927 -->
<!-- npu="A3" id2928 -->
- Atlas A3 products: Supported
<!-- end id2928 -->
<!-- npu="910b" id2929 -->
- Atlas A2 products: Supported
<!-- end id2929 -->
<!-- npu="310b" id2930 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2930 -->
<!-- npu="310p" id2931 -->
- Atlas inference products: Supported
<!-- end id2931 -->
<!-- npu="910" id2932 -->
- Atlas training products: Supported
<!-- end id2932 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id22 -->

### Function

Determines whether operator instructions are compatible based on the AI processor version.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| socVersion | Input | AI processor version. |
| canCompatible | Output | Whether the instructions are compatible. 1 indicates compatible, and 0 indicates incompatible. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIAbort"></a>

## aclmdlRIAbort

```c
aclError aclmdlRIAbort(aclmdlRI modelRI)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id2024 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2024 -->
<!-- npu="A3" id2025 -->
- Atlas A3 products: Supported
<!-- end id2025 -->
<!-- npu="910b" id2026 -->
- Atlas A2 products: Supported
<!-- end id2026 -->
<!-- npu="310b" id2027 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2027 -->
<!-- npu="310p" id2028 -->
- Atlas inference products: Supported
<!-- end id2028 -->
<!-- npu="910" id2029 -->
- Atlas training products: Supported
<!-- end id2029 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id23 -->

### Function

Stops the model running instance that is currently being executed.

To re-execute the model running instance, call the [aclmdlRIExecute](#aclmdlRIExecute) or [aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync) API again.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API cannot be used in model capture (ACL Graph) scenarios.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIGetStreams"></a>

## aclmdlRIGetStreams

```c
aclError aclmdlRIGetStreams(aclmdlRI modelRI, aclrtStream *streams, uint32_t *numStreams)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id2598 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2598 -->
<!-- npu="A3" id2599 -->
- Atlas A3 products: Supported
<!-- end id2599 -->
<!-- npu="910b" id2600 -->
- Atlas A2 products: Supported
<!-- end id2600 -->
<!-- npu="310b" id2601 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2601 -->
<!-- npu="310p" id2602 -->
- Atlas inference products: Not supported
<!-- end id2602 -->
<!-- npu="910" id2603 -->
- Atlas training products: Not supported
<!-- end id2603 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id24 -->

### Function

Obtains the streams associated with a model running instance.

All streams associated with the model running instance can be obtained by calling this API twice:

1. First call to aclmdlRIGetStreams: Pass a null pointer to the streams parameter and any non-negative integer to numStreams, and call aclmdlRIGetStreams to obtain the number of streams associated with the model running instance, numStreams.
2. Second call to aclmdlRIGetStreams: Allocate an array for streams with a size equal to the numStreams obtained in the previous step, and then pass streams and numStreams as inputs to aclmdlRIGetStreams to obtain all streams associated with the model running instance.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |
| streams | Input&Output | If a null pointer is passed to streams, the number of streams associated with the model running instance is obtained and returned through the numStreams parameter.<br>If streams is an array whose size is numStreams, it is used to store all streams associated with the model running instance. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| numStreams | Input&Output | As an input, it indicates the size of the streams array.<br>As an output, it indicates the number of streams associated with the model running instance. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIGetTasksByStream"></a>

## aclmdlRIGetTasksByStream

```c
aclError aclmdlRIGetTasksByStream(aclrtStream stream, aclmdlRITask *tasks, uint32_t *numTasks)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id1716 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1716 -->
<!-- npu="A3" id1717 -->
- Atlas A3 products: Supported
<!-- end id1717 -->
<!-- npu="910b" id1718 -->
- Atlas A2 products: Supported
<!-- end id1718 -->
<!-- npu="310b" id1719 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1719 -->
<!-- npu="310p" id1720 -->
- Atlas inference products: Not supported
<!-- end id1720 -->
<!-- npu="910" id1721 -->
- Atlas training products: Not supported
<!-- end id1721 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id25 -->

### Function

Obtains all tasks in a specified stream.

Before calling this API, call [aclmdlRIGetStreams](#aclmdlRIGetStreams) to obtain all streams associated with the model running instance, and then obtain all tasks in the specified stream.

All tasks in a specified stream can be obtained by calling this API twice:

1. First call: Pass a null pointer to the tasks parameter and any non-negative integer to numTasks, and call aclmdlRIGetTasksByStream to obtain the number of all tasks in the specified stream, which is returned through numTasks.
2. Second call: Allocate an array for tasks with a size equal to the numTasks obtained in the previous step, and then pass tasks and numTasks as inputs to aclmdlRIGetTasksByStream to obtain all tasks in the specified stream.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specified stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>A stream associated with the model running instance must be passed. |
| tasks | Input&Output | If a null pointer is passed to tasks, the number of all tasks in the specified stream is obtained and returned through the numTasks parameter.<br>If tasks is an array whose size is numTasks, it is used to store all tasks in the specified stream. For the type definition, see [aclmdlRITask](25-05_Typedefs.md#aclmdlRITask). |
| numTasks | Input&Output | As an input, indicates the size of the tasks array.<br>As an output, indicates the number of all tasks in the specified stream. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRITaskGetSeqId"></a>

## aclmdlRITaskGetSeqId

```c
aclError aclmdlRITaskGetSeqId(aclmdlRITask task, uint32_t *id)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id771 -->
- Ascend 950PR&950DT products: Supported
<!-- end id771 -->
<!-- npu="A3" id772 -->
- Atlas A3 products: Supported
<!-- end id772 -->
<!-- npu="910b" id773 -->
- Atlas A2 products: Supported
<!-- end id773 -->
<!-- npu="310b" id774 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id774 -->
<!-- npu="310p" id775 -->
- Atlas inference products: Not supported
<!-- end id775 -->
<!-- npu="910" id776 -->
- Atlas training products: Not supported
<!-- end id776 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id26 -->

### Function

Obtains the sequence ID of a task.

Before calling this API, call [aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream) to obtain all tasks in the specified stream, and then obtain the sequence ID of the specified task.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| task | Input | Specified task. For the type definition, see [aclmdlRITask](25-05_Typedefs.md#aclmdlRITask). |
| id | Output | Task sequence ID. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

For the same model running instance, this API does not support concurrent calls.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRITaskGetParams"></a>

## aclmdlRITaskGetParams

```c
aclError aclmdlRITaskGetParams(aclmdlRITask task, aclmdlRITaskParams* params)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id2360 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2360 -->
<!-- npu="A3" id2361 -->
- Atlas A3 products: Supported
<!-- end id2361 -->
<!-- npu="910b" id2362 -->
- Atlas A2 products: Supported
<!-- end id2362 -->
<!-- npu="310b" id2363 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2363 -->
<!-- npu="310p" id2364 -->
- Atlas inference products: Not supported
<!-- end id2364 -->
<!-- npu="910" id2365 -->
- Atlas training products: Not supported
<!-- end id2365 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id27 -->

### Function

Obtains the parameter information of a task.

Before calling this API, call [aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream) to obtain all tasks in the specified stream, and then obtain the parameter information of the specified task.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| task | Input | Specified task. For the type definition, see [aclmdlRITask](25-05_Typedefs.md#aclmdlRITask). |
| params | Output | Parameter information. See [aclmdlRITaskParams](25-04_Structs.md#aclmdlRITaskParams) for the type definition. <br>The memory pointed to by any pointer returned in params is associated with the current task and is managed by Runtime. The caller must not modify or release it. This memory remains valid until the task is destroyed. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

For the same model running instance, this API does not support concurrent calls.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRITaskSetParams"></a>

## aclmdlRITaskSetParams

```c
aclError aclmdlRITaskSetParams(aclmdlRITask task, aclmdlRITaskParams* params)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id148 -->
- Ascend 950PR&950DT products: Supported
<!-- end id148 -->
<!-- npu="A3" id149 -->
- Atlas A3 products: Supported
<!-- end id149 -->
<!-- npu="910b" id150 -->
- Atlas A2 products: Supported
<!-- end id150 -->
<!-- npu="310b" id151 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id151 -->
<!-- npu="310p" id152 -->
- Atlas inference products: Not supported
<!-- end id152 -->
<!-- npu="910" id153 -->
- Atlas training products: Not supported
<!-- end id153 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id28 -->

### Function

Sets the parameter information of a task.

Before calling this API, use [aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream) to obtain all tasks in the specified stream, and then use [aclmdlRITaskGetParams](#aclmdlRITaskGetParams) to obtain the parameter information of the specified task. If the parameter information needs to be updated, call aclmdlRITaskSetParams.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| task | Input | Specified task. For the type definition, see [aclmdlRITask](25-05_Typedefs.md#aclmdlRITask). |
| params | Input | Parameter information. See [aclmdlRITaskParams](25-04_Structs.md#aclmdlRITaskParams) for the type definition.<br>params is a tagged union data structure. The task type must be specified through the type field, and the type-related parameters must be filled in the corresponding union member. All unused bytes (including reserved fields such as rsv0, rsv1, and rsv2, as well as all bytes beyond the used union member) may be enabled in the future and therefore must be set to 0. It is recommended to use brace initialization or memset to ensure that all bytes are correctly initialized. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- For the same model running instance, this API does not support concurrent calls.
- When updating task parameter information, you must ensure that the dependency relationships among tasks in the modified model running instance are correct; otherwise, subsequent services may become abnormal, for example, model execution may fail.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIKernelTaskGetAttribute"></a>

## aclmdlRIKernelTaskGetAttribute

```c
aclError aclmdlRIKernelTaskGetAttribute(aclmdlRITask task, aclrtLaunchKernelAttrId attrId, aclrtLaunchKernelAttrValue *attrValue)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id1016 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1016 -->
<!-- npu="A3" id1017 -->
- Atlas A3 products: Supported
<!-- end id1017 -->
<!-- npu="910b" id1018 -->
- Atlas A2 products: Supported
<!-- end id1018 -->
<!-- npu="310b" id1019 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1019 -->
<!-- npu="310p" id1020 -->
- Atlas inference products: Not supported
<!-- end id1020 -->
<!-- npu="910" id1021 -->
- Atlas training products: Not supported
<!-- end id1021 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id29 -->

### Function

Queries the attribute configuration of a compute task on the Cube Core or Vector Core.

Before calling this API, use [aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream) to obtain all tasks in the specified stream, then use [aclmdlRITaskGetType](#aclmdlRITaskGetType) to confirm that the current task is a compute task on the Cube Core or Vector Core, and then call this API to query the specific attribute configuration.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| task | Input | Specified task. For the type definition, see [aclmdlRITask](25-05_Typedefs.md#aclmdlRITask). |
| attrId | Input | ID of the attribute to query. See [aclrtLaunchKernelAttrId](25-02_Enumerations.md#aclrtLaunchKernelAttrId) for the type definition.<br>The following attributes are not supported for query:<br>ACL_RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE (operator execution engine);<br>ACL_RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET (numBlocks offset);<br>ACL_RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH (whether to prevent the hardware from prefetching the information of this task when the task is dispatched). |
| attrValue | Output | Attribute value obtained by the query. See [aclrtLaunchKernelAttrValue](25-04_Structs.md#aclrtLaunchKernelAttrValue) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

For the same model running instance, this API does not support concurrent calls.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRITaskDisable"></a>

## aclmdlRITaskDisable

```c
aclError aclmdlRITaskDisable(aclmdlRITask task)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id505 -->
- Ascend 950PR&950DT products: Supported
<!-- end id505 -->
<!-- npu="A3" id506 -->
- Atlas A3 products: Supported
<!-- end id506 -->
<!-- npu="910b" id507 -->
- Atlas A2 products: Supported
<!-- end id507 -->
<!-- npu="310b" id508 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id508 -->
<!-- npu="310p" id509 -->
- Atlas inference products: Not supported
<!-- end id509 -->
<!-- npu="910" id510 -->
- Atlas training products: Not supported
<!-- end id510 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id30 -->

### Function

Sets a specified task to the disable state, indicating that the task no longer participates in scheduling.

Before calling this API, call [aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream) to obtain all tasks in the specified stream. After calling this API, call [aclmdlRIUpdate](#aclmdlRIUpdate) to update the model.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| task | Input | Specified task. For the type definition, see [aclmdlRITask](25-05_Typedefs.md#aclmdlRITask). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

For the same model running instance, this API does not support concurrent calls.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIUpdate"></a>

## aclmdlRIUpdate

```c
aclError aclmdlRIUpdate(aclmdlRI modelRI)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id1184 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1184 -->
<!-- npu="A3" id1185 -->
- Atlas A3 products: Supported
<!-- end id1185 -->
<!-- npu="910b" id1186 -->
- Atlas A2 products: Supported
<!-- end id1186 -->
<!-- npu="310b" id1187 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1187 -->
<!-- npu="310p" id1188 -->
- Atlas inference products: Not supported
<!-- end id1188 -->
<!-- npu="910" id1189 -->
- Atlas training products: Not supported
<!-- end id1189 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id31 -->

### Function

Updates the specified model.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Specifies the model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Because Profiling does not support dynamically updating the reported operator parameters during model execution, all parameters must be updated before the model is executed for the first time if Profiling data needs to be analyzed.

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRITaskGetType"></a>

## aclmdlRITaskGetType

```c
aclError aclmdlRITaskGetType(aclmdlRITask task, aclmdlRITaskType *type)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id1219 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1219 -->
<!-- npu="A3" id1220 -->
- Atlas A3 products: Supported
<!-- end id1220 -->
<!-- npu="910b" id1221 -->
- Atlas A2 products: Supported
<!-- end id1221 -->
<!-- npu="310b" id1222 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1222 -->
<!-- npu="310p" id1223 -->
- Atlas inference products: Not supported
<!-- end id1223 -->
<!-- npu="910" id1224 -->
- Atlas training products: Not supported
<!-- end id1224 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id32 -->

### Function

Obtains the task type.

Before calling this API, call [aclmdlRIGetTasksByStream](#aclmdlRIGetTasksByStream) to obtain all tasks in the specified stream, and then obtain the type of the specified task.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| task | Input | Specified task. For the type definition, see [aclmdlRITask](25-05_Typedefs.md#aclmdlRITask). |
| type | Output | Task type. See [aclmdlRITaskType](25-02_Enumerations.md#aclmdlRITaskType) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIDestroyRegisterCallback"></a>

## aclmdlRIDestroyRegisterCallback

```c
aclError aclmdlRIDestroyRegisterCallback(aclmdlRI modelRI, aclrtCallback func, void *userData)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id1870 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1870 -->
<!-- npu="A3" id1871 -->
- Atlas A3 products: Supported
<!-- end id1871 -->
<!-- npu="910b" id1872 -->
- Atlas A2 products: Supported
<!-- end id1872 -->
<!-- npu="310b" id1873 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1873 -->
<!-- npu="310p" id1874 -->
- Atlas inference products: Supported
<!-- end id1874 -->
<!-- npu="910" id1875 -->
- Atlas training products: Supported
<!-- end id1875 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id33 -->

### Function

Registers a callback function that is invoked when the model running instance is destroyed.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |
| func | Input | Callback function.<br>The prototype of the callback function is as follows:<br>typedef void (*aclrtCallback)(void*userData); |
| userData | Input | Pointer to the user data to be passed to the callback function.<br>Can be NULL, indicating that no additional data needs to be passed. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIDestroyUnregisterCallback"></a>

## aclmdlRIDestroyUnregisterCallback

```c
aclError aclmdlRIDestroyUnregisterCallback(aclmdlRI modelRI, aclrtCallback func)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id2878 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2878 -->
<!-- npu="A3" id2879 -->
- Atlas A3 products: Supported
<!-- end id2879 -->
<!-- npu="910b" id2880 -->
- Atlas A2 products: Supported
<!-- end id2880 -->
<!-- npu="310b" id2881 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2881 -->
<!-- npu="310p" id2882 -->
- Atlas inference products: Supported
<!-- end id2882 -->
<!-- npu="910" id2883 -->
- Atlas training products: Supported
<!-- end id2883 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id34 -->

### Function

Cancels the callback function registered through the [aclmdlRIDestroyRegisterCallback](#aclmdlRIDestroyRegisterCallback) API. After cancellation, the callback function is no longer invoked when the model running instance is destroyed.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |
| func | Input | Callback function.<br>The prototype of the callback function is as follows:<br>typedef void (*aclrtCallback)(void*userData); |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICondHandleCreate"></a>

## aclmdlRICondHandleCreate

```c
aclError aclmdlRICondHandleCreate(aclmdlRI modelRI, uint32_t defaultLaunchValue, aclmdlRICondHandleFlag flag, aclmdlRICondHandle *handle)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id134 -->
- Ascend 950PR&950DT products: Supported
<!-- end id134 -->
<!-- npu="A3" id135 -->
- Atlas A3 products: Supported
<!-- end id135 -->
<!-- npu="910b" id136 -->
- Atlas A2 products: Supported
<!-- end id136 -->
<!-- npu="310b" id137 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id137 -->
<!-- npu="310p" id138 -->
- Atlas inference products: Not supported
<!-- end id138 -->
<!-- npu="910" id139 -->
- Atlas training products: Not supported
<!-- end id139 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id35 -->

### Function

Creates a condition handle.

When flag is set to ACL\_MODEL\_RI\_COND\_HANDLE\_ASSIGN\_DEFAULT, the condition variable is initialized to the value of defaultLaunchValue at the start of each model execution.

### Parameters

| Parameter | Input/Output | Description |
| --- | --- | --- |
| modelRI | Input | Model running instance used to create the condition handle. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |
| defaultLaunchValue | Input | Initial value of the condition variable. |
| flag | Input | Condition handle flag. See [aclmdlRICondHandleFlag](25-02_Enumerations.md#aclmdlRICondHandleFlag) for the type definition.<br>Currently, only the following values are supported:<br><br>  - ACL_MODEL_RI_COND_HANDLE_ASSIGN_DEFAULT: The condition variable is initialized to the value of defaultLaunchValue before each model execution starts.<br>  - 0: The condition variable is not initialized to the value of defaultLaunchValue before model execution starts. Instead, you manage the condition variable value. In this case, call aclmdlRICondHandleGetCondPtr to obtain the Device memory address pointer that stores the condition variable value, and then write the condition variable value to that Device memory. |
| handle | Output | Condition handle. See [aclmdlRICondHandle](25-05_Typedefs.md#aclmdlRICondHandle) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICondHandleGetCondPtr"></a>

## aclmdlRICondHandleGetCondPtr

```c
aclError aclmdlRICondHandleGetCondPtr(aclmdlRICondHandle handle, uint64_t **ptr)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id736 -->
- Ascend 950PR&950DT products: Supported
<!-- end id736 -->
<!-- npu="A3" id737 -->
- Atlas A3 products: Supported
<!-- end id737 -->
<!-- npu="910b" id738 -->
- Atlas A2 products: Supported
<!-- end id738 -->
<!-- npu="310b" id739 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id739 -->
<!-- npu="310p" id740 -->
- Atlas inference products: Not supported
<!-- end id740 -->
<!-- npu="910" id741 -->
- Atlas training products: Not supported
<!-- end id741 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id36 -->

### Function

Obtains the Device memory address pointer where the Runtime internally stores the condition variable value.

To manage the condition value by yourself, call this API to obtain the pointer and write the condition value to the Device memory.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| handle | Input | Condition handle. See [aclmdlRICondHandle](25-05_Typedefs.md#aclmdlRICondHandle) for the type definition. |
| ptr | Output | Device memory address pointer used to store the condition value.<br>The memory is 8 bytes in size and does not need to be released by you. It is automatically released by Runtime when the modelRI is destroyed or the application process exits. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRIAddCondTask"></a>

## aclmdlRIAddCondTask

```c
aclError aclmdlRIAddCondTask(aclmdlRICondTaskParams params, aclrtStream stream, uint32_t flags)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id2689 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2689 -->
<!-- npu="A3" id2690 -->
- Atlas A3 products: Supported
<!-- end id2690 -->
<!-- npu="910b" id2691 -->
- Atlas A2 products: Supported
<!-- end id2691 -->
<!-- npu="310b" id2692 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2692 -->
<!-- npu="310p" id2693 -->
- Atlas inference products: Not supported
<!-- end id2693 -->
<!-- npu="910" id2694 -->
- Atlas training products: Not supported
<!-- end id2694 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id37 -->

### Function

Adds a conditional task to a stream.

The conditional task parameters include the condition handle (condition value, default value, and so on), condition type, number of branches, subgraph, and other information. The stream on which the conditional task is executed must be in the capture state.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| params | Input | Condition task parameters, including the condition handle, condition type, number of branches, subgraph, and other information. For the type definition, see [aclmdlRICondTaskParams](25-04_Structs.md#aclmdlRICondTaskParams). Before calling this API, call [aclmdlRICondHandleCreate](#aclmdlRICondHandleCreate) to create the condition handle. |
| stream | Input | Stream on which the conditional task is executed. This stream must be in the capture state. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| flags | Input | Reserved parameter. It is fixed to 0. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclmdlRICaptureToModelRIBegin"></a>

## aclmdlRICaptureToModelRIBegin

```c
aclError aclmdlRICaptureToModelRIBegin(aclrtStream stream, aclmdlRI modelRI, aclmdlRICaptureMode mode)
```

**Note: This API is an experimental feature and may change in later versions. It is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id3312 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3312 -->
<!-- npu="A3" id3313 -->
- Atlas A3 products: Supported
<!-- end id3313 -->
<!-- npu="910b" id3314 -->
- Atlas A2 products: Supported
<!-- end id3314 -->
<!-- npu="310b" id3315 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3315 -->
<!-- npu="310p" id3316 -->
- Atlas inference products: Not supported
<!-- end id3316 -->
<!-- npu="910" id3317 -->
- Atlas training products: Not supported
<!-- end id3317 -->
<!-- @ref: runtime/res/docs/zh/api_ref/15_model_running_instance_management_res.md#id38 -->

### Function

Starts capturing tasks dispatched on the stream into the specified model running instance.

Between aclmdlRICaptureToModelRIBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd), tasks dispatched on the specified stream are not executed immediately. Instead, they are temporarily stored in the system's internal model running instance. These tasks are actually executed only when the root model calls [aclmdlRIExecuteAsync](#aclmdlRIExecuteAsync) to execute the model, thereby reducing the task dispatch overhead on the Host side. This model running instance does not support aclmdlRIDestroy.

aclmdlRICaptureToModelRIBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) must be used in pairs, and the stream in the two APIs must be the same. Between these two APIs, you can call [aclmdlRICaptureGetInfo](#aclmdlRICaptureGetInfo) to obtain capture information, and call [aclmdlRICaptureThreadExchangeMode](#aclmdlRICaptureThreadExchangeMode) to switch the capture mode of the current thread. In addition, after calling [aclmdlRICaptureEnd](#aclmdlRICaptureEnd), you can also call [aclmdlRIDebugPrint](#aclmdlRIDebugPrint) to print model information, which helps locate issues in maintenance and test scenarios.

For tasks captured between aclmdlRICaptureToModelRIBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd), to update a task (including the task itself and its parameter information), you must dispatch the tasks that may be updated later between [aclmdlRICaptureTaskGrpBegin](#aclmdlRICaptureTaskGrpBegin) and [aclmdlRICaptureTaskGrpEnd](#aclmdlRICaptureTaskGrpEnd) to mark the tasks with a task group, and then update the input information of the tasks between [aclmdlRICaptureTaskUpdateBegin](#aclmdlRICaptureTaskUpdateBegin) and [aclmdlRICaptureTaskUpdateEnd](#aclmdlRICaptureTaskUpdateEnd).

Tasks captured between aclmdlRICaptureToModelRIBegin and [aclmdlRICaptureEnd](#aclmdlRICaptureEnd) are temporarily stored in the system's internal model running instance. As the number of tasks increases, and through Event derivation and operations on internal tasks, more streams enter the capture state, and stream resources are continuously consumed. This may eventually lead to insufficient concurrent scheduling resources. Therefore, plan the use of scheduling resources in advance.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Specifies the stream. For the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| modelRI | Input | Model running instance. See [aclmdlRI](25-05_Typedefs.md#aclmdlRI) for the type definition. |
| mode | Input |  Capture mode, which limits the scope of non-secure functions (including aclrtMemset, aclrtMemcpy, aclrtMemcpy2d, and APIs that perform asynchronous memory copy operations using non-Host pinned memory, such as aclrtMemcpyAsync).<br>For the type definition, see [aclmdlRICaptureMode](25-02_Enumerations.md#aclmdlRICaptureMode). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).
