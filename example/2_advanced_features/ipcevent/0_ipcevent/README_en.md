# 0_ipcevent

## Description
This sample demonstrates task synchronization between two processes using **IPC Event**.
- Process A (producer): Creates IPC event, records event and exports handle, then waits for consumer to complete.
- Process B (consumer): Imports IPC event handle, waits for event, completes work then records event to notify producer.

This sample uses binary file to pass event handle, demonstrating core IPC event usage: create, export, import, wait, record, query, and destroy.

## Product Support

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run

This sample launches `proc_a` and `proc_b` processes simultaneously by `run.sh`, and exchanges IPC Event handle through temporary file.
For environment installation details and general running steps, see [README](../../../README_en.md) in the example directory.

## CANN RUNTIME API

Key features and interfaces in this sample:

- Initialization
    - Call `aclInit` interface to initialize configuration.
    - Call `aclFinalize` interface to deinitialize.
- Device Management
    - Call `aclrtSetDevice` interface to specify Device for computation.
    - Call `aclrtResetDevice` interface to reset Device.
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
[INFO]  Process A: IPC event created
[INFO]  Process A: event recorded and synchronized
[INFO]  Process A: event status = 1 (1=completed)
[INFO]  Process A: IPC event handle written to ./event_handle.bin
[INFO]  Process A: consumer finished
[INFO]  Process A: cleanup completed
[INFO]  Process B: IPC event opened
[INFO]  Process B: event received, stream synchronized
[INFO]  Process B: event status = 1 (1=completed)
[INFO]  Process B: cleanup completed
[SUCCESS] IPC event synchronization works correctly.
```