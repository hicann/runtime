# 5_fdtd_stencil

## Description

This sample demonstrates a complete three-dimensional finite-difference stencil update on a single Device. The program first confirms that the FDTD Kernel is a compatible Vector Core Kernel, writes the center and neighbor coefficients for the current update to a Device variable, updates a deterministic three-dimensional grid with halo cells, and compares all 64 interior points against Host reference results. The program returns a non-zero value if the Kernel type is incompatible, the Device variable size is unexpected, the maximum error exceeds `1e-5`, or any Runtime operation or cleanup fails.

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
cd ${git_clone_path}/example/2_advanced_features/kernel/5_fdtd_stencil
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

- Initialization and Deinitialization
    - Call `aclInit` to initialize CANN Runtime.
    - Call `aclFinalize` to perform Deinitialization.
- Device Management
    - Call `aclrtSetDevice` to select the Device that executes the FDTD computation.
    - Call `aclrtResetDeviceForce` to reset the Device and reclaim related resources.
- Stream Management
    - Call `aclrtCreateStream` to create the Stream used for Kernel execution.
    - Call `aclrtSynchronizeStream` to wait for the FDTD Kernel to finish.
    - Call `aclrtDestroyStreamForce` to destroy the Stream.
- Memory and Data Transfer
    - Call `aclrtMalloc` to allocate input and output Device memory.
    - Call `aclrtFree` to release input and output Device memory.
    - Call `aclrtMemcpy` to transfer grid data between Host and Device.
    - Call `aclrtGetSymbolSize` to confirm the size of the FDTD coefficient Device variable.
    - Call `aclrtMemcpyToSymbol` to write the current FDTD coefficients to the Device variable.
- Kernel Configuration and Execution
    - Call `aclrtGetFuncBySymbol` to obtain a function handle from the FDTD Kernel symbol.
    - Call `aclrtGetFunctionAttribute` to query the Kernel type and confirm Vector Core compatibility.
    - Call `aclrtLaunchKernelWithArgsArray` to dispatch the FDTD stencil update.

## Sample Output

```text
[INFO]: Current compile soc version is Ascend910_9362
...
[INFO]  Start to run the 5_fdtd_stencil sample.
[INFO]  Kernel type 2 confirms Vector Core compatibility.
[INFO]  Copied 2 FDTD coefficients to the Device variable.
[INFO]  Verified 64 interior points; max error is 0.00000000.
[INFO]  Run the 5_fdtd_stencil sample successfully.
```
