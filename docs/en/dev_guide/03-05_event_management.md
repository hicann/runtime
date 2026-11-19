# Event Management

<!-- md-trans-meta sourceCommit=f27ca703aef442726cc28a36cb0f8ecff75fe506 translatedAt=2026-11-11T06:19:19.401Z pushedAt=2026-11-16T02:37:17.385Z nl=2 -->

## Concept

An event is used for task synchronization between different **streams** within the same **device**. An event supports **one task waiting for one event**. For example, if a task in stream2 depends on a task in stream1, you must ensure that the task in stream1 completes first. In this case, you can create an event, insert it into stream1 (Event Record task), and insert a task that waits for the event to complete into stream2 (Event Wait task).

An event also supports **multiple tasks waiting for the same event (many-to-one)**. For example, tasks in both stream2 and stream3 wait for the event in stream1 to complete. In addition, an event supports recording **event timestamp** information.

The following figure shows one task waiting for one event:

![](figures/Event_one_task_one_event.png)

The following figure shows multiple tasks waiting for the same event:

![](figures/Event_multi_tasks_one_event.png)

<br>
<br>

## Event Creation and Destruction

The following is a code example of creating and destroying two events. This example is for reference only to illustrate how to use events and cannot be directly copied, compiled, and run. For the complete sample code, see [Link](https://gitcode.com/cann/runtime/blob/master/example/1_basic_features/event/1_event_timestamp).

```c
aclrtEvent startEvent;
aclrtEvent endEvent;
// Create events. The ACL_EVENT_SYNC parameter is passed to the API, indicating that the created event is used for synchronization.
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_SYNC);
aclrtCreateEventExWithFlag(&endEvent, ACL_EVENT_SYNC);
......
// Destroy the events.
aclrtDestroyEvent(startEvent);
aclrtDestroyEvent(endEvent);
```

<br>
<br>

## Event Wait

An event can be used to synchronize tasks across multiple streams. For example, if a task in stream2 depends on a task in stream1 and the task in stream1 must complete first, you can create an event.

Call **aclrtRecordEvent** to insert the event into stream1. This is usually called an Event Record task. Call **aclrtStreamWaitEvent** to insert a task into stream2 that waits for the event to complete. This is usually called an Event Wait task.

The following is sample code for calling **aclrtStreamWaitEvent**. It cannot be directly copied, compiled, or run, and is for reference only.

```c
// Create an event.
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);

// Create stream1.
aclrtStream stream1;
aclrtCreateStream(&stream1);

// Create stream2.
aclrtStream stream2;
aclrtCreateStream(&stream2);

// Dispatch a task on stream1.
......

// Add an event at the end of stream1.
aclrtRecordEvent(event, stream1);

// Dispatch a task on stream2 that does not depend on the completion of stream1.
......

// Block stream2 from running until the specified event occurs, that is, until stream1 finishes execution.
aclrtStreamWaitEvent(stream2, event);

// Dispatch tasks on stream2 that depend on the completion of stream1 execution.
......

// Block the application from running until all tasks in stream1 and stream2 finish execution.
aclrtSynchronizeStream(stream1);
aclrtSynchronizeStream(stream2);

// Explicitly destroy the resources.
aclrtDestroyStream(stream1);
aclrtDestroyStream(stream2);
aclrtDestroyEvent(event);
......
```

<br>
<br>

## Event Timestamp Recording

The event created in [Event Creation and Destruction](#event-creation-and-destruction) can be used to measure the execution time of computation tasks on a stream. The following code example is for reference only and cannot be directly copied, compiled, and run. For the complete sample code, see [Link](https://gitcode.com/cann/runtime/blob/master/example/1_basic_features/event/1_event_timestamp).

```c
uint64_t time = 0;
float useTime = 0;

// Create a stream.
aclrtStream stream;
aclrtCreateStream(&stream);

aclrtEvent startEvent;
aclrtEvent endEvent;
// Create an event. Pass ACL_EVENT_TIME_LINE to the API to indicate that the event is used to record timestamps.
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_TIME_LINE);
aclrtCreateEventExWithFlag(&endEvent, ACL_EVENT_TIME_LINE);

// Insert startEvent.
aclrtRecordEvent(startEvent, stream);
// Dispatch the computation task to the stream.
kernel<<<blockDim, nullptr, stream>>>();
// Insert endEvent.
aclrtRecordEvent(endEvent, stream);
aclrtSynchronizeStream(stream);

// Obtain the timestamps and calculate the execution time.
aclrtEventElapsedTime(&useTime, startEvent, endEvent);
```

<br>
<br>

## Event Query

You can call the **aclrtQueryEventStatus** API to query whether a specified event is complete. This is a non-blocking API. The event status includes **ACL\_EVENT\_RECORDED\_STATUS\_COMPLETE** (all tasks have been executed) and **ACL\_EVENT\_RECORDED\_STATUS\_NOT\_READY** (there are tasks that have not been executed).

The following is a code example of implementing a multi-thread memory pool reuse management mechanism through events. It cannot be directly copied, compiled, and run, and is for reference only.

1. Create a memory pool in thread A. The memory used by the operator comes from the memory pool. Insert an Event Record task after the operator.

    ```c
    // Request a memory pool.
    ......
    // Create a stream.
    aclrtStream stream;
    aclrtCreateStream(&stream);

    // Create an event.
    aclrtEvent event;
    aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);

    // Dispatch the computation task on the stream.
    ......
    // Insert the event into the stream where the operator resides.
    aclrtRecordEvent(event, stream);
    ```

2. Call the query API in thread B. If the queried event is complete, the memory of all operators before the Event Record can be safely reused.

    ```c
    aclrtEventRecordedStatus status;
    // Query whether the event of thread A is complete.
    aclrtQueryEventStatus(event, &status);
    if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // The event is complete, and the memory occupied by the operator can be reused.
    } else {
    // The operator has not finished execution, and the memory occupied by it cannot be reused.
    }

    ```

<br>
<br>

## Event Synchronization

Call the **aclrtSynchronizeEvent** API to block the current host thread until the specified event is complete. The following is example code, which cannot be directly copied, compiled, or run, and is for reference only.

```c
// Create an event.
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);

// Create a stream.
aclrtStream stream;
aclrtCreateStream(&stream);

// Dispatch tasks on the stream.
......

// Record the event on the stream.
aclrtRecordEvent(event, stream);

// Block the application until the event occurs.
aclrtSynchronizeEvent(event);

// Explicitly destroy the resources.
aclrtDestroyStream(stream);
aclrtDestroyEvent(event);
```
