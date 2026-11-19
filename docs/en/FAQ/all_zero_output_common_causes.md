# Troubleshooting Common Causes of All-Zero Output After Operator Execution

<!-- md-trans-meta sourceCommit=cd22bdcf96d482b4c6fbbdcf8afeb5a530708b77 translatedAt=2026-11-11T06:24:54.713Z pushedAt=2026-11-16T03:21:52.489Z nl=2 -->

## Symptoms

**Symptom 1: The output data is all zeros after the operator is executed**

When the operator is executed, the input data is correct, but the output data is abnormal and all zeros.

Example of the error log:

```text
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.036.721 [stars_engine.cc:1321]2082291 ProcLogicCqReport:[INIT][DEFAULT]Task run failed, device_id=0, stream_id=2, task_id=1, sqe_type=0(ffts), errType=0x1(task exception), sqSwStatus=0
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.050.365 [davinic_kernel_task.cc:1219]2082291 PreCheckTaskErr:[INIT][DEFAULT]Kernel task happen error, retCode=0x31, [vector core exception].
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.050.517 [stream.cc:1082]2082291 GetError:[INIT][DEFAULT]AIV Kernel happen error, retCode=0x31.
[ERROR] RUNTIME(2082291,python3):2024-07-04-14:14:25.051.013 [davinic_kernel_task.cc:1082]2082291 GetArgsInfo:[INIT][DEFAULT][AIC_INFO] args(0 to 9) after execute:0, 0, 0, 0, 0, 0, 0, 0, 0
```

## Possible Causes

1. **Memory not initialized**: The output memory is not properly initialized or cleared, causing uninitialized data (usually 0) to be read.
2. **Data type mismatch**: The input and output data types of the operator are incorrectly configured, for example, float32 and float16 are mixed, causing data parsing errors.
3. **Memory copy failure**: The memory copy operation between the host and the device fails or is not executed, causing the device-side memory to retain its initial value (0).
4. **Kernel compilation or execution exception**:
   - A low-version kernel (below 5.10) uses the ASan tool, causing an execution exception.
   - The operator compilation options are incorrect.
   - The kernel launch parameters are incorrectly configured.

5. **Out-of-bounds address access**: The operator accesses an invalid memory address, triggering a device-side exception.

## Handling

### Step 1: Checking Memory Initialization

Ensure that the output memory is correctly allocated and initialized.

```cpp
// Check whether memory allocation is successful.
void *devPtr = nullptr;
size_t devSize = 1024 * 1024; // 1MB
aclError error = aclrtMalloc(&devPtr, devSize, ACL_MEM_MALLOC_HUGE_FIRST);
if (error != ACL_RT_SUCCESS || devPtr == nullptr) {
    printf("Memory allocation failed\n");
    return error;
}

// Initialize the memory to a specific value (non-zero) for verification.
error = aclrtMemset(devPtr, devSize, 0xFF, devSize);
if (error != ACL_RT_SUCCESS) {
    printf("Memory initialization failed\n");
    aclrtFree(devPtr);
    return error;
}

// Execute the operator...
// Check the output after execution. If it is still 0xFF, the operator did not write to it.
// If it is 0, the operator wrote to it but the data is abnormal.
```

### Step 2: Verifying Data Type Matching

Ensure that the input and output data types of the operator are consistent.

```cpp
// Check the data type of the tensor descriptor.
aclDataType inputType, outputType;
inputType = aclGetTensorDescType(inputDesc);
outputType = aclGetTensorDescType(outputDesc);

if (inputType != outputType) {
    printf("Warning: Input type %d != Output type %d\n", inputType, outputType);
}

// Confirm that the data format (ND, NCHW, etc.) matches.
aclFormat inputFormat, outputFormat;
inputFormat = aclGetTensorDescFormat(inputDesc);
outputFormat = aclGetTensorDescFormat(outputDesc);

printf("Input format: %d, Output format: %d\n", inputFormat, outputFormat);
```

### Step 3: Checking Memory Copy Operations

Verify that data transfer between the host and the device is successful.

```cpp
// Copy the memory from the host to the device.
aclError error = aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                                   ACL_MEMCPY_HOST_TO_DEVICE, stream);
if (error != ACL_RT_SUCCESS) {
    printf("Host to Device copy failed: %d\n", error);
    return error;
}

// Ensure that the copy is complete.
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    printf("Synchronize failed after H2D copy: %d\n", error);
    return error;
}

// Optional: copy back to the host to check whether the data is transferred correctly.
error = aclrtMemcpyAsync(hostVerifyPtr, hostSize, devPtr, devSize,
                         ACL_MEMCPY_DEVICE_TO_HOST, stream);
error = aclrtSynchronizeStream(stream);

// Compare whether the data in hostPtr and hostVerifyPtr is consistent.
```

### Step 4: Analyzing plog Logs to Locate the Exception

Locate the issue based on the error codes and exception information in the plog logs.

```bash
# Search for the key error information.
grep -i "error\|exception\|failed" plog.log

# Locate the faulty kernel.
grep "fault kernel_name" plog.log
# Example output: fault kernel_name=Add_ee98c6628030785f610b924ab1557b31

```

## Related Issues

- [Issue #480: Operator Execution Failure Caused by the aicore Exception](https://gitcode.com/cann/runtime/issues/480)
