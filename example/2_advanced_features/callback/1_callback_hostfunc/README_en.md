# 1_callback_hostfunc

## Description
This sample demonstrates dispatching a Host-side function on a Stream. This Host-side function is called after currently dispatched tasks complete, and blocks subsequently added tasks.

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
- Initialization
    - Call aclInit interface to initialize AscendCL configuration.
    - Call aclFinalize interface to deinitialize AscendCL.
- Device Management
    - Call aclrtSetDevice interface to specify Device for computation.
    - Call aclrtResetDeviceForce interface to forcibly reset current computation Device and reclaim Device resources.
- Context Management
    - Call aclrtCreateContext interface to create Context.
    - Call aclrtDestroyContext interface to destroy Context.
- Stream Management
    - Call aclrtCreateStream interface to create Stream.
    - Call aclrtSynchronizeStream interface to block waiting for Stream task completion.
    - Call aclrtSetStreamFailureMode interface to set Stream task execution error handling, defaults to continue on error, can be set to stop on error.
    - Call aclrtDestroyStreamForce interface to forcibly destroy Stream, discarding all tasks.
- Callback Control
    - Call aclrtLaunchHostFunc interface to directly trigger callback, without explicit thread creation.
- Memory Management
    - Call aclrtMalloc interface to allocate Device memory.
    - Call aclrtFree interface to release Device memory.
- Data Transfer
    - Call aclrtMemcpy interface to implement data transfer by memory copy.

## Sample Output

```text
[INFO]  Hostfunc callback!!!
[INFO]  After assigning the task through the created stream, the current result is: ...
[INFO]  Resource cleanup completed.
```

## Known Issues

   None
