# 0_simple_zero_copy

## Description

This sample demonstrates vector addition performed directly through mapped host memory on a single supported Device. The application allocates three blocks of pinned host memory, registers and maps them to Device-accessible addresses, and passes those mapped addresses to an AscendC Kernel. The Kernel adds two deterministic FP16 inputs and writes directly to the mapped host output buffer. After synchronizing the Stream, the application verifies all 16,384 results. Any API, result verification, or resource cleanup failure prints `ERROR` and returns a non-zero value.

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
cd ${git_clone_path}/example/3_memory_advanced/host_register/0_simple_zero_copy
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh

# Automatically detect SOC_VERSION and ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to compile and execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization
    - Call `aclInit` to perform initialization configuration.
    - Call `aclFinalize` to perform deinitialization.
- Device management
    - Call `aclrtSetDevice` to select the Device used for computation.
    - Call `aclrtResetDeviceForce` to forcibly reset the current Device and reclaim Device resources.
- Stream management
    - Call `aclrtCreateStream` to create a Stream.
    - Call `aclrtSynchronizeStream` to wait for Kernel completion before reading the output on the Host.
    - Call `aclrtDestroyStream` to destroy the Stream.
- Host memory management
    - Call `aclrtMallocHost` to allocate pinned host memory.
    - Call `aclrtHostRegisterV2` to register pinned host memory for Device mapping.
    - Call `aclrtHostGetDevicePointer` to obtain the mapped Device address for host memory.
    - Call `aclrtHostUnregister` to unregister host memory.
    - Call `aclrtFreeHost` to release pinned host memory.
- Kernel loading and execution
    - Call `aclrtBinaryLoadFromFile` to load the AscendC Kernel binary.
    - Call `aclrtBinaryGetFunction` to obtain the Kernel function handle.
    - Call `aclrtKernelArgsInit` to initialize the Kernel argument list.
    - Call `aclrtKernelArgsAppend` to append the three mapped Device addresses to the argument list.
    - Call `aclrtKernelArgsFinalize` to complete Kernel argument assembly.
    - Call `aclrtLaunchKernelWithConfig` to launch the vector-add Kernel.
    - Call `aclrtBinaryUnLoad` to unload the Kernel binary.

## Sample Output

```text
[INFO]: Current compile soc version is Ascend910B3
...
[INFO]  Start to run simple_zero_copy sample.
[INFO]  Registered three Host buffers and obtained their Device mapping addresses.
[INFO]  Verified 16384 FP16 additions through mapped Host memory.
[INFO]  Run the simple_zero_copy sample successfully.
```
