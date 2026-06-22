# 2_device_P2P

## Description
This sample demonstrates P2P data transfer flow between two Devices. The sample first queries whether Device 0 and Device 1 support data interaction. When the capability is available, it enables bidirectional P2P access, then completes inter-Device memory copy and result verification.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

This sample requires at least 2 available Devices, and Device 0 and Device 1 must support P2P data interaction.

1. Download the sample code to the environment where CANN software is installed. Switch to the sample directory.
```bash
cd ${git_clone_path}/example/1_basic_features/device/2_device_P2P
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
    - Call `aclrtDeviceCanAccessPeer` interface to query whether Devices support data interaction. If the query result indicates not supported, the sample will print an error log and end.
    - Call `aclrtDeviceEnablePeerAccess` interface to enable data interaction between current Device and specified Device.
    - Call `aclrtDeviceDisablePeerAccess` interface to disable data interaction between current Device and specified Device.
    - Call `aclrtSynchronizeDevice` interface to block and wait for tasks on current Device to complete.
    - Call `aclrtResetDeviceForce` interface to forcefully reset the current computation Device and reclaim Device resources.
- Memory Management
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtMallocHost` interface to allocate memory on Host.
    - Call `aclrtMemset` interface to initialize Host or Device memory.
    - Call `aclrtFree` interface to release memory on Device.
    - Call `aclrtFreeHost` interface to release memory on Host.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer through memory copy.


## Sample Output

```text
[INFO]  Start to run device_P2P sample.
[INFO]  Device 0 to device 1 memcpy success.
[INFO]  Device 1 to host memcpy success.
[INFO]  The data read from the memory is 103, verify success!
[INFO]  Run the device_P2P sample successfully.
```