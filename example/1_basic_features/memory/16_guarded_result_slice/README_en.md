# 16_guarded_result_slice

## Description

This sample demonstrates a partial result-table update on one Device. It fills the result table with a 32-bit sentinel and asynchronously copies a source-data slice through device-resident base addresses and byte offsets. After copying the result table back, the sample verifies the target slice and the untouched regions before and after it. This pattern is useful when only part of a result must be updated while unintended out-of-range writes must be detected.

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
cd ${git_clone_path}/example/1_basic_features/memory/16_guarded_result_slice
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root. The default installation root is /usr/local/Ascend
source ${install_root}/cann/set_env.sh

# Load the Runtime sample environment settings
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their corresponding APIs in this sample are as follows:

- Initialization
    - Call `aclInit` to perform initialization configuration.
    - Call `aclFinalize` to perform deinitialization.
- Device Management
    - Call `aclrtSetDevice` to specify the Device used for computation.
    - Call `aclrtResetDeviceForce` to forcibly reset the current Device and reclaim Device resources.
- Stream Management
    - Call `aclrtCreateStream` to create a Stream.
    - Call `aclrtSynchronizeStream` to block until tasks on the Stream are complete.
    - Call `aclrtDestroyStreamForce` to forcibly destroy the Stream.
- Memory Management
    - Call `aclrtMallocHost` to allocate pinned Host memory.
    - Call `aclrtMalloc` to allocate Device memory.
    - Call `aclrtMemsetD32` to synchronously fill the expected Host result table with a 32-bit unsigned value.
    - Call `aclrtMemsetD32Async` to asynchronously fill the Device result table with a 32-bit unsigned value on a Stream.
    - Call `aclrtFreeHost` to free Host memory.
    - Call `aclrtFree` to free Device memory.
- Data Transfer
    - Call `aclrtMemcpy` to transfer data between Host and Device.
    - Call `aclrtMemcpyAsyncWithOffset` to asynchronously copy a result slice within the Device through indirect base addresses and offsets.

## Sample Output

```text
Configuring CMake...
Building...
...
[INFO]  Verified Host sentinel baseline (16 elements)
[INFO]  Prepared expected result table with sentinel 0xDEADBEEF
[INFO]  Verified prefix guard [0, 5)
[INFO]  Verified copied slice [5, 11)
[INFO]  Verified suffix guard [11, 16)
[INFO]  [SUCCESS] Guarded result slice sample completed successfully
[SUCCESS] Guarded result slice sample executed successfully.
```
