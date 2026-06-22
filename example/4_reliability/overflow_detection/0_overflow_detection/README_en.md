# 0_overflow_detection

## Overview

This sample demonstrates stream-level overflow detection switch, status query, and reset processes.

## Function Description

- Query the floating-point overflow mode of the current Device, and switch it to `ACL_RT_OVERFLOW_MODE_SATURATION`.
- Create a Stream in saturation mode, enable the overflow detection switch, and read the current configuration.
- Allocate a fixed 64-byte Device status buffer, obtain the overflow status once, and synchronize it to the Host.
- Call `aclrtResetOverflowStatus` to query the status again, and restore the original saturation mode at the end.
- Destroy the Stream, Context, and status buffer.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | Yes |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | Yes |

## Build and Run

For details about environment installation and execution, see the [README](../../../README_en.md) in the example directory.

Follow these steps to run:

```bash
# Replace ${install_root} with the CANN installation root directory. The default installation directory is `/usr/local/Ascend`.
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Build and run
bash run.sh
```
## CANN RUNTIME API

In this sample, the key functions and interfaces are as follows:
- Initialization and Context/Stream Management
    - Call `aclInit` and `aclFinalize` interfaces to complete ACL initialization and deinitialization.
    - Call `aclrtSetDevice` and `aclrtResetDeviceForce` interfaces to manage the Device.
    - Call `aclrtCreateContext` and `aclrtDestroyContext` interfaces to create and destroy the Context.
    - Call `aclrtCreateStream`, `aclrtSynchronizeStream`, and `aclrtDestroyStream` interfaces to manage the Stream.
- Device Floating-Point Overflow Mode Management
    - Call `aclrtGetDeviceSatMode` and `aclrtSetDeviceSatMode` interfaces to query and set the Device saturation mode.
- Overflow Detection Status Management
    - Call `aclrtSetStreamOverflowSwitch` and `aclrtGetStreamOverflowSwitch` interfaces to enable or query the Stream overflow detection switch.
    - Call `aclrtGetOverflowStatus` interface to obtain the current overflow status.
    - Call `aclrtResetOverflowStatus` interface to reset the overflow status.
- Memory Management and Data Transfer
    - Call `aclrtMalloc` and `aclrtFree` interfaces to manage the status buffer.
    - Call `aclrtMemcpy` interface to synchronize the status data to the Host side.

## Known Issues

- `aclrtSetStreamOverflowSwitch` can be used in both `ACL_RT_OVERFLOW_MODE_SATURATION` and `ACL_RT_OVERFLOW_MODE_INFNAN` modes. If the current product does not support this capability, the related interfaces may return `ACL_ERROR_RT_FEATURE_NOT_SUPPORT (207000)`. The sample logs a warning and exits after completing resource cleanup.