# 12_cross_server_physical_memory_sharing_withoutpid

## Description
This sample demonstrates cross-server physical memory sharing using `aclrtMemExportToShareableHandleV2` and `aclrtMemImportFromShareableHandleV2` APIs with process whitelist validation disabled. The server allocates physical memory and exports a Fabric shareable handle. The client receives the handle over the network, imports it, and maps the physical memory.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | × |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | √ |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | × |

## Build and Run

This sample depends on cross-server shareable handle capabilities and is designed for Atlas A3 Training Series Products/Atlas A3 Inference Series Products only. It must be run on two servers with completed environment configuration and network connectivity.

1. Download the sample code to an environment where CANN software is installed, and switch to the sample directory on both the server and client.
```bash
cd ${git_clone_path}/example/1_basic_features/memory/12_cross_server_physical_memory_sharing_withoutpid
```

2. Set environment variables.

Run on both the server and client:
```bash
# Replace ${install_root} with the CANN installation root directory, which is installed in `/usr/local/Ascend` by default
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Set SOC_VERSION and ASCENDC_CMAKE_DIR
# -SOC_VERSION: The model of the Ascend AI processor, such as Ascend910_9362, Ascend910B2, and so on
# -ASCENDC_CMAKE_DIR: The sample involves calling AscendC operators. Configure the AscendC compiler ascendc.cmake path, such as /usr/local/Ascend/cann/x86_64-linux/tikcpp/ascendc_kernel_cmake
source ${git_clone_path}/example/set_sample_env.sh
```

3. First, run the following command on the server and enter the listening port when prompted. The default port is `8888`.
```bash
bash run_server.sh
```

4. Then, run the following command on the client and enter the server IP address and port when prompted. The port must match the server listening port.
```bash
bash run_client.sh
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
    - Call `aclrtSynchronizeStream` to block and wait for tasks on the Stream to complete.
    - Call `aclrtDestroyStreamForce` to forcibly destroy a Stream and discard all tasks.
- Memory Management
    - Call `aclrtMemGetAllocationGranularity` to query the memory allocation granularity.
    - Call `aclrtMallocPhysical` to allocate Device physical memory and return a physical memory handle.
    - Call `aclrtReserveMemAddress` to reserve virtual memory.
    - Call `aclrtMapMem` to map virtual memory to physical memory.
    - Call `aclrtMemSetAccess` to set virtual memory access permissions.
    - Call `aclrtMemExportToShareableHandleV2` to export a physical memory handle as a cross-server shareable Fabric handle. If the current environment does not support cross-server shareable handles, it may return `207000`.
    - Call `aclrtMemImportFromShareableHandleV2` to import a Fabric shareable handle and get a physical memory handle available to the current process.
    - Call `aclrtUnmapMem` to unmap the relationship between virtual memory and physical memory.
    - Call `aclrtReleaseMemAddress` to release reserved virtual memory.
    - Call `aclrtFreePhysical` to free physical memory.

## Sample Output

Typical server output:

```text
[INFO]: Current compile soc version is ...
[INFO]: Running server on port ...
[INFO]  Server: get memory allocation granularity successfully, granularity = ...
[INFO]  Server: allocate physical memory successfully
[INFO]  Server: reserve virtual memory successfully
[INFO]  Server: export shareable handle successfully
[INFO]  Server: listening on port ...
[INFO]  Server: send ipc message successfully, size = ...
[INFO]  Server: receive ipc message successfully, flag = 1
[INFO]  Server: ipc close successfully
[INFO]  Server: released memory successfully
[SUCCESS] Server completed successfully.
```

Typical client output:

```text
[INFO]: Current compile soc version is ...
[INFO]: Running client connecting to ...
[INFO]  Client: send connection message successfully
[INFO]  Client: import shareable handle successfully
[INFO]  Client: reserve virtual memory successfully
[INFO]  Client: map virtual memory address to physical memory handle
[INFO]  Client: released memory successfully
[SUCCESS] Client completed successfully
```