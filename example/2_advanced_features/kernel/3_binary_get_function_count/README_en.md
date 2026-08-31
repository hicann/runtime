# 3_binary_get_function_count

## Description

This sample demonstrates how to use the `aclrtBinaryGetFunctionCount` interface to query the number of kernel functions in an operator binary file, and then perform a complete workflow including function lookup, information query, kernel launch, and result verification. The sample compiles three AscendC kernel functions (`add_custom`, `sub_custom`, and `mul_custom`) into a single standalone operator binary, queries the total number of kernel functions, obtains handles by name, queries function information, prepares FP16 input data, and finally launches each kernel and verifies computation results.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run

1. Download sample code to environment with CANN software installed, switch to sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/3_binary_get_function_count
```

2. Set environment variables.

```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh

# Automatically identify SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to execute the sample.

```bash
bash run.sh
```

## CANN RUNTIME API

Key features and interfaces in this sample:

- Initialization
    - Call `aclInit` interface to initialize configuration.
    - Call `aclFinalize` interface to deinitialize.
- Device Management
    - Call `aclrtSetDevice` interface to specify Device for computation.
    - Call `aclrtResetDeviceForce` interface to forcibly reset current computation Device and reclaim Device resources.
- Stream Management
    - Call `aclrtCreateStream` interface to create Stream.
    - Call `aclrtSynchronizeStream` interface to block waiting for Stream task execution completion.
    - Call `aclrtDestroyStreamForce` interface to forcibly destroy Stream.
- Memory Management
    - Call `aclrtMallocHost` interface to allocate Host memory.
    - Call `aclrtMalloc` interface to allocate Device memory.
    - Call `aclrtMemcpy` interface to perform memory copy between Host and Device.
    - Call `aclrtFreeHost` interface to free Host memory.
    - Call `aclrtFree` interface to free Device memory.
- Binary Management
    - Call `aclrtBinaryLoadFromFile` interface to load and parse an operator binary file from disk, outputting a binHandle.
    - Call `aclrtBinaryGetFunctionCount` interface to get the total number of kernel function handles in the binary.
    - Call `aclrtBinaryGetFunction` interface to get a kernel function handle by its name.
    - Call `aclrtGetFunctionName` interface to get the kernel function name from a function handle.
    - Call `aclrtGetFunctionAddr` interface to get the Device-side kernel code address from a function handle.
    - Call `aclrtLaunchKernelWithHostArgs` interface to launch a kernel with Host-side arguments that are automatically copied to Device.
    - Call `aclrtBinaryUnLoad` interface to unload the operator binary file and release associated resources.

## Sample Output

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] ASCENDC_CMAKE_DIR=...
[INFO] SOC_VERSION=...
Configuring CMake...
Building...
[INFO]  Querying the number of kernel functions in the binary
[INFO]  aclrtBinaryGetFunctionCount returned 3 functions
[INFO]  Getting function handles by name
[INFO]  Querying function names and addresses
[INFO]  function[0]: name=add_custom, handle=..., aic=..., aiv=...
[INFO]  function[1]: name=sub_custom, handle=..., aic=..., aiv=...
[INFO]  function[2]: name=mul_custom, handle=..., aic=..., aiv=...
[INFO]  Preparing input data
[INFO]  Launching kernels and verifying results
[INFO]  add_custom result verified
[INFO]  sub_custom result verified
[INFO]  mul_custom result verified
[INFO]  aclrtBinaryGetFunctionCount sample PASSED
```
