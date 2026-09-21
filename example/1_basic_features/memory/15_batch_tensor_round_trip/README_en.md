# 15_batch_tensor_round_trip

## Description

This sample demonstrates batched round-trip transfers for independent small tensors during inference preprocessing and postprocessing. It uses the same group of tensors with different lengths in four modes: legacy synchronous, V2 synchronous, legacy asynchronous, and V2 asynchronous. Each mode transfers the tensors from Host to Device and back from Device to Host, then verifies every element of every tensor.

The output shows that the legacy APIs set `failIndex` to `SIZE_MAX` after successful copies, while the V2 APIs return only the call result and no longer provide a `failIndex` output parameter.

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
cd ${git_clone_path}/example/1_basic_features/memory/15_batch_tensor_round_trip
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root. The default is /usr/local/Ascend.
source ${install_root}/cann/set_env.sh

# Load the Runtime sample environment configuration.
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
    - Call `aclrtSynchronizeStream` to block until tasks on the Stream have completed.
    - Call `aclrtDestroyStreamForce` to forcibly destroy the Stream.
- Memory Management
    - Call `aclrtMallocHost` to allocate page-locked Host memory.
    - Call `aclrtMalloc` to allocate Device memory.
    - Call `aclrtFreeHost` to release Host memory.
    - Call `aclrtFree` to release Device memory.
- Batched Data Transfer
    - Call `aclrtMemcpyBatch` to synchronously transfer batches from Host to Device and Device to Host and obtain the failed-copy index through `failIndex`.
    - Call `aclrtMemcpyBatchV2` to synchronously transfer batches from Host to Device and Device to Host without a `failIndex` output parameter.
    - Call `aclrtMemcpyBatchAsync` to asynchronously transfer batches from Host to Device and Device to Host on a Stream and obtain the failed-copy index through `failIndex`.
    - Call `aclrtMemcpyBatchAsyncV2` to asynchronously transfer batches from Host to Device and Device to Host on a Stream without a `failIndex` output parameter.

## Sample Output

```text
Configuring CMake...
Building...
...
[INFO]  Legacy synchronous mode returned ACL_SUCCESS; H2D and D2H failIndex are SIZE_MAX
[INFO]  Legacy synchronous mode verified tensor 0 (4 elements)
[INFO]  Legacy synchronous mode verified tensor 1 (7 elements)
[INFO]  Legacy synchronous mode verified tensor 2 (11 elements)
[INFO]  V2 synchronous mode returned ACL_SUCCESS for H2D and D2H; V2 has no failIndex output
[INFO]  V2 synchronous mode verified tensor 0 (4 elements)
[INFO]  V2 synchronous mode verified tensor 1 (7 elements)
[INFO]  V2 synchronous mode verified tensor 2 (11 elements)
[INFO]  Legacy asynchronous mode returned ACL_SUCCESS; H2D and D2H failIndex are SIZE_MAX
[INFO]  Legacy asynchronous mode verified tensor 0 (4 elements)
[INFO]  Legacy asynchronous mode verified tensor 1 (7 elements)
[INFO]  Legacy asynchronous mode verified tensor 2 (11 elements)
[INFO]  V2 asynchronous mode returned ACL_SUCCESS for H2D and D2H; V2 has no failIndex output
[INFO]  V2 asynchronous mode verified tensor 0 (4 elements)
[INFO]  V2 asynchronous mode verified tensor 1 (7 elements)
[INFO]  V2 asynchronous mode verified tensor 2 (11 elements)
[INFO]  [SUCCESS] Batch tensor round-trip sample completed successfully
[SUCCESS] Batch tensor round-trip sample executed successfully.
```
