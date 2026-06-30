# 1_ipcevent_multi_device

## Description
This sample demonstrates cross-process task synchronization using **IPC Event** on **multiple Devices**.
- **Producer process (proc_a)**: Runs on Device 0, creates an IPC Event, records event and exports handle to file, then waits for all consumer processes to complete.
- **Consumer process (proc_b)**: Runs on other Devices (such as Device 1, Device 2, and so on), each consumer reads event handle, opens event, waits for the event in Stream, then records event to notify producer.

Through this approach, one producer can synchronize multiple consumers running on different Devices, achieving distributed task coordination.

## Product Support

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run

For environment installation details and general running steps, see [README](../../../README_en.md) in the example directory.

Run steps:

```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh

# Automatically identify SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh

# Build and run
bash run.sh
```

This sample requires at least 2 available Devices. `CONSUMER_NUM` in `run.sh` defaults to 1, meaning producer uses Device 0 and consumer uses Device 1; to start more consumers, adjust `CONSUMER_NUM` based on actual available Device count.
Before launching processes, `run.sh` calls `aclrtGetDeviceCount` to check the available Device count. If there are not enough Devices, it prints a `[SKIP]` message and exits with code 0 so automation can treat the result as an unmet environment requirement instead of a sample failure.

## CANN RUNTIME API

Key features and interfaces in this sample:

- Initialization
    - Call `aclInit` interface to initialize configuration.
    - Call `aclFinalize` interface to deinitialize.
- Device Management
    - Call `aclrtSetDevice` interface to specify Device for computation.
    - Call `aclrtResetDevice` interface to reset current computation Device and reclaim Device resources.

    Note: This sample is a multi-process IPC scenario on one host. Each process calls `aclrtResetDevice` when it exits to release its own Device resources, avoiding the forced reset effect of `aclrtResetDeviceForce` on other processes on the same host.
- Stream Management
    - Call `aclrtCreateStream` interface to create Stream.
    - Call `aclrtSynchronizeStream` interface to block waiting for Stream task completion.
    - Call `aclrtDestroyStream` interface to destroy Stream.
- Event Management
    - Call `aclrtCreateEventExWithFlag` interface to create IPC-enabled Event.
    - Call `aclrtRecordEvent` interface to record Event.
    - Call `aclrtSynchronizeEvent` interface to block waiting for Event completion.
    - Call `aclrtQueryEventStatus` interface to query Event status.
    - Call `aclrtIpcGetEventHandle` interface to get Event IPC handle.
    - Call `aclrtIpcOpenEventHandle` interface to open IPC Event.
    - Call `aclrtStreamWaitEvent` interface to block Stream waiting for Event completion.
    - Call `aclrtDestroyEvent` interface to destroy Event.

## Sample Output

```text
[INFO] Starting producer on device 0, waiting for 1 consumer(s)...
[INFO] Starting consumer 1 on device 1
[INFO]  Consumer 1: IPC event opened on device 1
[INFO]  Consumer 1: event received, stream synchronized
[INFO]  Consumer 1: event status = 1 (1=completed)
[INFO]  Consumer 1 (device 1) finished successfully.
[INFO]  Producer: IPC event created on device 0
[INFO]  Producer: event status = 1 (1=completed)
[INFO]  All 1 consumers have finished.
[INFO]  Producer: finished successfully.
[SUCCESS] IPC event multi-device synchronization works correctly.
```
