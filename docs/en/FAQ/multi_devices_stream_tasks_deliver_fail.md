# Failure to Dispatch Tasks on the Stream Across Devices

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-16T10:02:44.574Z pushedAt=2026-10-23T06:08:39.972Z -->

## Symptoms

**Symptom 1: Failure to dispatch an operator on the stream that does not belong to the current device**

In a multi-device scenario, when you attempt to launch an operator on a stream that has no ownership relationship with the current device, the task dispatch fails.

Incorrect code example:

```cpp
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);
myKernel<<<8, nullptr, s0>>>();    // ✓ Created on Device 0 and used on Device 0.

aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);
myKernel<<<8, nullptr, s1>>>();    // ✓ Created on Device 1 and used on Device 1.

myKernel<<<8, nullptr, s0>>>();    // ✗ Dispatching an operator through Stream s0 on Device 1 fails
```

**Symptom 2: Failure to call an asynchronous copy API on a stream that does not belong to the current device**

When the device to which the stream belongs differs from the device currently being operated, calling **aclrtMemcpyAsync** on this stream fails.

**Symptom 3: Operations fail when an event and a stream are associated with different devices**

When an event and a stream are associated with different devices, calling **aclrtRecordEvent** or **aclrtStreamWaitEvent** fails.

## Possible Causes

1. A stream has a device ownership relationship. After a stream is created on its owning device, it can only be used on that device.
2. An event also has a device ownership relationship. An event can only be associated with a stream that belongs to the same device as the event.
3. The device on which the current operation is performed does not match the device to which the stream/event belongs, violating the resource ownership relationship constraint.

## Handling

**Solution 1: Using the stream on the correct device**

Ensure that operations are performed on the device to which the stream belongs:

```cpp
// Correct example: use the stream on the device to which it belongs.
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);
myKernel<<<8, nullptr, s0>>>();    // ✓ Correct: created on Device 0 and used on Device 0.

aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);
myKernel<<<8, nullptr, s1>>>();    // ✓ Correct: created on Device 1 and used on Device 1.
```

**Solution 2: Using an event for cross-device synchronization**

If cross-device task coordination is required, use an event for synchronization instead of using a stream across devices.

```cpp
// Create an event on Device 0 and record it.
aclrtSetDevice(0);
aclrtStream s0;
aclrtCreateStream(&s0);
aclrtEvent event;
aclrtCreateEvent(&event);
aclrtRecordEvent(event, s0);

// Switch to Device 1 and wait for the event from Device 0.
aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);
aclrtStreamWaitEvent(s1, event);  // The stream on Device 1 waits for the event on Device 0.
myKernel<<<8, nullptr, s1>>>();
```

**Solution 3: Checking the device ownership relationship between the event and the stream**

Ensure that the event and the stream are associated with the same device:

```cpp
// Incorrect example:
aclrtSetDevice(0);
aclrtEvent event;
aclrtCreateEvent(&event);  // The event belongs to Device 0.

aclrtSetDevice(1);
aclrtStream s1;
aclrtCreateStream(&s1);    // The stream belongs to Device 1.
aclrtRecordEvent(event, s1);  // ✗ Incorrect: The event and the stream belong to different devices.

// Correct example
aclrtSetDevice(0);
aclrtEvent event;
aclrtCreateEvent(&event);  // The event belongs to Device 0.
aclrtStream s0;
aclrtCreateStream(&s0);    // The stream belongs to Device 0.
aclrtRecordEvent(event, s0);  // ✓ Correct: The event and the stream belong to the same device.
```

## Related Issues

- [Issue #344: Consultation on the Relationship Among the Device, Context, and Stream](https://gitcode.com/cann/runtime/issues/344)
