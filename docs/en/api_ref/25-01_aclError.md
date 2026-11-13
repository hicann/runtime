# aclError Return Code List

<!-- md-trans-meta sourceCommit=72ad505978aa2a456f844d9ca39de6bb2ec24d86 translatedAt=2026-11-06T11:39:12.227Z pushedAt=2026-11-09T11:29:38.331Z nl=2 -->

This topic provides the aclError return code list.

<br>

<br>

<a id="aclError"></a>

## aclError

```c
typedef int aclError;
```

Return code definition rules:

- Rule 1: If the developer's environment is abnormal or the code logic is incorrect, the problem can be resolved by optimizing the environment or code logic. In this case, the return code is defined as 1XXXXX.
- Rule 2: If resources are insufficient (stream, memory, etc.) or the APIs or parameters used by the developer during programming do not match the current hardware, the problem can be resolved by using resources properly during programming. In this case, the return code is defined as 2XXXXX.
- Rule 3: If a service function is abnormal, such as a full queue or an empty queue, the return code is defined as 3XXXXX.
- Rule 4: If an internal software or hardware exception occurs, such as an internal software error or a device execution failure, the problem cannot be resolved by the user and must be reported to technical support. In this case, the return code is defined as 5XXXXX. You can obtain logs and submit an issue.
- Rule 5: Unidentified errors are currently all mapped to 500000. You can obtain logs and submit an issue.

<a id="table1323834101720"></a>
**Table 1**  ACL return code list

