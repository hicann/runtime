# 3_d2h_sync_memory_copy

## Description
This sample demonstrates synchronous memory copy from Device to Host using the `aclrtMemcpy` API for data transfer.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | √ |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | √ |

## Build and Run

1. Download the sample code to an environment where CANN software is installed, and switch to the sample directory.
```bash
cd ${git_clone_path}/example/1_basic_features/memory/3_d2h_sync_memory_copy
```

2. Set environment variables.
```bash
# Replace ${install_root} with the CANN installation root directory, which is installed in `/usr/local/Ascend` by default
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Set SOC_VERSION and ASCENDC_CMAKE_DIR
# -SOC_VERSION: The model of the Ascend AI processor, such as Ascend910_9362, Ascend910B2, and so on
# -ASCENDC_CMAKE_DIR: The sample involves calling AscendC operators. Configure the AscendC compiler ascendc.cmake path, such as /usr/local/Ascend/cann/x86_64-linux/tikcpp/ascendc_kernel_cmake
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to execute the sample.
```bash
bash run.sh
```
## CANN RUNTIME API

The key functionality points and their corresponding APIs in this sample are as follows:
- Initialization
    - Call `aclInit` to perform initialization configuration.
    - Call `aclFinalize` to perform deinitialization.
- Device Management
    - Call `aclrtSetDevice` to specify the Device for computation.
    - Call `aclrtResetDeviceForce` to forcibly reset the current Device and reclaim Device resources.
- Stream Management
    - Call `aclrtCreateStream` to create a Stream.
    - Call `aclrtDestroyStreamForce` to forcibly destroy a Stream and discard all tasks.
- Memory Management
    - Call `aclrtMallocHost` to allocate memory on the Host.
    - Call `aclrtMalloc` to allocate memory on the Device.
    - Call `aclrtFreeHost` to free memory on the Host.
    - Call `aclrtFree` to free memory on the Device.
- Data Transfer
    - Call `aclrtMemcpy` to implement Device-to-Host data transfer using memory copy.

## Sample Output

```text
[INFO]  Allocate memory on the host memory 0x... successfully
[INFO]  Allocate memory on the device memory 0x... successfully
[INFO]  Write the data 123 to the virtual memory 0x...
[INFO]  Copy memory from memory 0x... to memory 0x...
[INFO]  Destination data: 123
Source data: 123
```
