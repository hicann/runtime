# Differences and Selection Between Stream Synchronization and Event Synchronization

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T09:57:19.614Z pushedAt=2026-10-22T08:18:14.632Z -->

## Symptoms

**Symptom 1: Failure to understand the difference between stream synchronization and event synchronization**

The usage scope and features of the two synchronization mechanisms are confused, leading to improper selection.

Typical error scenario:

```c
// Use stream synchronization in the scenario where you need to wait for a cross-stream task to complete.
aclrtSynchronizeStream(stream1);  // Wait only for stream1, not stream2.
```

**Symptom 2: Improper synchronization timing causes performance issues or deadlock**

Incorrect selection of the synchronization mode: Event synchronization is used for single-stream waiting (over-engineering), while stream synchronization is used for multi-stream coordination (which blocks the thread).

Typical error scenario:

```c
// Wait within a single stream, but event synchronization is used (over-engineering).
aclrtEvent event;
aclrtRecordEvent(event, stream);
aclrtSynchronizeEvent(event);  // Event synchronization is more complex than stream synchronization.
```

**Symptom 3: Incorrect use of synchronization APIs causes disorderly task execution**

Event synchronization is not used for coordination across streams, resulting in incorrect task dependencies.

## Possible Causes

1. **Failure to understand the differences between the two synchronization mechanisms**: Stream synchronization blocks the entire stream, while event synchronization provides fine-grained control.
2. **Incorrect selection of the synchronization mode**: Event synchronization is used for single-stream waiting and stream synchronization for multi-stream coordination, with the order reversed.

## Handling

### Cause 1: Failure to Understand the Differences Between the Two Synchronization Mechanisms

**Solution**:

- Understand the stream synchronization features:
  - **Scope**: blocks all tasks on the specified stream until they are all complete.
  - **Applicable scenario**: waits for the entire batch of tasks on a single stream to complete.
  - **API**: **aclrtSynchronizeStream(stream)**
- Understand the event synchronization features:
  - **Scope**: precisely controls to a specific time point and supports cross-stream synchronization.
  - **Applicable scenario**: Cross-stream task coordination and fine-grained time point control.
  - **API**: **aclrtRecordEvent**, **aclrtSynchronizeEvent**, and **aclrtStreamWaitEvent**

Comparison example:

```c
// Stream synchronization: waits for the tasks in the entire stream to complete.
aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<..., stream>>>();
aclrtMemcpyAsync(host, size, dst, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

aclrtSynchronizeStream(stream);  // Wait for all the preceding three tasks to complete.

// Event synchronization: precisely controls the time point.
aclrtEvent event1, event2;
aclrtCreateEvent(&event1);
aclrtCreateEvent(&event2);

aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream1);
aclrtRecordEvent(event1, stream1);  // Record time point 1.

aclrtStreamWaitEvent(stream2, event1);  // stream2 waits for event1.
myKernel<<<..., stream2>>>();
aclrtRecordEvent(event2, stream2);  // Record time point 2.

aclrtSynchronizeEvent(event2);  // Wait for event2 to complete.
```

### Cause 2: Incorrect Synchronization Mode Selection

**Solution**:

- **Single-stream wait**: use **aclrtSynchronizeStream**, which is simple and direct.
- **Cross-stream coordination**: use an event, with stream1 Record and stream2 Wait.
- **Fine-grained time point control**: use an event to record and wait for specific time points.
- **Avoid over-engineering**: do not use event synchronization in a single-stream scenario.

Scenario selection example:

```c
// Scenario 1: Wait for the entire batch of tasks on a single stream → Stream synchronization.
aclrtStream stream;
aclrtCreateStream(&stream);

aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<..., stream>>>();
aclrtMemcpyAsync(host, size, dst, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// Recommended: stream synchronization
aclrtSynchronizeStream(stream);  // Wait for the entire stream to complete.

// Not recommended: event synchronization (over-engineering)
aclrtEvent event;
aclrtRecordEvent(event, stream);
aclrtSynchronizeEvent(event);  // One extra RecordEvent step, which has high complexity.

// Scenario 2: Perform cross-stream coordination → Event synchronization.
aclrtStream stream1, stream2;
aclrtCreateStream(&stream1);
aclrtCreateStream(&stream2);

aclrtMemcpyAsync(dst1, size, src1, size, ACL_MEMCPY_HOST_TO_DEVICE, stream1);

// Recommended: event synchronization
aclrtEvent event;
aclrtRecordEvent(event, stream1);      // stream1 records the time point.
aclrtStreamWaitEvent(stream2, event);  // stream2 waits for the time point.

aclrtMemcpyAsync(dst2, size, src2, size, ACL_MEMCPY_HOST_TO_DEVICE, stream2);

// Not recommended: stream synchronization (blocks stream1 and affects concurrency)
aclrtSynchronizeStream(stream1);       // Blocks all tasks of stream1.
aclrtMemcpyAsync(dst2, size, src2, size, ACL_MEMCPY_HOST_TO_DEVICE, stream2);

// Scenario 3: Perform fine-grained time point control → Event synchronization
aclrtEvent event1, event2, event3;
aclrtCreateEvent(&event1);
aclrtCreateEvent(&event2);
aclrtCreateEvent(&event3);

aclrtMemcpyAsync(dst, size, src, size, ACL_MEMCPY_HOST_TO_DEVICE, stream);
aclrtRecordEvent(event1, stream);  // Record the copy completion time point.

myKernel<<<..., stream>>>();
aclrtRecordEvent(event2, stream);  // Record the operator completion time point.

aclrtMemcpyAsync(host, size, dst, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);
aclrtRecordEvent(event3, stream);  // Record the output copy completion time point.

// Flexibly wait for a specific time point.
aclrtSynchronizeEvent(event2);  // Wait only for the operator to complete, without waiting for the subsequent copy.
```

## Related Issues

- [Issue #477: aclrtSynchronizeStream Reports Error 507015](https://gitcode.com/cann/runtime/issues/477)
