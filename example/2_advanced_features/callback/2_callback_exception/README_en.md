# 2_callback_exception

## Description
This sample demonstrates how to get task exception information through error callback function, and after sync failure, supplement query for recent error message, thread-level last error, and detailed device error information, forming a more complete Runtime error handling chain.

## Product Support

This sample has the following support status on the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run
For environment installation details and running details, see [README](../../../README_en.md) in the example directory.

Run steps:

```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh

# Automatically identify SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh

# Build and run
bash run.sh
```

## CANN RUNTIME API
Key features and interfaces in this sample:
- Initialization and Resource Management
  - `aclInit` / `aclFinalize`
  - `aclrtSetDevice` / `aclrtResetDeviceForce`
  - `aclrtCreateContext` / `aclrtDestroyContext`
  - `aclrtCreateStream` / `aclrtDestroyStreamForce`
  - `aclrtSetStreamFailureMode`
- Control Callback and Exception Handling
  - `aclrtSubscribeReport` / `aclrtProcessReport` / `aclrtUnSubscribeReport`
  - `aclrtLaunchCallback`
  - `aclrtSetExceptionInfoCallback`
  - `aclrtGetThreadLastTaskId`
  - `aclrtGetTaskIdFromExceptionInfo`
  - `aclrtGetStreamIdFromExceptionInfo`
  - `aclrtGetThreadIdFromExceptionInfo`
  - `aclrtGetDeviceIdFromExceptionInfo`
  - `aclrtGetErrorCodeFromExceptionInfo`
  - `aclrtGetArgsFromExceptionInfo`
  - `aclrtGetFuncHandleFromExceptionInfo`
  - `aclrtPeekAtLastError` / `aclrtGetLastError`
  - `aclGetRecentErrMsg`
  - `aclrtGetErrorVerbose`
- Memory Management and Data Transfer
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy`
  - `aclrtSynchronizeStream`

## Sample Output

```text
[INFO]  Begin a easy task and a error task, the error task will callback exception.
[INFO]  The last task id is: ...
[INFO]  Exception occurred, callback function.
[INFO]  The error task id is ...
[INFO]  The error stream id is ...
[INFO]  The error thread id is ...
[INFO]  The error device id is ...
[INFO]  The error code id is ...
[ERROR]  aclrtSynchronizeStream(stream_) returned error code ...
[INFO]  Thread exit
[INFO]  Run the callback_exception sample successfully.
```

## Known Issues

None.
