# 0_launch_kernel

## Description

This sample demonstrates the flow of running Add custom operator using CANN Runtime Kernel loading and execution interfaces, covering binary loading, kernel function handle retrieval, parameter assembly, task dispatch, Stream synchronization, and result verification. The sample supports `simple` and `placeholder` parameter organization modes. After running, input data is generated, Kernel is executed, and output result is verified.

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
cd ${git_clone_path}/example/2_advanced_features/kernel/0_launch_kernel
```

2. Set environment variables.

```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Replace ${ascend_name} with Ascend AI processor model, obtained by checking Name field using npu-smi info and removing spaces
export SOC_VERSION=${ascend_name}

# Replace ${cmake_path} with ascendc.cmake directory, for example ${install_root}/cann/aarch64-linux/tikcpp/ascendc_kernel_cmake
export ASCENDC_CMAKE_DIR=${cmake_path}
```

If environment variables are not set beforehand, `run.sh` automatically attempts to detect `ASCEND_INSTALL_PATH`, `ASCEND_HOME_PATH`, `$HOME/Ascend/cann`, `/usr/local/Ascend/cann`, `/opt/Ascend/cann`, `SOC_VERSION`, and `ASCENDC_CMAKE_DIR`; if automatic detection fails, set manually using the above commands.

This sample data generation and result verification depends on `numpy`. Ensure Python environment has `numpy` installed before executing `run.sh`.

3. Run the following command to execute the sample.

```bash
# mode can be simple or placeholder; defaults to simple if not specified
bash run.sh -r simple
```

In `simple` mode, Kernel pointer-type parameters use Device memory address allocated and data copied by user beforehand. In `placeholder` mode, data corresponding to placeholder parameters is transferred to Device side by Runtime at Kernel Launch time.

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
    - Call `aclrtFreeHost` interface to release Host memory.
    - Call `aclrtFree` interface to release Device memory.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer between Host and Device.
- Kernel Loading and Execution
    - Call `aclrtBinaryLoadFromFile` interface to load and parse operator binary file from file.
    - Call `aclrtBinaryGetFunction` interface to get kernel function handle.
    - Call `aclrtKernelArgsInit` interface to initialize parameter list based on kernel function handle.
    - Call `aclrtKernelArgsAppend` interface to append parameters to parameter list.
    - Call `aclrtKernelArgsAppendPlaceHolder` interface to append placeholder parameters.
    - Call `aclrtKernelArgsGetPlaceHolderBuffer` interface to get Host memory address corresponding to placeholder parameters.
    - Call `aclrtKernelArgsFinalize` interface to mark parameter assembly complete.
    - Call `aclrtLaunchKernelWithConfig` interface to dispatch Kernel computation task.
    - Call `aclrtBinaryUnLoad` interface to unload operator binary file.

## Sample Output

```text
Configuring CMake...
Building...
...
[INFO]  Kernel launch sample runs in simple mode.
[INFO]  Run the launch_kernel sample successfully.
... output/output_z.bin
... output/golden.bin
error ratio: 0.0000, tolerance: 0.0010
[SUCCESS] result correct
```