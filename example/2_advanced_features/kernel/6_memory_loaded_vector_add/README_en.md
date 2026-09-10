# 6_memory_loaded_vector_add

## Description

This sample targets single-Device applications that keep a Kernel binary in an in-memory cache, resource package, or network buffer. It reads the built Ascend C vector-add binary into Host memory, loads it on the current Device through `aclrtBinaryLoadFromData`, obtains the `add_custom` function, and performs FP16 vector addition. It then verifies every element against `1.0 + 2.0 = 3.0` and unloads the binary in the same Context before releasing all resources.

This sample is tested on a single Atlas A3 Device. Support for Atlas A2 and Ascend 950PR/Ascend 950DT is based on static admission against the public documentation for every source API; those products were not tested in this task.

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
cd ${git_clone_path}/example/2_advanced_features/kernel/6_memory_loaded_vector_add
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to compile and execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization
    - Call `aclInit` to initialize the ACL runtime environment.
    - Call `aclFinalize` for Deinitialization.
- Device Management
    - Call `aclrtSetDevice` to select Device 0 for loading and executing the Kernel.
    - Call `aclrtResetDeviceForce` to reset the Device and reclaim its resources.
- Stream Management
    - Call `aclrtCreateStream` to create the Stream that carries the Kernel task.
    - Call `aclrtSynchronizeStream` to wait for vector addition to finish.
    - Call `aclrtDestroyStreamForce` to destroy the Stream.
- FP16 Data Preparation and Verification
    - Call `aclFloatToFloat16` to convert deterministic inputs to FP16 values.
    - Call `aclFloat16ToFloat` to convert output elements and verify the computation.
- Memory Management
    - Call `aclrtMalloc` to allocate Device memory for the three vectors.
    - Call `aclrtMemcpy` to transfer the inputs and retrieve the result.
    - Call `aclrtFree` to release the Device vector memory.
- In-Memory Binary Loading and Execution
    - Call `aclrtBinaryLoadFromData` to load Kernel binary bytes from Host memory.
    - Call `aclrtBinaryGetFunction` to obtain the `add_custom` function from the loaded binary.
    - Call `aclrtLaunchKernelWithHostArgs` to pass Device addresses and launch the vector-add Kernel.
    - Call `aclrtBinaryUnLoad` to unload the Kernel binary in the same Context.

## Sample Output

```text
[INFO]  Start to run 6_memory_loaded_vector_add sample.
[INFO]  Loaded ... binary bytes from Host memory.
[INFO]  Verified 16384 FP16 additions: 1.0 + 2.0 = 3.0.
[INFO]  Run the 6_memory_loaded_vector_add sample successfully.
```
