# Exception Handling

<!-- md-trans-meta sourceCommit=88f8e54977c1d152ff28cba0a29d534aabf3ade1 translatedAt=2026-10-16T10:23:47.395Z pushedAt=2026-10-21T06:20:30.243Z -->

## Obtaining Runtime Error Codes

Generally, a Runtime API returns an error code. Depending on the API type, the meaning of the return code and the way to obtain the error differ:

- **Asynchronous API** (see [Asynchronous Task Execution](03_asynchronous_task_execution.md)): The error code is returned before a device task is complete. The return code only indicates whether the host dispatches the task successfully and cannot reflect the actual execution error on the device.
- **Synchronous API**: The return code directly reflects the result of this execution. Typical scenarios include: invalid parameters are passed (such as a null pointer or an out-of-range size), unsupported hardware features are requested, or memory allocation fails.

### Asynchronous API Error Handling

To check an asynchronous error immediately after an asynchronous function call, **the only way** is to explicitly call a [synchronous API](03-02_stream_management.md#explicit-synchronization) (for example, the **aclrtSynchronizeDevice** API) to block the host thread, and check the error code returned by the synchronous API.

In addition, Runtime maintains an error variable for each host thread. This variable is initialized as **ACL\_RT\_SUCCESS** and is overwritten by the error code each time an error occurs (whether a parameter validation error or an asynchronous error). The `aclrtPeekAtLastError` API only returns the value of this variable, while the `aclrtGetLastError` API also returns the value of this variable but resets it to **ACL\_RT\_SUCCESS** at the same time.

```c
// Specify a device.
aclError error = aclrtSetDevice(0);

// Create a stream.
aclrtStream stream;
error = aclrtCreateStream(&stream);

// Set the stop-on-error mode.
error = aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

// Dispatch a task on the stream. The return code only indicates whether the dispatch is successful, which is usually a parameter validation error on the host, and cannot represent the actual execution error on the device.
error = aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);

// The <<<>>> kernel call method has no return value. If you only need to detect host-side errors, obtain them through aclrtPeekAtLastError/aclrtGetLastError.
myKernel<<<8, nullptr, stream>>>();

// Obtain the most recent error of the current thread.
error = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
......

// Obtain the most recent error of the current thread and reset the status to ACL_RT_SUCCESS.
error = aclrtGetLastError(ACL_RT_THREAD_LEVEL);
......

error = aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// [Key difference] An asynchronous API must call a synchronous API to obtain asynchronous errors on the device.
error = aclrtSynchronizeDevice();
if (error != ACL_RT_SUCCESS) {
    // Obtain ErrorMsg.
    char *errMsg = aclGetRecentErrMsg();
    // Output to the log.
    printf("Error: %s\n", errMsg);
    ......
}

// Destroy resources.
error = aclrtDestroyStream(stream);
error = aclrtResetDevice(0);
```

**Note:** In continue-on-error mode, if an exception occurs during task execution on a stream, other unexecuted tasks on the stream can still continue to execute, and it does not prevent new tasks from being dispatched to the stream or to other streams in the same context. In this case, **aclrtPeekAtLastError** and **aclrtGetLastError** may not return the information about the first error.

### Synchronous API Error Handling

**There is no need to call the stream synchronization API**; simply check the return value directly.

```c
// Specify a device.
aclError error = aclrtSetDevice(0);

// [Key difference] There is no need to call APIs such as stream synchronization; simply check the return value directly.
error = aclrtMemcpy(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE);
if (error != ACL_RT_SUCCESS) {
    // Obtain ErrorMsg.
    char *errMsg = aclGetRecentErrMsg();
    // Output to the log.
    printf("Error: %s\n", errMsg);
    ......
}

// Destroy resources.
error = aclrtResetDevice(0);
```

### Differences Between Asynchronous and Synchronous API Error Handling

| Comparison Item | Asynchronous API | Synchronous API |
|--------|----------|----------|
| Return code meaning | Indicates only whether the host dispatches the task successfully. | Directly reflects the result of this execution. |
| Whether stream synchronization is required | **Yes**: capture asynchronous errors through synchronization APIs such as `aclrtSynchronizeDevice`. | **No**: the return code already contains the execution result. |
| Error acquisition timing | After stream synchronization | When the API returns |

### Usage Recommendations

For any Runtime API call, **check its return value** so that synchronous errors can be detected as early as possible. For asynchronous operations, errors must be checked again at key synchronization points (such as `aclrtSynchronizeDevice`) to ensure that execution-time errors are captured.
