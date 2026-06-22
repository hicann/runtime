# 1_launch_kernel_with_reslimit

## Description

This sample demonstrates basic flow of executing Kernel after setting Device resource limits in current process. The sample sets Cube Core resource limit, queries current limit value, and dispatches print Kernel. After running, you can see Kernel output `Hello World` log and script verification result.

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
cd ${git_clone_path}/example/2_advanced_features/kernel/1_launch_kernel_with_reslimit
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

3. Run the following command to execute the sample.

```bash
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
- Runtime Configuration
    - Call `aclrtSetDeviceResLimit` interface to set current process Device resource limit.
    - Call `aclrtGetDeviceResLimit` interface to get current process Device resource limit.

## Sample Output

```text
[INFO]: Current compile soc version is ...
Configuring CMake...
Building...
[INFO]  ACL initialized.
[INFO]  Device 0 selected.
[INFO]  Stream created.
[INFO]  Device resource limit type 0 set to 8.
[INFO]  Current device resource limit type 0 is 8.
Hello World
Hello World
Hello World
Hello World
Hello World
Hello World
Hello World
Hello World
[INFO]  Run the launch_kernel_with_reslimit sample successfully.
[SUCCESS]: Launch kernels under resource limits successfully.
```