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
export ASCEND_INSTALL_PATH=${install_root}/cann

# Replace ${ascend_name} with Ascend AI processor model, obtained by checking Name field using npu-smi info and removing spaces, for example ascend910b3
export SOC_VERSION=${ascend_name}

# Some samples involve calling AscendC operators, need to configure AscendC compiler ascendc.cmake path, for example ${install_root}/cann/aarch64-linux/tikcpp/ascendc_kernel_cmake
# Find ascendc_kernel_cmake under CANN package installation path, for example find ./ -name ascendc_kernel_cmake, and replace ${cmake_path} with ascendc_kernel_cmake directory path
export ASCENDC_CMAKE_DIR=${cmake_path}

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

## Known Issues

None.