| Return Code | Description | Possible Causes and Solution |
| --- | --- | --- |
| static const int ACL_SUCCESS = 0; | Execution successful. | - |
| static const int ACL_ERROR_INVALID_EXCEPTION_INFO = -1; | Invalid exception information. | Check whether the passed exception information parameter value is a null pointer. |
| static const int ACL_ERROR_NONE = 0;<br>Caution: This return code will be deprecated in subsequent versions. Use the **ACL_SUCCESS** return code instead. | Execution successful. | - |
| static const int ACL_ERROR_INVALID_PARAM = 100000; | Parameter validation failed. | Check whether the input parameter values of the API are correct. |
| static const int ACL_ERROR_UNINITIALIZE = 100001; | Not initialized. | - Check whether the aclInit API has been called for initialization. Ensure that the aclInit API has been called and is called before other acl APIs.<br>  - Check whether the initialization API of the corresponding feature has been called, for example, the **aclmdlInitDump** API for initializing dump and the **aclprofInit** API for initializing profiling. |
| static const int ACL_ERROR_REPEAT_INITIALIZE = 100002; | Repeated initialization or repeated loading. | Check whether the corresponding API has been called for repeated initialization or repeated loading. |
| static const int ACL_ERROR_INVALID_FILE = 100003; | Invalid file. | Check whether the file exists and whether it can be accessed. |
| static const int ACL_ERROR_WRITE_FILE = 100004; | Failed to write the file. | Check whether the file path exists and whether the file has write permission. |
| static const int ACL_ERROR_INVALID_FILE_SIZE = 100005; | Invalid file size. | Check whether the file size meets the API requirements. |
| static const int ACL_ERROR_PARSE_FILE = 100006; | Failed to parse the file. | Check whether the file content is valid. |
| static const int ACL_ERROR_FILE_MISSING_ATTR = 100007; | The file is missing parameters. | Check whether the file content is complete. |
| static const int ACL_ERROR_FILE_ATTR_INVALID = 100008; | Invalid file parameters. | Check whether the parameter values in the file are correct. |
| static const int ACL_ERROR_INVALID_DUMP_CONFIG = 100009; | Invalid dump configuration. | Check whether the dump configuration is correct. |
| static const int ACL_ERROR_INVALID_PROFILING_CONFIG = 100010; | Invalid profiling configuration. | Check whether the profiling configuration is correct. |
| static const int ACL_ERROR_INVALID_MODEL_ID = 100011; | Invalid model ID. | Check whether the model ID is correct and whether the model is loaded correctly. |
| static const int ACL_ERROR_DESERIALIZE_MODEL = 100012; | Failed to deserialize the model. | The model may not match the current version. Rebuild the model. |
| static const int ACL_ERROR_PARSE_MODEL = 100013; | Failed to parse the model. | The model may not match the current version. Rebuild the model. |
| static const int ACL_ERROR_READ_MODEL_FAILURE = 100014; | Failed to read the model. | Check whether the model file exists and whether it can be accessed. |
| static const int ACL_ERROR_MODEL_SIZE_INVALID = 100015; | Invalid model size. | The model file is invalid. Rebuild the model. |
| static const int ACL_ERROR_MODEL_MISSING_ATTR = 100016; | The model is missing parameters. | The model may not match the current version. Rebuild the model. |
| static const int ACL_ERROR_MODEL_INPUT_NOT_MATCH = 100017; | The model input does not match. | Check whether the model input is correct. |
| static const int ACL_ERROR_MODEL_OUTPUT_NOT_MATCH = 100018; | The model output does not match. | Check whether the model output is correct. |
| static const int ACL_ERROR_MODEL_NOT_DYNAMIC = 100019; | Not a dynamic model. | Check whether the current model supports dynamic scenarios. If not, rebuild the model. |
| static const int ACL_ERROR_OP_TYPE_NOT_MATCH = 100020; | Single-operator type mismatch. | Check whether the operator type is correct. |
| static const int ACL_ERROR_OP_INPUT_NOT_MATCH = 100021; | Single-operator input mismatch. | Check whether the operator input is correct. |
| static const int ACL_ERROR_OP_OUTPUT_NOT_MATCH = 100022; | Single-operator output mismatch. | Check whether the operator output is correct. |
| static const int ACL_ERROR_OP_ATTR_NOT_MATCH = 100023; | Single-operator attribute mismatch. | Check whether the operator attributes are correct. |
| static const int ACL_ERROR_OP_NOT_FOUND = 100024; | Single operator not found. | Check whether the operator type is supported. |
| static const int ACL_ERROR_OP_LOAD_FAILED = 100025; | Failed to load the single operator. | The model may not match the current version. Rebuild the single operator model. |
| static const int ACL_ERROR_UNSUPPORTED_DATA_TYPE = 100026; | Unsupported data type. | Check whether the data type exists and whether it is currently supported. |
| static const int ACL_ERROR_FORMAT_NOT_MATCH = 100027; | Format mismatch. | Check whether the format is correct. |
| static const int ACL_ERROR_BIN_SELECTOR_NOT_REGISTERED = 100028; | When the operator API is compiled using the binary selection method, the operator selector is not registered. | Check whether the **aclopRegisterSelectKernelFunc** API has been called to register the operator selector. |
| static const int ACL_ERROR_KERNEL_NOT_FOUND = 100029; | When the operator is compiled, the operator kernel is not registered. | Check whether the **aclopCreateKernel** API has been called to register the operator kernel. |
| static const int ACL_ERROR_BIN_SELECTOR_ALREADY_REGISTERED = 100030; | When the operator API is compiled using the binary selection method, the operator selector is registered repeatedly. | Check whether the **aclopRegisterSelectKernelFunc** API has been called repeatedly to register the operator selector. |
| static const int ACL_ERROR_KERNEL_ALREADY_REGISTERED = 100031; | When the operator is compiled, the operator kernel is registered repeatedly. | Check whether the **aclopCreateKernel** API has been called repeatedly to register the operator kernel. |
| static const int ACL_ERROR_INVALID_QUEUE_ID = 100032; | Invalid queue ID. | Check whether the queue ID is correct. |
| static const int ACL_ERROR_REPEAT_SUBSCRIBE = 100033; | Repeated subscription. | Check whether the **aclrtSubscribeReport** API has been called repeatedly for the same stream. |
| static const int ACL_ERROR_STREAM_NOT_SUBSCRIBE = 100034;<br>Caution: This return code will be deprecated in subsequent versions. Use [ACL_ERROR_RT_STREAM_NO_CB_REG](#table1089051917356) return code instead. | Stream not subscribed. | Check whether the **aclrtSubscribeReport** API has been called. |
| static const int ACL_ERROR_THREAD_NOT_SUBSCRIBE = 100035;<br>Caution: This return code will be deprecated in subsequent versions. Use the [ACL_ERROR_RT_THREAD_SUBSCRIBE](#table1089051917356) return code instead. | Thread not subscribed. | Check whether the **aclrtSubscribeReport** API has been called. |
| static const int ACL_ERROR_WAIT_CALLBACK_TIMEOUT = 100036;<br>Caution: This return code will be deprecated in subsequent versions. Use the [ACL_ERROR_RT_REPORT_TIMEOUT](#table1089051917356) return code instead. | Waiting for callback timed out. | Check whether the **aclrtLaunchCallback** API has been called to dispatch the callback task.<br>Check whether the timeout in the **aclrtProcessReport** API is reasonable.<br>Check whether the callback task has been processed. If it has been processed but the **aclrtProcessReport** API is still called, optimize the code logic. |
| static const int ACL_ERROR_REPEAT_FINALIZE = 100037; | Repeated deinitialization. | Check whether the **aclFinalize** API or the **aclFinalizeReference** API has been called repeatedly for deinitialization. |
| static const int ACL_ERROR_NOT_STATIC_AIPP = 100038;<br>Caution: This return code will be deprecated in subsequent versions. Use the [ACL_ERROR_GE_AIPP_NOT_EXIST](#table153902340461) return code instead. | Static AIPP configuration information does not exist. | When calling the **aclmdlGetFirstAippInfo** API, pass a correct index value. |
| static const int ACL_ERROR_COMPILING_STUB_MODE = 100039; | The dynamic library path configured before application running is the path of the compilation stub, not the correct dynamic library path. | Check the dynamic library path configuration and ensure that the dynamic library in run mode is used. |
| static const int ACL_ERROR_GROUP_NOT_SET = 100040;<br>Caution: This return code will be deprecated in subsequent versions. Use the [ACL_ERROR_RT_GROUP_NOT_SET](#table1089051917356) return code instead. | Group not set. | Check whether the **aclrtSetGroup** API has been called. |
| static const int ACL_ERROR_GROUP_NOT_CREATE = 100041;<br>Caution: This return code will be deprecated in subsequent versions. Use the [ACL_ERROR_RT_GROUP_NOT_CREATE](#table1089051917356) return code instead. | The corresponding group is not created. | Check whether the group ID set when the API is called is within the supported range. The value range of the group ID is [0, (Number of groups - 1)]. The user can call the **aclrtGetGroupCount** API to obtain the number of groups. |
| static const int ACL_ERROR_PROF_ALREADY_RUN = 100042; | A task for collecting profiling data already exists. | - Check the code logic. The configuration for "collecting profiling data by calling AscendCL APIs" cannot coexist with profiling configurations of other methods. Only one can be retained.<br>  - Check whether profiling configurations have been dispatched repeatedly to the same device. |
| static const int ACL_ERROR_PROF_NOT_RUN = 100043; | Profiling initialization is not performed first using the **aclprofInit** API. | Check the API call sequence. |
| static const int ACL_ERROR_DUMP_ALREADY_RUN = 100044; | A task for obtaining dump data already exists. | Check whether the **aclInit** API has been called to configure dump information before calling the **aclmdlInitDump**, **aclmdlSetDump**, and **aclmdlFinalizeDump** APIs to configure dump information. If so, adjust the code logic and retain only one method for configuring dump information. |
| static const int ACL_ERROR_DUMP_NOT_RUN = 100045; | Dump initialization is not performed first using the **aclmdlInitDump** API. | Check the call sequence of the APIs for obtaining dump data. For details, see the description of the **aclmdlInitDump** API. |
| static const int ACL_ERROR_PROF_REPEAT_SUBSCRIBE = 148046; | Repeated subscription to the same model. | Check the API call sequence. |
| static const int ACL_ERROR_PROF_API_CONFLICT = 148047; | API call conflict when collecting performance data. | The profiling performance data collection APIs of the two methods cannot be called in an interleaved manner. The **aclprofModelSub**, **aclprofGet\***, and **aclprofModelUnSubscribe** APIs cannot be called between the **aclprofInit** and **aclprofFinalize** APIs. The **aclprofInit**, **aclprofStart**, **aclprofStop**, and **aclprofFinalize** APIs cannot be called between the **aclprofModelSubscribe** and **aclprofModelUnSubscribe** APIs. |
| static const int ACL_ERROR_INVALID_MAX_OPQUEUE_NUM_CONFIG = 148048; | Invalid operator cache information aging configuration. | Check the operator cache information aging configuration. For details, see the configuration description and examples at **aclInit**. |
| static const int ACL_ERROR_INVALID_OPP_PATH = 148049; | The **ASCEND_OPP_PATH** environment variable is not set, or is set incorrectly. | Check whether the **ASCEND_OPP_PATH** environment variable is set and whether its value is the installation path of the **opp** software package. |
| static const int ACL_ERROR_OP_UNSUPPORTED_DYNAMIC = 148050; | The operator does not support the dynamic shape. | - Check whether the shape of the operator in the single-operator model file is dynamic. If it is dynamic, change it to a fixed shape.<br>  - Check whether the shape of **aclTensorDesc** is dynamic when compiling the operator. If it is dynamic, recreate **aclTensorDesc** with a fixed shape. |
| static const int ACL_ERROR_RELATIVE_RESOURCE_NOT_CLEARED = 148051; | Related resources have not been released. | This return code is returned when destroying channel description information if the related channel has not been destroyed. Check whether the channel associated with this channel description information has been destroyed. |
| static const int ACL_ERROR_UNSUPPORTED_JPEG = 148052; | Input image encoding format not supported by the JPEGD feature (arithmetic coding, progressive coding, etc.). | When the JPEGD image decoding feature is implemented, only Huffman coding is supported. The color space of the original image before compression is YUV, and the component ratio of pixels is 4:4:4, 4:2:2, 4:2:0, 4:0:0, or 4:4:0. Arithmetic coding, progressive JPEG format, and JPEG2000 format are not supported. |
| static const int ACL_ERROR_INVALID_BUNDLE_MODEL_ID = 148053; | Invalid model ID. | Check whether the model ID is correct and whether the model is loaded correctly. |
| static const int ACL_ERROR_BAD_ALLOC = 200000; | Failed to request memory. | Check the remaining storage in the hardware environment. |
| static const int ACL_ERROR_API_NOT_SUPPORT = 200001; | API not supported. | Check whether the called API is currently supported. |
| static const int ACL_ERROR_INVALID_DEVICE = 200002;<br>Caution: This return code will be deprecated in subsequent versions. Use the [ACL_ERROR_RT_INVALID_DEVICEID](#table1089051917356) return code instead. | Invalid device. | Check whether the device exists. |
| static const int ACL_ERROR_MEMORY_ADDRESS_UNALIGNED = 200003; | Memory address not aligned. | Check whether the memory address meets the API requirements. |
| static const int ACL_ERROR_RESOURCE_NOT_MATCH = 200004; | Resource mismatch. | Check whether correct resources such as streams and contexts are passed when calling the API. |
| static const int ACL_ERROR_INVALID_RESOURCE_HANDLE = 200005; | Invalid resource handle. | Check whether the resources such as streams and contexts passed when calling the API have been destroyed or occupied. |
| static const int ACL_ERROR_FEATURE_UNSUPPORTED = 200006; | Feature not supported. | You can obtain the logs and submit an issue. |
| static const int ACL_ERROR_PROF_MODULES_UNSUPPORTED = 200007; | Unsupported profiling configuration dispatched. | Check whether the profiling configuration is correct based on the description in **aclprofCreateConfig**. |
| static const int ACL_ERROR_STORAGE_OVER_LIMIT = 300000; | Storage limit exceeded. | Check the remaining storage in the hardware environment. |
| static const int ACL_ERROR_INTERNAL_ERROR = 500000; | Unknown internal error. | You can obtain the logs and submit an issue. |
| static const int ACL_ERROR_FAILURE = 500001; | Internal error. | You can obtain the logs and submit an issue. |
| static const int ACL_ERROR_GE_FAILURE = 500002; | Error in the Graph Engine (GE) module. | You can obtain the logs and submit an issue. |
| static const int ACL_ERROR_RT_FAILURE = 500003; | Error in the RUNTIME module. | You can obtain the logs and submit an issue. |
| static const int ACL_ERROR_DRV_FAILURE = 500004; | Error in the Driver module. | You can obtain the logs and submit an issue. |
| static const int ACL_ERROR_PROFILING_FAILURE = 500005; | Error in the Profiling module. | You can obtain the logs and submit an issue. |

<a id="table1089051917356"></a>
**Table 2**  Return code list for passthrough RUNTIME

| Return Code | Description | Possible Causes and Solution |
| --- | --- | --- |
| #define  ACL_RT_SUCCESS  0 | Execution successful. | - |
| #define  ACL_ERROR_RT_PARAM_INVALID  107000 | Parameter validation failed. | Check whether the API input parameters are correct. |
| #define  ACL_ERROR_RT_INVALID_DEVICEID  107001 | Invalid device ID. | Check whether the device ID is valid. |
| #define  ACL_ERROR_RT_CONTEXT_NULL  107002 | The context is null. | Check whether **aclrtSetCurrentContext** or **aclrtSetDevice** has been called. |
| #define  ACL_ERROR_RT_STREAM_CONTEXT  107003 | The stream is not in the current context. | Check whether the context where the stream resides is consistent with the current context. |
| #define  ACL_ERROR_RT_MODEL_CONTEXT  107004 | The model is not in the current context. | Check whether the loaded model is consistent with the current context. |
| #define  ACL_ERROR_RT_STREAM_MODEL  107005 | The stream is not in the current model. | Check whether the stream has been bound to the model. |
| #define  ACL_ERROR_RT_EVENT_TIMESTAMP_INVALID  107006 | The event timestamp is invalid. | Check whether the event has been created. |
| #define  ACL_ERROR_RT_EVENT_TIMESTAMP_REVERSAL  107007 | The event timestamp is reversed. | Check whether the event has been created. |
| #define  ACL_ERROR_RT_ADDR_UNALIGNED  107008 | The memory address is not aligned. | Check whether the requested memory address is aligned. |
| #define  ACL_ERROR_RT_FILE_OPEN  107009 | Failed to open the file. | Check whether the file exists. |
| #define  ACL_ERROR_RT_FILE_WRITE  107010 | Failed to write the file. | Check whether the file exists and whether the file has the write permission. |
| #define  ACL_ERROR_RT_STREAM_SUBSCRIBE  107011 | The stream is not subscribed to or is repeatedly subscribed to. | Check whether the current stream is subscribed to or repeatedly subscribed to. |
| #define  ACL_ERROR_RT_THREAD_SUBSCRIBE  107012 | The thread is not subscribed to or is repeatedly subscribed to. | Check whether the current thread is subscribed to or repeatedly subscribed to. |
| #define  ACL_ERROR_RT_GROUP_NOT_SET  107013 | No group is set. | Check whether the **aclrtSetGroup** API has been called. |
| #define  ACL_ERROR_RT_GROUP_NOT_CREATE  107014 | The corresponding group is not created. | Check whether the group ID set when the interface is called is within the supported range. The value range of the group ID is [0, (Number of groups - 1)]. You can call the **aclrtGetGroupCount** API to obtain the number of groups. |
| #define  ACL_ERROR_RT_STREAM_NO_CB_REG  107015 | The stream corresponding to the callback is not registered to the thread. | Check whether the stream has been registered to the thread and whether the **aclrtSubscribeReport** API has been called. |
| #define  ACL_ERROR_RT_INVALID_MEMORY_TYPE  107016 | Invalid memory type. | Check whether the memory type is valid. |
| #define  ACL_ERROR_RT_INVALID_HANDLE  107017 | Invalid resource handle. | Check whether the corresponding input and used parameters are correct. |
| #define  ACL_ERROR_RT_INVALID_MALLOC_TYPE  107018 | The memory type requested for usage is incorrect. | Check whether the corresponding input and used memory type is correct. |
| #define  ACL_ERROR_RT_WAIT_TIMEOUT  107019 | Wait timeout. | Try to re-execute the API that dispatches the task. |
| #define  ACL_ERROR_RT_TASK_TIMEOUT  107020 | Task execution timeout. | Check whether the service orchestration is reasonable or set a reasonable timeout period. |
| #define  ACL_ERROR_RT_SYSPARAMOPT_NOT_SET  107021 | Failed to obtain the system parameter value in the current context. | The system parameter value in the current context is not set. For details, see **aclrtCtxSetSysParamOpt**. |
| #define  ACL_ERROR_RT_DEVICE_TASK_ABORT  107022 | The task abort operation on the device conflicts with other operations. | This return code is caused by a conflict between calling the **aclrtDeviceTaskAbort** API to stop tasks on the device and other API operations. Check the code logic and wait until the **aclrtDeviceTaskAbort** API finishes execution before performing other operations. |
| #define  ACL_ERROR_RT_STREAM_ABORT  107023 | Tasks on the stream are being cleared. | Tasks on the specified stream are being cleared. Synchronous waiting for task execution on the stream is not supported. |
| #define  ACL_ERROR_RT_CAPTURE_DEPENDENCY  107024 | When a model running instance is built in the capture mode, the Event Wait task has no corresponding Event Record task. | Call the **aclrtRecordEvent** API to add an Event Record task. |
| #define  ACL_ERROR_RT_STREAM_UNJOINED  107025 | In the cross-stream capture scenario, the last task of the sub-stream is not an Event Record task, or the last Event Record task of the sub-stream has no corresponding Event Wait task, or the sub-stream does not return to the origin stream. | - The last task of the sub-stream is not an Event Record task. Dispatch an Event Record task at the end of the sub-stream that reports the error (call the **aclrtRecordEvent** API).<br>  - The last Event Record task of the sub-stream has no corresponding Event Wait task. Dispatch an Event Wait task on the stream that does not report the error (call the **aclrtStreamWaitEvent** API).<br>  - The sub-stream does not return to the origin stream. Make the sub-stream return to the origin stream by properly dispatching Event Record and Event Wait tasks. |
| #define  ACL_ERROR_RT_MODEL_CAPTURED  107026 | The model is already in the capture state. | Call the **aclmdlRICaptureEnd** API to end the capture first, and then perform the corresponding operation. |
| #define  ACL_ERROR_RT_STREAM_CAPTURED  107027 | The stream is already in the capture state. | Call the **aclmdlRICaptureEnd** API to end the capture first, and then perform the corresponding operation. |
| #define  ACL_ERROR_RT_EVENT_CAPTURED  107028 | The event is already in the capture state. | Call the **aclmdlRICaptureEnd** API to end the capture first, and then perform the corresponding operation. |
| #define  ACL_ERROR_RT_STREAM_NOT_CAPTURED  107029 | The stream is not in the capture state. | Check whether **aclmdlRICaptureBegin** has been called to start capturing tasks dispatched on the stream. |
| #define  ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT  107030 | The current capture mode does not support this operation. | Different capture modes support different operation scopes. For details, see the description in the **aclmdlRICaptureThreadExchangeMode** API, and switch to the correct capture mode. |
| #define  ACL_ERROR_RT_STREAM_CAPTURE_IMPLICIT  107031 | The default stream is not allowed in the capture scenario. | Try to use another stream instead of the default stream. |
| #define  ACL_ERROR_STREAM_CAPTURE_CONFLICT  107032 | The model running instances where the event and the stream reside are inconsistent. | Check whether the multiple streams that call the **aclmdlRICaptureBegin** API simultaneously are associated through events. |
| #define  ACL_ERROR_STREAM_TASK_GROUP_STATUS  107033 | The task group status is abnormal. | The possible causes of this error are as follows. Check them one by one.<br><br>  - **aclmdlRICaptureTaskGrpBegin** is called to repeatedly start task group recording on the same stream.<br>  - **aclmdlRICaptureTaskUpdateBegin** is called to update the same task group simultaneously.<br>  - **aclmdlRICaptureTaskGrpBegin** is not used in pair with **aclmdlRICaptureTaskGrpEnd**.<br>  - **aclmdlRICaptureTaskUpdateBegin** is not used in pair with **aclmdlRICaptureTaskUpdateEnd**.<br>  - The same stream is used to record and update task groups simultaneously. |
| #define  ACL_ERROR_STREAM_TASK_GROUP_INTR  107034 | Task group recording is interrupted. | The cause of this error is that when a task group is recorded, the task is submitted to a capture stream on which task group recording is not enabled.<br>It is recommended to call the **aclmdlRICaptureTaskUpdateBegin** API to enable task group recording first, and then submit the task. |
| #define  ACL_ERROR_RT_STREAM_CAPTURE_UNMATCHED  107036 | An unmatched operation is found during capture. The **aclmdlRICaptureBegin** API is not called to start capturing tasks on the stream. | Check the code logic. Call the **aclmdlRICaptureBegin** API to start capturing tasks on the stream first, and then call the **aclmdlRICaptureEnd** API to end the capture. |
| #define  ACL_ERROR_RT_MODEL_RUNNING  107037 | The current model is being executed and cannot be destroyed. | Check the code logic and destroy the model after the model execution is complete. |
| #define  ACL_ERROR_RT_STREAM_CAPTURE_WRONG_THREAD  107038 | **aclmdlRICaptureEnd** and **aclmdlRICaptureBegin** are not in the same thread. | In the **aclmdlRICaptureBegin** API, if **mode** is set to a value other than **ACL_MODEL_RI_CAPTURE_MODE_RELAXED**, the **aclmdlRICaptureEnd** API and the **aclmdlRICaptureBegin** API must be in the same thread. |
| #define  ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY  107039 | Insufficient array space. The array size is smaller than the actually required array size. | Adjust the input array size. |
| #define  ACL_ERROR_RT_MODEL_UPDATE_FAILED  107040 | The model is not fully captured, the model is being executed, or parameter update fails, causing the model update to fail. | Ensure that the model is successfully captured, the execution is complete, or the parameter update succeeds. |
| #define  ACL_ERROR_RT_CAPTURE_MODE_BLOCK_ASYNC  107041 | The current capture mode does not support the asynchronous-to-synchronous conversion operation. | Different capture modes support different operation scopes. For details, see the description in the **aclmdlRICaptureThreadExchangeMode** API, and switch to the correct capture mode. |
| #define  ACL_ERROR_RT_SYMBOL_NOT_FOUND  107042 | The symbol is not found. | Check whether the global variable name is consistent with the global variable name in the operator binary. |
| #define  ACL_ERROR_RT_INVALID_SYMBOL  107043 | Invalid symbol. | Check whether the variable name is declared in the device code. |
| #define  ACL_ERROR_RT_INVALID_DEVICE_FUNCTION  107044 | Invalid kernel function symbol. | Check whether the kernel function is declared in the device code. |
| #define  ACL_ERROR_RT_FEATURE_NOT_SUPPORT  207000 | Feature not supported. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_MEMORY_ALLOCATION  207001 | Memory request failed. | Check the remaining storage in the hardware environment. |
| #define  ACL_ERROR_RT_MEMORY_FREE  207002 | Memory release failed. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICORE_OVER_FLOW  207003 | AI Core operator computation overflow. | Check whether the corresponding AI Core operator computation overflows. You can find the overflowing operator based on the dump data and then locate the specific operator problem. |
| #define  ACL_ERROR_RT_NO_DEVICE  207004 | The device is unavailable. | Check whether the device is running properly. |
| #define  ACL_ERROR_RT_RESOURCE_ALLOC_FAIL  207005 | Resource request failed. | Check the usage of resources such as streams and release unused resources in a timely manner. |
| #define  ACL_ERROR_RT_NO_PERMISSION  207006 | No operation permission. | Check whether the user permission for running the application is correct. |
| #define  ACL_ERROR_RT_NO_EVENT_RESOURCE  207007 | Insufficient event resources. | Check whether the number of events meets the requirements based on the description in the **aclrtCreateEvent** API. |
| #define  ACL_ERROR_RT_NO_STREAM_RESOURCE  207008 | Insufficient stream resources. | Check whether the number of streams meets the requirements based on the description in the **aclrtCreateStream** API. |
| #define  ACL_ERROR_RT_NO_NOTIFY_RESOURCE  207009 | Insufficient internal Notify resources in the system. | There are too many concurrent tasks for media data processing or too many resources are consumed during model inference. It is recommended to reduce concurrent tasks or unload some models. |
| #define  ACL_ERROR_RT_NO_MODEL_RESOURCE  207010 | Insufficient model resources. | It is recommended to unload some models. |
| #define  ACL_ERROR_RT_NO_CDQ_RESOURCE  207011 | Insufficient internal runtime resources. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_OVER_LIMIT  207012 | The number of queues exceeds the upper limit. | Destroy the queues that are no longer needed before creating new queues. |
| #define  ACL_ERROR_RT_QUEUE_EMPTY  207013 | The queue is empty. | Data cannot be obtained from an empty queue. Add data to the queue first, and then obtain it. |
| #define  ACL_ERROR_RT_QUEUE_FULL  207014 | The queue is full. | Data cannot be added to a full queue. Obtain data from the queue first, and then add it. |
| #define  ACL_ERROR_RT_REPEATED_INIT  207015 | The queue is repeatedly initialized. | It is recommended to initialize the queue only once and avoid repeated initialization. |
| #define  ACL_ERROR_RT_DEVICE_OOM  207018 | The device-side memory is exhausted. | Check the memory usage on the device and plan the memory usage properly based on the memory specifications of the device. |
| #define  ACL_ERROR_RT_FEATURE_NOT_SUPPORT_UPDATE_OP  207019 | The current driver version does not support updating this operator. | Check the driver version.<br>You can click [Link](https://www.hiascend.com/hardware/firmware-drivers/commercial) to download the driver installation package of Ascend HDK 25.0.RC1 or later on the firmware and driver page, and install or upgrade it by referring to the documentation of the corresponding version. |
| #define  ACL_ERROR_RT_TIMEOUT  207020 | Driver execution timeout. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_LINK_TYPE_NOT_SUPPORTED  207021 | The specified link type is not supported. | Check whether the hardware supports the used link type. |
| #define  ACL_ERROR_RT_INTERNAL_ERROR  507000 | Internal error in the Runtime module. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_TS_ERROR  507001 | Internal error in the task scheduler module on the device. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_STREAM_TASK_FULL  507002 | The number of tasks on the stream is full. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_STREAM_TASK_EMPTY  507003 | The number of tasks on the stream is empty. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_STREAM_NOT_COMPLETE  507004 | Not all tasks on the stream have been executed. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_END_OF_SEQUENCE  507005 | The task on the AI CPU has been executed. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_EVENT_NOT_COMPLETE  507006 | The event is not complete. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_CONTEXT_RELEASE_ERROR  507007 | Failed to release the context. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_SOC_VERSION  507008 | Failed to obtain the SoC version. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_TASK_TYPE_NOT_SUPPORT  507009 | Unsupported task type. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_LOST_HEARTBEAT  507010 | The task scheduler lost the heartbeat. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_MODEL_EXECUTE  507011 | Model execution failed. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_REPORT_TIMEOUT  507012 | Failed to obtain the message from the task scheduler. | Check whether the timeout setting of the API is too short. If yes, increase the timeout appropriately. If the timeout error persists after the timeout increases, check the logs.<br>You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_SYS_DMA  507013 | System Direct Memory Access (DMA) hardware execution error. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICORE_TIMEOUT  507014 | AI Core execution timeout. | You can obtain the logs and submit an issue.<br>For details about the logs, see *Log Reference*. |
| #define  ACL_ERROR_RT_AICORE_EXCEPTION  507015 | AI Core execution exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICORE_TRAP_EXCEPTION  507016 | AI Core trap execution exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICPU_TIMEOUT  507017 | AI CPU execution timeout. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICPU_EXCEPTION  507018 | AI CPU execution exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICPU_DATADUMP_RSP_ERR  507019 | The AI CPU does not return a response to the task scheduler after data dump. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICPU_MODEL_RSP_ERR  507020 | The AI CPU does not return a response to the task scheduler after model execution. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_PROFILING_ERROR  507021 | Profiling function execution exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_IPC_ERROR  507022 | Inter-process communication exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_MODEL_ABORT_NORMAL  507023 | The model exits. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_KERNEL_UNREGISTERING  507024 | The operator is being unregistered. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_RINGBUFFER_NOT_INIT  507025 | The ring buffer feature is not initialized. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_RINGBUFFER_NO_DATA  507026 | The ring buffer has no data. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_KERNEL_LOOKUP  507027 | The kernel inside RUNTIME is not registered. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_KERNEL_DUPLICATE  507028 | The kernel inside RUNTIME is repeatedly registered. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_DEBUG_REGISTER_FAIL  507029 | Failed to register the debug feature. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_DEBUG_UNREGISTER_FAIL  507030 | Failed to unregister the debug feature. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_LABEL_CONTEXT  507031 | The label is not in the current context. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_PROGRAM_USE_OUT  507032 | The number of registered programs exceeds the limit. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_DEV_SETUP_ERROR  507033 | Failed to start the device. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_VECTOR_CORE_TIMEOUT  507034 | Vector Core execution timeout. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_VECTOR_CORE_EXCEPTION  507035 | Vector Core execution exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_VECTOR_CORE_TRAP_EXCEPTION  507036 | Vector Core trap execution exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_CDQ_BATCH_ABNORMAL  507037 | Runtime internal resource request exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_DIE_MODE_CHANGE_ERROR  507038 | DIE mode modification exception. The DIE mode cannot be modified. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_DIE_SET_ERROR  507039 | The DIE cannot be specified in single-DIE mode. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_INVALID_DIEID  507040 | The specified DIE ID is incorrect. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_DIE_MODE_NOT_SET  507041 | The DIE mode is not set. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICORE_TRAP_READ_OVERFLOW  507042 | AI Core trap out-of-bounds read exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICORE_TRAP_WRITE_OVERFLOW  507043 | AI Core trap out-of-bounds write exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_VECTOR_CORE_TRAP_READ_OVERFLOW  507044 | Vector Core trap out-of-bounds read exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_VECTOR_CORE_TRAP_WRITE_OVERFLOW  507045 | Vector Core trap out-of-bounds write exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_STREAM_SYNC_TIMEOUT  507046 | In the specified timeout wait event, not all tasks in the specified stream have completed execution. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_EVENT_SYNC_TIMEOUT  507047 | In the specified event synchronization wait, the event has not completed execution in the specified time. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_FFTS_PLUS_TIMEOUT  507048 | Internal task execution timeout. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_FFTS_PLUS_EXCEPTION  507049 | Internal task execution exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_FFTS_PLUS_TRAP_EXCEPTION  507050 | Internal task trap exception. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_SEND_MSG  507051 | Message sending failed during data enqueueing. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_COPY_DATA  507052 | Memory copy failed during data enqueueing. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_DEVICE_MEM_ERROR  507053 | An erroneous virtual address with a memory UCE (uncorrectable error, meaning a memory error that the system hardware cannot directly handle and recover) has occurred. | Obtain and fix the erroneous virtual address of the memory UCE based on the description in the **aclrtGetMemUceInfo** API. |
| #define  ACL_ERROR_RT_HBM_MULTI_BIT_ECC_ERROR  507054 | HBM multi-bit ECC fault. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_SUSPECT_DEVICE_MEM_ERROR  507055 | In multi-process and multi-device scenarios, a memory UCE error may occur. | Because the memory of the peer device accessed by the current device has failed, the user needs to check the error information of the peer device process. |
| #define  ACL_ERROR_RT_LINK_ERROR  507056 | In multi-device scenarios, the communication between two devices is disconnected. | Retry is recommended. If the error persists, check the communication link between the two devices. |
| #define  ACL_ERROR_RT_SUSPECT_REMOTE_ERROR  507057 | In multi-process and multi-device scenarios, the memory of the peer device may have failed, or the memory access of the current device is out of bounds. | The user needs to check the error information of the peer device process or the memory access of the current device. |
| #define  ACL_ERROR_RT_DRV_INTERNAL_ERROR  507899 | Internal error in the Driver module. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICPU_INTERNAL_ERROR  507900 | Internal error in the AI CPU module. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_SOCKET_CLOSE  507901 | The internal Host Device Communication (HDC) session connection is disconnected. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_AICPU_INFO_LOAD_RSP_ERR  507902 | AI CPU scheduling processing failed. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_STREAM_CAPTURE_INVALIDATED  507903 | Model capture exception. | You can obtain the logs and submit an issue. |
| #define ACL_ERROR_RT_COMM_OP_RETRY_FAIL  507904 | Communication operator re-execution failed. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_SNAPSHOT_LOCK_TIMEOUT  507905 | The **aclrtSnapShotProcessLock** API call timed out. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_SNAPSHOT_LOCK_FAILED  507906 | Failed to lock the current process. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_SNAPSHOT_UNLOCK_FAILED  507907 | Failed to unlock the current process. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_SNAPSHOT_BACKUP_FAILED  507908 | Failed to back up the snapshot process. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_SNAPSHOT_RESTORE_FAILED  507909 | Failed to restore the snapshot process. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED  507910 | The host memory has already been registered. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_HOST_MEMORY_NOT_REGISTERED  507911 | The host memory to be deregistered has not been registered. | You can obtain the logs and submit an ISSUE. |
| #define  ACL_ERROR_SNAPSHOT_CALLBACK_FAILED  507912 | Failed to execute the callback function at a certain snapshot stage. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_SNAPSHOT_REGISTER_CALLBACK_FAILED  507913 | Failed to register the callback function. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_L3_PORT_ERROR  507914 | L3 port error. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_CCU_TIMEOUT  507915 | CCU execution timeout. | You can obtain the logs and submit an issue. |
| #define  ACL_ERROR_RT_CCU_EXCEPTION  507916 | CCU execution exception. | You can obtain the logs and submit an issue. |

<a id="table153902340461"></a>
**Table 3**  Return code list for passthrough GE

| Return Code | Description | Possible Causes and Solution |
| --- | --- | --- |
| uint32_t ACL_ERROR_GE_PARAM_INVALID = 145000; | Parameter validation failed. | Check whether the input parameter values of the API are correct. |
| uint32_t ACL_ERROR_GE_EXEC_NOT_INIT = 145001; | Not initialized. | - Check whether the **aclInit** API has been called for initialization. Ensure that the **aclInit** API has been called and is called before other acl APIs.<br>  - Check whether the initialization API of the corresponding feature has been called, for example, the **aclmdlInitDump** API for initializing dump and the **aclprofInit** API for initializing profiling. |
| uint32_t ACL_ERROR_GE_EXEC_MODEL_PATH_INVALID = 145002; | Invalid model path. | Check whether the model path is correct. |
| uint32_t ACL_ERROR_GE_EXEC_MODEL_ID_INVALID = 145003; | Invalid model ID. | Check whether the model ID is correct and whether the model is loaded correctly. |
| uint32_t ACL_ERROR_GE_EXEC_MODEL_DATA_SIZE_INVALID = 145006; | Invalid model size. | The model file is invalid. Rebuild the model. |
| uint32_t ACL_ERROR_GE_EXEC_MODEL_ADDR_INVALID = 145007; | Invalid model memory address. | Check whether the model address is valid. |
| uint32_t ACL_ERROR_GE_EXEC_MODEL_QUEUE_ID_INVALID = 145008; | Invalid queue ID. | Check whether the queue ID is correct. |
| uint32_t ACL_ERROR_GE_EXEC_LOAD_MODEL_REPEATED = 145009; | Repeated initialization or repeated loading. | Check whether the corresponding API is called for repeated initialization or repeated loading. |
| uint32_t ACL_ERROR_GE_DYNAMIC_INPUT_ADDR_INVALID = 145011; | Invalid dynamic profiling input address. | Check the dynamic profiling input address. |
| uint32_t ACL_ERROR_GE_DYNAMIC_INPUT_LENGTH_INVALID = 145012; | Invalid dynamic profiling input length. | Check the dynamic profiling input length. |
| uint32_t ACL_ERROR_GE_DYNAMIC_BATCH_SIZE_INVALID = 145013; | Invalid dynamic profiling batch size. | Check the dynamic profiling batch size. |
| uint32_t ACL_ERROR_GE_AIPP_BATCH_EMPTY = 145014; | Invalid AIPP batch size. | Check whether the AIPP batch size is correct. |
| uint32_t ACL_ERROR_GE_AIPP_NOT_EXIST = 145015; | The AIPP configuration does not exist. | Check whether AIPP is configured. |
| uint32_t ACL_ERROR_GE_AIPP_MODE_INVALID = 145016; | Invalid AIPP mode. | Check whether the AIPP mode set during model conversion is correct. |
| uint32_t ACL_ERROR_GE_OP_TASK_TYPE_INVALID = 145017; | Invalid task type. | Check whether the operator type is correct. |
| uint32_t ACL_ERROR_GE_OP_KERNEL_TYPE_INVALID = 145018; | Invalid operator type. | Check whether the operator type is correct. |
| uint32_t ACL_ERROR_GE_PLGMGR_PATH_INVALID = 145019; | Invalid .so file, including cases such as the .so file path hierarchy being too deep or the .so file being deleted by mistake. | Check whether the environment variable **LD_LIBRARY_PATH** set before application running is correct. For details, see the operation guide in the compilation and running. |
| uint32_t ACL_ERROR_GE_FORMAT_INVALID = 145020; | Invalid format. | Check whether the format of the tensor data is valid. |
| uint32_t ACL_ERROR_GE_SHAPE_INVALID = 145021; | Invalid shape. | Check whether the shape of the tensor data is valid. |
| uint32_t ACL_ERROR_GE_DATATYPE_INVALID = 145022; | Invalid data type. | Check whether the data type of the tensor data is valid. |
| uint32_t ACL_ERROR_GE_MEMORY_ALLOCATION = 245000; | Failed to request memory. | Check the remaining memory in the hardware environment. |
| uint32_t ACL_ERROR_GE_MEMORY_OPERATE_FAILED = 245001; | Memory initialization or memory copy operation failed. | Check whether the memory address is correct and whether the memory in the hardware environment is sufficient. |
| uint32_t ACL_ERROR_GE_DEVICE_MEMORY_ALLOCATION_FAILED = 245002; | Failed to request device memory. | The device memory is exhausted and cannot be requested further. Release some device memory and try again. |
| uint32_t  ACL_ERROR_GE_SUBHEALTHY = 345102; | Sub-healthy state. | The state after the redeployment action triggered by a device or process exception is completed is the sub-healthy state. In the sub-healthy state, related APIs can be called normally. |
| static const uint32_t ACL_ERROR_GE_USER_RAISE_EXCEPTION = 345103; | The user-defined function actively throws an exception. | The user can identify which input data caused the execution error based on **UserData** set in **DataFlowInfo**, and then troubleshoot the issue based on the error. |
| static const uint32_t ACL_ERROR_GE_DATA_NOT_ALIGNED = 345104; | Data is not aligned. | If the user-defined function has multiple outputs, check whether the user code has set too few outputs. Missing outputs may cause data alignment exceptions. |
| uint32_t ACL_ERROR_GE_INTERNAL_ERROR = 545000; | Unknown internal error. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_LOAD_MODEL = 545001; | Failed to load the model internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_EXEC_LOAD_MODEL_PARTITION_FAILED = 545002; | Failed to load the model internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_EXEC_LOAD_WEIGHT_PARTITION_FAILED = 545003; | Failed to load the model weights internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_EXEC_LOAD_TASK_PARTITION_FAILED = 545004; | Failed to load the model tasks internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_EXEC_LOAD_KERNEL_PARTITION_FAILED = 545005; | Failed to load the model operators internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_EXEC_RELEASE_MODEL_DATA = 545006; | Failed to release the model space internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_COMMAND_HANDLE = 545007; | Command operation failed internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_GET_TENSOR_INFO = 545008; | Failed to obtain tensor data internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_UNLOAD_MODEL = 545009; | Failed to unload the model space internally in the system. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_MODEL_EXECUTE_TIMEOUT = 545601; | Model execution timeout. | Obtain the logs and submit an issue. |
| uint32_t ACL_ERROR_GE_REDEPLOYING = 545602; | Redeployment in progress. | Wait for the redeployment action to complete and then call the related APIs again. |
