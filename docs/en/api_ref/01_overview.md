# 1. Overview

<!-- md-trans-meta sourceCommit=3d4f78761a251a21e2e2f4108ce8b55bb3e3f406 translatedAt=2026-11-11T06:30:58.425Z pushedAt=2026-11-16T06:25:59.430Z nl=2 -->

This section describes the basic concepts of the CANN Runtime APIs, header files and library files, synchronous/asynchronous APIs, and deprecated APIs.

## Header Files and Library Files

### API Categories

Typically, an API name starts with the prefix `acl`, in the naming style of acl_*API category abbreviation*_*, where* indicates the operation verb and object, both starting with an uppercase letter. For ease of description, all APIs in this document are called acl APIs.

**Table 1**  Key API categories

| API Name Prefix | Description |
| --- | --- |
| acl | Basic APIs, used for initialization & de-initialization, logging, data type conversion, and more. |
| aclrt | Runtime management APIs, used for device management, stream management, memory management, kernel loading and execution, and more. |
| aclmdlRI | Model running instance management APIs. |
| acltdt | Data transmission APIs. |
| aclmdl&aclop | Data dump APIs for models and operators. |
| aclprof | Profiling APIs. |
| acllog | Log callback APIs, which allow user-defined modules to record logs. |

### Header Files and Library Files Required for Calling APIs

After the firmware, drivers, and CANN software package are installed, an application can reference the header files and library files of the acl APIs during build and running.

You need to include the dependent files based on the actually used acl APIs. The purpose of each header file is described in the following table.

The header files of acl APIs are stored in the **"\${INSTALL_DIR}/include/"** directory, and the library files are stored in the **"\${INSTALL_DIR}/lib64/"** directory. Replace **\${INSTALL_DIR}** with the file storage path after CANN software installation. For example, if you install CANN as the **root** user, the default file storage path after installation is **/usr/local/Ascend/cann**.

>**CAUTION:**
>When compiling acl API programs, link against the library files corresponding to the included header files. If redundant library files (for example, **libascendcl.a**) are referenced, version features may become abnormal or compatibility issues may arise when upgrading to a subsequent version.

**Table 2**  Header files

| API-Defining Header File | Purpose | Library File |
| --- | --- | --- |
| acl/acl_rt.h | Defines the APIs for initialization/de-initialization, device/context/stream/memory management, and synchronization wait. | libacl_rt.so<br>Note: For compatibility with earlier versions, you can still use `libascendcl.so` in earlier versions, but this file will be deprecated in future releases. Use `libacl_rt.so` to prevent compatibility issues in subsequent versions. |
| acl/acl_rt_api.h | Defines C++ extended APIs, providing function overloading and template wrappers (for C++ programs only). Depends on acl_rt.h. | libacl_rt.so |
| acl/acl_dump.h | Defines the model and operator data dump APIs. | libascend_dump.so |
| acl/acl_prof.h | Defines the profiling APIs. | libmsprofiler.so<br>Note: For compatibility with earlier versions, you can still use `libascendcl.so` in earlier versions, but this file will be deprecated in future releases. Use `libmsprofiler.so` to prevent compatibility issues in subsequent versions. |
| base/acl_log.h | Defines the log callback APIs, which allow user-defined modules to record logs. | libascendalog.so |
| acl/acl_tdt.h | Defines the tensor data transmission APIs. | libacl_tdt_channel.so |
| acl/acl_tdt_queue.h | Defines the APIs for managing shared queues and shared buffers. | libacl_tdt_queue.so |

### Expression Conventions

This document contains identifiers for API or parameter statuses such as "Supported", "Not supported", "Trial", "Reserved", and "Deprecated". The meanings of these identifiers are as follows:

- "Supported": indicates that an API or parameter is supported.

- "Not supported": indicates that an API or parameter is not supported. Using such an API or parameter will cause undefined behavior, for example, the API returns an error or service functions become abnormal.

- "Reserved": indicates that an API or parameter is reserved. It is currently incomplete or not implemented, does not support calls, and may be available in a subsequent version.

- "Trial": indicates that an API or parameter is in the trial phase. Its definition and behavior may change. It is not recommended for use in production environments.

- "Deprecated": will be deleted in a subsequent version. Use the alternative API or parameter described in the document.

## Synchronous and Asynchronous APIs

CANN supports the following types of APIs for explicit synchronization. Upon the call of such an API, the host threads block until related tasks complete.

- **Device synchronization (e.g. aclrtSynchronizeDevice)**

    Block the current host threads until all explicitly or implicitly created streams on the device complete all previously issued tasks. Use this function as little as possible to avoid delaying host execution.

- **Stream synchronization (e.g. aclrtSynchronizeStream)**

    Block the current host threads until all issued tasks in the specified stream are complete.

