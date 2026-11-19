# Error Locating Methods in Stop-on-Error Mode

<!-- md-trans-meta sourceCommit=c5aa067e073fcae574b75cc09d19b23aa99be389 translatedAt=2026-11-11T06:25:57.752Z pushedAt=2026-11-16T03:23:05.025Z nl=2 -->

## Symptoms

**Symptom 1: The failed task cannot be accurately located in stop-on-error mode**

When the stop-on-error mode (**ACL_STOP_ON_FAILURE**) is configured on a stream, all tasks in the context are stopped when a task fails to execute. However, it is impossible to accurately determine which task failed and what caused the failure.

Typical scenario:

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

// Dispatch multiple tasks.
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                 ACL_MEMCPY_HOST_TO_DEVICE, stream);
kernel1<<<8, nullptr, stream>>>(args1);
kernel2<<<8, nullptr, stream>>>(args2);
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);

// An error is found during synchronization, but it is unknown which task failed.
aclError error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // How to determine whether kernel1 or kernel2 failed?
    // What is the cause of the failure?
}
```

## Possible Causes

1. **Long task sequence**: Multiple asynchronous tasks are dispatched on the stream, making it difficult to intuitively determine which task failed after an error occurs.

2. **Insufficiently detailed error information**: The specific failure cause cannot be identified from the return code alone; the plog logs and error query APIs must be used together.

3. **Limitation of the stop-on-error feature**: In stop-on-error mode, task execution on all streams in the context stops when the first error occurs, which may affect the preservation of the error scene.

## Handling

### Method 1: Locating the Error Task by Segmented Synchronization

Decompose a long task sequence into multiple small segments, and perform a synchronization check after each segment.

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

// Task 1: copy from the host to the device
aclError error = aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                                   ACL_MEMCPY_HOST_TO_DEVICE, stream);
if (error != ACL_RT_SUCCESS) {
    printf("Task 1 launch failed: %d\n", error);
    return error;
}

error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    printf("Task 1 execution failed: %d\n", error);
    char *errMsg = aclGetRecentErrMsg();
    printf("Error: %s\n", errMsg);
    return error;
}

// Task 2: kernel1 execution.
kernel1<<<8, nullptr, stream>>>(args1);
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    printf("Task 2 (kernel1) execution failed: %d\n", error);
    char *errMsg = aclGetRecentErrMsg();
    printf("Error: %s\n", errMsg);
    return error;
}

// Task 3: kernel2 execution.
kernel2<<<8, nullptr, stream>>>(args2);
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    printf("Task 3 (kernel2) execution failed: %d\n", error);
    char *errMsg = aclGetRecentErrMsg();
    printf("Error: %s\n", errMsg);
    return error;
}

// Task 4: copy from the device to the host
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);
error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    printf("Task 4 execution failed: %d\n", error);
    return error;
}

aclrtDestroyStream(stream);
```

### Method 2: Using Events to Mark Task Boundaries

Insert events between critical tasks and determine the task execution progress based on event status:

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

// Create multiple events to mark task boundaries.
aclrtEvent event1, event2, event3;
aclrtCreateEvent(&event1);
aclrtCreateEvent(&event2);
aclrtCreateEvent(&event3);

// Dispatch tasks and insert event markers.
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                 ACL_MEMCPY_HOST_TO_DEVICE, stream);
aclrtRecordEvent(event1, stream);  // Mark the copy task as complete.

kernel1<<<8, nullptr, stream>>>(args1);
aclrtRecordEvent(event2, stream);  // Mark kernel1 execution as complete.

kernel2<<<8, nullptr, stream>>>(args2);
aclrtRecordEvent(event3, stream);  // Mark kernel2 execution as complete.

aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);

// Synchronize and check for errors.
aclError error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // Query event status to locate the failed task.
    aclrtEventRecordedStatus status1, status2, status3;

    aclrtQueryEventStatus(event1, &status1);
    aclrtQueryEventStatus(event2, &status2);
    aclrtQueryEventStatus(event3, &status3);

    printf("Event status: event1=%d, event2=%d, event3=%d\n",
           status1, status2, status3);

    // ACL_EVENT_RECORDED_STATUS_COMPLETE = 1, ACL_EVENT_RECORDED_STATUS_NOT_READY = 0
    // The task after the last completed event is the failed task.
    if (status1 == ACL_EVENT_RECORDED_STATUS_COMPLETE && status2 == ACL_EVENT_RECORDED_STATUS_NOT_READY) {
        printf("Task failed between event1 and event2 (kernel1 failed)\n");
    } else if (status2 == ACL_EVENT_RECORDED_STATUS_COMPLETE && status3 == ACL_EVENT_RECORDED_STATUS_NOT_READY) {
        printf("Task failed between event2 and event3 (kernel2 failed)\n");
    }

    char *errMsg = aclGetRecentErrMsg();
    printf("Error detail: %s\n", errMsg);
}

