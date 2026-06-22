# 0_custom_allocator

## Overview

This sample demonstrates the creation, registration, and callback function execution of custom Runtime allocator descriptors.

## Functional Description

- Define four types of callback functions: alloc/free/allocAdvise/getAddr.
- Register the custom allocator object and function pointers to AllocatorDesc.
- Bind AllocatorDesc to a Stream, and read back the registration result through GetByStream.
- Invoke callbacks to perform an actual allocation, address retrieval, and deallocation.

## Product Support

This sample supports the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 Training Series Products/Atlas A3 Inference Series Products | Yes |
| Atlas A2 Training Series Products/Atlas A2 Inference Series Products | Yes |

## Build and Run

For details about environment installation and execution, see the [README](../../../README_en.md) in the example directory.

Run the following steps:

```bash
# Replace ${install_root} with the CANN installation root directory. The default installation directory is `/usr/local/Ascend`.
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Build and run
bash run.sh
```
## CANN RUNTIME API

In this sample, the key functional points and their key interfaces are as follows:
- Initialization and Stream Management
    - Call `aclInit` and `aclFinalize` interfaces to complete ACL initialization and deinitialization.
    - Call `aclrtSetDevice` and `aclrtResetDeviceForce` interfaces to manage Device.
    - Call `aclrtCreateStream` and `aclrtDestroyStream` interfaces to create and destroy Stream.
- AllocatorDesc Descriptor Management
    - Call `aclrtAllocatorCreateDesc` and `aclrtAllocatorDestroyDesc` interfaces to create and destroy AllocatorDesc.
    - Call `aclrtAllocatorSetObjToDesc`, `aclrtAllocatorSetAllocFuncToDesc`, `aclrtAllocatorSetFreeFuncToDesc`, `aclrtAllocatorSetAllocAdviseFuncToDesc`, and `aclrtAllocatorSetGetAddrFromBlockFuncToDesc` interfaces to bind custom allocator objects and callback functions.
- Allocator Registration and Query
    - Call `aclrtAllocatorRegister` and `aclrtAllocatorUnregister` interfaces to complete registration and deregistration of custom allocators.
    - Call `aclrtAllocatorGetByStream` interface to query the currently effective Allocator configuration by Stream.

## Known Issues

None.