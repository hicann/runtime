# 13_memcpy_descriptor

## Description

This sample demonstrates asynchronous data copying with a memcpy descriptor within a single device. It is suitable for scenarios where the source address, destination address, and copy length are managed together in a descriptor. The sample generates deterministic input data, performs a descriptor-based device-to-device copy, copies the result back after synchronization, and verifies every element.

## Supported Products

This sample supports the following products:

| Product | Supported |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run

1. Download the sample code to an environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/1_basic_features/memory/13_memcpy_descriptor
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root. The default path is /usr/local/Ascend.
source ${install_root}/cann/set_env.sh

# Load the Runtime sample environment configuration.
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functions and APIs used in this sample are as follows:

- Initialization
    - Call `aclInit` to initialize ACL.
    - Call `aclFinalize` to finalize ACL.
- Device management
    - Call `aclrtSetDevice` to select the device used for execution.
    - Call `aclrtResetDeviceForce` to reset the current device and release its resources.
- Stream management
    - Call `aclrtCreateStream` to create a stream.
    - Call `aclrtSynchronizeStream` to wait for tasks on the stream to complete.
    - Call `aclrtDestroyStreamForce` to forcibly destroy the stream.
- Memory management
    - Call `aclrtMalloc` to allocate device memory for the source data, destination data, and memcpy descriptor.
    - Call `aclrtFree` to free device memory.
- Data transfer
    - Call `aclrtMemcpy` to transfer data between the host and device.
    - Call `aclrtGetMemcpyDescSize` to obtain the amount of device memory required by a memcpy descriptor.
    - Call `aclrtSetMemcpyDesc` to record the source address, destination address, and copy length in the descriptor.
    - Call `aclrtMemcpyAsyncWithDesc` to asynchronously copy data within the device using the descriptor.

## Sample Output

```text
Configuring CMake...
Building...
...
[INFO]  Configured a ...-byte memcpy descriptor for 4096 bytes of data
[INFO]  Verified all 1024 copied elements
[INFO]  [SUCCESS] Memcpy descriptor sample completed successfully
[SUCCESS] Memcpy descriptor sample executed successfully.
```
