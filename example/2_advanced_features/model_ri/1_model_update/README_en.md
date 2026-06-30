# 1_model_update

## Description
This sample demonstrates how to update tasks in a model instance after capturing it.

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
    - Call aclrtDestroyStreamForce interface to forcibly destroy Stream, discarding all tasks.
- Model Management
    - Call aclmdlRICaptureBegin interface to start capture mode.
    - Call aclmdlRICaptureThreadExchangeMode interface to change model capture mode.
    - Call aclmdlRICaptureTaskGrpBegin interface to mark the start of task group to update.
    - Call aclmdlRICaptureTaskGrpEnd interface to mark the end of task group to update, get handle for subsequent update.
    - Call aclmdlRICaptureEnd interface to end capture mode and get modelRI handle.
    - Call aclmdlRIExecuteAsync interface to asynchronously execute model inference.
    - Call aclmdlRICaptureTaskUpdateBegin interface to mark the start of tasks to update.
    - Call aclmdlRICaptureTaskUpdateEnd interface to mark the end of tasks to update.
    - Call aclmdlRIDestroy interface to destroy model runtime instance.
- Memory Management
    - Call aclrtMalloc interface to allocate Device memory.
    - Call aclrtFree interface to release Device memory.
- Data Transfer
    - Call aclrtMemcpy interface to implement data transfer by memory copy.
    - Call aclrtMemcpyAsync interface to perform asynchronous memory copy.

## Sample Output

```text
[INFO]  Execute model, loop count: 1.
[INFO]  The vector data is: 5.4000  6.4000  7.4000  8.4000  9.4000  10.4000  11.4000  12.4000
[INFO]  Execute model, loop count: 2.
[INFO]  Update alpha value of aclnnAdd
[INFO]  The vector data is: 7.6000  8.6000  9.6000  10.6000  11.6000  12.6000  13.6000  14.6000
```

## Known Issues

   None
