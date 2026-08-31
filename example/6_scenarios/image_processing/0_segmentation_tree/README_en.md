# 0_segmentation_tree

## Description

This sample is intended for developers who need to generate hierarchical image-segmentation labels on one Device. It constructs a deterministic 8x8 grayscale image, queries available Device memory and uses the result for task-capacity admission, then runs an Ascend C Kernel that generates four fine-grained labels from the intensity ranges and merges each adjacent pair into one coarse label, producing a directly verifiable two-level segmentation tree.

The program verifies every fine label, coarse label, and the `coarse = fine / 2` hierarchy. It also verifies that each fine class contains 16 pixels and each coarse class contains 32 pixels. Any Runtime API, result invariant, or cleanup failure produces an `ERROR` and a non-zero return value. The final success message is printed only after all checks and cleanup operations succeed. The sample uses Device 0.

## Product Support

| Product | Supported |
| --- | --- |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.
2. Set the environment variables.
3. Run the following command to compile and execute the sample.

```bash
cd ${git_clone_path}/example/6_scenarios/image_processing/0_segmentation_tree
# Replace ${install_root} with the CANN installation root directory
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
bash run.sh
```

## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Runtime Initialization and Device management
    - `aclInit`: Initializes ACL Runtime.
    - `aclrtSetDevice`: Selects Device 0 for image segmentation.
    - `aclrtResetDevice`: Releases Runtime resources on Device 0.
    - `aclFinalize`: Performs ACL Runtime Deinitialization.
- Stream and memory management
    - `aclrtGetMemInfo`: Queries free and total HBM capacity and admits the task only when the image and label buffers fit.
    - `aclrtCreateStream`: Creates the Stream used for asynchronous transfers and Kernel execution.
    - `aclrtMallocHost`: Allocates Host memory for the image and two label levels.
    - `aclrtMalloc`: Allocates Device memory for the image and two label levels.
    - `aclrtMemcpyAsync`: Asynchronously transfers the image and two label levels.
    - `aclrtSynchronizeStream`: Waits for transfers and the segmentation Kernel to finish.
    - `aclrtFree`: Frees Device memory.
    - `aclrtFreeHost`: Frees Host memory.
    - `aclrtDestroyStream`: Destroys the Stream.
- Kernel loading and execution
    - `aclrtBinaryLoadFromFile`: Loads the segmentation-tree Kernel binary.
    - `aclrtBinaryGetFunction`: Obtains the segmentation-tree Kernel function handle.
    - `aclrtKernelArgsInit`: Initializes the Kernel argument handle.
    - `aclrtKernelArgsAppend`: Appends the image, fine-label, and coarse-label addresses.
    - `aclrtKernelArgsFinalize`: Completes Kernel argument construction.
    - `aclrtLaunchKernelWithConfig`: Launches the segmentation-tree Kernel on the Stream.
    - `aclrtBinaryUnLoad`: Unloads the Kernel binary.

## Sample Output

```text
[INFO]  Start to run 0_segmentation_tree sample.
[INFO]  Memory admission passed: required=192 bytes, free=... bytes.
[INFO]  Segmentation verified: fine counts=[16,16,16,16], coarse counts=[32,32].
[INFO]  Run the 0_segmentation_tree sample successfully.
```
