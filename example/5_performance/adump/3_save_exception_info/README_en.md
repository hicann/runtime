# 3_save_exception_info

## Description

This example demonstrates how to combine the `acldumpGetExceptionInfoPath` and `acldumpSaveExceptionInfo` interfaces to actively save custom tensor data to the Adump Exception Dump path during operator execution.

Background: some components or frameworks need to save custom data when an operator exception occurs. This sample enables Exception Dump via `dump_scene=aic_err_brief_dump` in `acl.json`, first runs a normal aclnnAdd operator, and then:

1. Calls `acldumpGetExceptionInfoPath` to query the Exception Dump root path (with deviceId);
2. Builds `acldumpTensorInfo` (reusing the operator's device addresses, shapes, and data types) and calls `acldumpSaveExceptionInfo` to save tensor data under that path. The `userTag` is stored in the OpAttr of the dump file proto header.

> Note: `fileName` is a relative path (must not be empty or contain a `..` segment); the final location is confined within the Exception Dump root path. To avoid overwriting existing files on repeated runs, a `.custom.{timestamp}` suffix (`timestamp` is a millisecond-level timestamp) is appended to `fileName` for the on-disk filename, e.g. `save_exception_info` becomes `save_exception_info.custom.20260721153012345`. Exception Dump must be enabled before calling, otherwise the interface returns failure.
>
> Note: this interface reads data by using `tensorAddr` directly as the device data address, so the sample passes `ACL_DUMP_ADDR_RAW` as `addrType` and `ACL_DUMP_PLACEMENT_DEVICE` as `placement`.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

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
    - Call the aclInit interface to initialize AscendCL configuration (Exception Dump enabled via acl.json).
    - Call the aclFinalize interface to deinitialize AscendCL.
- Exception Dump
    - Call the acldumpGetExceptionInfoPath interface to query the Exception Dump root path.
    - Call the acldumpSaveExceptionInfo interface to save custom tensor data under the Exception Dump path, storing userTag in the proto header OpAttr.
- Device Management
    - Call aclrtSetDevice/aclrtResetDeviceForce interfaces to manage the Device.
- Stream Management
    - Call aclrtCreateStream/aclrtSynchronizeStream/aclrtDestroyStream interfaces to manage the Stream.
- Memory Management
    - Call aclrtMalloc/aclrtFree interfaces to allocate and free Device memory.
- Data Transfer
    - Call the aclrtMemcpy interface to transfer data.

## Additional Coverage in This Sample

- `acldumpGetExceptionInfoPath`: query the Exception Dump root path.
- `acldumpSaveExceptionInfo`: actively save custom tensor data under the Exception Dump path, with extra info stored via userTag.

## Sample Output

```text
[INFO]  acldumpGetExceptionInfoPath success, exception dump path is: .../extra-info/data-dump/0/
[INFO]  acldumpSaveExceptionInfo success, data has been saved under exception dump path: .../extra-info/data-dump/0/
[INFO]  result[0] is: 1.000000
...
[INFO]  Run the save_exception_info sample successfully.
```

## Known Issues

   None
