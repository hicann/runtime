# Stream Management

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:19:21.252Z pushedAt=2026-11-16T02:28:51.045Z nl=2 -->

## Concept

A stream describes a task queue that is dispatched by the host and executed on the device.

Within the same stream, tasks are executed sequentially in the order in which they are enqueued. When hardware resources are sufficient, tasks on different streams are scheduled to different hardware resources for parallel execution. When hardware resources are insufficient, tasks on different streams may be executed serially.

A stream can be configured with multiple attributes such as priority, stop-on-failure, and persistent. The priority affects the execution order of tasks on different streams. Generally, tasks on a high-priority stream are executed before tasks on a low-priority stream. If a stream is configured with the persistent attribute, tasks dispatched to it are not executed immediately, and they are not destroyed immediately after execution is complete. Persistent streams are suitable for scenarios where model runtime instances are built.

Relative to the host thread, tasks on a stream are executed asynchronously. The host thread can use a device synchronization API to wait until all tasks on all streams under the current context are complete, or use a stream synchronization API to wait until all tasks on a stream are complete.

All streams in Runtime are non-blocking streams. The default stream does not perform implicit synchronization with explicitly created streams.

<br>
<br>

## Stream Creation and Destruction

Call **aclrtCreateStream** to create a stream. The obtained **aclrtStream** object is used as the stream input parameter for subsequent APIs such as asynchronous memory copy, stream synchronization, and kernel execution. An explicitly created stream must be explicitly destroyed by calling **aclrtDestroyStream**. When a stream is destroyed, if there are unfinished tasks on the stream, the system waits for the tasks to complete before the stream is destroyed.

