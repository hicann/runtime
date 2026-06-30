# 10_ipc_memory_withpid

## Description
This sample demonstrates IPC-based Device memory sharing between two processes on the same Device with process whitelist validation enabled. Process B provides its process ID first. Process A adds Process B to the IPC shared memory whitelist and then exports the shared memory key. Process B then imports the shared memory using the key.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | √ |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | √ |

## Build and Run

This sample starts two processes, `proc_a` and `proc_b`, using `run.sh` and exchanges process IDs, shared memory keys, and completion flags through temporary files in the `file/` directory.

1. Download the sample code to an environment where CANN software is installed, and switch to the sample directory.
```bash
cd ${git_clone_path}/example/1_basic_features/memory/10_ipc_memory_withpid
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
    - Call `aclrtMalloc` to allocate memory on the Device.
    - Call `aclrtFree` to free memory on the Device.
    - Call `aclrtDeviceGetBareTgid` to get the current process ID.
    - Call `aclrtIpcMemGetExportKey` to set the specified Device memory as IPC shared memory and return the shared memory key.
    - Call `aclrtIpcMemSetImportPid` to set the process whitelist for IPC shared memory.
    - Call `aclrtIpcMemImportByKey` to get the key information and return the Device memory address available to the current process.
    - Call `aclrtIpcMemClose` to close the IPC shared memory.

## Sample Output

```text
[INFO]  Process B: get Process B's pid successfully
[INFO]  Process B: get the shareable memory identifier successfully, shareable identifier = ...
[INFO]  Process B: complete ipc memory sharing
Destination data: 123
[INFO]  Allocate memory on the device 0x... successfully
[INFO]  Write data 123 to the device address 0x...
[INFO]  Process A: get the shareable memory identifier ... successfully
[INFO]  Process A: add Process B to the whitelist successfully
Source data: 123
[INFO]  Process A: receive the completion signal from Process B, completion signal = 1
[SUCCESS] IPC memory sharing successfully. Values at source and destination are equal: 123
```
