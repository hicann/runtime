## 2_model_dump_config

## Description
This example demonstrates how to use the model-level Dump configuration interfaces `aclmdlInitDump`, `aclmdlSetDump`, `acldumpGetPath`, and `aclmdlFinalizeDump` to enable Dump based on a configuration file in a single operator API scenario and query the currently effective Dump output path.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | Yes |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | Yes |

## Build and Run
For environment installation details and runtime details, see [README](../../../README_en.md) in the example directory.


Follow the steps below to run:

```bash
# Replace ${install_root} with the CANN installation root directory, which is installed in `/usr/local/Ascend` by default
source ${install_root}/cann/set_env.sh

# Automatically identify SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh

# Build and run
bash run.sh
```
## CANN RUNTIME API

In this sample, the key functional points and their key interfaces are as follows:
- Initialization
    - Call the aclInit interface to initialize AscendCL configuration.
    - Call the aclmdlInitDump interface to initialize Dump configuration.
    - Call the aclmdlSetDump interface to load the Dump configuration file.
    - Call the acldumpGetPath interface to query the current Dump output path.
    - Call the aclmdlFinalizeDump interface to finalize the current Dump configuration.
    - Call the aclFinalize interface to deinitialize AscendCL.
- Device Management
    - Call the aclrtSetDevice interface to specify the Device for computation.
    - Call the aclrtResetDeviceForce interface to forcibly reset the current computing Device and reclaim resources on the Device.
- Stream Management
    - Call the aclrtCreateStream interface to create a Stream.
    - Call the aclrtSynchronizeStream interface to block and wait for tasks on the Stream to complete.
    - Call the aclrtDestroyStream interface to destroy a Stream.
- Memory Management
    - Call the aclrtMalloc interface to allocate memory on the Device.
    - Call the aclrtFree interface to free memory on the Device.
- Data Transfer
    - Call the aclrtMemcpy interface to implement data transfer through memory copy.

## Notes

- This example uses the model-level Dump configuration interfaces in a single operator API scenario to complement the configuration-based Dump usage in the `adump` directory.
- The configuration file `acl.json` uses the `dump_op_switch: on` configuration recommended for single operator Dump scenarios.

## Sample Output

```text
[INFO]  Configured model dump path is: ...
[INFO]  result[0] is: 1.000000
[INFO]  result[1] is: 2.000000
[INFO]  result[2] is: 3.000000
[INFO]  result[3] is: 5.000000
[INFO]  result[4] is: 6.000000
[INFO]  result[5] is: 7.000000
[INFO]  result[6] is: 10.000000
[INFO]  result[7] is: 11.000000
[INFO]  Run the model dump config sample successfully.
```

## Known Issues

   None
