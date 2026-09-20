# 2_reusable_stream_handoff

## Description

This sample demonstrates how producer and consumer Streams on one Device rotate data through three slots coordinated by a reusable Notify set. Each round generates data tagged with its round and slot, records and checks the Notify IDs, makes the consumer Stream wait for the matching producer transfer, and verifies every output value. It then batch-resets all Notifies. Three rounds with distinct data patterns verify that no state or data leaks across rounds or slots.

This sample does not support Ascend virtualization instances.

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
cd ${git_clone_path}/example/2_advanced_features/notify/2_reusable_stream_handoff
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root. The default is /usr/local/Ascend.
source ${install_root}/cann/set_env.sh
```

3. Build and run the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality and interfaces used in this sample are as follows:

- Initialization
    - Call `aclInit` for initialization.
    - Call `aclFinalize` for deinitialization.
- Device and Context Management
    - Call `aclrtSetDevice` to select the Device used for computation.
    - Call `aclrtCreateContext` to create a Context.
    - Call `aclrtDestroyContext` to destroy the Context.
    - Call `aclrtResetDeviceForce` to forcibly reset the current Device and reclaim its resources.
- Stream Management and Data Transfer
    - Call `aclrtCreateStream` to create the producer and consumer Streams.
    - Call `aclrtMemcpyAsync` to transfer the data for each slot asynchronously.
    - Call `aclrtSynchronizeStream` to wait for one round of tasks to complete.
    - Call `aclrtDestroyStream` to destroy a Stream.
    - Call `aclrtDestroyStreamForce` to forcibly destroy Streams on a failed cleanup path.
- Notify Management
    - Call `aclrtCreateNotify` to create one Notify for each data slot.
    - Call `aclrtGetNotifyId` to record the Notify IDs and verify that they remain stable before each reuse round.
    - Call `aclrtRecordNotify` to record data readiness on the producer Stream.
    - Call `aclrtWaitAndResetNotify` to make the consumer Stream wait for the matching slot data.
    - Call `aclrtNotifyBatchReset` to reset all Notifies after each round is verified.
    - Call `aclrtDestroyNotify` to destroy a Notify.
- Memory Management
    - Call `aclrtMallocHost` and `aclrtMalloc` to allocate Host and Device memory, respectively.
    - Call `aclrtFreeHost` and `aclrtFree` to release the memory.

## Sample Output

```text
Configuring CMake...
Building...
[INFO]  Notify slot 0 has ID ....
[INFO]  Notify slot 1 has ID ....
[INFO]  Notify slot 2 has ID ....
[INFO]  Round 1 reused 3 stable Notify IDs.
[INFO]  Round 1 verified 96 values without cross-round or cross-slot interference.
[INFO]  Round 1 batch-reset 3 Notifies.
[INFO]  Round 2 reused 3 stable Notify IDs.
[INFO]  Round 2 verified 96 values without cross-round or cross-slot interference.
[INFO]  Round 2 batch-reset 3 Notifies.
[INFO]  Round 3 reused 3 stable Notify IDs.
[INFO]  Round 3 verified 96 values without cross-round or cross-slot interference.
[INFO]  Round 3 batch-reset 3 Notifies.
[INFO]  [SUCCESS] Reusable Stream handoff sample completed successfully.
[SUCCESS] Reusable Stream handoff sample executed successfully.
```
