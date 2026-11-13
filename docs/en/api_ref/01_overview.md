# 1. Overview

<!-- md-trans-meta sourceCommit=0d259c501b2f5c821b3ac578a0b5ff3cfc2cf960 translatedAt=2026-11-06T11:14:05.456Z pushedAt=2026-11-09T06:58:56.054Z nl=2 -->

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

- [aclGetDataBufferSize](25-03_Operation_APIs.md#aclGetDataBufferSize)

    This API will be deprecated in a subsequent version. Use [aclGetDataBufferSizeV2](25-03_Operation_APIs.md#aclGetDataBufferSizeV2) instead.

- [aclrtQueryEvent](07_event_management.md#aclrtQueryEvent)

    This API will be deprecated in a subsequent version. Use [aclrtQueryEventStatus](07_event_management.md#aclrtQueryEventStatus) instead.

- [aclrtGetVersion](24_other_APIs.md#aclrtGetVersion)

    This API will be deprecated in a subsequent version. Use [aclsysGetVersionNum](24_other_APIs.md#aclsysGetVersionNum) or [aclsysGetVersionStr](24_other_APIs.md#aclsysGetVersionStr) instead.

- [aclrtMemcpyAsyncWithCondition](11-03_memory_copy_and_set.md#aclrtMemcpyAsyncWithCondition)

    This API will be deprecated in a subsequent version. Use [aclrtMemcpyAsync](11-03_memory_copy_and_set.md#aclrtMemcpyAsync) instead.

- [aclrtSetExceptionInfoCallback](13_exception_handling.md#aclrtSetExceptionInfoCallback)

    This API will be deprecated in a subsequent version. Use [aclrtExceptionInfoCallbackRegister](13_exception_handling.md#aclrtExceptionInfoCallbackRegister) or [aclrtExceptionInfoCallbackUnregister](13_exception_handling.md#aclrtExceptionInfoCallbackUnregister) instead.

### Return Codes

- [ACL\_ERROR\_NONE](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_SUCCESS](25-01_aclError.md#aclError) instead.

- [ACL\_ERROR\_NOT\_STATIC\_AIPP](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_ERROR\_GE\_AIPP\_NOT\_EXIST](25-01_aclError.md#aclError) instead.

- [ACL\_ERROR\_STREAM\_NOT\_SUBSCRIBE](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_ERROR\_RT\_STREAM\_NO\_CB\_REG](25-01_aclError.md#aclError) instead.

- [ACL\_ERROR\_THREAD\_NOT\_SUBSCRIBE](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_ERROR\_RT\_THREAD\_SUBSCRIBE](25-01_aclError.md#aclError) instead.

- [ACL\_ERROR\_WAIT\_CALLBACK\_TIMEOUT](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_ERROR\_RT\_REPORT\_TIMEOUT](25-01_aclError.md#aclError) instead.

- [ACL\_ERROR\_INVALID\_DEVICE](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_ERROR\_RT\_INVALID\_DEVICEID](25-01_aclError.md#aclError) instead.

- [ACL\_ERROR\_GROUP\_NOT\_SET](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_ERROR\_RT\_GROUP\_NOT\_SET](25-01_aclError.md#aclError) instead.

- [ACL\_ERROR\_GROUP\_NOT\_CREATE](25-01_aclError.md#aclError)

    This return code will be deprecated in a subsequent version. Use [ACL\_ERROR\_RT\_GROUP\_NOT\_CREATE](25-01_aclError.md#aclError) instead.

### Enumerations

- `ACL_OPT_STRONG_CONSISTENCY` in the [aclSysParamOpt](25-02_Enumerations.md#aclsysparamopt) enumeration

    `ACL_OPT_STRONG_CONSISTENCY` in this enumeration will be deprecated in a subsequent version. Use `ACL_OPT_DETERMINISTIC` instead.
