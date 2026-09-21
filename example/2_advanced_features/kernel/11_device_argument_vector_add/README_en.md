# 11_device_argument_vector_add

## Description

This sample targets single-Device vector workloads that maintain a Kernel argument package in Device memory. It reuses the existing FP16 vector-add Kernel, packages the three vector Device addresses, uploads the package to Device memory, and submits the asynchronous computation through `aclrtLaunchKernelV2`. The Device argument package remains valid until Stream synchronization completes, demonstrating a lifecycle different from Host argument interfaces. The program then verifies all 16,384 vector-add results element by element and returns a nonzero value if any result is incorrect or resource cleanup fails.


## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN is installed, and switch to the sample directory.

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/11_device_argument_vector_add
```

2. Set the environment variables.

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

- Initialization and Deinitialization
    - Call `aclInit` to initialize the Runtime environment.
    - Call `aclFinalize` for deinitialization.
- Device Management
    - Call `aclrtSetDevice` to select the Device that loads and executes the Kernel.
    - Call `aclrtResetDeviceForce` to reset the Device and reclaim its resources.
- Stream Management
    - Call `aclrtCreateStream` to create the Stream that carries the Kernel task.
    - Call `aclrtSynchronizeStream` to wait for the asynchronous Kernel task and determine when the Device argument package can be released.
    - Call `aclrtDestroyStreamForce` to destroy the Stream.
- Data Preparation and Verification
    - Call `aclFloatToFloat16` to convert deterministic inputs to FP16 data.
    - Call `aclFloat16ToFloat` to convert each output and verify the computation.
    - Call `aclrtMalloc` to allocate Device memory for the vectors and argument package.
    - Call `aclrtMemcpy` to upload inputs and the argument package and to copy the result back to the Host.
    - Call `aclrtFree` to release Device memory after the task completes.
- Kernel Loading and Execution
    - Call `aclrtBinaryLoadFromFile` to load the vector-add Kernel binary.
    - Call `aclrtBinaryGetFunction` to obtain the `add_custom` function handle.
    - Call `aclrtLaunchKernelV2` to submit the asynchronous vector-add Kernel using the argument package in Device memory.
    - Call `aclrtBinaryUnLoad` to unload the Kernel binary.

## Sample Output

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] SOC_VERSION=...
[INFO] ASCENDC_CMAKE_DIR=...
...
[INFO]  Start to run the 11_device_argument_vector_add sample.
[INFO]  Uploaded a 24-byte Kernel argument package to Device memory.
[INFO]  Released the Device argument package after Stream synchronization.
[INFO]  Verified 16384 FP16 vector additions element by element.
[INFO]  Run the 11_device_argument_vector_add sample successfully.
```
