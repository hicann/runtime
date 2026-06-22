# 0_simple_stream

## Description
This sample demonstrates single Stream task dispatch flow, including dispatching tasks on default Stream, dispatching tasks on newly created Stream, and querying Stream status after multiple task dispatches on the same Stream.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN software is installed. Switch to the sample directory.
```bash
cd ${git_clone_path}/example/1_basic_features/stream/0_simple_stream
```

2. Set environment variables.
```bash
# Replace ${install_root} with the CANN installation root directory. The default installation is in the `/usr/local/Ascend` directory.
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Set SOC_VERSION and ASCENDC_CMAKE_DIR
# -SOC_VERSION: Ascend AI processor model, such as Ascend910_9362, Ascend910B2, and so on
# -ASCENDC_CMAKE_DIR: The sample involves calling AscendC operators. Configure the AscendC compiler ascendc.cmake path, such as /usr/local/Ascend/cann/x86_64-linux/tikcpp/ascendc_kernel_cmake
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to execute the sample.
```bash
bash run.sh
```
## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:
- Initialization
    - Call `aclInit` interface for initialization configuration.
    - Call `aclFinalize` interface for deinitialization.
- Device Management
    - Call `aclrtSetDevice` interface to specify the Device for computation.
    - Call `aclrtResetDeviceForce` interface to forcefully reset the current computation Device and reclaim Device resources.
- Context Management
    - Call `aclrtCreateContext` interface to create Context.
    - Call `aclrtDestroyContext` interface to destroy Context.
- Stream Management
    - Call `aclrtCreateStream` interface to create Stream.
    - Call `aclrtSynchronizeStream` interface to block and wait for Stream tasks to complete.
    - Call `aclrtSetStreamFailureMode` interface to set the operation when Stream execution encounters errors. Default is continue on error, can be set to stop on error.
    - Call `aclrtStreamQuery` interface to get Stream completion status.
    - Call `aclrtDestroyStreamForce` interface to forcefully destroy Stream and discard all tasks.
- Memory Management
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtFree` interface to release memory on Device.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer through memory copy.

## Sample Output

```text
[INFO]  Use default stream assigning task.
[INFO]  Applied resource successfully, beging assigning task.
[INFO]  After assigning the task through the default stream, the current result is: 1.
[INFO]  Use created stream assigning task.
[INFO]  After assigning the task through the created stream, the current result is: 2.
[INFO]  Begin 3000 task.
[INFO]  After synchronize, stream status is: 0.
[INFO]  After loop, the current result is: 3002.
[INFO]  Resource cleanup completed.
```