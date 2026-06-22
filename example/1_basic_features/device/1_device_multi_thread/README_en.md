# 1_device_multi_thread

## Description
This sample demonstrates the Device management flow in multi-thread scenarios. The main thread specifies Device and sets Device resource limits. The worker thread queries Device count, run mode, resource limits, and other information, then dispatches kernel function tasks. Finally, it releases Device, Stream, and memory resources.

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
cd ${git_clone_path}/example/1_basic_features/device/1_device_multi_thread
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
    - Call `aclrtGetSocName` interface to query the Ascend AI processor version of the current runtime environment.
    - Call `aclrtGetDeviceCount` interface to get available Device count.
    - Call `aclrtQueryDeviceStatus` interface to query Device status.
    - Call `aclrtGetRunMode` interface to get current run mode.
    - Call `aclrtGetDeviceUtilizationRate` interface to query utilization rate of Cube, Vector, AI CPU, and other modules on Device.
    - Call `aclrtDeviceGetStreamPriorityRange` interface to query hardware-supported Stream priority range.
    - Call `aclrtGetDeviceInfo` interface to get specified Device attribute information.
    - Call `aclrtSetDeviceResLimit` interface to set Device resource limits for the current process.
    - Call `aclrtGetDeviceResLimit` interface to get Device resource limits for the current process.
    - Call `aclrtResetDeviceResLimit` interface to reset Device resource limits for the current process.
    - Call `aclrtResetDeviceForce` interface to forcefully reset the current computation Device and reclaim Device resources.
- Stream Management
    - Call `aclrtCreateStream` interface to create a Stream.
    - Call `aclrtSynchronizeStream` interface to block and wait for Stream tasks to complete.
    - Call `aclrtDestroyStream` interface to destroy a Stream.
- Memory Management
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtMallocHost` interface to allocate memory on Host.
    - Call `aclrtFree` interface to release memory on Device.
    - Call `aclrtFreeHost` interface to release memory on Host.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer through memory copy.

## Sample Output

```text
[INFO]  Start to run device_multi_thread sample.
[INFO]  Current Ascend chipset platform is: Ascend910_9362.
[INFO]  Get device count success. deviceCount: 2.
[INFO]  Query device status success. deviceStatus: 0.
[INFO]  RunMode is ACL_HOST.
[INFO]  Get device resLimit success. VECTOR_CORE 1.
[INFO]  Thr results (first 10 elements) of the kernel function:
[INFO]  Result: hostDst[0]: 0.000000 Expected value: 0.000000
[INFO]  Result: hostDst[1]: 2.000000 Expected value: 2.000000
...
[INFO]  Result: hostDst[9]: 18.000000 Expected value: 18.000000
[INFO]  Run the device_multi_thread sample successfully.
```