The following is a code example of creating a stream and dispatching a compute task on the stream. It cannot be directly copied, compiled, and run, and is for reference only. For the complete sample code, see [Link](https://gitcode.com/cann/runtime/blob/master/example/1_basic_features/stream/0_simple_stream).

```c
// Explicitly create a stream.
aclrtStream stream;
aclrtCreateStream(&stream);

// Dispatch a host-to-device copy task, a MyKernel task, and a device-to-host copy task on the stream.
aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// Destroy the stream (destroy it after the device-to-host copy task is complete).
aclrtDestroyStream(stream);
```

<br>
<br>

## Default Stream

When the **aclrtSetDevice** API or the **aclrtCreateContext** API is called, Runtime automatically creates a default stream. Each context has a default stream. If different host threads use the same context, they share the same default stream.

For APIs that require a stream parameter (such as **aclrtMemcpyAsync**), pass **nullptr** directly if the default stream is used as the input parameter. For APIs that do not have a stream input parameter (such as **aclrtMemcpy**), the default stream is not used.

The default stream cannot be explicitly destroyed by calling the **aclrtDestroyStream** API. When the **aclrtResetDevice** or **aclrtResetDeviceForce** API is called to release resources, the default stream is automatically destroyed.

The following is a code example of dispatching a computation task on the default stream. It is for reference only and cannot be directly copied, compiled, or run.

```c
// Specify the device (a default stream is automatically created inside the API).
aclrtSetDevice(0);

// Dispatch a host-to-device copy task, a MyKernel task, and a device-to-host copy task on the default stream.
aclrtMemcpyAsync(devPtrIn, size, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);
myKernel<<<8, nullptr, nullptr>>>(devPtrIn, devPtrOut, size);
aclrtMemcpyAsync(hostPtr, hostSize, devPtrOut, size, ACL_MEMCPY_DEVICE_TO_HOST, nullptr);

// Synchronize the default stream.
aclrtSynchronizeStream(nullptr);

// Reset the device (the default stream is automatically destroyed inside the API).
aclrtResetDevice(0);
```

<br>
<br>

## Explicit Synchronization

For asynchronous task APIs, after a host thread calls an asynchronous task API, the call only indicates that the task has been dispatched, not that task execution is complete. The user needs to explicitly call synchronization APIs such as device synchronization and stream synchronization to wait for task completion. After such an explicit synchronization API is called, the host thread is blocked until the related task execution is complete.

### Device Synchronization: aclrtSynchronizeDevice

The current host thread is blocked until all explicitly or implicitly created streams in the current context of the current device complete all dispatched tasks.

The following is a device synchronization code example. It is for reference only and cannot be directly copied, compiled, or run.

```c
// Specify the device.
aclrtSetDevice(0);

// Create a stream.
aclrtStream stream;
aclrtCreateStream(&stream);

// Dispatch tasks on the stream.
......

// Block the application until the device that is computing completes the computation.
aclrtSynchronizeDevice();

// Destroy the resources.
aclrtDestroyStream(stream);
aclrtResetDevice(0);
```

### Stream Synchronization: aclrtSynchronizeStream

The current host thread is blocked until all tasks dispatched to the specified stream are complete.

The following is a code example of stream synchronization. It is for reference only and cannot be directly copied, compiled, or run.

```c
// Create a stream.
aclrtStream stream;
aclrtCreateStream(&stream);

// Dispatch tasks to the stream.
......

// Call aclrtSynchronizeStream to block the application until all tasks in the specified stream are complete.
aclrtSynchronizeStream(stream);

// Explicitly destroy the stream after use.
aclrtDestroyStream(stream);
```

In addition, you can use **aclrtStreamQuery** to query whether all tasks on the stream have been executed.

<br>
<br>

## Host Callback Task

CANN provides a flexible mechanism for asynchronous collaboration between the CPU and the NPU. You can use **aclrtLaunchHostFunc** to insert a host callback task at any position in a stream. After all preceding tasks on the stream are executed, the host callback task is automatically executed, and it blocks the execution of subsequent tasks on the stream.

The callback function must not directly or indirectly call CANN Runtime APIs. Otherwise, errors or deadlocks may occur.

The following is a code example of inserting a host callback task on the stream. It is for reference only and cannot be directly copied, compiled, or run.

<!-- npu="950,A3,910b,910,310p,310b" id1 -->
For the complete sample code, see [Link](https://gitcode.com/cann/runtime/tree/master/example/2_advanced_features/callback/1_callback_hostfunc).
<!-- end id1 -->

```c
// Host callback task
void myHostCallback(void *args)
{
     printf("In MyHostCallback.\n");

     // Processing after myKernel1 is complete, blocking the execution of MyKernel2
     ......
}
......

// Create a stream.
aclrtStream stream;
aclrtCreateStream(&stream);

// Dispatch tasks on the stream.
aclrtMemcpyAsync(devPtrIn, size, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel1<<<8, nullptr, stream>>>(devPtrIn, devPtrOut, size);
aclrtLaunchHostFunc(stream, myHostCallback, nullptr);
myKernel2<<<8, nullptr, stream>>>(devPtrOut, size);
aclrtMemcpyAsync(hostPtr, hostSize, devPtrOut, size, ACL_MEMCPY_DEVICE_TO_HOST, stream);

// Block the application until all tasks on the specified stream are complete.
aclrtSynchronizeStream(stream);

// Destroy the stream.
aclrtDestroyStream(stream);
```

<br>
<br>

## Stream Priority Settings

At runtime, the scheduler on the device determines the task execution order based on the priority of each stream. Pending tasks in a high-priority stream are scheduled ahead of tasks in a low-priority stream, but they do not preempt low-priority tasks that are already running. The device does not dynamically re-evaluate the task queue during execution, so raising the priority of a stream does not interrupt tasks that are currently executing.

The priority of a stream is primarily used to influence the scheduling order of tasks, rather than to enforce a strict execution sequence. You can guide the task execution order by adjusting the priority of a stream, but you cannot use it to guarantee an absolute order between tasks.

When calling **aclrtCreateStreamWithConfig** to create a stream, you can specify the priority of the stream. The allowed priority range can be obtained by calling **aclrtDeviceGetStreamPriorityRange**, which returns the minimum and maximum priorities.

The following is example code, which cannot be directly copied, compiled, or run, and is for reference only.

```c
// Query the minimum and maximum stream priorities supported by the current device.
aclrtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);

// Create streams with the highest and lowest priorities.
aclrtStream stream_high;
aclrtStream stream_low;
aclrtCreateStreamWithConfig(&stream_high, greatestPriority, ACL_STREAM_FAST_LAUNCH);
aclrtCreateStreamWithConfig(&stream_low, leastPriority, ACL_STREAM_FAST_LAUNCH);
```

The priority of a stream takes effect within the device scope, rather than within the context scope.

<br>
<br>

## Stop-on-Failure Mode Settings

CANN supports the stop-on-failure mode (**ACL\_STOP\_ON\_FAILURE**) and the continue-on-failure mode (**ACL\_CONTINUE\_ON\_FAILURE**) to provide differentiated control over task execution failures for different applications. The continue-on-failure mode is used by default.

When a task on a stream fails to execute, if the stop-on-failure mode (**ACL\_STOP\_ON\_FAILURE**) is set, the execution of tasks on all streams in the context is stopped; if the continue-on-failure mode (**ACL\_CONTINUE\_ON\_FAILURE**) is set, the subsequent tasks on the stream continue to be executed.

The following sample code shows how to call **aclrtSetStreamFailureMode** to specify the scheduling mode. It is for reference only and cannot be directly copied, compiled, and run.

```c
aclrtStream stream;
aclrtCreateStream(&stream);

// Set the stop-on-failure mode.
aclrtSetStreamFailureMode(stream, ACL_STOP_ON_FAILURE);
......
```

The following sample code shows how to call **aclrtSetStreamAttribute** to specify the scheduling mode. It is for reference only and cannot be directly copied, compiled, and run.

```c
aclrtStream stream;
aclrtCreateStream(&stream);

// Set the continue-on-failure mode.
aclrtSetStreamAttribute(stream, ACL_STREAM_ATTR_FAILURE_MODE, ACL_CONTINUE_ON_FAILURE);
......
```

<br>
<br>

## Persistent Stream

Tasks on a non-persistent stream are dequeued from the stream after their execution is complete. To execute a task multiple times, you need to dispatch the task multiple times on the non-persistent stream.

Runtime provides persistent streams to support task persistence. Tasks dispatched on a persistent stream are not executed immediately, and they are not destroyed immediately after task execution is complete. The related tasks are destroyed only when the persistent stream is destroyed.

Call the **aclrtCreateStreamWithConfig** API to create a persistent stream. A persistent stream must be bound to a model running instance to support repeated model execution. The following is example code for reference only. Do not copy, compile, or run it directly.

```c
// Create a persistent stream.
aclrtStream stream;
aclrtCreateStreamWithConfig(&stream, 0, ACL_STREAM_PERSISTENT);

// Build a model running instance.
aclmdlRI modelRI;
aclmdlRIBuildBegin(&modelRI, 0);

// Bind the persistent stream to the model running instance.
aclmdlRIBindStream(modelRI, stream, ACL_MODEL_STREAM_FLAG_HEAD);

// Dispatch tasks on the persistent stream.
......

// Mark the end of task dispatch.
aclmdlRIEndTask(modelRI, stream);

// Finish building the model running instance.
aclmdlRIBuildEnd(modelRI, nullptr);

// Execute the model running instance multiple times in the default stream.
aclmdlRIExecute(modelRI, -1);
aclmdlRIExecute(modelRI, -1);

// Unbind the persistent stream.
aclmdlRIUnbindStream(modelRI, stream);

// Destroy the resources.
aclrtDestroyStream(stream);
aclmdlRIDestroy(modelRI);
......
```
