# 2_model_switch

## Description
This sample demonstrates how to use aclmdlRIBuildBegin interface to create a model instance, and implements Stream jumping and Stream activation in tasks.

## Product Support

Key interfaces in this sample have the following support status on different products:

| Interface | Atlas A3 training series products/Atlas A3 inference series products | Atlas A2 training series products/Atlas A2 inference series products |
| --- | --- | --- |
| aclmdlRIBuildBegin | Yes | Yes |
| aclmdlRIBindStream | Yes | Yes |
| aclmdlRIEndTask | Yes | Yes |
| aclmdlRIBuildEnd | Yes | Yes |
| aclmdlRIUnbindStream | Yes | Yes |
| aclmdlRIExecuteAsync | Yes | Yes |
| aclrtSwitchStream | No | Yes |
| aclrtActiveStream | No | Yes |

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
    - Call aclrtDestroyStreamForce interface to forcibly destroy Stream, discarding all tasks.
    - Call aclrtCreateStreamWithConfig interface to create Stream with special config.
    - Call aclrtSwitchStream interface to jump between Streams based on condition.
    - Call aclrtActiveStream interface to activate Stream.
- Model Management
    - Call aclmdlRIBuildBegin interface to start building a model runtime instance.
    - Call aclmdlRIBindStream interface to bind model runtime instance to Stream.
    - Call aclmdlRIEndTask interface to mark task dispatch end.
    - Call aclmdlRIBuildEnd interface to finish building model runtime instance.
    - Call aclmdlRIUnbindStream interface to unbind model runtime instance from Stream.
    - Call aclmdlRIExecuteAsync interface to asynchronously execute model inference.
    - Call aclmdlRIDestroy interface to destroy model runtime instance.
- Memory Management
    - Call aclrtMalloc interface to allocate Device memory.
    - Call aclrtFree interface to release Device memory.
- Data Transfer
    - Call aclrtMemcpy interface to implement data transfer by memory copy.
    - Call aclrtMemcpyAsync interface to perform asynchronous memory copy.

## Sample Output

```text
[INFO]  After executing, print data1.
[INFO]  The vector data is: 3.4000  3.4000  3.4000  3.4000  3.4000  3.4000  3.4000  3.4000
[INFO]  After executing, print data2.
[INFO]  The vector data is: 0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000  0.0000
[INFO]  After executing, print data3.
[INFO]  The vector data is: 5.4000  5.4000  5.4000  5.4000  5.4000  5.4000  5.4000  5.4000
...
[INFO]  After second execution, print data2.
[INFO]  The vector data is: 4.4000  4.4000  4.4000  4.4000  4.4000  4.4000  4.4000  4.4000
```

## Known Issues

   None
