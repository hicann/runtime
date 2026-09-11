# 0_prefetch_strategy_comparison

## Description

This sample is intended for developers choosing prefetch methods for Device worksets with different reuse patterns. On one Device, the program prepares two identical 256-element worksets and applies direct asynchronous prefetch to the one-time workset on a regular Stream. For the reused workset, it queries, allocates, and configures a reusable Device-side CMO descriptor, binds a persistent Stream to a minimal Model RI, and applies descriptor-based asynchronous prefetch. The same Ascend C Kernel transforms both worksets.

The program verifies every element from both prefetch paths against `output = input * 3 + 7` and confirms that the two results are identical. The queried descriptor size controls the actual allocation. Any Runtime API, result invariant, or cleanup failure produces an `ERROR` and a non-zero return value.

## Product Support

| Product | Supported |
| --- | --- |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Ascend 950PR/Ascend 950DT | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.
2. Set the environment variables.
3. Run the following command to compile and execute the sample.

```bash
cd ${git_clone_path}/example/3_memory_advanced/cache_maintenance/0_prefetch_strategy_comparison
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Runtime Initialization and Device management
    - `aclInit`: Initializes ACL Runtime.
    - `aclrtSetDevice`: Selects Device 0 for the prefetch strategy comparison.
    - `aclrtResetDeviceForce`: Releases Runtime resources on Device 0.
    - `aclFinalize`: Performs ACL Runtime Deinitialization.
- Stream and memory management
    - `aclrtCreateStream`: Creates the regular Stream for direct prefetch and the first Kernel invocation.
    - `aclrtCreateStreamWithConfig`: Creates a persistent Stream that can bind to the Model RI and carry descriptor CMO and the second Kernel invocation.
    - `aclrtMalloc`: Allocates two Device worksets, output buffers, and the CMO descriptor.
    - `aclrtMemcpy`: Synchronously writes the worksets before Model RI execution and reads both outputs afterward.
    - `aclrtSynchronizeStream`: Waits for direct prefetch and Kernel execution on the regular Stream and confirms it is idle again during cleanup.
    - `aclrtFree`: Frees Device memory for the worksets, outputs, and descriptor.
    - `aclrtDestroyStream`: Destroys both Streams used by the direct and descriptor prefetch paths.
- CMO prefetch strategies
    - `aclrtCmoAsync`: Submits direct asynchronous prefetch for the one-time workset.
    - `aclrtCmoGetDescSize`: Queries the Device memory size required by a reusable CMO descriptor.
    - `aclrtCmoSetDesc`: Records the reused workset address and size in the CMO descriptor.
    - `aclrtCmoAsyncWithDesc`: Submits asynchronous prefetch through the configured descriptor.
- Model RI task recording and execution
    - `aclmdlRIBuildBegin`: Starts building the minimal Model RI that carries the descriptor prefetch path.
    - `aclmdlRIBindStream`: Binds the persistent Stream as the Model RI head Stream.
    - `aclmdlRIEndTask`: Marks the end of descriptor prefetch and second Kernel task submission.
    - `aclmdlRIBuildEnd`: Completes Model RI construction so that the recorded tasks can execute.
    - `aclmdlRIExecute`: Synchronously executes the descriptor-prefetch computation path with a five-second timeout.
    - `aclmdlRIUnbindStream`: Unbinds the persistent Stream after result verification.
    - `aclmdlRIDestroy`: Destroys the Model RI when it is no longer needed.

## Sample Output

```text
[INFO]  Start to run 0_prefetch_strategy_comparison sample.
[INFO]  Verified 256 elements: direct and descriptor prefetch results are identical and correct.
[INFO]  Run the 0_prefetch_strategy_comparison sample successfully.
```
