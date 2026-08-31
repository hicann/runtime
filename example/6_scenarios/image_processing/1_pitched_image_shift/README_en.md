# 1_pitched_image_shift

## Description

This sample is intended for developers who need to process pitched two-dimensional images on one Device. It constructs an 8x8 `uint16_t` image, uses a 24-byte Host pitch and a 32-byte Device pitch for two-dimensional synchronous transfers, runs an Ascend C Kernel that performs a cyclic shift of two pixels horizontally and one pixel vertically using the Device pitch, and transfers the result back using the different pitches.

The program verifies all 64 output pixels and confirms that the two-dimensional D2H transfer does not overwrite the `0xFFFF` Host padding on each row. Any Runtime API, result invariant, or cleanup failure produces an `ERROR` and a non-zero return value. The final success message is printed only after all checks and cleanup operations succeed. The sample uses Device 0.

## Product Support

| Product | Supported |
| --- | --- |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.
2. Set the environment variables.
3. Run the following command to compile and execute the sample.

```bash
cd ${git_clone_path}/example/6_scenarios/image_processing/1_pitched_image_shift
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Runtime Initialization and Device management
    - `aclInit`: Initializes ACL Runtime.
    - `aclrtSetDevice`: Selects Device 0 for the image shift.
    - `aclrtResetDevice`: Releases Runtime resources on Device 0.
    - `aclFinalize`: Performs ACL Runtime Deinitialization.
- Stream and two-dimensional memory management
    - `aclrtCreateStream`: Creates the Stream used for Kernel execution.
    - `aclrtMallocHost`: Allocates Host image memory containing row padding.
    - `aclrtMalloc`: Allocates image memory using an independent Device pitch.
    - `aclrtMemcpy2d`: Synchronously transfers the valid pixel region between different Host and Device pitches.
    - `aclrtSynchronizeStream`: Waits for the shift Kernel to finish before the image is synchronously copied back.
    - `aclrtFree`: Frees Device memory.
    - `aclrtFreeHost`: Frees Host memory.
    - `aclrtDestroyStream`: Destroys the Stream.
- Kernel loading and execution
    - `aclrtBinaryLoadFromFile`: Loads the pitched-image shift Kernel binary.
    - `aclrtBinaryGetFunction`: Obtains the image-shift Kernel function handle.
    - `aclrtKernelArgsInit`: Initializes the Kernel argument handle.
    - `aclrtKernelArgsAppend`: Appends the input and output Device image addresses.
    - `aclrtKernelArgsFinalize`: Completes Kernel argument construction.
    - `aclrtLaunchKernelWithConfig`: Launches the image-shift Kernel on the Stream.
    - `aclrtBinaryUnLoad`: Unloads the Kernel binary.

## Sample Output

```text
[INFO]  Start to run 1_pitched_image_shift sample.
[INFO]  Pitched shift verified: 64 pixels, Host pitch=24 bytes, Device pitch=32 bytes.
[INFO]  Run the 1_pitched_image_shift sample successfully.
```
