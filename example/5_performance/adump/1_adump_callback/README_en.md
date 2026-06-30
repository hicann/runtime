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

# Automatically identify SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh

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


## Sample Output

```text
[INFO]  acldumpGetPath returned dump path: ...
[INFO]  Get workspace size...
[INFO]  Begin to add...
[INFO]  Receive dump tensor data success. file=..., bufLen=..., isLastChunk=..., offset=..., flag=..., preview=...
[INFO]  result[0] is: 1.000000
[INFO]  result[1] is: 2.000000
[INFO]  result[2] is: 3.000000
[INFO]  result[3] is: 5.000000
[INFO]  result[4] is: 6.000000
[INFO]  result[5] is: 7.000000
[INFO]  result[6] is: 10.000000
[INFO]  result[7] is: 11.000000
[INFO]  Dump callback summary: total chunks=..., total bytes=..., total files=...
[INFO]  Run the device_normal sample successfully.
```

## Known Issues

   None
