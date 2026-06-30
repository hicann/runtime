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
- Control Callback
  - `aclrtSubscribeReport` / `aclrtProcessReport` / `aclrtUnSubscribeReport`
  - `aclrtLaunchCallback`
  - `aclrtSubscribeHostFunc` / `aclrtProcessHostFunc` / `aclrtUnSubscribeHostFunc`
  - `aclrtLaunchHostFunc`
- Memory and Data Transfer
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy`
  - `aclrtSynchronizeStream`

## Sample Output

```text
[INFO]  The main thread id is ...
[INFO]  The created report thread id is ...
[INFO]  The created hostfunc thread id is ...
[INFO]  After begin a task, launch one hostfunc and five callbacks.
[INFO]  This callback before task, result: user data is: 520.
[INFO]  Hostfunc executed in subscribed thread, user data is: 520.
[INFO]  This callback after task and loop five times, result: user data is: 520.
[INFO]  After assigning the task, the current int is: ...
[INFO]  Report callback thread exit
[INFO]  Hostfunc processing thread exit
```

## Known Issues

None.
