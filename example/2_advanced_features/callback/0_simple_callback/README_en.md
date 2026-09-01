# 0_simple_callback

## Description
This sample demonstrates how to launch Host callback tasks on a Stream using `aclrtLaunchHostFunc`, inserting CPU callback functions before and after NPU tasks. This interface internally creates and manages the callback thread, without requiring users to create threads or register manually.

## Product Support

Key interfaces in this sample have the following support status on different products:

| Interface | Ascend 950PR/Ascend 950DT | Atlas A3 training series products/Atlas A3 inference series products | Atlas A2 training series products/Atlas A2 inference series products |
| --- | --- | --- | --- |
| aclrtLaunchHostFunc | Yes | Yes | Yes |

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
- Host Callback
  - `aclrtLaunchHostFunc`
- Memory and Data Transfer
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy`
  - `aclrtSynchronizeStream`

## Sample Output

```text
[INFO]  This callback before task, result: user data is: 520.
[INFO]  After begin a task, launch one hostfunc.
[INFO]  This callback after task, result: user data is: 520.
[INFO]  After assigning the task, the current int is: ...
```

## Known Issues

None.
