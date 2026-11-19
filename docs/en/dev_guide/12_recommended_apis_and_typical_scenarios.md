# Recommended APIs and Typical Scenarios

<!-- md-trans-meta sourceCommit=d88003ad992cd15f97c105cd9ea6c2a6fa193e0f translatedAt=2026-11-11T06:24:31.760Z pushedAt=2026-11-16T03:09:02.383Z nl=2 -->

This section describes recommended Runtime APIs and their typical usage scenarios, helping you quickly select appropriate APIs to complete common programming tasks.

## aclrtCreateEventExWithFlag

### API Declaration

```c
aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
```

Creates an event with a flag. Events with different flags are used for different functionalities. Multiple flags can be carried when an event is created (via a bitwise OR operation), thereby enabling the functionality of the corresponding flag simultaneously.

### Parameter Description

| Parameter | Description |
|------|------|
| `event` | Output, which indicates the pointer to the event. |
| `flag` | Input, which indicates the flag of the event. It supports bitwise OR combination. |

### Flag Description

| Flag | Value | Description |
|------|----|------|
| `ACL_EVENT_SYNC` | 0x01 | Supports task synchronization across multiple streams (**aclrtStreamWaitEvent**). |
| `ACL_EVENT_CAPTURE_STREAM_PROGRESS` | 0x02 | Tracks stream task execution progress. |
| `ACL_EVENT_TIME_LINE` | 0x08 | Records timestamps and supports timing via **aclrtEventElapsedTime**. |
| `ACL_EVENT_IPC` | 0x40 | Implements inter-process communication and supports **aclrtIpcGetEventHandle**. |

> **Note**: `ACL_EVENT_IPC` does not support bitwise OR operations with other flags and must be used alone. `ACL_EVENT_TIME_LINE` affects the performance of event-related APIs. Enable it only when there is a clear timing requirement.

### Usage Scenarios

#### Scenario 1: Task Synchronization Across Multiple Streams

When dependencies exist among multiple streams, stream2 must wait for stream1 to complete before execution. The "many-to-one" scenario is supported, where multiple streams wait for the same event simultaneously.

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);

// Execute the Record Event after stream1 dispatches the computation task.
aclrtRecordEvent(event, stream1);

// stream2 and stream3 wait for the event of stream1 to complete.
aclrtStreamWaitEvent(stream2, event);
aclrtStreamWaitEvent(stream3, event);

aclrtSynchronizeStream(stream2);
aclrtSynchronizeStream(stream3);
aclrtDestroyEvent(event);
```

#### Scenario 2: Event Timing (Performance Measurement)

Collect statistics on the execution time of a task on the device side.

```c
aclrtEvent startEvent, endEvent;
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_TIME_LINE);
aclrtCreateEventExWithFlag(&endEvent,   ACL_EVENT_TIME_LINE);

aclrtRecordEvent(startEvent, stream);
// ... Dispatch the computation task ...
aclrtRecordEvent(endEvent, stream);

aclrtSynchronizeStream(stream);

float ms = 0.0f;
aclrtEventElapsedTime(&ms, startEvent, endEvent);
printf("Task elapsed time: %.3f ms\n", ms);

aclrtDestroyEvent(startEvent);
aclrtDestroyEvent(endEvent);
```

#### Scenario 3: IPC Cross-Process Event Synchronization

Two processes share the same device. After process A completes computation on a stream, process B needs to wait before continuing. Both multi-process scenarios within the same device and across devices are supported.

```c
// Process A: Create an IPC event and export it.
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_IPC);
aclrtRecordEvent(event, streamA);

aclrtIpcEventHandle handle;
aclrtIpcGetEventHandle(event, &handle);  // Export the handle and pass it to process B.

// Process B: Import the IPC event and wait.
aclrtEvent eventB;
aclrtIpcOpenEventHandle(handle, &eventB);
aclrtStreamWaitEvent(streamB, eventB);

aclrtDestroyEvent(event);   // Process A
aclrtDestroyEvent(eventB);  // Process B
```

#### Scenario 4: Stream Execution Progress Tracking

Query the completion status of tasks on the stream in a non-blocking manner.

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);

aclrtRecordEvent(event, stream);

aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
// ACL_EVENT_RECORDED_STATUS_COMPLETE    → Task completed
// ACL_EVENT_RECORDED_STATUS_NOT_READY → Task not completed.

aclrtDestroyEvent(event);
```

