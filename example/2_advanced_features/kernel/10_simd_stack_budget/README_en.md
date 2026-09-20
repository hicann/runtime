# 10_simd_stack_budget

## Description

This sample demonstrates the complete flow for reserving stack space before a single-Device compute task executes a SIMD Kernel with a large amount of local data. After initialization and before binding the Device, the program configures the per-AI-Core SIMD stack budget for the current process to 64 KiB, a value supported by A2, A3, and A5, and reads the setting back for confirmation. It then runs a validation Kernel that uses 48 KiB of local stack data and verifies the deterministic checksum copied back to the Host. The program returns a nonzero value if the configured budget differs, the Kernel result is incorrect, or any Runtime operation or cleanup fails.


## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/10_simd_stack_budget
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/cann/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to compile and execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization and Deinitialization
    - Call `aclInit` to initialize the Runtime environment.
    - Call `aclFinalize` for deinitialization.
- Device Management
    - Call `aclrtDeviceSetLimit` before binding a Device to set the SIMD stack budget for the current process to 64 KiB.
    - Call `aclrtDeviceGetLimit` to read and confirm the SIMD stack budget for the current process.
    - Call `aclrtSetDevice` to select the Device and apply the resource limit configured in advance.
    - Call `aclrtResetDeviceForce` to reset the Device and reclaim its resources.
- Stream Management
    - Call `aclrtCreateStream` to create the Stream used for Kernel execution.
    - Call `aclrtSynchronizeStream` to wait for the Kernel to finish.
    - Call `aclrtDestroyStreamForce` to destroy the Stream.
- Device Memory Management
    - Call `aclrtMalloc` to allocate Device memory for the Kernel checksum.
    - Call `aclrtMemcpy` to copy the Kernel checksum to the Host for verification.
    - Call `aclrtFree` to release the Device memory.
- Kernel Configuration and Execution
    - Call `aclrtBinaryLoadFromFile` to load the validation Kernel binary after the SIMD stack budget takes effect.
    - Call `aclrtBinaryGetFunction` to obtain a function handle from the validation Kernel name.
    - Call `aclrtLaunchKernelWithArgsArray` to launch the validation Kernel that uses local stack data.
    - Call `aclrtBinaryUnLoad` to unload the validation Kernel binary.

## Sample Output

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] SOC_VERSION=Ascend910_9362
[INFO] ASCENDC_CMAKE_DIR=...
...
[INFO]  Start to run the 10_simd_stack_budget sample.
[INFO]  Configured and verified the SIMD stack budget: 65536 bytes.
[INFO]  Verified Kernel checksum 723969 using 49152 bytes of local stack data.
[INFO]  Run the 10_simd_stack_budget sample successfully.
```
