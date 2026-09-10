# 0_watershed_image_staging

## Description

This sample is intended for applications that stage watershed image-processing input on a single Device. It asynchronously uploads and reads back three pitched 8-bit grayscale images, confirming that the Runtime data path is ready before a downstream image algorithm runs.

The sample queries the Runtime and driver versions, current Device, total Device memory, and Stream flag, and uses the results to validate its resources and execution environment.  The sample verifies every pixel, each valid-region checksum, and that Host row padding remains untouched. Any core API, data, configuration, or cleanup invariant failure prints `ERROR` and returns a non-zero value.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | :---: |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Ascend 950PR/Ascend 950DT | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/6_scenarios/image_processing/0_watershed_image_staging
```

2. Set the environment variables.

`${install_root}` is the CANN installation root. `set_env.sh` loads the CANN runtime environment, while `set_sample_env.sh` sets `SOC_VERSION` and `ASCENDC_CMAKE_DIR` for sample compilation.

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

- Initialization and Device management
    - Call `aclInit` to initialize ACL.
    - Call `aclrtSetDevice` to select the single Device used for processing.
    - Call `aclrtGetDevice` to confirm that the current Device matches the selection.
    - Call `aclrtGetDeviceInfo` to query total Device memory and confirm that the image buffer can be allocated.
    - Call `aclrtResetDevice` to release Device resources used by the current process.
    - Call `aclFinalize` for ACL Deinitialization.
- Version and Stream configuration
    - Call `aclsysGetVersionNum` to query the Runtime and driver package versions; log a warning and continue if a query fails.
    - Call `aclrtCreateStreamWithConfig` to create a fast-synchronization Stream.
    - Call `aclrtStreamGetFlags` to confirm the flag configured when the Stream was created.
    - Call `aclrtSynchronizeStream` to wait for two-dimensional memory copies and confirm the Stream is idle before cleanup.
    - Call `aclrtDestroyStream` to destroy the Stream.
- Image memory and two-dimensional transfer
    - Call `aclrtMallocHost` to allocate pinned Host memory for the input and output images.
    - Call `aclrtMalloc` to allocate a pitched Device image buffer.
    - Call `aclrtMemcpy2dAsync` to asynchronously upload and read back the valid image width.
    - Call `aclrtFree` to release the Device image buffer.
    - Call `aclrtFreeHost` to release the input and output Host image buffers.

## Sample Output

```text
[INFO]  Start to run 0_watershed_image_staging sample.
[INFO]  Environment verified: runtime=90200000, driver=250505000, Device=0, global memory=65787658240 bytes, Stream flag=0x2.
[INFO]  Image 0 staging verified: 262144 pixels, checksum=32759100.
[INFO]  Image 1 staging verified: 262144 pixels, checksum=32764400.
[INFO]  Image 2 staging verified: 262144 pixels, checksum=32769700.
[INFO]  Run the 0_watershed_image_staging sample successfully.
```

The version numbers and total Device memory depend on the runtime environment. A failed version query is displayed as `-1`.