#### Scenario 5: Combination of Synchronization and Timing

Both multi-stream synchronization and timing are required.

```c
aclrtEvent startEvent, endEvent;
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_SYNC | ACL_EVENT_TIME_LINE);
aclrtCreateEventExWithFlag(&endEvent,   ACL_EVENT_SYNC | ACL_EVENT_TIME_LINE);

aclrtRecordEvent(startEvent, stream1);
// ... stream1 dispatches a computation task ...
aclrtRecordEvent(endEvent, stream1);

aclrtStreamWaitEvent(stream2, endEvent);  // stream2 synchronously waits for stream1 to complete.
aclrtSynchronizeStream(stream1);

float ms = 0.0f;
aclrtEventElapsedTime(&ms, startEvent, endEvent);

aclrtDestroyEvent(startEvent);
aclrtDestroyEvent(endEvent);
```

#### Scenario 6: Only Synchronization Scenario (Simplest Usage)

When only inter-stream synchronization is required, pass `ACL_EVENT_SYNC`.

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);

aclrtRecordEvent(event, stream);
aclrtSynchronizeEvent(event);

aclrtDestroyEvent(event);
```

### Flag Combination for Selection

| Requirement | flag Parameter | Applicable Scenario |
|------|---------|---------|
| Multi-stream synchronization only | `ACL_EVENT_SYNC` | Dependencies between multiple streams |
| Timing only | `ACL_EVENT_TIME_LINE` | Performance measurement |
| Synchronization + timing | `ACL_EVENT_SYNC \| ACL_EVENT_TIME_LINE` | Synchronization and timing |
| Synchronization + progress tracking | `ACL_EVENT_SYNC \| ACL_EVENT_CAPTURE_STREAM_PROGRESS` | Synchronization and progress query |
| Cross-process synchronization | `ACL_EVENT_IPC` (used alone, cannot be combined) | IPC cross-process synchronization |
| Progress tracking only | `ACL_EVENT_CAPTURE_STREAM_PROGRESS` | Non-blocking status query |

### Constraints

- `ACL_EVENT_IPC` does not support bitwise OR operations with other flags and must be used independently.
- `ACL_EVENT_TIME_LINE` affects the performance of event-related APIs. Enable it only when timing is explicitly required.
- Events created with `ACL_EVENT_IPC` do not support `aclrtEventElapsedTime`, `aclrtEventGetTimestamp`, `aclrtGetEventId`, or model capture scenarios.

## aclrtQueryEventStatus

### API Declaration

```c
aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
```

Queries the execution status of all tasks captured by the event. This is a non-blocking API that does not wait for task completion and immediately returns the current status.

### Parameter Description

| Parameter | Description |
|------|------|
| `event` | Input, which indicates the event to be queried. |
| `status` | Output, which indicates the execution status of the event. |

### Status Description

| Status Value | Description |
|--------|------|
| `ACL_EVENT_RECORDED_STATUS_COMPLETE` | All tasks captured by the event have completed execution. |
| `ACL_EVENT_RECORDED_STATUS_NOT_READY` | Some tasks captured by the event have not completed execution. |

### Usage Scenarios

#### Scenario 1: Memory Pool Reuse Management

In a multi-thread scenario, thread A dispatches an operator task and executes Record Event, and thread B determines whether the operator has completed by querying the event status. After completion, the memory occupied by the operator can be safely reused.

```c
// Thread A: dispatches the task and executes Record Event.
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);
aclrtRecordEvent(event, stream);

// Thread B: queries the event status to determine whether the memory can be reused.
aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // The task is complete, and the memory can be safely reused.
} else {
    // The task is not complete, and the memory cannot be reused.
}
```

#### Scenario 2: Polling to Wait for Task Completion

Instead of blocking the host thread, the task completion status is checked through polling, during which the host can perform other work.

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);
aclrtRecordEvent(event, stream);

aclrtEventRecordedStatus status = ACL_EVENT_RECORDED_STATUS_NOT_READY;
while (status != ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // The host can perform other work here.
    aclrtQueryEventStatus(event, &status);
}

// Task is completed, and subsequent processing continues.
aclrtDestroyEvent(event);
```

#### Scenario 3: Used with aclrtSynchronizeEvent

Use **aclrtSynchronizeEvent** to block the thread and wait for the event to complete, and then use **aclrtQueryEventStatus** to confirm the status.

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);
aclrtRecordEvent(event, stream);

