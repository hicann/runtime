# 8_reusable_kernel_args

## Description

This sample demonstrates a complete workflow for user-managed, reusable Kernel argument memory on a single Device. It queries the required sizes of the argument-list handle area and argument data area from the Kernel function handle, allocates two Host buffers using those results, and initializes the argument list. The first launch writes scalar `7` to the Device output. The sample then uses the parameter handle returned by the initial append to change the scalar to `23`, finalizes the same argument list again, and launches the same Kernel a second time. It succeeds only when the two copied-back outputs are `7` and `23`, respectively, and every Runtime operation and cleanup succeeds.

The `userArgsSize` in this sample is the sum of the two Kernel argument sizes after each is aligned to eight bytes. The user allocates both the argument-list handle area and argument data area and releases them after destroying the Stream, demonstrating the memory ownership required by `aclrtKernelArgsInitByUserMem`.

## Product Support

The public documentation statically confirms that every source API supports the products below. This task completed a real-device run on a single Atlas A3 Device and cross-build validation for Atlas A2 and Ascend 950PR/Ascend 950DT.

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to an environment where CANN is installed and switch to the sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/8_reusable_kernel_args
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Build and run the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functions and APIs used in this sample are as follows:

- Initialization and Deinitialization
    - Call `aclInit` to initialize CANN Runtime.
    - Call `aclFinalize` to deinitialize CANN Runtime.
- Device and Stream Management
    - Call `aclrtSetDevice` to select the Device that executes the Kernel.
    - Call `aclrtResetDeviceForce` to reset the Device and reclaim related resources.
    - Call `aclrtCreateStream` to create the Stream used for Kernel execution.
    - Call `aclrtSynchronizeStream` to wait for each Kernel launch to complete.
    - Call `aclrtDestroyStreamForce` to destroy the Stream.
- Memory and Data Transfer
    - Call `aclrtMallocHost` to allocate the argument-list handle area and argument data area using the queried sizes.
    - Call `aclrtFreeHost` to release the two user-managed Host buffers.
    - Call `aclrtMalloc` to allocate Device memory for the Kernel output.
    - Call `aclrtMemcpy` to copy each Kernel output to Host for verification.
    - Call `aclrtFree` to release the output Device memory.
- Kernel Argument Construction and Reuse
    - Call `aclrtGetFuncBySymbol` to obtain the function handle from the Kernel symbol.
    - Call `aclrtKernelArgsGetHandleMemSize` to query the required argument-list handle area size.
    - Call `aclrtKernelArgsGetMemSize` to query the actual argument data area size from the aligned user argument total.
    - Call `aclrtKernelArgsInitByUserMem` to initialize the argument list with the two user-managed Host buffers.
    - Call `aclrtKernelArgsAppend` to append the output address and initial scalar in order and retain the scalar parameter handle.
    - Call `aclrtKernelArgsParaUpdate` to replace the initial scalar through its parameter handle.
    - Call `aclrtKernelArgsFinalize` after both initial appending and the parameter update to complete argument assembly.
    - Call `aclrtLaunchKernelWithConfig` to launch the Kernel twice with the same argument list.

## Sample Output

```text
[INFO]: Current compile soc version is Ascend910_9362
...
[INFO]  Start to run the 8_reusable_kernel_args sample.
[INFO]  Allocated user memory: handle=... bytes, argument buffer=... bytes.
[INFO]  Verified launch 1: scalar=7, output=7.
[INFO]  Updated the reusable scalar parameter from 7 to 23.
[INFO]  Verified launch 2: scalar=23, output=23.
[INFO]  Run the 8_reusable_kernel_args sample successfully.
```
