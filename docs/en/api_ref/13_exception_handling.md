# 13. Exception Handling

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-26T12:36:32.612Z pushedAt=2026-10-28T07:52:06.876Z -->

This topic describes the exception handling APIs of CANN Runtime, including error information obtaining, exception callback registration, memory UCE repair, and task abort.

- [`const char *aclGetRecentErrMsg()`](#aclGetRecentErrMsg): Obtains and clears the error description information generated when other acl APIs in the same process or thread as this API fail to be called.
- [`aclError aclrtSetExceptionInfoCallback(aclrtExceptionInfoCallback callback)`](#aclrtSetExceptionInfoCallback): Sets a process-level exception callback function. If the exception callback function is set multiple times, the last setting takes effect. (Deprecated API. Use the [`aclrtExceptionInfoCallbackRegister`](#aclrtExceptionInfoCallbackRegister) API or the [`aclrtExceptionInfoCallbackUnregister`](#aclrtExceptionInfoCallbackUnregister) API instead.)
- [`aclError aclrtExceptionInfoCallbackRegister(aclrtExceptionInfoCallback callback)`](#aclrtExceptionInfoCallbackRegister): Registers a process-level exception callback function. You can register multiple different callback functions.
- [`aclError aclrtExceptionInfoCallbackUnregister(aclrtExceptionInfoCallback callback)`](#aclrtExceptionInfoCallbackUnregister): Unregisters the process-level exception callback function registered through the **aclrtExceptionInfoCallbackRegister** API.
- [`uint32_t aclrtGetTaskIdFromExceptionInfo(const aclrtExceptionInfo *info)`](#aclrtGetTaskIdFromExceptionInfo): Obtains the task ID from the exception information.
- [`uint32_t aclrtGetStreamIdFromExceptionInfo(const aclrtExceptionInfo *info)`](#aclrtGetStreamIdFromExceptionInfo): Obtains the stream ID from the exception information.
- [`uint32_t aclrtGetThreadIdFromExceptionInfo(const aclrtExceptionInfo *info)`](#aclrtGetThreadIdFromExceptionInfo): Obtains the thread ID from the exception information.
- [`uint32_t aclrtGetDeviceIdFromExceptionInfo(const aclrtExceptionInfo *info)`](#aclrtGetDeviceIdFromExceptionInfo): Obtains the device ID from the exception information.
- [`uint32_t aclrtGetErrorCodeFromExceptionInfo(const aclrtExceptionInfo *info)`](#aclrtGetErrorCodeFromExceptionInfo): Obtains the error code from the exception information.
- [`aclError aclrtPeekAtLastError(aclrtLastErrLevel level)`](#aclrtPeekAtLastError): Obtains the Runtime (runtime management module) error code of the current thread, only obtaining but not clearing the error code.
- [`aclError aclrtGetLastError(aclrtLastErrLevel level)`](#aclrtGetLastError): Obtains the Runtime (runtime management module) error code of the current thread and clears the error code of the current thread after obtaining it. In this case, before a new error code is generated in the thread, calling this API returns **ACL\_SUCCESS**.
- [`aclError aclrtGetMemUceInfo(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize, size_t *retSize)`](#aclrtGetMemUceInfo): Obtains the erroneous virtual address of a memory UCE (uncorrectable error, which refers to a memory error that the system hardware cannot directly handle and rectify).
- [`aclError aclrtMemUceRepair(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize)`](#aclrtMemUceRepair): Repairs the erroneous virtual address of a memory UCE.
- [`aclError aclrtDeviceTaskAbort(int32_t deviceId, uint32_t timeout)`](#aclrtDeviceTaskAbort): Aborts the task being executed on the specified device and discards the task already dispatched to the specified device.
- [`aclError aclrtGetErrorVerbose(int32_t deviceId, aclrtErrorInfo *errorInfo);`](#aclrtGetErrorVerbose): Obtains detailed error information after a device fault occurs. This API must be called after the fault event is obtained and before task abort is submitted.
- [`aclError aclrtRepairError(int32_t deviceId, const aclrtErrorInfo *errorInfo)`](#aclrtRepairError): Performs fault rectification based on the detailed information obtained by the [aclrtGetErrorVerbose](#aclrtGetErrorVerbose) API. This API should be called after task abort is submitted.
- [`aclError aclrtSetDeviceTaskAbortCallback(const char *regName, aclrtDeviceTaskAbortCallback callback, void *args)`](#aclrtSetDeviceTaskAbortCallback): Registers a callback function, which is triggered before and after the [aclrtDeviceTaskAbort](#aclrtDeviceTaskAbort) API is called.

<a class="method_anchor" id="aclGetRecentErrMsg"></a>

## aclGetRecentErrMsg

```c
const char *aclGetRecentErrMsg()
```

### Applicable Products

<!-- npu="950" id113 -->
- Ascend 950PR&950DT products: Supported
<!-- end id113 -->
<!-- npu="A3" id114 -->
- Atlas A3 products: Supported
<!-- end id114 -->
<!-- npu="910b" id115 -->
- Atlas A2 products: Supported
<!-- end id115 -->
<!-- npu="310b" id116 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id116 -->
<!-- npu="310p" id117 -->
- Atlas inference products: Supported
<!-- end id117 -->
<!-- npu="910" id118 -->
- Atlas training products: Supported
<!-- end id118 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id1 -->

### Description

Obtains and clears the error description information generated when other acl APIs in the same process or thread as this API fail to be called.

Whether the process-level or thread-level error description information is obtained is controlled by **err\_msg\_mode** in the [aclInit](02_initialization_and_deinitialization.md#aclInit) API, and the thread level is used by default.

It is recommended that you call **aclGetRecentErrMsg** each time an acl API call fails, so as to obtain the error description information generated when the acl API call is abnormal and use it to locate the problem. Otherwise, error information may accumulate or be lost. After **aclGetRecentErrMsg** is called multiple times in the same process or thread, only the pointer to the error description string returned by the last call to **aclGetRecentErrMsg** is valid. The pointers to the error description strings returned by previous calls to **aclGetRecentErrMsg** cannot be used; otherwise, illegal memory access may occur.

### Parameters

None

### Return Values

Returns the pointer to the error description string. If multiple pieces of error description information are obtained through this API, the topmost piece of error description information is the latest one.

Returns **nullptr** when the error description information fails to be obtained.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetExceptionInfoCallback"></a>

## aclrtSetExceptionInfoCallback (Deprecated)

```c
aclError aclrtSetExceptionInfoCallback(aclrtExceptionInfoCallback callback)
```

**Caution: This API is deprecated. Use the [`aclrtExceptionInfoCallbackRegister`](#aclrtExceptionInfoCallbackRegister) API or the [`aclrtExceptionInfoCallbackUnregister`](#aclrtExceptionInfoCallbackUnregister) API instead.**

### Applicable Products

<!-- npu="950" id1877 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1877 -->
<!-- npu="A3" id1878 -->
- Atlas A3 products: Supported
<!-- end id1878 -->
<!-- npu="910b" id1879 -->
- Atlas A2 products: Supported
<!-- end id1879 -->
<!-- npu="310b" id1880 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1880 -->
<!-- npu="310p" id1881 -->
- Atlas inference products: Supported
<!-- end id1881 -->
<!-- npu="910" id1882 -->
- Atlas training products: Supported
<!-- end id1882 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id2 -->

### Description

Sets a process-level exception callback function. To clear the callback function, call this API with the input parameter set to a null pointer.
If this API is called multiple times to set the exception callback function, the last setting takes effect. This does not affect the exception callback function registered through the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| callback | Input | Callback function to be registered.<br>The function prototype of the callback function is as follows:<br>typedef void (*aclrtExceptionInfoCallback)(aclrtExceptionInfo*exceptionInfo); |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- The callback function involves shared resources (for example, locks). Therefore, use the callback function with caution. Calling APIs for resource application and release, stream synchronization, device synchronization, task dispatch, and task termination within the callback function may cause errors or deadlocks.
- You need to set the exception callback function before executing asynchronous tasks. When a task on the device executes abnormally, the system will pass a pointer to an **aclrtExceptionInfo** struct containing the task ID, stream ID, thread ID, device ID, and error code to the exception callback function set by the user, and execute the callback function. The user can then call the [aclrtGetTaskIdFromExceptionInfo](#aclrtGetTaskIdFromExceptionInfo), [aclrtGetStreamIdFromExceptionInfo](#aclrtGetStreamIdFromExceptionInfo), [aclrtGetThreadIdFromExceptionInfo](#aclrtGetThreadIdFromExceptionInfo), [aclrtGetDeviceIdFromExceptionInfo](#aclrtGetDeviceIdFromExceptionInfo), and [aclrtGetErrorCodeFromExceptionInfo](#aclrtGetErrorCodeFromExceptionInfo) APIs to obtain the task ID, stream ID, thread ID,device ID, and error code of the exception, which facilitates problem locating.

    **Usage scenario example**: For example, before calling the **aclopExecuteV2** API, call the **aclrtSetExceptionInfoCallback** API to set the exception callback function. When an operator executes abnormally on the device, the system will pass a pointer to an **aclrtExceptionInfo** struct containing the task ID, stream ID, thread ID, device ID, and error code to the exception callback function set by the user, and execute the callback function.
- `exceptionInfo` is managed by Runtime and is valid only during the execution of this callback. The callback function must not save, release, or modify this pointer or its contents.

### API Call Flow

**Usage scenario example**: When performing whole-network model inference (**dynamic shape scenarios are not supported**), if an AI Core error occurs, you can obtain the description information of the operator that reported the error by following the content in this topic, and then perform further error troubleshooting.

**The recommended API call sequence is as follows:**

1. Define and implement the exception callback function **fn\(aclrtExceptionInfoCallback type \)**.

    The key logic for implementing the callback function is as follows:

    1. In the exception callback function **fn**, call **aclrtGetDeviceIdFromExceptionInfo**, **aclrtGetStreamIdFromExceptionInfo**, and **aclrtGetTaskIdFromExceptionInfo** to obtain the device ID, stream ID, and task ID, respectively.
    2. In the exception callback function **fn**, call **aclmdlCreateAndGetOpDesc** to obtain the description information of the operator.
    3. In the exception callback function **fn**, call **aclGetTensorDescByIndex** to obtain the tensor description of the input/output of the specified operator.
    4. In the exception callback function **fn**, call the following APIs to obtain the data in the tensor description for further analysis.

        For example, call **aclGetTensorDescAddress** to obtain the memory address of the tensor data (from which the user can obtain the tensor data), call **aclGetTensorDescType** to obtain the data type in the tensor description, call **aclGetTensorDescFormat** to obtain the format in the tensor description, call **aclGetTensorDescNumDims** to obtain the number of shape dimensions in the tensor description, and call **aclGetTensorDescDimV2** to obtain the size of the specified dimension in the shape.

2. Call the **aclrtSetExceptionInfoCallback** API to set the exception callback function.
3. Execute model inference.

    If an AI Core error occurs, the callback function **fn** is triggered to obtain the operator information for further analysis.

### Examples

The following is a code example of the key steps for obtaining AI Core exception information. It cannot be directly copied, compiled, and run, and is for reference only. After calling the interface, you need to add branches for exception handling and record error logs and prompt logs, which are not listed one by one here.

```cpp
......

// 1. Load the model. After the model is loaded successfully, the modelId that identifies the model is returned.

// 2. Create data of the aclmdlDataset type to describe the input data and output data of the model.

// 3. Implement the exception callback function.
void callback(aclrtExceptionInfo *exceptionInfo)
{
    deviceId = aclrtGetDeviceIdFromExceptionInfo(exceptionInfo);
    streamId = aclrtGetStreamIdFromExceptionInfo(exceptionInfo);
    taskId = aclrtGetTaskIdFromExceptionInfo(exceptionInfo);
    
    char opName[256];
    aclTensorDesc *inputDesc = nullptr;
    aclTensorDesc *outputDesc = nullptr;
    size_t inputCnt = 0;
    size_t outputCnt = 0; 
    // The user can write the obtained operator information to a file, or start another thread so that the thread processing function is triggered when an exception callback occurs, and the operator information is displayed on the screen in the thread processing function. 
    aclmdlCreateAndGetOpDesc(deviceId, streamId, taskId, opName, 256,  &inputDesc, &inputCnt, &outputDesc, &outputCnt);
    // You can call the tensor-related APIs to obtain the operator-related information as needed.
    for (size_t i = 0; i < inputCnt; ++i) {
        const aclTensorDesc *desc = aclGetTensorDescByIndex(inputDesc, i);
        aclGetTensorDescAddress(desc);
        aclGetTensorDescFormat(desc);
    }
    for (size_t i = 0; i < outputCnt; ++i) {
        const aclTensorDesc *desc = aclGetTensorDescByIndex(outputDesc, i);
        aclGetTensorDescAddress(desc);
        aclGetTensorDescFormat(desc);
    }
    aclDestroyTensorDesc(inputDesc);
    aclDestroyTensorDesc(outputDesc);
}

// 4. Set the exception callback.
aclrtSetExceptionInfoCallback(callback);

// 5. Execute the model.
aclmdlExecute(modelId, input, output);

// 6. Process the model inference result.
......

// 7. Release the resources such as model input/output description information and memory, and unload the model.
......
```

<br>
<br>
<br>

<a class="method_anchor" id="aclrtExceptionInfoCallbackRegister"></a>

## aclrtExceptionInfoCallbackRegister

```c
aclError aclrtExceptionInfoCallbackRegister(aclrtExceptionInfoCallback callback)
```

### Applicable Products

<!-- npu="950" id36 -->
- Ascend 950PR&950DT products: Supported
<!-- end id36 -->
<!-- npu="A3" id37 -->
- Atlas A3 products: Supported
<!-- end id37 -->
<!-- npu="910b" id38 -->
- Atlas A2 products: Supported
<!-- end id38 -->
<!-- npu="310b" id39 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id39 -->
<!-- npu="310p" id40 -->
- Atlas inference products: Supported
<!-- end id40 -->
<!-- npu="910" id41 -->
- Atlas training products: Supported
<!-- end id41 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id16 -->

### Description

Registers a process-level exception callback function. This API can be used to register multiple exception callback functions with different function pointer values. If the function pointers in the **callback** parameter are different, the exception callback functions are considered different. Repeatedly calling this API to register the same callback function returns success, but Runtime retains only the last registration information.

The exception callback function registered through this API can coexist with the callback function set through the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API. When a device task execution exception occurs and the task enters the Runtime exception notification flow, the system notifies the exception information to the exception callback function registered through this API or the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API.

When the same callback function is both set through the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API and registered through this API, Runtime saves them as two mutually independent registration entries. The callback function is called twice in this notification, and the order of the two calls is not guaranteed.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| callback | Input | Callback function to be registered, which cannot be **NULL**.<br>The function prototype of the callback function is:<br>typedef void (*aclrtExceptionInfoCallback)(aclrtExceptionInfo*exceptionInfo); |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError). If the input parameter is NULL, a parameter error is returned.

### Constraints

- The callback function involves shared resources (for example, locks). Therefore, use the callback function with caution. Calling APIs such as resource application and release, stream synchronization, device synchronization, task dispatch, and task termination within the callback function may cause errors or deadlocks.
- To ensure that the exception notification of a task is received, you need to complete the registration of the exception callback function before executing the asynchronous task. When a task on the device encounters an execution exception, the system sends a pointer to an **aclrtExceptionInfo** struct containing the task ID, stream ID, thread ID, device ID, and error code to the exception callback function registered by the user, and executes the callback function. The user can then call the [aclrtGetTaskIdFromExceptionInfo](#aclrtGetTaskIdFromExceptionInfo), [aclrtGetStreamIdFromExceptionInfo](#aclrtGetStreamIdFromExceptionInfo), [aclrtGetThreadIdFromExceptionInfo](#aclrtGetThreadIdFromExceptionInfo), [aclrtGetDeviceIdFromExceptionInfo](#aclrtGetDeviceIdFromExceptionInfo), and [aclrtGetErrorCodeFromExceptionInfo](#aclrtGetErrorCodeFromExceptionInfo) APIs respectively to obtain the task ID, stream ID, thread ID, device ID, and error code of the task that generated the exception, which facilitates problem locating.

    **Usage scenario example**: For example, before calling the **aclopExecuteV2** API, call the **aclrtExceptionInfoCallbackRegister** API to register the exception callback function. When an operator encounters an execution exception on the device, the system sends a pointer to an **aclrtExceptionInfo** struct containing the task ID, stream ID, thread ID, device ID, and error code to the exception callback function set by the user, and executes the callback function.

- `exceptionInfo` is managed by Runtime and is valid only during the execution of this callback. The callback function must not save, release, or modify this pointer or its content.
- Runtime does not guarantee that the same callback function is executed in only one thread. Different exception notifications may invoke the same callback function concurrently in different threads, and the callback function must ensure thread safety for the data it accesses.
- Runtime does not provide exception isolation between callback functions. If any callback function throws an exception, the current notification may be interrupted, causing the remaining callback functions that have not yet been executed to no longer be invoked, and potentially interrupting subsequent exception handling by Runtime.

### API Call Flow

**Usage scenario example**: When performing whole-network model inference (**dynamic shape scenarios are not supported**), if an AI Core error occurs, you can obtain the description information of the operator that reported the error by following the content in this topic, and then perform further error troubleshooting.

**The recommended API call sequence is as follows:**

1. Define and implement the exception callback function **fn\(aclrtExceptionInfoCallback type \)**.

    The key logic for implementing the callback function is as follows:

    1. In the exception callback function **fn**, call **aclrtGetDeviceIdFromExceptionInfo**, **aclrtGetStreamIdFromExceptionInfo**, and **aclrtGetTaskIdFromExceptionInfo** to obtain the device ID, stream ID, and task ID, respectively.
    2. In the exception callback function **fn**, call **aclmdlCreateAndGetOpDesc** to obtain the description information of the operator.
    3. In the exception callback function **fn**, call **aclGetTensorDescByIndex** to obtain the tensor description of the input/output of the specified operator.
    4. In the exception callback function **fn**, call the following APIs to obtain the data in the tensor description for further analysis.

        For example, call **aclGetTensorDescAddress** to obtain the memory address of the tensor data (the user can obtain the tensor data from this memory address), call **aclGetTensorDescType** to obtain the data type in the tensor description, call **aclGetTensorDescFormat** to obtain the format in the tensor description, call **aclGetTensorDescNumDims** to obtain the number of shape dimensions in the tensor description, and call **aclGetTensorDescDimV2** to obtain the size of the specified dimension in the shape.

2. Call **aclrtExceptionInfoCallbackRegister** to set the exception callback function.
3. Execute model inference.

    If an AI Core error occurs, the callback function **fn** is triggered to obtain the operator information for further analysis.

### Examples

The following is a code example of the key steps for obtaining AI Core exception information. It cannot be directly copied, compiled, or run, and is provided for reference only. After calling the API, you need to add branches for exception handling and record error logs and prompt logs, which are not listed one by one here.

```cpp
......

// 1. Load the model. After the model is loaded successfully, the modelId that identifies the model is returned.

// 2. Create data of the aclmdlDataset type to describe the input and output data of the model.

// 3. Implement the exception callback function.
void callback(aclrtExceptionInfo *exceptionInfo)
{
    deviceId = aclrtGetDeviceIdFromExceptionInfo(exceptionInfo);
    streamId = aclrtGetStreamIdFromExceptionInfo(exceptionInfo);
    taskId = aclrtGetTaskIdFromExceptionInfo(exceptionInfo);
    
    char opName[256];
    aclTensorDesc *inputDesc = nullptr;
    aclTensorDesc *outputDesc = nullptr;
    size_t inputCnt = 0;
    size_t outputCnt = 0; 
    // The user can write the obtained operator information to a file, or start another thread. When an exception callback occurs, trigger the thread processing function to display the operator information on the screen. 
    aclmdlCreateAndGetOpDesc(deviceId, streamId, taskId, opName, 256,  &inputDesc, &inputCnt, &outputDesc, &outputCnt);
    // You can call the tensor-related APIs to obtain the operator-related information as needed.
    for (size_t i = 0; i < inputCnt; ++i) {
        const aclTensorDesc *desc = aclGetTensorDescByIndex(inputDesc, i);
        aclGetTensorDescAddress(desc);
        aclGetTensorDescFormat(desc);
    }
    for (size_t i = 0; i < outputCnt; ++i) {
        const aclTensorDesc *desc = aclGetTensorDescByIndex(outputDesc, i);
        aclGetTensorDescAddress(desc);
        aclGetTensorDescFormat(desc);
    }
    aclDestroyTensorDesc(inputDesc);
    aclDestroyTensorDesc(outputDesc);
}

// 4. Set the exception callback.
aclrtExceptionInfoCallbackRegister(callback);

// 5. Execute the model.
aclmdlExecute(modelId, input, output);

// 6. Process the model inference result.
......

// 7. Release resources such as model input/output description information and memory, and unload the model.
......
```

<br>
<br>
<br>

<a class="method_anchor" id="aclrtExceptionInfoCallbackUnregister"></a>

## aclrtExceptionInfoCallbackUnregister

```c
aclError aclrtExceptionInfoCallbackUnregister(aclrtExceptionInfoCallback callback)
```

### Applicable Products

<!-- npu="950" id43 -->
- Ascend 950PR&950DT products: Supported
<!-- end id43 -->
<!-- npu="A3" id44 -->
- Atlas A3 products: Supported
<!-- end id44 -->
<!-- npu="910b" id45 -->
- Atlas A2 products: Supported
<!-- end id45 -->
<!-- npu="310b" id46 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id46 -->
<!-- npu="310p" id47 -->
- Atlas inference products: Supported
<!-- end id47 -->
<!-- npu="910" id48 -->
- Atlas training products: Supported
<!-- end id48 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id17 -->

### Description

Unregisters the process-level exception callback function registered through the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API. Unregistering the callback function set through the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API is not supported.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| callback | Input | Callback function to be unregistered, which cannot be **NULL**.<br> If **callback** is NULL, a parameter error is returned. When unregistering a callback that has not been registered, no operation is performed and success is returned.|

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Runtime does not record the identity of the caller that invokes this API. Any caller within the process can unregister the registration entry as long as it holds the same function pointer that has been registered.
- This API does not wait for a callback function that has already entered the exception notification flow or is currently executing to finish. After the API returns success, subsequently dispatched exception notifications no longer include this registration entry, but a callback that has already entered the notification flow may still execute.

### Examples

The following example only shows the registration and unregistration order of multiple callback functions, omitting the initialization, task dispatch, and exception handling logic.

```cpp
void callbackA(aclrtExceptionInfo *exceptionInfo)
{
    // Read and process the exception information that callbackA is concerned with.
    deviceId = aclrtGetDeviceIdFromExceptionInfo(exceptionInfo);
    streamId = aclrtGetStreamIdFromExceptionInfo(exceptionInfo);
    taskId = aclrtGetTaskIdFromExceptionInfo(exceptionInfo);
    ......
}

void callbackB(aclrtExceptionInfo *exceptionInfo)
{
    // Read and process the exception information that callbackB is concerned with.
    deviceId = aclrtGetDeviceIdFromExceptionInfo(exceptionInfo);
    streamId = aclrtGetStreamIdFromExceptionInfo(exceptionInfo);
    taskId = aclrtGetTaskIdFromExceptionInfo(exceptionInfo);
    ......
}

aclrtExceptionInfoCallbackRegister(callbackA);
aclrtExceptionInfoCallbackRegister(callbackB);

// Dispatch an asynchronous task and process the task execution result.

aclrtExceptionInfoCallbackUnregister(callbackA);
aclrtExceptionInfoCallbackUnregister(callbackB);

// The unregistration API does not wait for ongoing callbacks to finish.
// Before releasing the resources accessed by the callback functions, confirm through service synchronization that all ongoing callbacks have finished.
```

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetTaskIdFromExceptionInfo"></a>

## aclrtGetTaskIdFromExceptionInfo

```c
uint32_t aclrtGetTaskIdFromExceptionInfo(const aclrtExceptionInfo *info)
```

### Applicable Products

<!-- npu="950" id2528 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2528 -->
<!-- npu="A3" id2529 -->
- Atlas A3 products: Supported
<!-- end id2529 -->
<!-- npu="910b" id2530 -->
- Atlas A2 products: Supported
<!-- end id2530 -->
<!-- npu="310b" id2531 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2531 -->
<!-- npu="310p" id2532 -->
- Atlas inference products: Supported
<!-- end id2532 -->
<!-- npu="910" id2533 -->
- Atlas training products: Supported
<!-- end id2533 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id3 -->

### Description

Obtains the task ID from the exception information. Runtime passes an **aclrtExceptionInfo** pointer to the exception callback function. Both the process-level exception callback function set through [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) and the one registered through [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) can call this API to read this field.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer to the exception information.<br>Before task execution, call [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) or [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister). The system stores the task ID, stream ID, thread ID, and device ID of the exception in the **aclrtExceptionInfo** struct. |

### Return Values

Returns the task ID from the exception information. A return value of **0xFFFFFFFF** (in hexadecimal) indicates a device exception.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetStreamIdFromExceptionInfo"></a>

## aclrtGetStreamIdFromExceptionInfo

```c
uint32_t aclrtGetStreamIdFromExceptionInfo(const aclrtExceptionInfo *info)
```

### Applicable Products

<!-- npu="950" id3116 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3116 -->
<!-- npu="A3" id3117 -->
- Atlas A3 products: Supported
<!-- end id3117 -->
<!-- npu="910b" id3118 -->
- Atlas A2 products: Supported
<!-- end id3118 -->
<!-- npu="310b" id3119 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3119 -->
<!-- npu="310p" id3120 -->
- Atlas inference products: Supported
<!-- end id3120 -->
<!-- npu="910" id3121 -->
- Atlas training products: Supported
<!-- end id3121 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id4 -->

### Description

Obtains the stream ID from the exception information. The Runtime passes an **aclrtExceptionInfo** pointer to the exception callback function. Both the process-level exception callback function set through the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API and the one registered through the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API described in this topic can call this API to read this field.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer to the exception information.<br>Before task execution, call the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API or the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API. The system stores the task ID, stream ID, thread ID, and device ID of the task that generated the exception in the **aclrtExceptionInfo** struct. This pointer is managed by Runtime and is valid only during the current callback execution. |

### Return Values

Returns the stream ID in the exception information. A return value of **0xFFFFFFFF** (in hexadecimal) indicates a device exception.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetThreadIdFromExceptionInfo"></a>

## aclrtGetThreadIdFromExceptionInfo

```c
uint32_t aclrtGetThreadIdFromExceptionInfo(const aclrtExceptionInfo *info)
```

### Applicable Products

<!-- npu="950" id2017 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2017 -->
<!-- npu="A3" id2018 -->
- Atlas A3 products: Supported
<!-- end id2018 -->
<!-- npu="910b" id2019 -->
- Atlas A2 products: Supported
<!-- end id2019 -->
<!-- npu="310b" id2020 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2020 -->
<!-- npu="310p" id2021 -->
- Atlas inference products: Supported
<!-- end id2021 -->
<!-- npu="910" id2022 -->
- Atlas training products: Supported
<!-- end id2022 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id5 -->

### Description

Obtains the thread ID from the exception information. Runtime passes an **aclrtExceptionInfo** pointer to the exception callback function. Both the process-level exception callback function set through [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) and the one registered through [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) can call this API to read this field.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer to the exception information.<br>Before task execution, call [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) or [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister). The system stores the task ID, stream ID, thread ID, and device ID of the exception in the **aclrtExceptionInfo** struct. |

### Return Values

Returns the thread ID in the exception information. A return value of **0xFFFFFFFF** (in hexadecimal) indicates a device exception.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetDeviceIdFromExceptionInfo"></a>

## aclrtGetDeviceIdFromExceptionInfo

```c
uint32_t aclrtGetDeviceIdFromExceptionInfo(const aclrtExceptionInfo *info)
```

### Applicable Products

<!-- npu="950" id757 -->
- Ascend 950PR&950DT products: Supported
<!-- end id757 -->
<!-- npu="A3" id758 -->
- Atlas A3 products: Supported
<!-- end id758 -->
<!-- npu="910b" id759 -->
- Atlas A2 products: Supported
<!-- end id759 -->
<!-- npu="310b" id760 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id760 -->
<!-- npu="310p" id761 -->
- Atlas inference products: Supported
<!-- end id761 -->
<!-- npu="910" id762 -->
- Atlas training products: Supported
<!-- end id762 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id6 -->

### Description

Obtains the device ID from the exception information. Runtime passes an **aclrtExceptionInfo** pointer to the exception callback function. Both the process-level exception callback function set through the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API and the one registered through the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API described in this topic can call this API to read this field.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer to the exception information.<br>Before a task is executed, call the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API or the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API. The system stores the task ID, Stream ID, thread ID, and device ID of the task that generated the exception in the **aclrtExceptionInfo** struct. This pointer is managed by Runtime and is valid only during the current callback execution. |

### Return Values

Returns the device ID in the exception information. A return value of **0xFFFFFFFF** (in hexadecimal) indicates a device exception.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetErrorCodeFromExceptionInfo"></a>

## aclrtGetErrorCodeFromExceptionInfo

```c
uint32_t aclrtGetErrorCodeFromExceptionInfo(const aclrtExceptionInfo *info)
```

### Applicable Products

<!-- npu="950" id1044 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1044 -->
<!-- npu="A3" id1045 -->
- Atlas A3 products: Supported
<!-- end id1045 -->
<!-- npu="910b" id1046 -->
- Atlas A2 products: Supported
<!-- end id1046 -->
<!-- npu="310b" id1047 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1047 -->
<!-- npu="310p" id1048 -->
- Atlas inference products: Supported
<!-- end id1048 -->
<!-- npu="910" id1049 -->
- Atlas training products: Supported
<!-- end id1049 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id7 -->

### Description

Obtains the error code from the exception information. Runtime passes an **aclrtExceptionInfo** pointer to the exception callback function. Both the process-level exception callback function set through the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API and the one registered through the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API described in this topic can call this API to read this field.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| info | Input | Pointer to the exception information.<br>Before task execution, call the [aclrtSetExceptionInfoCallback (Deprecated)](#aclrtSetExceptionInfoCallback) API or the [aclrtExceptionInfoCallbackRegister](#aclrtExceptionInfoCallbackRegister) API. The system stores the task ID, stream ID, thread ID, device ID, and error code of the exception in the **aclrtExceptionInfo** struct. |

### Return Values

Returns the error code in the exception information. A return value of **0xFFFFFFFF** (in hexadecimal) indicates a device exception.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtPeekAtLastError"></a>

## aclrtPeekAtLastError

```c
aclError aclrtPeekAtLastError(aclrtLastErrLevel level)
```

### Applicable Products

<!-- npu="950" id1835 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1835 -->
<!-- npu="A3" id1836 -->
- Atlas A3 products: Supported
<!-- end id1836 -->
<!-- npu="910b" id1837 -->
- Atlas A2 products: Supported
<!-- end id1837 -->
<!-- npu="310b" id1838 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1838 -->
<!-- npu="310p" id1839 -->
- Atlas inference products: Supported
<!-- end id1839 -->
<!-- npu="910" id1840 -->
- Atlas training products: Supported
<!-- end id1840 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id8 -->

### Description

Obtains the error code of Runtime (runtime management module) for the current thread. It only obtains the error code without clearing it.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| level | Input | Level at which the error code is obtained. Currently, only the thread level is supported. For details about the type definition, see [aclrtLastErrLevel](25-02_Enumerations.md#aclrtLastErrLevel). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetLastError"></a>

## aclrtGetLastError

```c
aclError aclrtGetLastError(aclrtLastErrLevel level)
```

### Applicable Products

<!-- npu="950" id904 -->
- Ascend 950PR&950DT products: Supported
<!-- end id904 -->
<!-- npu="A3" id905 -->
- Atlas A3 products: Supported
<!-- end id905 -->
<!-- npu="910b" id906 -->
- Atlas A2 products: Supported
<!-- end id906 -->
<!-- npu="310b" id907 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id907 -->
<!-- npu="310p" id908 -->
- Atlas inference products: Supported
<!-- end id908 -->
<!-- npu="910" id909 -->
- Atlas training products: Supported
<!-- end id909 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id9 -->

### Description

Obtains the error code of Runtime (runtime management module) for the current thread, and clears the error code of the current thread after obtaining. Before a new error code is generated in the thread, calling this API returns **ACL\_SUCCESS**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| level | Input | Level at which the error code is obtained. Currently, only the thread level is supported. For details about the type definition, see [aclrtLastErrLevel](25-02_Enumerations.md#aclrtLastErrLevel). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetMemUceInfo"></a>

## aclrtGetMemUceInfo

```c
aclError aclrtGetMemUceInfo(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize, size_t *retSize)
```

**Caution: This API is an experimental feature. It may change in later versions and is not supported for use in production environments.**

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
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id11 -->

### Description

Obtains the erroneous virtual address of a memory UCE (uncorrectable error, which refers to a memory error that the system hardware cannot directly handle and rectify).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>Keep it consistent with the device ID in [aclrtSetDevice](04_device_management.md#aclrtSetDevice). |
| memUceInfoArray | Input&Output | Pointer to the **aclrtMemUceInfo** array. For details about the type definition, see [aclrtMemUceInfo](25-04_Structs.md#aclrtMemUceInfo). |
| arraySize | Input | Length of the **aclrtMemUceInfo** array passed in. |
| retSize | Output | Valid length of the **aclrtMemUceInfo** array actually returned. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemUceRepair"></a>

## aclrtMemUceRepair

```c
aclError aclrtMemUceRepair(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize)
```

**Caution: This API is an experimental feature. It may change in later versions and is not supported for use in production environments.**

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
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id12 -->

### Description

Repairs the erroneous virtual address of a memory UCE.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>Keep it consistent with the device ID in the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API. |
| memUceInfoArray | Input | Pointer to the **aclrtMemUceInfo** array. |
| arraySize | Input | Length of the **aclrtMemUceInfo** array passed in. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDeviceTaskAbort"></a>

## aclrtDeviceTaskAbort

```c
aclError aclrtDeviceTaskAbort(int32_t deviceId, uint32_t timeout)
```

**Caution: This API is an experimental feature. It may change in later versions and is not supported for use in production environments.**

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
- Atlas inference products: Not supported
<!-- end id19 -->
<!-- npu="910" id20 -->
- Atlas training products: Not supported
<!-- end id20 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id13 -->

### Description

Aborts the task that is being executed on the specified device and discards the task that have been dispatched to the specified device. This API allows you to set permanent waiting or configure a specific timeout. If a specific timeout is configured and the call to this API exceeds the timeout, the API returns an error.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>Keep it consistent with the device ID in the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API. |
| timeout | Input | Timeout.<br>The value description is as follows:<br><br>  - **0**: permanent waiting.<br>  - **>0**: specific timeout, in milliseconds. The maximum timeout is 36 minutes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The current API is supported only in the stop-on-error scenario. Otherwise, unpredictable exceptions may occur. The default mode is continue-on-error. To call this API, set the stop-on-error mode first. For details, see [aclrtSetStreamFailureMode](06_stream_management.md#aclrtSetStreamFailureMode).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetErrorVerbose"></a>

## aclrtGetErrorVerbose

```c
aclError aclrtGetErrorVerbose(int32_t deviceId, aclrtErrorInfo *errorInfo);
```

**Caution: This API is an experimental feature. It may change in later versions and is not supported for use in production environments.**

### Applicable Products

<!-- npu="950" id22 -->
- Ascend 950PR&950DT products: Supported
<!-- end id22 -->
<!-- npu="A3" id23 -->
- Atlas A3 products: Supported
<!-- end id23 -->
<!-- npu="910b" id24 -->
- Atlas A2 products: Supported
<!-- end id24 -->
<!-- npu="310b" id25 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id25 -->
<!-- npu="310p" id26 -->
- Atlas inference products: Not supported
<!-- end id26 -->
<!-- npu="910" id27 -->
- Atlas training products: Not supported
<!-- end id27 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id14 -->

### Description

Obtains detailed error information after a device fault occurs. This API must be called after the fault event is obtained and before task abort is submitted.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>Keep it consistent with the device ID in the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API. |
| errorInfo | Output | Error information.<br>typedef enum { <br>   ACL_RT_NO_ERROR = 0,  // No error.<br>   ACL_RT_ERROR_MEMORY = 1,  // Memory error.<br>   ACL_RT_ERROR_L2 = 2,  // L2 buffer error.<br>   ACL_RT_ERROR_AICORE = 3,  // AI Core error.<br>   ACL_RT_ERROR_LINK = 4,  // Network error.<br>   ACL_RT_ERROR_L3_PORT = 5,  // L3 port error.<br>   ACL_RT_ERROR_OTHERS = 0xFFFF, // Other errors.<br>} aclrtErrorType;<br><br>typedef enum aclrtAicoreErrorType { <br>   ACL_RT_AICORE_ERROR_UNKNOWN,  // Unknown error.<br>   ACL_RT_AICORE_ERROR_SW,  // Software error troubleshooting is recommended.<br>   ACL_RT_AICORE_ERROR_HW_LOCAL, // Hardware error troubleshooting on the current device is recommended.<br>} aclrtAicoreErrorType;<br><br>#define ACL_RT_MEM_UCE_INFO_MAX_NUM 20<br>typedef struct {<br>   size_t arraySize;  // Size of the **memUceInfoArray** array.<br>   [aclrtMemUceInfo](25-04_Structs.md#aclrtMemUceInfo) memUceInfoArray[ACL_RT_MEM_UCE_INFO_MAX_NUM];  // Array of erroneous virtual addresses of memory UCE.<br>} aclrtMemUceInfoArray;<br><br>typedef union aclrtErrorInfoDetail { <br>   aclrtMemUceInfoArray uceInfo;  // Memory UCE (uncorrectable error).<br>   aclrtAicoreErrorType aicoreErrType;  // AI Core error.<br>} aclrtErrorInfoDetail; <br><br>typedef struct aclrtErrorInfo { <br>   uint8_t tryRepair;  // Whether repair is required. **0** indicates no repair is required, and **1** indicates repair is required.   <br>   uint8_t hasDetail;  // Whether detailed error information is available. **0** indicates no, and **1** indicates yes.<br>   uint8_t reserved[2];  // Reserved parameter.<br>   aclrtErrorType errorType;  // Error type.<br>   aclrtErrorInfoDetail detail; // Detailed error information.<br>} aclrtErrorInfo; |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

If the shortest timeout interval obtained through the [aclrtGetOpTimeOutInterval](12_execution_control.md#aclrtGetOpTimeOutInterval) API is less than 100 ms, the detailed fault information returned by this API may be inaccurate.
For Atlas A3 products and Atlas A2 products, only **ACL_RT_NO_ERROR** (no error), **ACL_RT_ERROR_MEMORY** (memory error), and **ACL_RT_ERROR_OTHERS** (other error) are supported.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtRepairError"></a>

## aclrtRepairError

```c
aclError aclrtRepairError(int32_t deviceId, const aclrtErrorInfo *errorInfo)
```

**Caution: This API is an experimental feature. It may change in later versions and is not supported for use in production environments.**

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
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id32 -->
<!-- npu="310p" id33 -->
- Atlas inference products: Not supported
<!-- end id33 -->
<!-- npu="910" id34 -->
- Atlas training products: Not supported
<!-- end id34 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id15 -->

### Description

Performs fault rectification based on the detailed information obtained by the [aclrtGetErrorVerbose](#aclrtGetErrorVerbose) API. This API should be called after task abort is submitted.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>Keep it consistent with the device ID in the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API. |
| errorInfo | Input | Error information.<br>For the description of the **aclrtErrorInfo** struct, see [aclrtGetErrorVerbose](#aclrtGetErrorVerbose). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetDeviceTaskAbortCallback"></a>

## aclrtSetDeviceTaskAbortCallback

```c
aclError aclrtSetDeviceTaskAbortCallback(const char *regName, aclrtDeviceTaskAbortCallback callback, void *args)
```

### Applicable Products

<!-- npu="950" id379 -->
- Ascend 950PR&950DT products: Supported
<!-- end id379 -->
<!-- npu="A3" id380 -->
- Atlas A3 products: Supported
<!-- end id380 -->
<!-- npu="910b" id381 -->
- Atlas A2 products: Supported
<!-- end id381 -->
<!-- npu="310b" id382 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id382 -->
<!-- npu="310p" id383 -->
- Atlas inference products: Not supported
<!-- end id383 -->
<!-- npu="910" id384 -->
- Atlas training products: Not supported
<!-- end id384 -->
<!-- @ref: runtime/res/docs/zh/api_ref/13_exception_handling_res.md#id10 -->

### Description

Registers a callback function, which is triggered before and after the [aclrtDeviceTaskAbort](#aclrtDeviceTaskAbort) API is called. Repeated registration is not supported.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| regName | Input | Registration name, which must be unique and cannot be empty. The input string must end with **\0**. |
| callback | Input | Callback function. If **callback** is not NULL, the callback function is registered; if it is NULL, the callback function is unregistered.<br>The function prototype of the callback function is as follows:<br>typedef enum {<br>   ACL_RT_DEVICE_TASK_ABORT_PRE = 0,<br>   ACL_RT_DEVICE_TASK_ABORT_POST,<br>} aclrtDeviceTaskAbortStage;<br>typedef int32_t (*aclrtDeviceTaskAbortCallback)(int32_t deviceId, aclrtDeviceTaskAbortStage stage, uint32_t timeout, void*args);<br>Here, **timeout** indicates the maximum expected execution time of the callback function. |
| args | Input | Pointer to the user data to be passed to the callback function. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>