// Block and wait for the event to complete.
aclrtSynchronizeEvent(event);

// Confirm that the status is complete.
aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
// status == ACL_EVENT_RECORDED_STATUS_COMPLETE

aclrtDestroyEvent(event);
```

#### Scenario 4: Querying an Event Created by ExWithFlag Before Its First Record

For an event created by `aclrtCreateEventExWithFlag`, querying before the first `aclrtRecordEvent` call returns `ACL_EVENT_RECORDED_STATUS_COMPLETE` (because no task has been captured in the event).

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);

aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
// Before the first record, status == ACL_EVENT_RECORDED_STATUS_COMPLETE

aclrtRecordEvent(event, stream);
aclrtQueryEventStatus(event, &status);
// After the record while the task is incomplete, status == ACL_EVENT_RECORDED_STATUS_NOT_READY

aclrtSynchronizeStream(stream);
aclrtQueryEventStatus(event, &status);
// After the task completion, status == ACL_EVENT_RECORDED_STATUS_COMPLETE

aclrtDestroyEvent(event);
```

### Constraints

- When `aclrtRecordEvent` and `aclrtQueryEventStatus` are called on different threads, the execution order may be disrupted by multi-threading, causing the found status to be inconsistent with expectations.
- An event created via `aclrtCreateEventExWithFlag` does not support the `aclrtQueryEventWaitStatus` API.

## aclrtCreateStreamWithConfig

### API Declaration

```c
aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

Creates a stream and supports configuring capabilities such as fast task dispatch (**FAST_LAUNCH**) and fast synchronization (**FAST_SYNC**) through flags. Compared with `aclrtCreateStream`, the stream created by this API offers significant performance advantages in task dispatch and synchronization waiting, making it suitable for scenarios that require high throughput or low latency.

### Parameter Description

| Parameter | Description |
|------|------|
| `stream` | Output, which indicates the pointer to the stream. |
| `priority` | Input, which indicates the priority. This is a reserved parameter and cannot be set currently. |
| `flag` | Input, which indicates the stream flag. It supports bitwise OR combination. |

### Flag Description

| Flag | Value | Description | Overhead |
|------|----|------|------|
| `ACL_STREAM_FAST_LAUNCH` | 0x01 | Pre-requests internal resources when creating the stream, enabling faster task dispatch. | Increased stream creation time and memory consumption |
| `ACL_STREAM_FAST_SYNC` | 0x02 | **aclrtSynchronizeStream** proactively polls the task status, enabling faster synchronization return. | Increased CPU performance consumption |
| `ACL_STREAM_PERSISTENT` | 0x04 | Tasks are not executed immediately and are not destroyed upon completion. The flag is used for building model running instances. | Applicable only to model building scenarios |
| `ACL_STREAM_DEVICE_USE_ONLY` | 0x20 | The stream is invoked only on the device | Supported only by some products |

> **Note:** `ACL_STREAM_FAST_LAUNCH` and `ACL_STREAM_FAST_SYNC` support bitwise OR combination. `ACL_STREAM_PERSISTENT` is used for model building scenarios and is not recommended to be combined with **FAST** flags. `ACL_STREAM_DEVICE_USE_ONLY` is supported only by some products and is not recommended for general scenarios.

### Usage Scenarios

#### Scenario 1: High-throughput Training/Inference — FAST_LAUNCH

In training and inference scenarios, a stream is created once and used multiple times, with a large number of operator tasks dispatched each time. **FAST_LAUNCH** pre-requests internal resources when the stream is created, eliminating the resource request overhead for each task dispatch and significantly reducing the task dispatch time. Although the stream creation time increases, the total time is reduced in long-term usage scenarios.

```c
aclrtStream stream;
aclrtCreateStreamWithConfig(&stream, 0, ACL_STREAM_FAST_LAUNCH);

for (int i = 0; i < iterations; i++) {
    aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
    myKernel<<<8, nullptr, stream>>>();
}

aclrtSynchronizeStream(stream);
aclrtDestroyStream(stream);
```

> **Applicable conditions**: A stream is created once and then used multiple times. If the stream has an extremely short lifecycle (created and then destroyed after dispatching only a few tasks), the overhead of pre-requested resources cannot be amortized, and **FAST_LAUNCH** is not recommended.

#### Scenario 2: Low-latency Inference — FAST_SYNC

Inference scenarios are sensitive to the latency of a single inference and require **aclrtSynchronizeStream** to return as soon as possible. In **FAST_SYNC** mode, **SynchronizeStream** does not passively wait for the device notification. Instead, it proactively polls the task completion status and returns immediately after the task is completed, reducing the synchronization wait time.

```c
aclrtStream stream;
aclrtCreateStreamWithConfig(&stream, 0, ACL_STREAM_FAST_SYNC);

aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);

aclrtSynchronizeStream(stream);

aclrtDestroyStream(stream);
```

> **Overhead**: Proactive polling increases CPU usage. In multi-stream concurrent scenarios, pay attention to CPU resource competition. It is recommended to enable **FAST_SYNC** only on latency-sensitive streams.

#### Scenario 3: High Throughput + Low Latency — FAST_LAUNCH | FAST_SYNC

Both fast task dispatch and fast synchronization return are required, such as large-scale inference services. The two flags are combined with bitwise OR to balance dispatch speed and synchronization speed.

```c
aclrtStream stream;
aclrtCreateStreamWithConfig(&stream, 0, ACL_STREAM_FAST_LAUNCH | ACL_STREAM_FAST_SYNC);

for (int i = 0; i < batchCount; i++) {
    aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
    myKernel<<<8, nullptr, stream>>>();
    aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);
    aclrtSynchronizeStream(stream);
}

aclrtDestroyStream(stream);
```

> **Overhead**: Both memory consumption (**FAST_LAUNCH**) and CPU consumption (**FAST_SYNC**) increase. It is recommended for scenarios with sufficient resources.

#### Scenario 4: Priority Scheduling + FAST_LAUNCH

In multi-stream scenarios, tasks on certain streams need to be scheduled and executed with priority. Combine the priority with **FAST_LAUNCH** to create a high-priority stream with fast dispatch.

```c
int leastPriority, greatestPriority;
aclrtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);

aclrtStream streamHigh;
aclrtCreateStreamWithConfig(&streamHigh, greatestPriority, ACL_STREAM_FAST_LAUNCH);

aclrtStream streamLow;
aclrtCreateStreamWithConfig(&streamLow, leastPriority, 0);

// Tasks on a high-priority stream are scheduled with priority.
......

aclrtDestroyStream(streamHigh);
aclrtDestroyStream(streamLow);
```

#### Scenario 5: Simple Scenario — Default Creation (Without the FAST Flag)

For scenarios where the stream has a short lifecycle, few tasks are dispatched, or latency is not a concern, directly use `aclrtCreateStream` or `aclrtCreateStreamWithConfig` without any flag. This avoids the additional memory or CPU overhead.

```c
aclrtStream stream;
aclrtCreateStream(&stream);

aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtSynchronizeStream(stream);

aclrtDestroyStream(stream);
```

### Flag Combination for Selection

| Requirement | flag Parameter | Applicable Scenario |
|------|---------|---------|
| Fast dispatch only | `ACL_STREAM_FAST_LAUNCH` | Training/high-frequency inference |
| Fast synchronization only | `ACL_STREAM_FAST_SYNC` | Low-latency inference |
| Fast dispatch + fast synchronization | `ACL_STREAM_FAST_LAUNCH \| ACL_STREAM_FAST_SYNC` | Large-scale inference service |
| Fast dispatch + priority scheduling | `ACL_STREAM_FAST_LAUNCH` (priority set to high) | Multi-stream priority scheduling |
| No FAST flag | `0` or use `aclrtCreateStream` | Simple scenarios, short-lived streams |
| Model running instance build | `ACL_STREAM_PERSISTENT` | Model building scenarios (used independently) |

### Constraints

- `ACL_STREAM_FAST_LAUNCH` pre-requests internal resources, which increases memory consumption. When there are many streams, pay attention to the total memory usage.
- `ACL_STREAM_FAST_SYNC` proactively polls tasks, which increases CPU usage. In multi-stream concurrent scenarios, pay attention to CPU resource competition.
- The `priority` parameter is currently reserved and cannot be set. The stream priority defaults to the highest.
- Before destroying a stream, call `aclrtSynchronizeStream` to ensure task completion.

## aclrtLaunchHostFunc

### API Declaration

```c
aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)
```

Dispatches a host callback task in the stream task queue. After all preceding tasks on the stream are executed, the system automatically creates a thread to execute the callback function, and the callback task blocks the execution of subsequent tasks on the stream by default. It is easy to use and does not require users to create and manage threads themselves.

### Parameter Description

| Parameter | Description |
|------|------|
| `stream` | Input, which indicates the stream on which the callback task is executed. |
| `fn` | Input, which indicates the callback function, with the prototype `void (*aclrtHostFunc)(void *args)`. |
| `args` | Input, which indicates the user data passed to the callback function. |

### Usage Scenarios

#### Scenario 1: Task Completion Callback

Insert a callback at a specific position on the stream. After the preceding tasks are completed, the host-side logic (such as notification, progress reporting, and data-ready processing) is automatically triggered. The callback blocks the execution of subsequent tasks on this stream until the callback function returns.

```c
typedef struct {
    void *hostBuffer;
    size_t size;
    const char *desc;
} CallbackInfo;

