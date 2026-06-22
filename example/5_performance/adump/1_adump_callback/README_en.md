## 1_adump_callback

## Description
This example demonstrates how to receive Dump data chunks through a callback function in a single operator execution scenario. The example registers an `acldumpRegCallback` callback, parses the filename, offset, chunk flag, flag, and data preview of `acldumpChunk` in the callback, and outputs summary statistics.

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
export ASCEND_INSTALL_PATH=${install_root}/cann

# Replace ${ascend_name} with the model of the Ascend AI processor. You can view the Name field using npu-smi info and remove spaces to obtain it, for example, ascend910b3
export SOC_VERSION=${ascend_name}

# Some examples involve calling AscendC operators and require configuring the path where the AscendC compiler ascendc.cmake is located, such as ${install_root}/cann/aarch64-linux/tikcpp/ascendc_kernel_cmake
# You can search for ascendc_kernel_cmake in the CANN installation path, for example, find ./ -name ascendc_kernel_cmake, and replace ${cmake_path} with the path where ascendc_kernel_cmake is located
export ASCENDC_CMAKE_DIR=${cmake_path}

# Build and run
bash run.sh
```
## CANN RUNTIME API

In this sample, the key functional points and their key interfaces are as follows:
- Initialization
    - Call the aclInit interface to initialize AscendCL configuration.
    - Call the acldumpRegCallback interface to register a Dump operator information callback function.
    - Call the acldumpGetPath interface to query the current Dump output path.
    - Call the acldumpUnregCallback interface to unregister the Dump operator information callback function.
    - Call the aclFinalize interface to deinitialize AscendCL.
- Device Management
    - Call the aclrtSetDevice interface to specify the Device for computation.
    - Call the aclrtSynchronizeDevice interface to block and wait for the computing Device to complete computation.
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

## New Coverage in This Example

- Callback data parsing: Parse the filename, offset, whether it is the last chunk, flag, and data preview of `acldumpChunk` in the callback.
- `acldumpGetPath`: Queries the current Dump output path for correspondence with filenames received in the callback.


## Known Issues

   None