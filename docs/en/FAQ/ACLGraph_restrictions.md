# Task Submission Restrictions During ACL Graph Capture

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:52:37.994Z pushedAt=2026-10-22T07:29:37.744Z -->

## Symptoms

**Symptom 1: Failure to perform synchronization or query operations on the stream, event, device, or context**

When using the ACL Graph method to capture tasks on a stream (between `aclmdlRICaptureBegin` and `aclmdlRICaptureEnd`), performing synchronization or query operations on the stream, event, device, or context causes capture to fail.

Example of incorrect code:

```cpp
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
aclrtSynchronizeStream(stream);  // ✗ Illegal operation, which causes capture to fail.
aclmdlRICaptureEnd(stream, &modelRI);
```

Example of the error log:

```text
[ERROR] RUNTIME: operation not permitted when a stream is capturing and the specified capture mode is not relaxed, ret=107041
```

**Symptom 2: An error is reported when memory synchronization operation class functions are called in globally prohibited mode**

In globally prohibited mode (`ACL_MODEL_RI_CAPTURE_MODE_GLOBAL`), an error is reported when memory synchronization operation class functions (such as `aclrtMemset`, `aclrtMemcpy`, and `aclrtMemcpy2d`) are called.

Example of incorrect code:

```cpp
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
aclrtMemcpy(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE);  // ✗ Illegal operation, which reports an error.
aclmdlRICaptureEnd(stream, &modelRI);
```

Example of the error log:

```text
[ERROR] RUNTIME: operation not permitted when a stream is capturing and the specified capture mode is not relaxed, ret=107041
```

**Symptom 3: Failure to use the default stream to perform capture**

When the default stream (passing **nullptr**) is used to perform ACL Graph capture, the capture may fail or behave abnormally.

Example of incorrect code:

```cpp
aclmdlRICaptureBegin(nullptr, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);  // ✗ Use the default stream.
aclmdlRICaptureEnd(nullptr, &modelRI);
```

## Possible Causes

1. **Performing synchronization or query operations on the stream, event, device, or context**: Executing synchronization or query operations during the capture phase violates the capture rules.
2. **Calling memory synchronization operation class functions in globally prohibited mode**: In **ACL_MODEL_RI_CAPTURE_MODE_GLOBAL** mode, memory synchronization functions such as **aclrtMemset** and **aclrtMemcpy** are not allowed.
3. **Using the default stream to perform capture**: The default stream (passing **nullptr**) may cause failures or abnormal behavior during the capture process.

## Handling

### Cause 1: Performing Synchronization or Query Operations on the Stream, Event, Device, or Context

Perform synchronization or query operations before or after the capture phase:

```cpp
// Correct example: complete the synchronization operation before capture.
aclrtSynchronizeStream(stream);  // ✓ Perform synchronization before the capture.

aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, stream);
aclmdlRICaptureEnd(stream, &modelRI);

// Synchronize after executing the model.
aclmdlRIExecuteAsync(modelRI, stream);
aclrtSynchronizeStream(stream);  // ✓ Perform synchronization after the capture.
```

### Cause 2: Calling Memory Synchronization Operation Class Functions in Globally Prohibited Mode

If you are certain that memory synchronization operations will not affect task capture, you can switch to the `ACL_MODEL_RI_CAPTURE_MODE_RELAXED` mode:

```cpp
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);

// Asynchronous memory copy (always allowed)
aclrtMemcpyAsync(self_d, size, self_h, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);

// Switch the capture mode to RELAXED to allow calling the aclrtMemcpy function.
aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_RELAXED;
aclmdlRICaptureThreadExchangeMode(&mode);

// Synchronous memory copy (executed only once, allowed in RELAXED mode)
aclrtMemcpy(other_d, size, other_h, size, ACL_MEMCPY_HOST_TO_DEVICE);

// Switch the capture mode back to GLOBAL.
aclmdlRICaptureThreadExchangeMode(&mode);

aclmdlRICaptureEnd(stream, &modelRI);
```

### Cause 3: Using the Default Stream for Capture

Create and use an explicit stream instead of the default stream:

```cpp
// Incorrect example: use the default stream during capture.
aclmdlRICaptureBegin(nullptr, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);  // ✗ Use the default stream
aclmdlRICaptureEnd(nullptr, &modelRI);

// Correct example: create an explicit stream.
aclrtStream stream;
aclrtCreateStream(&stream);
aclmdlRICaptureBegin(stream, ACL_MODEL_RI_CAPTURE_MODE_GLOBAL);  // ✓ Use an explicit stream
aclmdlRICaptureEnd(stream, &modelRI);
aclrtDestroyStream(stream);
```

## Related Issues

- [Issue #487: Consultation on Kernel Control API Support During the ACL Graph Capture Phase](https://gitcode.com/cann/runtime/issues/487)
