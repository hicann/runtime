# 2_event_wait_diagnostics

## Description

This sample demonstrates how a single-Device application diagnoses Event waiting between a producer Stream and a consumer Stream. It records the available Event counts before and after creation and obtains the Event ID after the first Record. It then gives the consumer a finite wait timeout and verifies both the wait-state transition from incomplete to complete and the final data result.

An ordinary Event may allocate its underlying resource only when it is first recorded, so the available counts are diagnostic values and are not required to decrease by exactly one after creation. This sample must create the Event with `aclrtCreateEvent`; it cannot be replaced by `aclrtCreateEventExWithFlag`.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to an environment where CANN is installed and switch to the sample directory.

```bash
cd ${git_clone_path}/example/1_basic_features/event/2_event_wait_diagnostics
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root. The default is /usr/local/Ascend.
source ${install_root}/cann/set_env.sh

# Automatically detect SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality and interfaces used in this sample are as follows:

- Initialization
    - Call `aclInit` for initialization.
    - Call `aclFinalize` for deinitialization.
- Device Management
    - Call `aclrtSetDevice` to select the Device used for computation.
    - Call `aclrtResetDeviceForce` to forcibly reset the current Device and reclaim its resources.
- Context Management
    - Call `aclrtCreateContext` to create a Context.
    - Call `aclrtDestroyContext` to destroy the Context.
- Stream Management
    - Call `aclrtCreateStream` to create the producer and consumer Streams.
    - Call `aclrtStreamWaitEventWithTimeout` to enqueue a bounded Event Wait task on the consumer Stream.
    - Call `aclrtSynchronizeStream` to wait for Stream tasks to complete.
    - Call `aclrtDestroyStream` to destroy a Stream.
    - Call `aclrtDestroyStreamForce` to forcibly destroy a Stream on a failed cleanup path.
- Event Management
    - Call `aclrtGetEventAvailNum` to query the number of available Events on the current Device.
    - Call `aclrtCreateEvent` to create an ordinary Event.
    - Call `aclrtGetEventId` to obtain the Event ID.
    - Call `aclrtRecordEvent` to record the Event on the producer Stream.
    - Call `aclrtQueryEventWaitStatus` to query whether the Event's wait tasks have completed.
    - Call `aclrtDestroyEvent` to destroy the Event.
- Memory Management and Data Transfer
    - Call `aclrtMalloc` to allocate Device memory.
    - Call `aclrtMemcpy` to copy data between Host and Device.
    - Call `aclrtFree` to release Device memory.

## Sample Output

```text
[INFO]: Current compile soc version is ...
Configuring CMake...
Building...
[INFO]  Available Events before creation: ...
[INFO]  Available Events after creation: ...
[INFO]  Producer starts a long task: value += 1.
[INFO]  Recorded ordinary Event ID: ...
[INFO]  Consumer waits for the Event with a 5-second timeout.
[INFO]  Wait status before consumer synchronization: NOT_READY.
[INFO]  Consumer submits the dependent task: value *= 2.
[INFO]  Wait status after consumer synchronization: COMPLETE.
[INFO]  Output value: 2 (expected: 2).
[INFO]  [SUCCESS] Event wait diagnostics sample completed successfully.
[SUCCESS] Event wait diagnostics sample executed successfully.
```
