# 3_cond_model

## Description
This sample demonstrates aclGraph conditional operation (IF/WHILE/SWITCH) graph capture and execution, covering 3 typical scenarios:
1. IF conditional double branch validation (true branch alpha=2.0, false branch alpha=0.5)
2. WHILE single iteration loop (loop body executes once then exits)
3. SWITCH multi-branch selection (3 cases each with different alpha)

**Core conclusion**: aclGraph conditional operations use `aclmdlRICondHandle` + `aclmdlRIAddCondTask` to implement IF/WHILE/SWITCH branch capture, use `aclmdlRICondHandleGetCondPtr` to get device-side condition pointer, and execution dynamically determines branch direction by condition value.

**Note**: This sample requires CANN version support for aclGraph conditional operation APIs (`aclmdlRICondHandleCreate`, `aclmdlRIAddCondTask`, `aclmdlRICaptureToModelRIBegin`, and so on). Please confirm CANN version includes these interfaces before running.

## Product Support

This sample has the following support status on the following products:

| Product | Supported |
| --- | --- |
| Atlas A3 training series products/Atlas A3 inference series products | Yes |
| Atlas A2 training series products/Atlas A2 inference series products | Yes |

## Build and Run

1. Download sample code to environment with CANN software installed, switch to sample directory.
```bash
cd ${git_clone_path}/example/2_advanced_features/model_ri/3_cond_model
```

2. Set environment variables.
```bash
# Replace ${install_root} with CANN installation root directory, default installation at /usr/local/Ascend
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Set SOC_VERSION and ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

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
    - Call `aclrtResetDeviceForce` interface to reset current computation Device and reclaim Device resources.
- Context Management
    - Call `aclrtCreateContext` interface to create Context.
    - Call `aclrtDestroyContext` interface to destroy Context.
- Stream Management
    - Call `aclrtCreateStream` interface to create Stream.
    - Call `aclrtDestroyStream` interface to destroy Stream.
    - Call `aclrtSynchronizeStream` interface to block waiting for Stream task completion.
- Memory Management
    - Call `aclrtMalloc` interface to allocate Device memory.
    - Call `aclrtFree` interface to release Device memory.
- Data Transfer
    - Call `aclrtMemcpy` interface to implement data transfer by memory copy.
    - Call `aclrtMemcpyAsync` interface to perform asynchronous memory copy.
- aclGraph Conditional Operations
    - Call `aclmdlRICaptureBegin` interface to start graph capture.
    - Call `aclmdlRICaptureEnd` interface to end graph capture and get modelRI handle.
    - Call `aclmdlRICaptureGetInfo` interface to get graph capture status and modelRI.
    - Call `aclmdlRICondHandleCreate` interface to create condition handle.
    - Call `aclmdlRICondHandleGetCondPtr` interface to get condition pointer.
    - Call `aclmdlRIAddCondTask` interface to register condition task (IF/WHILE/SWITCH).
    - Call `aclmdlRICaptureToModelRIBegin` interface to start sub-model capture.
    - Call `aclmdlRIExecuteAsync` interface to asynchronously execute model runtime instance.
    - Call `aclmdlRIDestroy` interface to destroy model runtime instance.
- aclnn Operators
    - Call `aclnnAddGetWorkspaceSize` and `aclnnAdd` interfaces to execute addition operator calculation.

## Sample Output

```text
[INFO]  ========== IF condition ==========
[INFO]  IF true branch result:
[INFO]  The vector data is: 1.2500  2.5000  3.7500  5.0000  6.2500  7.5000  8.7500  10.0000
[INFO]  IF false branch result:
[INFO]  The vector data is: 1.2500  2.5000  3.7500  5.0000  6.2500  7.5000  8.7500  10.0000
[INFO]  IF condition PASSED
[INFO]  ========== WHILE condition ==========
[INFO]  WHILE single iteration result:
[INFO]  The vector data is: 1.2500  2.5000  3.7500  5.0000  6.2500  7.5000  8.7500  10.0000
[INFO]  WHILE condition PASSED
[INFO]  ========== SWITCH condition ==========
[INFO]  SWITCH case 0 result:
[INFO]  The vector data is: 1.5000  3.0000  4.5000  6.0000  7.5000  9.0000  10.5000  12.0000
...
[INFO]  SWITCH condition PASSED
[INFO]  ========== All tests PASSED ==========
```

## Known Issues

None
