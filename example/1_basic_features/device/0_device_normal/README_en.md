# 0_device_normal

## Description

This sample demonstrates the basic usage flow of CANN Runtime Device management, including initialization, specifying Device, creating Stream, executing `aclnnAdd` vector addition operator, synchronously waiting for task completion, and releasing resources.

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
cd ${git_clone_path}/example/1_basic_features/device/0_device_normal
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
    - Call `aclrtSynchronizeDevice` interface to block and wait for the computing Device to complete computation.
    - Call `aclrtResetDeviceForce` interface to forcefully reset the current computation Device and reclaim Device resources.
- Stream Management
    - Call `aclrtCreateStream` interface to create a Stream.
    - Call `aclrtSynchronizeStream` interface to block and wait for Stream tasks to complete.
    - Call `aclrtDestroyStream` interface to destroy a Stream.
- Memory Management
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtFree` interface to release memory on Device.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer through memory copy.
- Operator Execution
    - Call `aclnnAddGetWorkspaceSize` interface to get workspace information required for `aclnnAdd` operator execution.
    - Call `aclnnAdd` interface to execute vector addition operator.

## Sample Output

```text
[INFO]: Current compile soc version is ...
...
[INFO]  Start to run device_normal sample.
[INFO]  result[0] is: 1.200000
[INFO]  result[1] is: 2.200000
[INFO]  result[2] is: 3.200000
[INFO]  result[3] is: 5.400000
[INFO]  result[4] is: 6.400000
[INFO]  result[5] is: 7.400000
[INFO]  result[6] is: 9.600000
[INFO]  result[7] is: 10.600000
[INFO]  Run the device_normal sample successfully.
```