void MyCallback(void *arg) {
    CallbackInfo *info = (CallbackInfo *)arg;
    printf("Task completed: %s\n", info->desc);
    processResult(info->hostBuffer, info->size);
}

aclrtStream stream;
aclrtCreateStream(&stream);

aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);

CallbackInfo info = {hostPtr, hostSize, "kernel compute"};
aclrtLaunchHostFunc(stream, MyCallback, &info);

aclrtSynchronizeStream(stream);
aclrtDestroyStream(stream);
```

> Only host-side logic should be executed in the callback function, such as printing logs, updating status, and triggering host functions that are not part of the Runtime.

#### Scenario 2: Pipeline Stage Coordination

In a multi-stage pipeline, multiple HostFuncs are used to insert callbacks among stages. By leveraging the feature that callbacks block subsequent tasks, ensure strict ordered execution among stages.

```c
void Stage1Done(void *arg) {
    printf("Stage 1 done, starting stage 2.\n");
}

void Stage2Done(void *arg) {
    printf("Stage 2 done, starting stage 3.\n");
}

aclrtStream stream;
aclrtCreateStream(&stream);

aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel1<<<8, nullptr, stream>>>();
aclrtLaunchHostFunc(stream, Stage1Done, nullptr);

myKernel2<<<8, nullptr, stream>>>();
aclrtLaunchHostFunc(stream, Stage2Done, nullptr);

aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);
aclrtSynchronizeStream(stream);

aclrtDestroyStream(stream);
```

### Constraints

- The callback function **must not invoke** Runtime resource request/release, stream synchronization, device synchronization, task dispatch, task termination, or other APIs, as doing so may cause errors or deadlocks.
- The callback function should only execute host-side logic (such as printing logs, updating state variables, and invoking non-Runtime host functions).
- The callback function blocks the execution of subsequent tasks on this stream by default. Subsequent tasks do not start until the callback function returns.
- `aclrtLaunchHostFunc` and `aclrtLaunchCallback` must not be used together on the same stream, as this may cause exceptions.

## aclrtLaunchKernelWithHostArgs

### API Declaration

```c
aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
```

Specifies the configuration for task dispatch and starts the computation task of the corresponding operator. The parameter data is stored in host memory and is automatically processed by Runtime at launch. The placeholder mechanism is supported, which merges the H2D copies of small data blocks into a single launch operation, reducing the number of copies and improving performance. This is an asynchronous API.

### Parameter Description

| Parameter | Description |
|------|------|
| `funcHandle` | Input, which indicates the kernel function handle. It is obtained using `aclrtBinaryGetFunction`. |
| `numBlocks` | Input, which indicates the number of cores on which the kernel function is executed. |
| `stream` | Input, which indicates the stream on which the task is executed. |
| `cfg` | Input, which indicates the task dispatch configuration. Pass **NULL** if not specified. |
| `hostArgs` | Input, which indicates the host memory address pointer that stores all input parameter data of the kernel function. |
| `argsSize` | Input, which indicates the size of the **hostArgs** parameter value (in bytes). |
| `placeHolderArray` | Input, which indicates the placeholder parameter array. Pass **NULL** if no placeholder is used. |
| `placeHolderNum` | Input, which indicates the number of placeholder parameters. Pass **0** if no placeholder is used. |

### API Comparison

| API | Parameter Storage Location | cfg Support | placeholder Support | Applicable Scenario |
|------|------------|------------|-------------------|---------|
| `aclrtLaunchKernel` | Device memory | No | No | Parameters are already on the device side and no configuration is required. |
| `aclrtLaunchKernelV2` | Device memory | Yes | No | Parameters are already on the device side and configuration is required. |
| `aclrtLaunchKernelWithConfig` | argsHandle parameter list | Yes | Yes | Fine-grained control over parameter layout and parameter update are required |
| **`aclrtLaunchKernelWithHostArgs`** | **Host memory** | **Yes** | **Yes** | **Parameters are organized contiguously on the host side. This API is the most general-purpose.** |
| `aclrtLaunchKernelWithArgsArray` | Host memory (parameter array) | Yes | No | Each parameter has an independent pointer |

> **Recommended reason**: `aclrtLaunchKernelWithHostArgs` is the most general-purpose LaunchKernel API. Parameters are organized contiguously on the host side (the most natural programming approach), the cfg configuration and the placeholder mechanism are supported, the code is concise, and there is no need to assemble parameters step by step using **argsHandle**.

### Usage Scenarios

#### Scenario 1: Basic Usage — Contiguous Parameters on the Host Side

All kernel function input parameters are device pointers (input/output buffers), and the parameters are organized contiguously on the host side as a structure or array and passed directly. This is the most common usage.

```c
aclrtBinHandle bin = nullptr;
aclrtBinaryLoadFromFile("add_custom.o", nullptr, &bin);

