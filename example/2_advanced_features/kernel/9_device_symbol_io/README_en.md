# 9_device_symbol_io

## Description

This sample demonstrates a complete read-and-write flow for Kernel shared state stored in a Device variable on a single Device. It validates the Device variable address and size, asynchronously writes deterministic initial values from pinned Host memory, updates every value in an Ascend C Kernel, and reads the result through both synchronous and asynchronous paths for element-wise verification. The program returns a non-zero value if the address or size is invalid, the read paths differ, the values are unexpected, or any Runtime operation or cleanup fails.

## Product Support

The sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 Training Series/Atlas A3 Inference Series | Yes |
| Atlas A2 Training Series/Atlas A2 Inference Series | Yes |

## Build and Run

1. Download the sample code to an environment where CANN is installed, and change to the sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/9_device_symbol_io
```

2. Set the environment variables.

```bash
# Replace ${install_root} with the CANN installation root.
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. Build and run the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

The key functions and APIs used in this sample are as follows:

- Initialization and finalization
    - `aclInit` initializes the Runtime environment.
    - `aclFinalize` finalizes the Runtime environment.
- Device management
    - `aclrtSetDevice` selects the Device on which the sample runs.
    - `aclrtResetDeviceForce` resets the Device and reclaims its resources.
- Stream management
    - `aclrtCreateStream` creates the Stream used for asynchronous Device variable transfers and Kernel execution.
    - `aclrtSynchronizeStream` waits for queued Stream work to finish.
    - `aclrtDestroyStreamForce` destroys the Stream.
- Host memory management
    - `aclrtMallocHost` allocates pinned Host memory for asynchronous transfers.
    - `aclrtFreeHost` releases the pinned Host memory.
- Device variable memory operations
    - `aclrtGetSymbolAddress` queries and validates the Device variable address.
    - `aclrtGetSymbolSize` queries the Device variable size and validates transfer bounds.
    - `aclrtMemcpyToSymbolAsync` asynchronously writes the initial Device variable values.
    - `aclrtMemcpyFromSymbol` synchronously reads the Device variable after the Kernel update.
    - `aclrtMemcpyFromSymbolAsync` asynchronously reads the Device variable after the Kernel update.
- Kernel configuration and execution
    - `aclrtGetFuncBySymbol` obtains a function handle from the Kernel symbol.
    - `aclrtLaunchKernelWithArgsArray` launches the Device variable update.

## Sample Output

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] SOC_VERSION=Ascend910_9362
[INFO] ASCENDC_CMAKE_DIR=...
...
[INFO]  Start to run the 9_device_symbol_io sample.
[INFO]  Resolved Device variable at ... with 32 bytes.
[INFO]  Initialized 8 values asynchronously and added 7 in the Kernel.
[INFO]  Verified 8 values through the synchronous read path.
[INFO]  Verified 8 values through the asynchronous read path.
[INFO]  Both read paths returned [17, ..., 87].
[INFO]  Run the 9_device_symbol_io sample successfully.
```
