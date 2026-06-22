# 0_simple_callback

## Description
This sample demonstrates how to register Report callback thread and HostFunc processing thread for the same Stream, and observe execution behavior of both callback types on user-specified threads using `aclrtLaunchCallback` and `aclrtLaunchHostFunc`.

## Product Support

Key interfaces in this sample have the following support status on different products:

| Interface | Atlas A3 training series products/Atlas A3 inference series products | Atlas A2 training series products/Atlas A2 inference series products |
| --- | --- | --- |
| aclrtSubscribeReport | Yes | Yes |
| aclrtProcessReport | Yes | Yes |
| aclrtUnSubscribeReport | Yes | Yes |
| aclrtLaunchCallback | Yes | Yes |
| aclrtSubscribeHostFunc | No | No |
| aclrtProcessHostFunc | No | No |
| aclrtUnSubscribeHostFunc | No | No |
| aclrtLaunchHostFunc | Yes | Yes |

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
- Control Callback
  - `aclrtSubscribeReport` / `aclrtProcessReport` / `aclrtUnSubscribeReport`
  - `aclrtLaunchCallback`
  - `aclrtSubscribeHostFunc` / `aclrtProcessHostFunc` / `aclrtUnSubscribeHostFunc`
  - `aclrtLaunchHostFunc`
- Memory and Data Transfer
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy`
  - `aclrtSynchronizeStream`

## Known Issues

None.