aclrtFuncHandle func = nullptr;
aclrtBinaryGetFunction(bin, "add_custom", &func);

aclrtMalloc(&dX, size, ACL_MEM_MALLOC_HUGE_FIRST);
aclrtMalloc(&dY, size, ACL_MEM_MALLOC_HUGE_FIRST);
aclrtMalloc(&dZ, size, ACL_MEM_MALLOC_HUGE_FIRST);

aclrtMemcpy(dX, size, hX, size, ACL_MEMCPY_HOST_TO_DEVICE);
aclrtMemcpy(dY, size, hY, size, ACL_MEMCPY_HOST_TO_DEVICE);

void *args[] = {dX, dY, dZ};
size_t argsSize = sizeof(args);

aclrtLaunchKernelWithHostArgs(func, 8, stream, nullptr, args, argsSize, nullptr, 0);
aclrtSynchronizeStream(stream);

aclrtMemcpy(hZ, size, dZ, size, ACL_MEMCPY_DEVICE_TO_HOST);
aclrtBinaryUnLoad(bin);
```

#### Scenario 2: Placeholder Mechanism — Merging Small Data Block Copies

In addition to device pointers (input/output buffers), the kernel function parameters also include small blocks of configuration data (such as scalar parameters and shape information, recommended to be less than 2 KB). Through the placeholder mechanism, this data is automatically copied from the host to the device by the Runtime at launch, eliminating the need for users to call `aclrtMemcpy` separately and reducing the number of copy operations.

```c
// Kernel function parameters: dX (input buffer), dY (output buffer), len (scalar, to be copied to the device)
struct ArgsData {
    void *x;      // Device pointer, non-placeholder
    void *y;      // Device pointer, non-placeholder
    uint32_t len; // Small data block, placeholder
};

// The placeholder parameter (len) immediately follows all non-placeholder parameters.
// addrOffset = Position offset in hostArgs where the real device address of the placeholder is to be refreshed
// dataOffset = Address offset of the placeholder data area relative to hostArgs
aclrtPlaceHolderInfo placeholders[] = {
    {8, 16}  // The device address of len is refreshed to ArgsData.len (offset 8), and the len data is at offset 16
};

ArgsData args = {dX, dY, 256};
aclrtLaunchKernelWithHostArgs(func, 8, stream, nullptr, &args, sizeof(args), placeholders, 1);
aclrtSynchronizeStream(stream);

aclrtBinaryUnLoad(bin);
```

> **Placeholder principles**: During launch, Runtime first copies **hostArgs** as a whole to the device, then copies the placeholder data area to the corresponding location on the device based on **placeHolderInfo**, and refreshes the pointer fields in **hostArgs** to the actual device addresses. In this way, the H2D copy of small data blocks is merged into a single launch operation.

#### Scenario 3: cfg Configuration — Scheduling Mode and Timeout

When you need to specify the scheduling mode (batch or normal scheduling) or the task timeout, configure it via the **cfg** parameter.

```c
// Configure the batch scheduling mode: the task starts only when all cores are idle.
aclrtLaunchKernelAttr attrs[] = {
    {ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE, {.schemMode = 1}}
};
aclrtLaunchKernelCfg cfg = {attrs, 1};