// Clean up resources.
aclrtDestroyEvent(event1);
aclrtDestroyEvent(event2);
aclrtDestroyEvent(event3);
aclrtDestroyStream(stream);
```

### Method 3: Combining the Error Query API with the Plog Log

Obtain the error code through the error query API, and use the plog log to locate the specific cause of the failure.

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

// Dispatch the task.
// ... (task dispatch code omitted)

// Synchronize and check for errors.
aclError error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // 1. Obtain the error code.
    printf("Stream synchronize failed with error code: %d (0x%x)\n", error, error);

    // 2. View the latest error.
    aclError lastError = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
    printf("Last error: %d (0x%x)\n", lastError, lastError);

    // 3. Obtain the detailed error information.
    char *errMsg = aclGetRecentErrMsg();
    if (errMsg != nullptr) {
        printf("Error message: %s\n", errMsg);
    }

    // 4. Prompt to view the plog log.
    printf("Please check plog for detailed error information:\n");
    printf("  - Look for 'fault kernel_name' to identify failed kernel\n");
    printf("  - Look for 'retCode' to get error code\n");
    printf("  - Look for 'error module_type' and 'module_name' for error source\n");
}

aclrtDestroyStream(stream);
```

**Extracting key information from the plog log**:

```bash
# Search for the failed task.
grep "Task run failed" plog.log

# Search for the name of the failed kernel.
grep "fault kernel_name" plog.log

# Search for the error code and type.
grep "retCode\|errType" plog.log

# Search for the error module.
grep "module_type\|module_name" plog.log

# Example output parsing:
# [ERROR] Task run failed, device_id=0, stream_id=2, task_id=1
#   -> Locate the specific device, stream, and task ID.
# fault kernel_name=Add_ee98c6628030785f610b924ab1557b31
#   -> Locate the specific failed kernel.
# retCode=0x31, [vector core exception]
#   -> Error cause: vector core exception
# module_type=5, module_name=EZ9999
#   -> Error source module
```

### Method 4: Comparing with the Continue-on-Error Mode

If the stop-on-error mode makes fault locating difficult, you can temporarily switch to the continue-on-error mode so that subsequent tasks continue to execute and collect more information.

```cpp
aclrtStream stream;
aclrtCreateStream(&stream);

// Use the continue-on-error mode for testing.
aclrtSetStreamFailureMode(stream, ACL_CONTINUE_ON_FAILURE);

// Dispatch multiple tasks.
// ...

// Synchronize and check for errors.
aclError error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    printf("Error occurred: %d\n", error);

    // In continue-on-error mode, more information can be obtained.
    // Note: aclrtPeekAtLastError may return the last error that occurred, not the first error.
    aclError lastError = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
    printf("Last error: %d\n", lastError);

    char *errMsg = aclGetRecentErrMsg();
    printf("Error message: %s\n", errMsg);

    // Check which tasks succeeded and which failed.
    // (This needs to be verified through intermediate results)
}

// After the issue is located, switch back to the stop-on-error mode for the production environment.
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);
aclrtDestroyStream(stream);
```

### Method 5: Using Host Callback Tasks for Debugging

Insert host callback functions between critical tasks to record the task execution progress.

```cpp
void taskCallback(void *userData) {
    int *taskId = (int*)userData;
    printf("Task %d completed successfully\n", *taskId);
}

// ...

aclrtStream stream;
aclrtCreateStream(&stream);
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);

int taskId1 = 1, taskId2 = 2, taskId3 = 3, taskId4 = 4;

// Dispatch tasks and insert callbacks.
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize,
                 ACL_MEMCPY_HOST_TO_DEVICE, stream);
aclrtLaunchHostFunc(stream, taskCallback, &taskId1);

kernel1<<<8, nullptr, stream>>>(args1);
aclrtLaunchHostFunc(stream, taskCallback, &taskId2);

kernel2<<<8, nullptr, stream>>>(args2);
aclrtLaunchHostFunc(stream, taskCallback, &taskId3);

aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize,
                 ACL_MEMCPY_DEVICE_TO_HOST, stream);
aclrtLaunchHostFunc(stream, taskCallback, &taskId4);

// Synchronize.
aclError error = aclrtSynchronizeStream(stream);
if (error != ACL_RT_SUCCESS) {
    // The callback output indicates the last task that completed successfully.
    // The failed task is the one following the last successful task.
    printf("Error occurred after last successful task\n");
}

aclrtDestroyStream(stream);
```

## Related Issues

- [Issue #487: Consultation on Error Handling During the ACL Graph Capture Phase](https://gitcode.com/cann/runtime/issues/487)
- [Issue #544: Error Code Format and Log Macro Usage Specifications](https://gitcode.com/cann/runtime/issues/544)
