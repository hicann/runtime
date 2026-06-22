# 1_error_handling

## Description

This sample demonstrates the basic pattern of Runtime error handling, referencing the CUDA `checkCudaErrors` approach, showing how to uniformly check ACL return values, and combining `aclrtPeekAtLastError`, `aclrtGetLastError`, `aclGetRecentErrMsg`, and `aclrtGetErrorVerbose` to get more complete diagnostic information.

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
- Device Management
    - Call `aclrtSetDevice` interface to specify the Device for computation.
    - Call `aclrtResetDeviceForce` interface to forcefully reset the current computation Device and reclaim Device resources.
    - Call `aclrtGetRunMode` interface to query the current run mode.
- Error Diagnosis
    - Call `aclrtPeekAtLastError` interface to query thread-level Runtime error code without clearing status.
    - Call `aclrtGetLastError` interface to get and clear thread-level Runtime error code.
    - Call `aclGetRecentErrMsg` interface to get the error description of the most recent ACL call failure.
    - Call `aclrtGetErrorVerbose` interface to query detailed error summary information. This interface is a reserved interface. The current environment may return a non-success error code. The sample will record a WARN and continue to complete the error diagnosis process.

## Sample Output

```text
[INFO]  ACL init and set device successfully
[INFO]  Current run mode: ACL_HOST
[INFO]  Triggering an expected invalid-parameter error with aclrtGetRunMode(nullptr)
[ERROR] Diagnostics: ret=..., peekErr=..., lastErr=..., recentErrMsg=...
[INFO]  Verbose error info: errorType=..., tryRepair=..., hasDetail=...
[INFO]  After diagnostics are consumed once: peekErr=0, lastErr=0, recentErrMsg=<null>
```