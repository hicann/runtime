# 4_stream_resource_budget

## Description

This sample demonstrates how a single-Device application checks the available Stream count before creating a Stream, sets a Vector Core resource limit for that Stream, and executes a minimal Kernel after binding the resource configuration to the current thread. The sample verifies the complete Stream resource budget lifecycle through configuration queries, Kernel output, and a final query of the restored default configuration.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed. Switch to the sample directory.

```bash
cd ${git_clone_path}/example/1_basic_features/stream/4_stream_resource_budget
```

2. Set environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory. The default installation is in /usr/local/Ascend.
source ${install_root}/cann/set_env.sh

# Automatically detect SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization
    - Call `aclInit` for ACL initialization.
    - Call `aclFinalize` for ACL finalization.
- Device Management
    - Call `aclrtSetDevice` to specify the Device used for computation.
    - Call `aclrtResetDeviceForce` to forcibly reset the current Device and reclaim its resources.
- Stream Management
    - Call `aclrtGetStreamAvailableNum` to get the number of Streams currently available on the Device.
    - Call `aclrtCreateStream` to create a Stream.
    - Call `aclrtSynchronizeStream` to wait for tasks on the Stream to finish.
    - Call `aclrtDestroyStream` to destroy the Stream.
    - Call `aclrtDestroyStreamForce` to forcibly destroy the Stream on the failure cleanup path.
- Stream Resource Configuration
    - Call `aclrtSetStreamResLimit` to set a Device resource limit for a Stream.
    - Call `aclrtGetStreamResLimit` to get the Device resource limit for a Stream.
    - Call `aclrtUseStreamResInCurrentThread` to use a Stream's Device resource limit in the current thread.
    - Call `aclrtUnuseStreamResInCurrentThread` to stop using a Stream's Device resource limit in the current thread.
    - Call `aclrtResetStreamResLimit` to reset the Device resource limit for a Stream.
- Memory Management and Data Transfer
    - Call `aclrtMalloc` to allocate Device memory.
    - Call `aclrtMemcpy` to copy data between the Host and Device.
    - Call `aclrtFree` to release Device memory.

## Sample Output

```text
[INFO]: Current compile soc version is ...
Configuring CMake...
Building...
[INFO]  Available Streams before creation: ...
[INFO]  Available Streams after creation: ...
[INFO]  Default Vector Core limit: ...
[INFO]  Configured Vector Core limit: 1.
[INFO]  Use the Stream resource limit in the current thread.
[INFO]  Kernel output: 42 (expected: 42).
[INFO]  Stop using the Stream resource limit in the current thread.
[INFO]  Reset Vector Core limit: ...
[INFO]  [SUCCESS] Stream resource budget sample completed successfully.
[SUCCESS] Stream resource budget sample executed successfully.
```
