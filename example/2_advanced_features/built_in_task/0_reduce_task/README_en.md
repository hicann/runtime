# Launch Reduce Task Sample

## Overview

This sample demonstrates how to use CANN Runtime `aclrtReduceAsync` API to execute reduction (Reduce) operation. Reduction is a common operation in parallel computing, used to perform sum, maximum, and other operations on array elements.

## Product Support

This sample has the following support status on the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run
For environment installation details and running details, see [README](../../../README_en.md) in the example directory.


Run steps:

```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Build and run
bash run.sh
```

## CANN RUNTIME API

Key features and interfaces in this sample:
- Initialization
    - Call aclInit interface to initialize AscendCL configuration.
    - Call aclFinalize interface to deinitialize AscendCL.
- Device Management
    - Call aclrtSetDevice interface to specify Device for computation.
    - Call aclrtResetDeviceForce interface to forcibly reset current computation Device and reclaim Device resources.
- Stream Management
    - Call aclrtCreateStream interface to create Stream.
    - Call aclrtSynchronizeStream interface to block waiting for Stream task execution completion.
    - Call aclrtDestroyStream interface to destroy Stream.
- Memory Management
    - Call aclrtMalloc interface to allocate Device memory.
    - Call aclrtFree interface to release Device memory.
- Data Transfer
    - Call aclrtMemcpy interface to copy input/output data between Host and Device.
- Reduce Task Execution
    - Call aclrtReduceAsync interface to asynchronously execute Reduce operation on Stream.

## Core API

### aclrtReduceAsync

```c
aclError aclrtReduceAsync(
    void* dst,                    // Output address
    const void* src,              // Input address
    uint64_t count,               // Data size (bytes)
    aclrtReduceKind kind,         // Reduction type
    aclDataType type,             // Data type
    aclrtStream stream,           // Stream
    void* reserve                 // Reserved parameter
);
```
### Reduction Type

```c
ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM  // Automatic sum (prefix sum)
```

## Sample Output

```text
Reduce SUM result[0] = 2.000000
Reduce SUM result[1] = 4.000000
Reduce SUM result[2] = 6.000000
Reduce SUM result[3] = 8.000000
Sample Run Successfully.
```

## Known Issues
  
  None
