# 0_hello_cann

## Description

This sample is a quick start example using Runtime interfaces. Using the `aclnnAdd` vector addition operator from the CANN neural network operator library as the entry point, it demonstrates a minimum computation closed loop: complete initialization configuration, specify Device and create Stream, prepare input/output Tensor and output DataBuffer, query and apply workspace, execute `out = self + alpha * other`, synchronously get results and release resources.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Ascend 950PR/Ascend 950DT | Yes |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Compile and Run

For environment installation details and general running steps, refer to [README](../../README_en.md) in the example directory.

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
- Tensor and Data Description
    - Call `aclCreateTensor` interface to create input and output Tensors.
    - Call `aclCreateScalar` interface to create scaling factor `alpha`.
    - Call `aclCreateDataBuffer` and `aclGetDataBufferAddr` interfaces to manage output Buffer.
    - Call `aclDestroyTensor`, `aclDestroyScalar`, and `aclDestroyDataBuffer` interfaces to release description objects.
- Memory Management and Data Transfer
    - Call `aclrtMalloc` interface to allocate memory on Device.
    - Call `aclrtMemcpy` interface to complete Host/Device data transfer.
    - Call `aclrtFree` interface to release memory on Device.
- Operator Execution
    - Call `aclnnAddGetWorkspaceSize` interface to query workspace required for operator execution.
    - Call `aclnnAdd` interface to execute vector addition.

## Core API

### aclnnAdd

```c
aclError aclnnAdd(
    void* workspace,         // workspace address
    uint64_t workspaceSize,  // workspace size
    aclOpExecutor* executor, // operator executor
    aclrtStream stream       // Stream
);
```

### aclnnAddGetWorkspaceSize

```c
aclError aclnnAddGetWorkspaceSize(
    const aclTensor* self,   // first input tensor
    const aclTensor* other,  // second input tensor
    const aclScalar* alpha,  // scaling factor
    aclTensor* out,          // output tensor
    uint64_t* workspaceSize, // [output] workspace size
    aclOpExecutor** executor // [output] operator executor
);
```

## Computation Formula

```
out = self + alpha * other
```

## Sample Output

```text
ACL init successfully
Set device 0 successfully
Create stream successfully
Input vectors:
  self:   [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
  other:  [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
  alpha:  1.0
Create output aclDataBuffer successfully, buffer addr = 0x...
Get workspace size successfully, workspace size = ...
Launch aclnnAdd successfully
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

Sample run successfully!
```

## Related Samples

- [4_custom_kernel_launch](../4_custom_kernel_launch/README_en.md): If you need to use `<<<>>>` to call custom AscendC Kernel, refer to this sample.