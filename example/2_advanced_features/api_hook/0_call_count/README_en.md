# 0_call_count

## Description

Tool developers can temporarily count Runtime API calls in a single Device application while preserving the API behavior. This sample hooks one query of Device 0 and verifies that the count is 1 and the returned Device ID is 0. After restoring the original function, it queries again and checks that the Device ID remains 0 and the count does not increase.

Installation, calls, and restoration run sequentially on the main thread, without application worker threads. Run independently of other API Hook tools or Profiling. The sample fails if an existing hook is detected. In a multithreaded application, pause relevant API calls and wait for in-flight calls to finish before installing or restoring a hook.

## Product Support

| Product | Supported |
| --- | --- |
| Atlas A2 series products | Yes |
| Atlas A3 series products | Yes |
| Ascend 950PR/Ascend 950DT | Yes |

Use a CANN version that provides these API Hook interfaces and a Runtime build with API Hook enabled. Missing interfaces or a disabled feature cause a build or runtime failure.

## Compile and Run

See the [sample guide](../../../README_en.md) for environment preparation and execution. This sample uses logical Device 0.

## CANN RUNTIME API

The key functions and interfaces used in this sample are:

- Initialization and finalization: `aclInit` initializes the configuration; `aclFinalize` finalizes it.
- Device management and result validation: `aclrtSetDevice` binds the Device, `aclrtGetDevice` queries its ID, and `aclrtResetDeviceForce` releases Device resources.
- API Hook call observation: `aclrtApiInjectionGetFunc` retrieves and validates the original and current function pointers; `aclrtApiInjectionSetFunc` installs the counting hook and restores the original function.

## Sample Output

On success, the hooked call changes the count to 1; the query after restoration keeps it at 1. Failures return a nonzero exit code without printing the success marker.

```text
[INFO]  Hook installed for aclrtGetDevice
[INFO]  Hooked call: device=0, hook count=1
[INFO]  Original function restored
[INFO]  Restored call: device=0, hook count=1
[INFO]  Run the call_count sample successfully.
```