void *args[] = {dX, dY, dZ};
size_t argsSize = sizeof(args);

aclrtLaunchKernelWithHostArgs(func, 8, stream, &cfg, args, argsSize, nullptr, 0);
aclrtSynchronizeStream(stream);
```

### API Selection

| Requirement | Recommended API | Description |
|------|---------|------|
| Parameters on the host side, which is most general | `aclrtLaunchKernelWithHostArgs` | Organize parameters contiguously on the host side, with placeholder support. |
| Parameters on the host side, containing small data blocks that need automatic copying | `aclrtLaunchKernelWithHostArgs` + placeholder | Reduces the number of H2D copy operations. |
| Parameters on the host side, requiring scheduling configuration | `aclrtLaunchKernelWithHostArgs` + cfg | Supports scheduling mode, timeout, and other configurations. |
| Parameters already organized contiguously on the device side | `aclrtLaunchKernelV2` | Avoid repeated copying at launch. |
| Fine-grained control over parameter layout and multiple parameter updates required | `aclrtLaunchKernelWithConfig` | Assemble parameters step by step using **argsHandle**. |

### Constraints

- Before using this API, call `aclrtBinaryLoadFromFile` to load the operator binary, and then call `aclrtBinaryGetFunction` to obtain the kernel function handle.
- It is recommended that placeholder data be smaller than 2 KB. Larger data should be copied to the device separately via `aclrtMemcpy`.
- The data area of placeholder parameters in **hostArgs** must be placed after all non-placeholder parameters.
- `aclrtPlaceHolderInfo.addrOffset` specifies the position offset in **hostArgs** where the actual device address of the placeholder needs to be refreshed, and `dataOffset` specifies the address offset of the placeholder data area based on **hostArgs**.
- After use, call `aclrtBinaryUnLoad` to unload the operator binary.

## aclrtHostRegisterV2

### API Declaration

```c
aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
```

Registers a host memory address. It supports registering pageable memory requested by functions such as **malloc** as page-locked memory (**PINNED**) and mapping it to a memory address accessible by the device (**MAPPED**). Compared with `aclrtHostRegister`, this API supports the **PINNED** flag, allowing ordinary host memory to be directly registered as page-locked memory without calling `aclrtMallocHost` in advance to request page-locked memory.

### Parameter Description

| Parameter | Description |
|------|------|
| `ptr` | Input, which indicates the host memory address. It must be 4 KB page-aligned. |
| `size` | Input, which indicates the memory size in bytes. |
| `flag` | Input, which indicates the registration type, supporting bitwise OR combination. |

### API Comparison

| Comparison Item | `aclrtHostRegister` | `aclrtHostRegisterV2` |
|------|---------------------|----------------------|
| Page lock capability | None; can only process existing page-locked memory | Supports `ACL_HOST_REG_PINNED`, which can register memory requested by **malloc** as the page-locked memory. |
| Flag combination | Single enum value (**Mapped**/**IOmemory**/**ReadOnly**) | Supports bitwise OR combination (`PINNED \| MAPPED`, etc.) |
| Device address obtaining | Directly outputs **devPtr** within the API | Requires an additional call to `aclrtHostGetDevicePointer` (two-step operation, more flexible) |
| Programming guide recommendation | Mentioned only in VA consistency scenarios | **Explicitly recommended by the programming guide for page lock + mapping scenarios** |

> **Recommended reason**: `ACL_HOST_REG_PINNED` of `aclrtHostRegisterV2` is the core advantage. Users can directly request memory with **malloc** and then register it as page-locked memory, without using `aclrtMallocHost`, making it the most natural and universal approach.

### Flag Description

| Flag | Value | Description |
|------|----|------|
| `ACL_HOST_REG_PINNED` | 0x10000000 | Registers non-page-locked host memory as page-locked memory (for example, memory requested by **malloc**). |
| `ACL_HOST_REG_MAPPED` | 0x02 | Registers host memory mapping as a memory address accessible to the device. |
| `ACL_HOST_REG_IOMEMORY` | 0x04 | Registers the I/O space mapping of a third-party PCIe device as accessible to the device (reserved, not supported currently). |
| `ACL_HOST_REG_READONLY` | 0x08 | Registers the host memory mapping as read-only for the device. |

> **Note:** `ACL_HOST_REG_PINNED`, `ACL_HOST_REG_MAPPED`, and `ACL_HOST_REG_READONLY` support bitwise OR combination, but `ACL_HOST_REG_IOMEMORY` does not support currently.

### Usage Scenarios

#### Scenario 1: Registering the Memory Requested by malloc as Page-Locked Memory and Mapping It to the Device

The most common usage is as follows: use **malloc** to request ordinary pageable memory, and register it as page-locked memory and map it to the device in one step via `ACL_HOST_REG_PINNED | ACL_HOST_REG_MAPPED`, so that the device can access it directly. There is no need to use `aclrtMallocHost`.

```c
void *hostPtr = malloc(size);

