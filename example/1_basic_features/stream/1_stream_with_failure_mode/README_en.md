# 1_stream_with_failure_mode

## Description
This sample demonstrates Stream stop-on-error mode and simulates scenarios where errors occur during Stream execution through kernel function tasks.

This sample contains three parts: stop-on-error demonstration on normal Stream, `aclrtStreamStop` auxiliary demonstration, and `aclrtStreamAbort` auxiliary demonstration.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

If the current environment does not meet the additional prerequisites for `stop/abort` auxiliary demonstrations, the sample will print `WARN` and skip corresponding auxiliary demonstrations. The `aclrtSetStreamFailureMode` demonstration in the main flow will still execute.

1. Download the sample code to the environment where CANN software is installed. Switch to the sample directory.
```bash
cd ${git_clone_path}/example/1_basic_features/stream/1_stream_with_failure_mode
```

2. Set environment variables.
```bash
# Replace ${install_root} with the CANN installation root directory. The default installation is in the `/usr/local/Ascend` directory.
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Set SOC_VERSION and ASCENDC_CMAKE_DIR
# -SOC_VERSION: Ascend AI processor model, such as Ascend910_9362, Ascend910B2, and so on
# -ASCENDC_CMAKE_DIR: The sample involves calling AscendC operators. Configure the AscendC compiler ascendc.cmake path, such as /usr/local/Ascend/cann/x86_64-linux/tikcpp/ascendc_kernel_cmake
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to execute the sample.
```bash
bash run.sh
```
## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:
- Initialization
    - Call `aclInit` interface for initialization configuration.
    - Call `aclFinalize` interface for deinitialization.
- Device Management
    - Call `aclrtSetDevice` interface to specify the Device for computation.
    - Call `aclrtResetDeviceForce` interface to forcefully reset the current computation Device and reclaim Device resources.
- Context Management
    - Call `aclrtCreateContext` interface to create Context.
    - Call `aclrtDestroyContext` interface to destroy Context.
- Stream Management
    - Call `aclrtCreateStream` interface to create Stream.
    - Call `aclrtCreateStreamWithConfig` interface to create `ACL_STREAM_DEVICE_USE_ONLY` type Stream. On Atlas A2/Atlas A3, `aclrtStreamStop` requires the target Stream to be created through `aclrtCreateStreamWithConfig(..., ACL_STREAM_DEVICE_USE_ONLY)`.
    - Call `aclrtSynchronizeStream` interface to block and wait for Stream tasks to complete.
    - Call `aclrtSetStreamFailureMode` interface to set the operation when Stream execution encounters errors. Default is continue on error, can be set to stop on error.
    - Call `aclrtRegStreamStateCallback` interface to register Stream status callback.
    - Call `aclrtStreamStop` interface to stop auxiliary Stream. The sample will separately create a device-use-only Stream and call `aclrtStreamStop` after submitting a long-running kernel task on it.
    - Call `aclrtStreamAbort` interface to abort auxiliary Stream. `aclrtStreamAbort` does not support `ACL_STREAM_DEVICE_USE_ONLY` Stream, so the sample will demonstrate separately on normal Stream. When calling `aclrtSynchronizeStream` again after demonstration, it may return stream abort type status code, which is an expected result. The sample will log this but will not judge the entire flow as failed.
    - Call `aclrtDestroyStreamForce` interface to forcefully destroy Stream and discard all tasks.
- Memory Management
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtFree` interface to release memory on Device.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer through memory copy.

## Sample Output

```text
[INFO]  Assigning task without failure mode.
[ERROR]  Operation failed: aclrtSynchronizeStream(stream) returned error code 507035
[INFO]  Without failure mode, the result is 2.
[INFO]  Assigning task with failure mode.
[ERROR]  Operation failed: aclrtSynchronizeStream(stream) returned error code 507035
[INFO]  After set failure mode, the current result is: 1.
[INFO]  aclrtStreamStop returned 0.
[WARN]  aclrtSynchronizeStream(after stop) returned 507000.
[INFO]  aclrtStreamAbort returned 0.
[INFO]  aclrtSynchronizeStream(after abort) returned 507035 after stream abort, which is expected.
[INFO]  Resource cleanup completed.
[INFO]  Run the stream_with_failure_mode sample successfully.
```