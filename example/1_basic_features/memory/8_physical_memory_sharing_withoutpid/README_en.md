# 8_physical_memory_sharing_withoutpid

## Description
This sample demonstrates physical memory sharing between two processes on the same Device with process whitelist validation disabled. Process A allocates physical memory and exports a shareable handle. Process B imports the handle, maps virtual memory, and reads the shared data.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | √ |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | √ |

## Build and Run

This sample starts two processes, `proc_a` and `proc_b`, using `run.sh` and exchanges shareable handles and completion flags through temporary files in the `file/` directory.

1. Download the sample code to an environment where CANN software is installed, and switch to the sample directory.
```bash
cd ${git_clone_path}/example/1_basic_features/memory/8_physical_memory_sharing_withoutpid
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
    - Call `aclrtMemGetAllocationGranularity` to query the memory allocation granularity.
    - Call `aclrtMallocPhysical` to allocate Device physical memory and return a physical memory handle.
    - Call `aclrtReserveMemAddress` to reserve virtual memory.
    - Call `aclrtMapMem` to map virtual memory to physical memory.
    - Call `aclrtMemSetAccess` to set virtual memory access permissions.
    - Call `aclrtMemExportToShareableHandle` to export a physical memory shareable handle.
    - Call `aclrtMemImportFromShareableHandle` to import a shareable handle and get a physical memory handle available to the current process.
    - Call `aclrtUnmapMem` to unmap the relationship between virtual memory and physical memory.
    - Call `aclrtReleaseMemAddress` to release reserved virtual memory.
    - Call `aclrtFreePhysical` to free physical memory.
    - Call `aclrtMallocHost` to allocate memory on the Host.
    - Call `aclrtFreeHost` to free memory on the Host.
- Data Transfer
    - Call `aclrtMemcpy` to implement data transfer using memory copy.

## Sample Output

Typical output from Process A:

```text
[INFO]  Process A: allocate physical memory successfully
[INFO]  Process A: reserve virtual memory successfully
[INFO]  Process A: export a shareable handle successfully, shareable handle = ...
CANN Version: 1.0.0, TimeStamp: ...
Source data: 123
[INFO]  Process A: receive the completion signal from Process B, completion signal = 1
[INFO]  Process A: release the virtual and physical memory successfully
```

Typical output from Process B:

```text
[INFO]  Process B: get a shareable handle successfully, shareable handle = ...
[INFO]  Process B: map virtual memory address to physical memory handle
[INFO]  Process B: copy memory from device address 0x... to host address 0x...
[INFO]  Destination data: 123
[INFO]  Process B: complete the physical memory sharing
[INFO]  Process B: release the virtual and physical memory successfully
```