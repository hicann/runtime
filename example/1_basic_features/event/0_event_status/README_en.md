# 0_event_status

## Description
This sample demonstrates Event status query flow after creation, after recording, and after synchronization.

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
cd ${git_clone_path}/example/1_basic_features/event/0_event_status
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
    - Call `aclrtSetStreamFailureMode` interface to set the operation when Stream execution encounters errors. Default is continue on error, can be set to stop on error.
    - Call `aclrtDestroyStreamForce` interface to forcefully destroy Stream.
- Event Management
    - Call `aclrtCreateEvent` interface to create Event.
    - Call `aclrtRecordEvent` interface to record Event.
    - Call `aclrtSynchronizeEvent` interface to block and wait for Event to complete.
    - Call `aclrtQueryEventStatus` interface to query Event status.
    - Call `aclrtDestroyEvent` interface to destroy Event.
- Memory Management
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtFree` interface to release memory on Device.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer through memory copy.

## Sample Output

```text
[INFO]  After create event, current event status is 0.
[INFO]  Applied resource successfully, beging assigning task.
[INFO]  Begin a long task.
[INFO]  0 is incompleted, 1 is completed.
[INFO]  After record but before synchronize, current event status is 0.
[INFO]  After synchronize, current event status is 1.
[INFO]  The answer is 1.
[INFO]  Resource cleanup completed.
```