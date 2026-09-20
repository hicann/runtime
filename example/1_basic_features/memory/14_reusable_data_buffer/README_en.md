# 14_reusable_data_buffer

## Description

This sample demonstrates reusing one `aclDataBuffer` while processing data batches on a single device. It prepares separate device buffers for two valid lengths, switches the descriptor from the shorter payload to the longer payload, and verifies the address, valid size, and byte-for-byte copied content before and after the update. This pattern applies when input addresses and lengths vary between batches.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to an environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/1_basic_features/memory/14_reusable_data_buffer
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
- Memory management
    - Call `aclrtMallocAlign32` to allocate device memory with a size aligned to 32 bytes for data with two valid lengths.
    - Call `aclrtFree` to free device memory.
- DataBuffer management
    - Call `aclCreateDataBuffer` to create an `aclDataBuffer` that describes a data address and valid size.
    - Call `aclUpdateDataBuffer` to update the data address and valid size in the same `aclDataBuffer`.
    - Call `aclGetDataBufferAddr` to obtain and verify the data address in the `aclDataBuffer`.
    - Call `aclGetDataBufferSizeV2` to obtain and verify the valid data size in the `aclDataBuffer`.
    - Call `aclDestroyDataBuffer` to destroy the `aclDataBuffer`.
- Data transfer
    - Call `aclrtMemcpy` to transfer data between the host and device and verify the content referenced by the descriptor.

## Sample Output

```text
Configuring CMake...
Building...
...
[INFO]  Verified short payload binding: address=0x..., size=37 bytes, content matched
[INFO]  Updated one aclDataBuffer from 37 to 83 bytes
[INFO]  Verified long payload binding: address=0x..., size=83 bytes, content matched
[INFO]  [SUCCESS] Reusable data buffer sample completed successfully
[SUCCESS] Reusable data buffer sample executed successfully.
```