- **Event synchronization (e.g. aclrtSynchronizeEvent)**

    Block the current host threads until the specified event is complete. This is a finer-grained synchronization.

**For asynchronous APIs**, after a host thread calls an asynchronous API, the call only indicates that tasks are issued, not that the tasks are executed. Before the tasks are completed, the asynchronous API has already returned a success message to the host thread. You need to explicitly call the preceding synchronous APIs to block the host thread and wait for the tasks to complete. Otherwise, unknown issues such as training or inference exceptions and device disconnection/drop may occur.

## Deprecated Items

Deprecated items in the Runtime APIs (such as APIs and return codes), once declared as deprecated in the documentation of a specified version, will be removed by default in a version after one year from the declaration, together with the matching code and documentation. For example, an API declared as deprecated in the documentation of version 9.1.0 (June 2026) is planned to be removed in a version after June 30, 2027.

### APIs

- [aclGetDataBufferSize](25-03_Operation_APIs.md#aclGetDataBufferSize_deprecated)

    The **aclGetDataBufferSize** API is marked as deprecated in CANN 8.5.0 and will be removed in a version after December 30, 2026. Use [aclGetDataBufferSizeV2](25-03_Operation_APIs.md#aclGetDataBufferSizeV2) instead.

- [aclrtQueryEvent](07_event_management.md#aclrtQueryEvent_deprecated)

    The **aclrtQueryEvent** API is marked as deprecated in CANN 8.5.0 and will be removed in a version after December 30, 2026. Use [aclrtQueryEventStatus](07_event_management.md#aclrtQueryEventStatus) instead.

- [aclrtGetVersion](24_other_APIs.md#aclrtGetVersion_deprecated)

    The **aclrtGetVersion** API is marked as deprecated in CANN 9.2.0 and will be removed in a version after September 30, 2027. Use [aclsysGetVersionNum](24_other_APIs.md#aclsysGetVersionNum) or [aclsysGetVersionStr](24_other_APIs.md#aclsysGetVersionStr) instead.

- [aclrtMemcpyAsyncWithCondition](11-03_memory_copy_and_set.md#aclrtMemcpyAsyncWithCondition_deprecated)

    The **aclrtMemcpyAsyncWithCondition** API is marked as deprecated in CANN 9.2.0 and will be removed in a version after September 30, 2027. Use [aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync) instead.

- [aclrtSetExceptionInfoCallback](13_exception_handling.md#aclrtSetExceptionInfoCallback_deprecated)

    The **aclrtSetExceptionInfoCallback** API is marked as deprecated in CANN 9.2.0 and will be removed in a version after September 30, 2027. Use [aclrtExceptionInfoCallbackRegister](13_exception_handling.md#aclrtExceptionInfoCallbackRegister) and [aclrtExceptionInfoCallbackUnregister](13_exception_handling.md#aclrtExceptionInfoCallbackUnregister) instead.

- [aclsysGetCANNVersion](24_other_APIs.md#aclsysGetCANNVersion) API

    The **aclsysGetCANNVersion** API is marked as deprecated in CANN 8.5.0 and will be removed in a version after December 30, 2026. Use [aclsysGetVersionStr](24_other_APIs.md#aclsysGetVersionStr) or [aclsysGetVersionNum](24_other_APIs.md#aclsysGetVersionNum) instead.

- [aclmdlRIDebugPrint](15_model_running_instance_management.md#aclmdlRIDebugPrint_deprecated) API

    The **aclmdlRIDebugPrint** API is marked as deprecated in CANN 8.5.0 and will be removed in a version after December 30, 2026. Use [aclmdlRIDebugJsonPrint](15_model_running_instance_management.md#aclmdlRIDebugJsonPrint) instead.

### Return Codes

- [ACL\_ERROR\_NONE](25-01_aclError.md#aclError)

    The `ACL_ERROR_NONE` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_SUCCESS](25-01_aclError.md#aclError) return code.

- [ACL\_ERROR\_NOT\_STATIC\_AIPP](25-01_aclError.md#aclError)

    The `ACL_ERROR_NOT_STATIC_AIPP` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_ERROR_GE_AIPP_NOT_EXIST](25-01_aclError.md#aclError) return code.

- [ACL\_ERROR\_STREAM\_NOT\_SUBSCRIBE](25-01_aclError.md#aclError)

    The `ACL_ERROR_STREAM_NOT_SUBSCRIBE` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_ERROR_RT_STREAM_NO_CB_REG](25-01_aclError.md#aclError) return code.

- [ACL\_ERROR\_THREAD\_NOT\_SUBSCRIBE](25-01_aclError.md#aclError)

    The `ACL_ERROR_THREAD_NOT_SUBSCRIBE` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_ERROR_RT_THREAD_SUBSCRIBE](25-01_aclError.md#aclError) return code.

- [ACL\_ERROR\_WAIT\_CALLBACK\_TIMEOUT](25-01_aclError.md#aclError)

    The `ACL_ERROR_WAIT_CALLBACK_TIMEOUT` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_ERROR_RT_REPORT_TIMEOUT](25-01_aclError.md#aclError) return code.

- [ACL\_ERROR\_INVALID\_DEVICE](25-01_aclError.md#aclError)

    The `ACL_ERROR_INVALID_DEVICE` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_ERROR_RT_INVALID_DEVICEID](25-01_aclError.md#aclError) return code.

- [ACL\_ERROR\_GROUP\_NOT\_SET](25-01_aclError.md#aclError)

    The `ACL_ERROR_GROUP_NOT_SET` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_ERROR_RT_GROUP_NOT_SET](25-01_aclError.md#aclError) return code.

- [ACL\_ERROR\_GROUP\_NOT\_CREATE](25-01_aclError.md#aclError)

    The `ACL_ERROR_GROUP_NOT_CREATE` return code is marked as deprecated in CANN 8.5.0 and will be removed in versions after December 30, 2026. Replace it with the [ACL_ERROR_RT_GROUP_NOT_CREATE](25-01_aclError.md#aclError) return code.

### Enumerations

- `ACL_OPT_STRONG_CONSISTENCY` in the [aclSysParamOpt](25-02_Enumerations.md#aclsysparamopt) enumeration

    The `ACL_OPT_STRONG_CONSISTENCY` enumeration member is marked as deprecated in CANN 9.2.0 and will be removed in versions after September 30, 2027. Replace it with the `ACL_OPT_DETERMINISTIC` enumeration member. Set it to `2`.

- `ACL_RT_LAUNCH_KERNEL_ATTR_LOCAL_MEMORY_SIZE` in the [aclrtLaunchKernelAttrId](25-02_Enumerations.md#aclrtLaunchKernelAttrId) enumeration

    The `ACL_RT_LAUNCH_KERNEL_ATTR_LOCAL_MEMORY_SIZE` enumeration member is marked as deprecated in CANN 9.0.0 and will be removed in a version after March 30, 2027. Replace it with the `ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE` enumeration member.

- `ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE` in the [aclrtDevAttr](25-02_Enumerations.md#aclrtDevAttr) enumeration

    The `ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE` enumeration member is marked as deprecated in CANN 9.0.0 and will be removed in a version after March 30, 2027. Replace it with the `ACL_DEV_ATTR_UBUF_PER_VECTOR_CORE` enumeration member.

- `ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID` in the [aclrtDevAttr](25-02_Enumerations.md#aclrtDevAttr) enumeration

    The `ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID` enumeration member is marked as deprecated in CANN 9.0.0 and will be removed in a version after March 30, 2027. Replace it with the `ACL_DEV_ATTR_SUPER_POD_DEVICE_ID` enumeration member.

- `ACL_RT_ATOMIC_CAPABILITY_REDUCATION` in the [aclrtAtomicOperationCapability](25-02_Enumerations.md#aclrtAtomicOperationCapability) enumeration

    The `ACL_RT_ATOMIC_CAPABILITY_REDUCATION` enumeration member is marked as deprecated in CANN 9.2.0 and will be removed in a version after September 30, 2027. Replace it with the `ACL_RT_ATOMIC_CAPABILITY_REDUCTION` enumeration member.

- `ACL_RT_BINARY_LOAD_OPT_LAZY_MAGIC` in the [aclrtBinaryLoadOptionType](25-02_Enumerations.md#aclrtBinaryLoadOptionType) enumeration

    The `ACL_RT_BINARY_LOAD_OPT_LAZY_MAGIC` enumeration member is marked as deprecated in CANN 8.5.0 and will be removed in a version after December 30, 2026. Replace it with the `ACL_RT_BINARY_LOAD_OPT_MAGIC` enumeration member.

- `localMemorySize` in the [aclrtLaunchKernelAttrValue](25-04_Structs.md#aclrtLaunchKernelAttrValue) union

    The `aclrtLaunchKernelAttrValue.localMemorySize` member is marked as deprecated in CANN 9.0.0 and will be removed in a version after March 30, 2027. Replace it with the `aclrtLaunchKernelAttrValue.dynUBufSize` member.

### Macros

- [ACL\_EVENT\_EXTERNAL](07_event_management.md#aclrtCreateEventWithFlag) macro

    The `ACL_EVENT_EXTERNAL` macro is marked as deprecated in CANN 9.3.0 and will be removed in a version after December 30, 2027. Call the [aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag) API and set `ACL_EVENT_SYNC` to create an event, and then use it together with APIs such as [aclrtRecordEventWithFlag](07_event_management.md#aclrtRecordEventWithFlag) and [aclrtStreamWaitEventWithFlag](07_event_management.md#aclrtStreamWaitEventWithFlag).
