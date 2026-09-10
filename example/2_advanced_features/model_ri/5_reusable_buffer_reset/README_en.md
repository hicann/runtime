# 5_reusable_buffer_reset

## Description

This sample demonstrates reusable Model RI capture, structure enumeration, and execution in CANN Runtime. On a single Device 0, it captures an asynchronous buffer reset as a reusable Model RI, uses `aclmdlRIGetStreams` and `aclmdlRIGetTasksByStream` to produce its Stream/Task manifest, and executes the model only when that manifest is valid, yielding a 4096-byte Device buffer whose bytes are all zero.

The program first verifies that the buffer contains non-zero bytes, then requires the Model RI to contain at least one Stream and one Task, and finally verifies every byte after execution. Any Runtime API, structural relationship, data invariant, or cleanup failure produces an `ERROR` and a non-zero return value. The final success marker is printed only after both business checks and cleanup succeed. `aclmdlRIGetStreams` and `aclmdlRIGetTasksByStream` are experimental features that may change in later releases and are not supported in production environments; this sample is for learning and functional validation only.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/model_ri/5_reusable_buffer_reset
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to compile and execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization and runtime condition validation
    - Calls `aclInit` to perform ACL Initialization.
    - Calls `aclrtGetDeviceCount` to confirm that Device 0 is available.
    - Calls `aclrtCreateContext` to create the Context used by the current thread on Device 0.
- Stream and buffer management
    - Calls `aclrtCreateStream` to create the Stream used to capture and execute the Model RI.
    - Calls `aclrtMalloc` to allocate the reusable Device buffer.
    - Calls `aclrtMemsetAsync` to prefill non-zero data and capture the asynchronous reset task.
    - Calls `aclrtSynchronizeStream` to wait for asynchronous prefill or model execution.
    - Calls `aclrtMemcpy` to copy the Device buffer to the Host for data verification.
- Model RI capture and structure manifest
    - Calls `aclmdlRICaptureBegin` to begin capturing the asynchronous reset task.
    - Calls `aclmdlRICaptureEnd` to end capture and obtain the reusable Model RI.
    - Calls `aclmdlRIGetStreams` twice to obtain the number and handles of Streams associated with the Model RI.
    - Calls `aclmdlRIGetTasksByStream` twice to obtain the number and handles of Tasks on each Stream.
- Model RI execution and resource cleanup
    - Calls `aclmdlRIExecuteAsync` to asynchronously execute the Model RI after its manifest is validated.
    - Calls `aclmdlRIDestroy` to destroy the Model RI.
    - Calls `aclrtFree` to release the Device buffer.
    - Calls `aclrtDestroyStream` to destroy the Stream.
    - Calls `aclrtDestroyContext` to destroy the explicitly created Context.
    - Calls `aclFinalize` to perform ACL Deinitialization.

## Sample Output

```text
[INFO]  Start to run 5_reusable_buffer_reset sample.
[INFO]  Prepared 4096-byte reusable buffer with pattern 0xA5.
[INFO]  Model RI manifest: streams=1, tasks=2.
[INFO]  Verified 4096-byte reusable buffer reset to zero.
[INFO]  Run the 5_reusable_buffer_reset sample successfully.
```

The Stream and Task counts above come from one successful run in a CANN 9.2.0 environment. They may vary with the CANN version, but both must be positive.
