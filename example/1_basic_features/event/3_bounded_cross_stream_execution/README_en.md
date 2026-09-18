# 3_bounded_cross_stream_execution

## Description

This sample demonstrates how a single-Device data-processing pipeline applies operation execution, cross-Stream Event wait, and Device synchronization timeouts together. It reads the hardware operation-timeout interval, configures operation timeouts in seconds and microseconds, and verifies the effective hardware values. It then gives a consumer Stream a finite budget to wait for a producer Event, submits asynchronous data transfers, synchronizes the Device within a bounded time, and compares every input and output value to verify the cross-Stream dependency.

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
cd ${git_clone_path}/example/1_basic_features/event/3_bounded_cross_stream_execution
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
- Operation Execution Timeout Configuration
    - Call `aclrtGetOpTimeOutInterval` to obtain the hardware operation-timeout interval.
    - Call `aclrtSetOpExecuteTimeOut` to set the operation execution timeout in seconds.
    - Call `aclrtSetOpExecuteTimeOutV2` to set the operation execution timeout in microseconds and obtain its effective value.
    - Call `aclrtGetOpExecuteTimeout` to read back the effective hardware operation execution timeout in milliseconds.
- Device Management
    - Call `aclrtSetDevice` to select the Device used for computation.
    - Call `aclrtSynchronizeDeviceWithTimeout` to wait a bounded time for Device tasks to complete.
    - Call `aclrtResetDeviceForce` to forcibly reset the current Device and reclaim its resources.
- Context Management
    - Call `aclrtCreateContext` to create a Context.
    - Call `aclrtDestroyContext` to destroy the Context.
- Stream and Event Management
    - Call `aclrtCreateStream` to create the producer and consumer Streams.
    - Call `aclrtCreateEvent` to create the Event used for cross-Stream synchronization.
    - Call `aclrtSetOpWaitTimeout` to set the wait timeout for subsequent Event Wait tasks.
    - Call `aclrtRecordEvent` to record the Event on the producer Stream.
    - Call `aclrtStreamWaitEvent` to make the consumer Stream wait for the producer Event.
    - Call `aclrtDestroyEvent` to destroy the Event.
    - Call `aclrtDestroyStream` to destroy a Stream.
    - Call `aclrtDestroyStreamForce` to forcibly destroy a Stream on a failed cleanup path.
- Memory Management and Data Transfer
    - Call `aclrtMallocHost` to allocate page-locked Host memory.
    - Call `aclrtMalloc` to allocate Device memory.
    - Call `aclrtMemcpyAsync` to transfer data asynchronously on the producer and consumer Streams.
    - Call `aclrtFreeHost` and `aclrtFree` to release memory.

## Sample Output

```text
Configuring CMake...
Building...
[INFO]  Hardware operation timeout interval: ... us.
[INFO]  Second-level request: 1 s; hardware readback: ... ms.
[INFO]  Microsecond request: ... us; actual: ... us.
[INFO]  Event wait budget: 5 s.
[INFO]  Submitted producer copy, cross-Stream Event wait, and consumer copy.
[INFO]  Device synchronized within 5000 ms.
[INFO]  Verified 256 values transferred across the Event dependency.
[INFO]  [SUCCESS] Bounded cross-Stream execution sample completed successfully.
[SUCCESS] Bounded cross-Stream execution sample executed successfully.
```
