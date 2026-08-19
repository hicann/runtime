# 0_uvm_allocate

## Description

This sample uses the UVM (Unified Virtual Memory) mechanism and allocates memory for Kernel inputs and outputs through the UVM memory allocation interface, eliminating explicit data transfer during Kernel parameter appending and result writing back. The sample covers UVM-type memory allocation, binary loading, kernel function handle retrieval, parameter assembly, task dispatch, Stream synchronization, and result verification. After running this sample, Kernel input data is generated, Kernel is executed, and Kernel output result is verified.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | No |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

> Note: The sample checks at runtime whether the current SOC supports UVM. On products without UVM support (such as the Ascend 910 series), `aclrtMemAllocManaged` returns `ACL_ERROR_RT_FEATURE_NOT_SUPPORT (207000)`. In this case, the sample prints a `[SKIP]` message and exits normally with code 0; after detecting `[SKIP]`, `run.sh` skips the subsequent result verification and also exits normally.

## Build and Run

1. Download sample code to environment with CANN software installed, switch to sample directory.

```bash
cd ${git_clone_path}/example/3_memory_advanced/managed_memory/0_uvm_allocate
```

2. Set environment variables.

```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh

# Automatically identify SOC_VERSION and ASCENDC_CMAKE_DIR.
source ${git_clone_path}/example/set_sample_env.sh


```

This sample data generation and result verification depends on `numpy`. Ensure Python environment has `numpy` installed before executing `run.sh`. The `numpy` version of 1.19.0 or higher is required.

3. Run the following command to execute the sample.

```bash
# mode can be simple or placeholder; defaults to simple if not specified
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
    - Call `aclrtMemAllocManaged` interface to allocate UVM-type memory.
    - Call `aclrtFree` interface to release UVM-type memory.
- Kernel Loading and Execution
    - Call `aclrtBinaryLoadFromFile` interface to load and parse operator binary file from file.
    - Call `aclrtBinaryGetFunction` interface to get kernel function handle.
    - Call `aclrtKernelArgsInit` interface to initialize parameter list based on kernel function handle.
    - Call `aclrtKernelArgsAppend` interface to append parameters to parameter list.
    - Call `aclrtKernelArgsFinalize` interface to mark parameter assembly complete.
    - Call `aclrtLaunchKernelWithConfig` interface to dispatch Kernel computation task.
    - Call `aclrtBinaryUnLoad` interface to unload operator binary file.

## Sample Output

```text
Configuring CMake...
Building...
...
[INFO]  Run the uvm_allocate sample successfully.
... output/output_z.bin
... output/golden.bin
error ratio: 0.0000, tolerance: 0.0010
[SUCCESS] result correct
```

Example output on a product that does not support UVM:

```text
[INFO]  [SKIP] uvm_allocate sample skipped: the current SOC (Ascend910A) does not support UVM, aclrtMemAllocManaged returned error code 207000.
[SUCCESS] uvm_allocate sample skipped because the current SOC does not support UVM.
```