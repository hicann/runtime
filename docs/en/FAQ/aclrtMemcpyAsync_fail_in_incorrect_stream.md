# aclrtMemcpyAsync Fails When Dispatching Tasks on an Incorrect Stream

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:52:29.336Z pushedAt=2026-10-22T07:40:51.787Z -->

## Symptoms

**Symptom 1: A device mismatch error code is returned when aclrtMemcpyAsync is called**

When the **aclrtMemcpyAsync** API is called for asynchronous memory copy, error code 107003 (**ACL_ERROR_RT_STREAM_CONTEXT**) is returned, indicating that the stream is not in the context of the current device.

Typical error scenario:

```c
aclrtSetDevice(0);                 // Specify Device 0.
aclrtStream s0;
aclrtCreateStream(&s0);            // Create Stream s0 on Device 0.

aclrtSetDevice(1);                 // Specify Device 1.
aclrtStream s1;
aclrtCreateStream(&s1);            // Create Stream s1 on Device 1.

// Error: Dispatch a task on Device 1 through Stream s0 of Device 0.
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s0);  // Failure
```

Example of the error log:

```text
aclrtMemcpyAsync failed, ret = 107003, stream not in current context
[ERROR] RUNTIME: Stream not in current context, stream device mismatch
```

## Possible Causes

1. **The stream does not belong to the current device**: A stream is bound to a specific device when created, and tasks cannot be dispatched on another device.

## Handling

### Cause 1: The Stream Does Not Belong to the Current Device

**Solution**:

- Understand the concept of the stream ownership: a stream belongs to the device on which it is created and is bound to that device.
- Dispatch tasks on the correct device: after switching devices, use the stream that belongs to that device.
- Create an independent stream for each device: avoid mixing streams across devices.

Correct usage example:

```c
// Operations on Device 0
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);  // s0 belongs to Device 0.

// Use s0 to dispatch tasks on Device 0.
aclrtMemcpyAsync(dst0, size, src0, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s0);  // Correct

// Operations on Device 1
aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);  // s1 belongs to Device 1.

// Use s1 to dispatch tasks on Device 1.
aclrtMemcpyAsync(dst1, size, src1, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s1);  // Correct

// Incorrect example: use Stream s0 of Device 0 on Device 1.
aclrtMemcpyAsync(dst1, size, src1, size, ACL_MEMCPY_DEVICE_TO_DEVICE, s0);  // Failure!
```

Best practices for multi-device programming:

```c
// Create an independent stream for each device.
aclrtStream deviceStreams[2];

aclrtSetDevice(0);
aclrtCreateStream(&deviceStreams[0]);  // Stream of Device 0

aclrtSetDevice(1);
aclrtCreateStream(&deviceStreams[1]);  // Stream of Device 1

// Use the corresponding stream after switching the device.
aclrtSetDevice(0);
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, deviceStreams[0]);  // Correct

aclrtSetDevice(1);
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_DEVICE_TO_DEVICE, deviceStreams[1]);  // Correct
```

## Related Issues

None
