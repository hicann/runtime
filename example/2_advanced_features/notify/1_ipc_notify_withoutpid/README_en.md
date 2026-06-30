## 1_ipc_notify_withoutpid

## Description
This sample demonstrates Notify sharing between two Devices and two processes, with process whitelist validation disabled when sharing Notify.

## Product Support

This sample has the following support status on the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run
- For environment preparation and environment variable configuration details, see [README](../../../README_en.md) in the example directory.


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
    - Call aclrtDeviceCanAccessPeer interface to query whether Devices support data interaction.
    - Call aclrtDeviceEnablePeerAccess interface to enable data interaction between current Device and specified Device.
- Stream Management
    - Call aclrtCreateStream interface to create Stream.
    - Call aclrtDestroyStreamForce interface to forcibly destroy Stream, discarding all tasks.
    - Call aclrtSynchronizeStream interface to block waiting for Stream task completion.
- Memory Management
    - Call aclrtMalloc interface to allocate Device memory.
    - Call aclrtFree interface to release Device memory.
    - Call aclrtIpcMemGetExportKey interface to set specified Device memory as IPC shared memory, and return shared memory key.
    - Call aclrtIpcMemImportByKey interface to get key information, and return Device memory address pointer usable by current process.
    - Call aclrtIpcMemClose interface to close IPC shared memory.
- Notify Management
    - Call aclrtCreateNotify interface to create Notify.
    - Call aclrtNotifyGetExportKey interface to set specified Notify in current process as IPC Notify, and return key (Notify shared name), used for task synchronization across different processes on multiple Devices.
    - Call aclrtWaitAndResetNotify interface to block specified Stream execution until specified Notify completes, then reset Notify.
    - Call aclrtDestroyNotify interface to destroy Notify.
    - Call aclrtNotifyImportByKey interface to get key information in current process, and return Notify pointer usable by current process.
    - Call aclrtRecordNotify interface to record a Notify on specified Stream.


## Sample Output

```text
[INFO]  Process A: enable data interaction between device 2 and device 3
[INFO]  Process A: get a shareable identifier for IPC memory sharing successfully, shareable identifier = ...
[INFO]  Process A: get a shareable identifier for IPC notify sharing successfully, shareable identifier = ...
[INFO]  Process B: enable data interaction between device 3 and device 2
[INFO]  Process B: get the shareable identifier for IPC memory sharing successfully, shareable identifier = ...
[INFO]  Process B: get the shareable identifier for IPC notify sharing successfully, shareable identifier = ...
[INFO]  Process B: write data 123 to the device memory ...
Destination data: 123
[SUCCESS] IPC notify for task synchronization is successful. Values at source and destination are equal: 123
```

## Known Issues

  None
