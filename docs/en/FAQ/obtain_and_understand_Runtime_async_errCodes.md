# How to Obtain and Interpret Runtime Asynchronous Error Codes

<!-- md-trans-meta sourceCommit=fa4946f649859b6ee5cb357a13cbe6c3c5736c6d translatedAt=2026-11-11T06:25:33.490Z pushedAt=2026-11-16T03:22:26.299Z nl=2 -->

## Symptoms

**Symptom 1: An asynchronous API returns success but the actual execution on the device side fails**

When a Runtime asynchronous API (such as **aclrtMemcpyAsync** or **Kernel Launch**) is called, the API returns success (**ACL_RT_SUCCESS**), but an error actually occurs on the device side during execution.

Typical scenario:

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);

// The asynchronous API returns success, which only indicates that the task is dispatched successfully.
aclError error = aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                                   ACL_MEMCPY_HOST_TO_DEVICE, stream);
// error == ACL_RT_SUCCESS, but the execution on the device side may fail.
```

**Symptom 2: Delayed propagation of asynchronous errors makes them difficult to locate**

An asynchronous error on the device side is returned only when a subsequent Runtime API is called, which may not be the API where the error actually occurred, making error locating difficult.

Example of the error log:

```text
[ERROR] RUNTIME: Aicore kernel execute failed, ret=507015, aicore exception
fault kernel_name=Add_ee98c6628030785f610b924ab1557b31
```

**Symptom 3: Multiple errors overwrite each other in continue-on-error mode**

In continue-on-error mode, if multiple tasks on a stream fail to execute, a later error may overwrite the earlier error information, making it impossible to obtain the first error.

```cpp
// Subsequent operations continue to execute based on an erroneous assumption.
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);
aclrtSynchronizeStream(stream);
// The error is only discovered at this point, making it difficult to identify which asynchronous task failed.
```

## Possible Causes

1. **Asynchronous execution mechanism**: After an asynchronous API of Runtime dispatches a task on the host side, it returns immediately, and the task is executed asynchronously on the device side. The return value of the API only reflects whether host-side parameter validation and task dispatch succeed, and cannot report the actual execution error on the device side.
2. **Delayed error propagation**: An asynchronous error on the device side is returned only when a subsequent Runtime API is called, which may not be the API where the error actually occurred, making error locating difficult.
3. **Error overwriting**: In continue-on-error mode, if multiple tasks on a stream fail, a later error may overwrite the earlier error information, making it impossible to obtain the first error.

Typical asynchronous error example (obtained through **aclrtSynchronizeStream**):

```text
[ERROR] RUNTIME: Aicore kernel execute failed, ret=507015, aicore exception
fault kernel_name=Add_ee98c6628030785f610b924ab1557b31
```

## Handling

### Method 1: Synchronizing Immediately to Obtain Asynchronous Errors

Call a synchronous API immediately after the asynchronous API call to obtain the actual execution result on the device side.

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);

// Dispatch the asynchronous task.
aclError error = aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                                   ACL_MEMCPY_HOST_TO_DEVICE, stream);

// Synchronize immediately and obtain the error code.
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // Handle the error.
    printf("Async task failed with error: %d\n", error);
    char *errMsg = aclGetRecentErrMsg();
    printf("Error message: %s\n", errMsg);
}

aclrtDestroyStream(stream);
```

### Method 2: Using the Error Query API

Use `aclrtPeekAtLastError` or `aclrtGetLastError` to query the error status of the current thread.

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

// Dispatch multiple asynchronous tasks.
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                 ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);

// Synchronize and check for the error.
aclrtSynchronizeStream(stream);

// View the error without resetting.
aclError lastError = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
if (lastError != ACL_RT_SUCCESS) {
    printf("Last error: %d\n", lastError);
}

// Obtain and reset the error status.
lastError = aclrtGetLastError(ACL_RT_THREAD_LEVEL);
// The error status has been reset to ACL_RT_SUCCESS.
```

### Method 3: Obtaining Detailed Error Information

Obtain the detailed error description by calling `aclGetRecentErrMsg()`.

```cpp
aclError error = aclrtSynchronizeDevice();
if (error != ACL_RT_SUCCESS) {
    char *errMsg = aclGetRecentErrMsg();
    if (errMsg != nullptr) {
        printf("Error detail: %s\n", errMsg);
    }

    // Classify and handle the information based on the error code.
    // For the actual error code definitions, see the rt_error_codes.h header file.
    switch (error) {
        case ACL_ERROR_RT_PARAM_INVALID:        // 107000
            printf("Invalid parameter\n");
            break;
        case ACL_ERROR_RT_INVALID_DEVICEID:     // 107001
            printf("Invalid device ID\n");
            break;
        // ... Handle other error codes.
    }
}
```

### Method 4: Combining with the Stop-on-Error Mode

Configure the stop-on-error mode to stop execution at the first error and prevent error propagation.

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);

// Configure stop-on-error.
aclError error = aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);
if (error != ACL_RT_SUCCESS) {
    printf("Failed to set failure mode\n");
    return error;
}

// Dispatch tasks.
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                 ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);

// Synchronize and check.
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // Stop at the first error for easier locating.
    printf("First error occurred: %d\n", error);
    char *errMsg = aclGetRecentErrMsg();
    printf("Error message: %s\n", errMsg);
}

aclrtDestroyStream(stream);
```

## Related Issues

- [Issue #477: Error Code 507015 Reported by aclrtSynchronizeStream and Plog Log Analysis](https://gitcode.com/cann/runtime/issues/477)
- [Issue #480: AICore Exception Analysis](https://gitcode.com/cann/runtime/issues/480)
