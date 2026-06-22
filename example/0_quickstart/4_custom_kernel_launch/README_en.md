# 4_custom_kernel_launch

## Description

This sample provides a minimum runnable example demonstrating how to use the `<<<>>>` kernel call operator to dispatch custom AscendC Kernel to complete 8-element vector addition. After successful execution, the result should be consistent with the vector addition result in [0_hello_cann](../0_hello_cann/README_en.md).

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

1. Download the sample code to the environment where CANN software is installed. Switch to the sample directory.
```bash
cd ${git_clone_path}/example/0_quickstart/4_custom_kernel_launch
```

2. Set environment variables.
```bash
# Replace ${install_root} with the CANN installation root directory. The default installation is in the `/usr/local/Ascend` directory.
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Set SOC_VERSION and ASCENDC_CMAKE_DIR
# -SOC_VERSION: Ascend AI processor model, such as Ascend910_9362, Ascend910B2, and so on
# -ASCENDC_CMAKE_DIR: The sample involves calling AscendC operators. Configure the AscendC compiler ascendc.cmake path, such as /usr/local/Ascend/cann/x86_64-linux/tikcpp/ascendc_kernel_cmake
source ${git_clone_path}/example/set_sample_env.sh
```

3. Run the following command to execute the sample.
```bash
bash run.sh
```
## CANN RUNTIME API

The key functionality points and their key interfaces involved in this sample are as follows:

- Initialization
    - Call `aclInit` interface for initialization configuration.
    - Call `aclFinalize` interface for deinitialization.
- Device and Stream Management
    - Call `aclrtSetDevice` interface to specify the Device for computation.
    - Call `aclrtCreateStream` interface to create a Stream.
    - Call `aclrtSynchronizeStream` interface to block and wait for Stream tasks to complete.
    - Call `aclrtDestroyStream` interface to destroy a Stream.
    - Call `aclrtResetDeviceForce` interface to forcefully reset the current computation Device and reclaim Device resources.
- Memory Management and Data Transfer
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtMemcpy` interface to complete Host/Device data transfer.
    - Call `aclrtFree` interface to release memory on Device.
- Kernel Call
    - Use `<<<>>>` kernel call operator to dispatch custom AscendC Kernel.

## Sample Output

The sample will print input vectors, `<<<>>>` call success information, and the final result. Typical output is as follows:

```text
ACL init successfully
Set device 0 successfully
Create stream successfully
Allocate device buffers successfully
Copy input vectors to device successfully
Input vectors:
  self:   [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
  other:  [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
  alpha:  1.0
Custom AscendC kernel <<<>>> call successfully
Synchronize stream successfully

Vector addition result:
  result[0] = 1.5 (expected: 1.5)
  result[1] = 3.0 (expected: 3.0)
  result[2] = 4.5 (expected: 4.5)
  result[3] = 6.0 (expected: 6.0)
  result[4] = 7.5 (expected: 7.5)
  result[5] = 9.0 (expected: 9.0)
  result[6] = 10.5 (expected: 10.5)
  result[7] = 12.0 (expected: 12.0)

Sample run successfully with <<<>>> kernel call!
```

If the output result matches expectations, it indicates that the CANN custom Kernel `<<<>>>` call path is working properly.

## Related Samples

- [0_hello_cann](../0_hello_cann/README_en.md): Use `aclnnAdd` to complete the same vector addition.