aclrtHostRegisterV2(hostPtr, size, ACL_HOST_REG_PINNED | ACL_HOST_REG_MAPPED);

void *devicePtr = nullptr;
aclrtHostGetDevicePointer(hostPtr, &devicePtr, 0);

myKernel<<<8, nullptr, stream>>>(devicePtr);
aclrtSynchronizeStream(stream);

aclrtHostUnregister(hostPtr);
free(hostPtr);
```

> **Constraint**: When the OS kernel version is 5.10 or earlier, **PINNED** causes an exception. In this case, use `aclrtMallocHost` to request page-locked memory instead.

#### Scenario 2: Registering Page-Locked Memory Only (Without Mapping)

This is used when you only need to improve the data copy performance from the host to device (page-locked memory avoids the page locking overhead during DMA copy), but do not need the device to directly access the address via mapping. Using `ACL_HOST_REG_PINNED` alone is sufficient.

```c
void *hostPtr = malloc(size);

aclrtHostRegisterV2(hostPtr, size, ACL_HOST_REG_PINNED);

aclrtMemcpy(devPtr, size, hostPtr, size, ACL_MEMCPY_HOST_TO_DEVICE);
myKernel<<<8, nullptr, stream>>>(devPtr);
aclrtMemcpy(hostPtr, size, devPtr, size, ACL_MEMCPY_DEVICE_TO_HOST);
aclrtSynchronizeStream(stream);

aclrtHostUnregister(hostPtr);
free(hostPtr);
```

#### Scenario 3: Mapping the I/O Space of a Third-Party PCIe Device

You need to map and register the registers or cache of a third-party PCIe device on the host as accessible to the device, so that the device can read and write them directly. In this case, use `ACL_HOST_REG_IOMEMORY | ACL_HOST_REG_MAPPED`.

```c
void *ioPtr = ...;

aclrtHostRegisterV2(ioPtr, ioSize, ACL_HOST_REG_IOMEMORY | ACL_HOST_REG_MAPPED);

void *devicePtr = nullptr;
aclrtHostGetDevicePointer(ioPtr, &devicePtr, 0);

// Read and write the register of the third-party device directly via devicePtr on the device.
......

aclrtHostUnregister(ioPtr);
```

### Flag Combination for Selection

| Requirement | flag Parameter | Applicable Scenario |
|------|---------|---------|
| Page-locked memory + mapping to the device | `ACL_HOST_REG_PINNED \| ACL_HOST_REG_MAPPED` | The memory requested by **malloc** is directly accessed by the device (most common) |
| Page-locked memory only | `ACL_HOST_REG_PINNED` | Improves H2D/D2H copy performance. |
| Mapping only (existing page-locked memory) | `ACL_HOST_REG_MAPPED` | Maps the memory requested by **aclrtMallocHost** to the device. |
| Mapping as read-only | `ACL_HOST_REG_READONLY` or `ACL_HOST_REG_READONLY \| ACL_HOST_REG_MAPPED` | Host memory is read-only for the device. |
| PCIe I/O space mapping | `ACL_HOST_REG_IOMEMORY \| ACL_HOST_REG_MAPPED` | Third-party device register mapping |

### Constraints

- The host memory address must be 4K page-aligned. You can request aligned memory via `posix_memalign` or `aligned_alloc`.
- When the OS kernel version is 5.10 or earlier, using `ACL_HOST_REG_PINNED` to register non-page-locked memory causes an exception. In this case, use `aclrtMallocHost` to request page-locked memory instead.
- The mapped device memory address cannot be used for memory operations (such as `aclrtMemcpy`). It is only for direct access by device-side operators. If memory copy is required, still use `aclrtMemcpy`.
- Registration and unregistration must be used in pairs: `aclrtHostRegisterV2` and `aclrtHostUnregister`.
- `ACL_HOST_REG_IOMEMORY` is currently a reserved option and is not supported.
