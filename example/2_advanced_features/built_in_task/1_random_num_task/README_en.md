# Launch Random Number Sample

## Overview

This sample demonstrates how to use CANN Runtime `aclrtRandomNumAsync` API to generate random numbers. Supports multiple random number distribution types and data types, used to meet random number generation requirements in different scenarios.

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
- Memory Management
    - Call aclrtMalloc interface to allocate Device output buffer and random number counter buffer.
    - Call aclrtFree interface to release Device memory.
- Data Transfer
    - Call aclrtMemcpy interface to copy generated random numbers back to Host side for checking.
- Random Number Task Execution
    - Call aclrtRandomNumAsync interface to asynchronously dispatch random number task, generating uniform, normal distribution results and dropout bitmask.

## Core API

### aclrtRandomNumAsync

```c
aclError aclrtRandomNumAsync(
    const aclrtRandomNumTaskInfo* taskInfo,  // Random number task information
    aclrtStream stream,                      // Stream
    void* reserve                            // Reserved field
);
```

### aclrtRandomNumTaskInfo Structure

```c
typedef struct { 
    aclDataType dataType; 
    aclrtRandomNumFuncParaInfo randomNumFuncParaInfo;
    void *randomParaAddr;  
    void *randomResultAddr; 
    void *randomCounterAddr;
    aclrtRandomParaInfo randomSeed; 
    aclrtRandomParaInfo randomNum; 
    uint8_t rsv[10]; 
} aclrtRandomNumTaskInfo;
```

## Random Number Generation Types

### 1. Uniform Distribution

Supported data types:
- **Floating-point types**: `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`
- **Integer types**: `ACL_INT32`, `ACL_INT64`, `ACL_UINT32`, `ACL_UINT64`

Function type identifier: `ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS`

Parameter description:
- `min`: Minimum value
- `max`: Maximum value

### 2. Normal Distribution

Supported data types:
- `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`

Function type identifier: `ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS`

Parameter description:
- `mean`: Mean value
- `stddev`: Standard deviation

### 3. Truncated Normal Distribution

Supported data types:
- `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`

Function type identifier: `ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS`

Parameter description:
- `mean`: Mean value
- `stddev`: Standard deviation

### 4. Dropout Bitmask Generation

Used to generate bit mask for random dropout (Dropout), supports generation by ratio.

Function type identifier: `ACL_RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK`

Parameter description:
- `ratio`: Dropout ratio (supported data types `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`)

## Random Number Algorithms

| Algorithm | Features |
|------|------|
| **Philox4_32_10** | - Supports all distribution types<br>- Counter is 128bit, requires 16Byte storage |

## Memory Requirements

1. **Counter Memory**: Fixed 16 bytes, any byte-aligned address is acceptable
2. **Output Memory**: Dynamically allocated based on data type and random number count
3. **Parameter Memory**: Mean, standard deviation, range, and other parameters can use immediate values or device memory

## Known Issues

None