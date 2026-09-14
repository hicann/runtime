# 7_binary_introspection

## Description

This sample targets single-Device applications that inspect custom Kernel metadata after loading. It creates and loads an Ascend C Kernel binary from Host memory, verifies the Binary-to-Function association, parameter layout, AI Core/Vector Core code sizes, dynamic UB size, and the Device address of the binary, then writes and reads back a named Device global variable to validate its resolved address.

## Product Support

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to an environment where CANN is installed and switch to the sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/7_binary_introspection
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

The key functionality points and interfaces used in this sample are as follows:

- Initialization and deinitialization
    - Call `aclInit` to initialize the runtime environment.
    - Call `aclFinalize` to deinitialize it.
- Device management
    - Call `aclrtSetDevice` to select the Device that loads the binary.
    - Call `aclrtResetDeviceForce` to reset the Device and reclaim its resources.
- Binary lifecycle
    - Call `aclrtCreateBinary` to create a descriptor from binary data in Host memory.
    - Call `aclrtBinaryLoad` to parse the binary and load it on the Device for the current Context.
    - Call `aclrtBinaryUnLoad` to unload the binary in the same Context.
    - Call `aclrtDestroyBinary` to destroy the Binary descriptor; the application still owns the original Host memory.
- Binary metadata
    - Call `aclrtBinaryGetDevAddress` to obtain the Device address and size of the loaded binary.
    - Call `aclrtBinaryGetGlobal` to resolve the address and size of a named Device global variable.
- Function metadata
    - Call `aclrtBinaryGetFunction` to obtain a Kernel function by name.
    - Call `aclrtFunctionGetBinary` to retrieve the Binary associated with the function.
    - Call `aclrtFunctionGetParamCount` to query the Kernel parameter count.
    - Call `aclrtFunctionGetParamInfo` to query each parameter offset and size.
    - Call `aclrtGetFunctionSize` to query the AI Core and Vector Core code sizes.
    - Call `aclrtFunctionGetAvailDynUbufPerBlock` to query the dynamic UB available per Block. This sample uses a non-SIMT Kernel, so the expected value is 0.
- Global variable validation
    - Call `aclrtMemcpy` to write a probe value to the global variable and read it back for validation.

## Sample Output

```text
[INFO]  Start to run the 7_binary_introspection sample.
[INFO]  Loaded ... binary bytes from Host memory.
[INFO]  Parameter[0]: offset=0, size=8.
[INFO]  Parameter[1]: offset=8, size=8.
[INFO]  Parameter[2]: offset=16, size=4.
[INFO]  Function code size: aic=... bytes, aiv=... bytes; dynamic UB=0 bytes.
[INFO]  Binary Device image: address=..., size=... bytes.
[INFO]  Verified Device global g_binary_metadata_value: size=... bytes, value=0x13572468.
[INFO]  Run the 7_binary_introspection sample successfully.
```
