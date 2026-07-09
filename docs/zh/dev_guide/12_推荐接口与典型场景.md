# 推荐接口与典型场景

本章节介绍 Runtime 推荐使用的接口及其典型使用场景，帮助开发者快速选择合适的接口完成常见编程任务。

## aclrtCreateEventExWithFlag

### 接口声明

```c
aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
```

创建带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。

### 参数说明

| 参数 | 说明 |
|------|------|
| `event` | 输出，Event的指针 |
| `flag` | 输入，Event的flag，支持位或组合 |

### Flag说明

| Flag | 值 | 功能 |
|------|----|------|
| `ACL_EVENT_SYNC` | 0x01 | 支持多Stream间任务同步（aclrtStreamWaitEvent） |
| `ACL_EVENT_CAPTURE_STREAM_PROGRESS` | 0x02 | 跟踪Stream任务执行进度 |
| `ACL_EVENT_TIME_LINE` | 0x08 | 记录时间戳，支持aclrtEventElapsedTime计时 |
| `ACL_EVENT_IPC` | 0x40 | 进程间通信，支持aclrtIpcGetEventHandle |

> **注意**：`ACL_EVENT_IPC` 不支持与其他flag进行位或操作，需单独使用。`ACL_EVENT_TIME_LINE` 会影响Event相关接口性能，仅在对计时有明确需求时启用。

### 使用场景

#### 场景 1：多Stream间任务同步

多个Stream之间存在依赖关系，stream2需要等stream1完成后再执行。支持"多等一"场景，多个Stream同时等待同一个Event。

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);

// stream1 下发计算任务后 Record Event
aclrtRecordEvent(event, stream1);

// stream2、stream3 等待 stream1 的Event完成
aclrtStreamWaitEvent(stream2, event);
aclrtStreamWaitEvent(stream3, event);

aclrtSynchronizeStream(stream2);
aclrtSynchronizeStream(stream3);
aclrtDestroyEvent(event);
```

#### 场景 2：Event计时（性能测量）

统计某段任务在设备侧的执行耗时。

```c
aclrtEvent startEvent, endEvent;
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_TIME_LINE);
aclrtCreateEventExWithFlag(&endEvent,   ACL_EVENT_TIME_LINE);

aclrtRecordEvent(startEvent, stream);
// ... 下发计算任务 ...
aclrtRecordEvent(endEvent, stream);

aclrtSynchronizeStream(stream);

float ms = 0.0f;
aclrtEventElapsedTime(&ms, startEvent, endEvent);
printf("Task elapsed time: %.3f ms\n", ms);

aclrtDestroyEvent(startEvent);
aclrtDestroyEvent(endEvent);
```

#### 场景 3：IPC跨进程Event同步

两个进程共享同一个Device，进程A在stream上完成计算后，进程B需要等待再继续。支持同一个Device内多进程及跨Device多进程场景。

```c
// 进程A：创建IPC Event并导出
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_IPC);
aclrtRecordEvent(event, streamA);

aclrtIpcEventHandle handle;
aclrtIpcGetEventHandle(event, &handle);  // 导出handle，传递给进程B

// 进程B：导入IPC Event并等待
aclrtEvent eventB;
aclrtIpcOpenEventHandle(handle, &eventB);
aclrtStreamWaitEvent(streamB, eventB);

aclrtDestroyEvent(event);   // 进程A
aclrtDestroyEvent(eventB);  // 进程B
```

#### 场景 4：Stream执行进度跟踪

非阻塞地查询Stream上任务的完成状态。

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);

aclrtRecordEvent(event, stream);

aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
// ACL_EVENT_RECORDED_STATUS_COMPLETE    → 任务已完成
// ACL_EVENT_RECORDED_STATUS_NOT_COMPLETE → 任务未完成

aclrtDestroyEvent(event);
```

#### 场景 5：同步 + 计时组合

既需要多Stream同步，又需要计时。

```c
aclrtEvent startEvent, endEvent;
aclrtCreateEventExWithFlag(&startEvent, ACL_EVENT_SYNC | ACL_EVENT_TIME_LINE);
aclrtCreateEventExWithFlag(&endEvent,   ACL_EVENT_SYNC | ACL_EVENT_TIME_LINE);

aclrtRecordEvent(startEvent, stream1);
// ... stream1 下发计算任务 ...
aclrtRecordEvent(endEvent, stream1);

aclrtStreamWaitEvent(stream2, endEvent);  // stream2同步等待stream1完成
aclrtSynchronizeStream(stream1);

float ms = 0.0f;
aclrtEventElapsedTime(&ms, startEvent, endEvent);

aclrtDestroyEvent(startEvent);
aclrtDestroyEvent(endEvent);
```

#### 场景 6：纯同步场景（最简用法）

只需要Stream间同步功能时，传入 `ACL_EVENT_SYNC` 即可。

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);

aclrtRecordEvent(event, stream);
aclrtSynchronizeEvent(event);

aclrtDestroyEvent(event);
```

### Flag组合选择

| 需求 | flag参数 | 适用场景 |
|------|---------|---------|
| 仅多Stream同步 | `ACL_EVENT_SYNC` | 多Stream间依赖 |
| 仅计时 | `ACL_EVENT_TIME_LINE` | 性能测量 |
| 同步 + 计时 | `ACL_EVENT_SYNC | ACL_EVENT_TIME_LINE` | 同步并计时 |
| 同步 + 进度跟踪 | `ACL_EVENT_SYNC | ACL_EVENT_CAPTURE_STREAM_PROGRESS` | 同步并查询进度 |
| 跨进程同步 | `ACL_EVENT_IPC`（单独使用，不可组合） | IPC跨进程同步 |
| 仅进度跟踪 | `ACL_EVENT_CAPTURE_STREAM_PROGRESS` | 非阻塞状态查询 |

### 约束说明

- `ACL_EVENT_IPC` 不支持与其他flag进行位或操作，需单独使用。
- `ACL_EVENT_TIME_LINE` 会影响Event相关接口性能，仅在对计时有明确需求时启用。
- `ACL_EVENT_IPC` 创建的Event不支持 `aclrtEventElapsedTime`、`aclrtEventGetTimestamp`、`aclrtGetEventId`、模型捕获场景。

## aclrtQueryEventStatus

### 接口声明

```c
aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
```

查询该Event捕获的所有任务的执行状态。非阻塞接口，不会等待任务完成，立即返回当前状态。

### 参数说明

| 参数 | 说明 |
|------|------|
| `event` | 输入，待查询的Event |
| `status` | 输出，Event的执行状态 |

### 状态说明

| 状态值 | 含义 |
|--------|------|
| `ACL_EVENT_RECORDED_STATUS_COMPLETE` | Event捕获的所有任务都已执行完成 |
| `ACL_EVENT_RECORDED_STATUS_NOT_READY` | Event捕获的任务中有尚未执行完成的 |

### 使用场景

#### 场景 1：内存池复用管理

在多线程场景中，A线程下发算子任务并Record Event，B线程通过查询Event状态判断算子是否完成，完成后安全复用算子占用的内存。

```c
// A线程：下发任务并Record Event
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);
aclrtRecordEvent(event, stream);

// B线程：查询Event状态，判断内存是否可以复用
aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // 任务已完成，内存可安全复用
} else {
    // 任务未完成，内存不可复用
}
```

#### 场景 2：轮询等待任务完成

不希望阻塞主机线程，而是通过轮询方式检查任务完成情况，期间主机可做其他工作。

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);
aclrtRecordEvent(event, stream);

aclrtEventRecordedStatus status = ACL_EVENT_RECORDED_STATUS_NOT_READY;
while (status != ACL_EVENT_RECORDED_STATUS_COMPLETE) {
    // 主机可在此处执行其他工作
    aclrtQueryEventStatus(event, &status);
}

// 任务完成，继续后续处理
aclrtDestroyEvent(event);
```

#### 场景 3：与aclrtSynchronizeEvent配合使用

先通过aclrtSynchronizeEvent阻塞等待Event完成，再用aclrtQueryEventStatus确认状态。

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);
aclrtRecordEvent(event, stream);

// 阻塞等待Event完成
aclrtSynchronizeEvent(event);

// 确认状态为完成
aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
// status == ACL_EVENT_RECORDED_STATUS_COMPLETE

aclrtDestroyEvent(event);
```

#### 场景 4：ExWithFlag创建的Event首次Record前查询

使用 `aclrtCreateEventExWithFlag` 创建的Event，在首次调用 `aclrtRecordEvent` 前查询，状态为 `ACL_EVENT_RECORDED_STATUS_COMPLETE`（因为Event中没有捕获任何任务）。

```c
aclrtEvent event;
aclrtCreateEventExWithFlag(&event, ACL_EVENT_CAPTURE_STREAM_PROGRESS);

aclrtEventRecordedStatus status;
aclrtQueryEventStatus(event, &status);
// 首次Record前，status == ACL_EVENT_RECORDED_STATUS_COMPLETE

aclrtRecordEvent(event, stream);
aclrtQueryEventStatus(event, &status);
// Record后任务未完成时，status == ACL_EVENT_RECORDED_STATUS_NOT_READY

aclrtSynchronizeStream(stream);
aclrtQueryEventStatus(event, &status);
// 任务完成后，status == ACL_EVENT_RECORDED_STATUS_COMPLETE

aclrtDestroyEvent(event);
```

### 约束说明

- 在不同线程上分别调用 `aclrtRecordEvent` 和 `aclrtQueryEventStatus` 时，可能因多线程导致执行时间乱序，查询到的状态不符合预期。
- 通过 `aclrtCreateEventExWithFlag` 创建的Event，不支持调用 `aclrtQueryEventWaitStatus` 接口。

## aclrtCreateStreamWithConfig

### 接口声明

```c
aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

创建Stream，支持通过flag配置快速下发任务（FAST_LAUNCH）、快速同步（FAST_SYNC）等能力。相比 `aclrtCreateStream`，本接口创建的Stream在任务下发和同步等待环节有显著的性能优势，适用于对吞吐或延迟有要求的场景。

### 参数说明

| 参数 | 说明 |
|------|------|
| `stream` | 输出，Stream的指针 |
| `priority` | 输入，优先级，预留参数暂不支持设置 |
| `flag` | 输入，Stream的flag，支持位或组合 |

### Flag说明

| Flag | 值 | 功能 | 代价 |
|------|----|------|------|
| `ACL_STREAM_FAST_LAUNCH` | 0x01 | 创建Stream时预申请内部资源，下发任务更快 | 创建Stream时长增加、内存消耗增加 |
| `ACL_STREAM_FAST_SYNC` | 0x02 | aclrtSynchronizeStream主动轮询任务状态，同步返回更快 | CPU性能消耗增加 |
| `ACL_STREAM_PERSISTENT` | 0x04 | 任务不立即执行、完成后不销毁，用于模型运行实例构建 | 仅适用于模型构建场景 |
| `ACL_STREAM_DEVICE_USE_ONLY` | 0x20 | Stream仅在Device上调用 | 仅部分产品支持 |

> **注意**：`ACL_STREAM_FAST_LAUNCH` 和 `ACL_STREAM_FAST_SYNC` 支持位或组合使用。`ACL_STREAM_PERSISTENT` 用于模型构建场景，不推荐与FAST标记组合。`ACL_STREAM_DEVICE_USE_ONLY` 仅部分产品支持，不建议通用场景使用。

### 使用场景

#### 场景 1：高吞吐训练/推理 — FAST_LAUNCH

训练和推理场景中，Stream创建一次、使用多次，每次下发大量算子任务。FAST_LAUNCH在创建Stream时预申请内部资源，省去每次下发任务时的资源申请开销，显著缩短任务下发耗时。创建Stream时长虽有增加，但在长期使用的场景下总时长缩短。

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

> **适用条件**：Stream创建一次后多次使用。若Stream生命周期极短（创建后仅下发少量任务即销毁），预申请资源的开销无法被摊薄，不建议使用FAST_LAUNCH。

#### 场景 2：低延迟推理 — FAST_SYNC

推理场景对单次推理延迟敏感，需要aclrtSynchronizeStream尽快返回。FAST_SYNC模式下，SynchronizeStream不被动等待Device通知，而是主动轮询任务完成状态，任务完成后立即返回，减少同步等待时长。

```c
aclrtStream stream;
aclrtCreateStreamWithConfig(&stream, 0, ACL_STREAM_FAST_SYNC);

aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtMemcpyAsync(hostPtr, hostSize, devPtr, devSize, ACL_MEMCPY_DEVICE_TO_HOST, stream);

aclrtSynchronizeStream(stream);

aclrtDestroyStream(stream);
```

> **代价**：主动轮询会增加CPU占用。在多Stream并发场景下需注意CPU资源竞争，建议仅在延迟敏感的Stream上启用FAST_SYNC。

#### 场景 3：高吞吐 + 低延迟 — FAST_LAUNCH | FAST_SYNC

同时需要快速下发任务和快速同步返回的场景，如大规模推理服务。两个flag位或组合使用，兼顾下发速度和同步速度。

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

> **代价**：同时增加内存消耗（FAST_LAUNCH）和CPU消耗（FAST_SYNC），建议在资源充裕的场景下使用。

#### 场景 4：优先级调度 + FAST_LAUNCH

多Stream场景中，需要某些Stream的任务优先调度执行。结合优先级和FAST_LAUNCH，创建高优先级快速下发的Stream。

```c
int leastPriority, greatestPriority;
aclrtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);

aclrtStream streamHigh;
aclrtCreateStreamWithConfig(&streamHigh, greatestPriority, ACL_STREAM_FAST_LAUNCH);

aclrtStream streamLow;
aclrtCreateStreamWithConfig(&streamLow, leastPriority, 0);

// 高优先级Stream上的任务会被优先调度
......

aclrtDestroyStream(streamHigh);
aclrtDestroyStream(streamLow);
```

#### 场景 5：简单场景 — 默认创建（不加FAST标记）

对于Stream生命周期短、下发任务数量少、或对延迟不敏感的场景，直接使用 `aclrtCreateStream` 或 `aclrtCreateStreamWithConfig` 不加flag即可，无需承担额外的内存或CPU开销。

```c
aclrtStream stream;
aclrtCreateStream(&stream);

aclrtMemcpyAsync(devPtr, devSize, hostPtr, hostSize, ACL_MEMCPY_HOST_TO_DEVICE, stream);
myKernel<<<8, nullptr, stream>>>();
aclrtSynchronizeStream(stream);

aclrtDestroyStream(stream);
```

### Flag组合选择

| 需求 | flag参数 | 适用场景 |
|------|---------|---------|
| 仅快速下发 | `ACL_STREAM_FAST_LAUNCH` | 训练/高频推理 |
| 仅快速同步 | `ACL_STREAM_FAST_SYNC` | 低延迟推理 |
| 快速下发 + 快速同步 | `ACL_STREAM_FAST_LAUNCH \| ACL_STREAM_FAST_SYNC` | 大规模推理服务 |
| 快速下发 + 优先级调度 | `ACL_STREAM_FAST_LAUNCH`（priority设为高优先级） | 多Stream优先级调度 |
| 不加FAST标记 | `0` 或使用 `aclrtCreateStream` | 简单场景、短生命周期Stream |
| 模型运行实例构建 | `ACL_STREAM_PERSISTENT` | 模型构建场景（独立使用） |

### 约束说明

- `ACL_STREAM_FAST_LAUNCH` 预申请内部资源会增加内存消耗，Stream数量较多时需关注总内存占用。
- `ACL_STREAM_FAST_SYNC` 主动轮询会增加CPU占用，多Stream并发场景下需注意CPU资源竞争。
- `priority` 参数当前为预留参数，暂不支持设置；Stream优先级默认为最高。
- 销毁Stream前需调用 `aclrtSynchronizeStream` 确保任务完成。

## aclrtLaunchHostFunc

### 接口声明

```c
aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)
```

在Stream的任务队列中下发一个Host回调任务。当Stream上所有前序任务执行完成后，系统内部自动创建线程执行回调函数，并且回调任务默认阻塞本Stream上后续任务的执行。使用简单，无需用户自行创建和管理线程。

### 参数说明

| 参数 | 说明 |
|------|------|
| `stream` | 输入，指定执行回调任务的Stream |
| `fn` | 输入，回调函数，原型为 `void (*aclrtHostFunc)(void *args)` |
| `args` | 输入，传递给回调函数的用户数据 |

### 使用场景

#### 场景 1：任务完成回调

在Stream上某个位置插入回调，当前序任务完成后自动触发主机侧逻辑（如通知、进度报告、数据就绪处理等）。回调阻塞本Stream上后续任务的执行，直到回调函数返回。

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

> 回调函数中只应执行纯主机侧逻辑，如打印日志、更新状态、触发非Runtime的主机函数。

#### 场景 2：流水线阶段协调

多阶段流水线中，通过多个HostFunc在各阶段间插入回调，利用回调阻塞后续任务的特性，确保阶段间严格有序执行。

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

### 约束说明

- 回调函数中**不可调用**Runtime资源申请/释放、Stream同步、Device同步、任务下发、任务终止等接口，否则可能导致错误或死锁。
- 回调函数中只应执行纯主机侧逻辑（如打印日志、更新状态变量、调用非Runtime的主机函数）。
- 回调函数默认阻塞本Stream上后续任务的执行，直到回调函数返回后后续任务才开始。
- `aclrtLaunchHostFunc` 与 `aclrtLaunchCallback` 不能在同一个Stream上混用，否则可能出现异常。

## aclrtLaunchKernelWithHostArgs

### 接口声明

```c
aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
```

指定任务下发的配置信息，并启动对应算子的计算任务。参数数据存放在Host内存中，由Runtime在Launch时自动处理。支持placeholder机制，将小块数据的 H2D 拷贝合并到一次 Launch 操作中，减少拷贝次数，提升性能。异步接口。

### 参数说明

| 参数 | 说明 |
|------|------|
| `funcHandle` | 输入，核函数句柄，通过 `aclrtBinaryGetFunction` 获取 |
| `numBlocks` | 输入，核函数在几个核上执行 |
| `stream` | 输入，执行任务的Stream |
| `cfg` | 输入，任务下发配置，不指定时传NULL |
| `hostArgs` | 输入，存放核函数所有入参数据的Host内存地址指针 |
| `argsSize` | 输入，hostArgs参数值的大小（Byte） |
| `placeHolderArray` | 输入，placeholder参数数组，无placeholder时传NULL |
| `placeHolderNum` | 输入，placeholder参数数量，无placeholder时传0 |

### 接口对比

| 接口 | 参数存放位置 | 是否支持cfg | 是否支持placeholder | 适用场景 |
|------|------------|------------|-------------------|---------|
| `aclrtLaunchKernel` | Device内存 | 否 | 否 | 参数已在Device侧，不需要配置 |
| `aclrtLaunchKernelV2` | Device内存 | 是 | 否 | 参数已在Device侧，需要配置 |
| `aclrtLaunchKernelWithConfig` | argsHandle参数列表 | 是 | 是 | 需精细控制参数布局、更新参数 |
| **`aclrtLaunchKernelWithHostArgs`** | **Host内存** | **是** | **是** | **参数在Host侧连续组织，最通用** |
| `aclrtLaunchKernelWithArgsArray` | Host内存（参数数组） | 是 | 否 | 每个参数独立指针 |

> **推荐理由**：`aclrtLaunchKernelWithHostArgs` 是最通用的 LaunchKernel 接口。参数在Host侧连续组织（最自然的编程方式），支持cfg配置和placeholder机制，代码简洁，无需使用 argsHandle 一步步组装参数。

### 使用场景

#### 场景 1：基本用法 — Host侧连续参数

核函数入参全部为Device指针（输入/输出buffer），参数在Host侧连续组织为结构体或数组，直接传入即可。这是最常见的用法。

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

#### 场景 2：placeholder机制 — 合并小块数据拷贝

核函数入参中除了Device指针（输入/输出buffer）外，还有小块配置数据（如标量参数、shape信息等，建议<2KB）。这些数据通过placeholder机制，在Launch时由Runtime自动从Host拷贝到Device，无需用户单独调用 `aclrtMemcpy`，减少拷贝次数。

```c
// 核函数入参：dX（输入buffer），dY（输出buffer），len（标量，需拷贝到Device）
struct ArgsData {
    void *x;      // Device指针，非placeholder
    void *y;      // Device指针，非placeholder
    uint32_t len; // 小块数据，placeholder
};

// placeholder参数（len）紧跟在所有非placeholder参数之后
// addrOffset = placeholder真实Device地址需刷新到hostArgs中的位置偏移
// dataOffset = placeholder数据区基于hostArgs的地址偏移
aclrtPlaceHolderInfo placeholders[] = {
    {8, 16}  // len的Device地址刷新到ArgsData.len（偏移8），len数据在偏移16处
};

ArgsData args = {dX, dY, 256};
aclrtLaunchKernelWithHostArgs(func, 8, stream, nullptr, &args, sizeof(args), placeholders, 1);
aclrtSynchronizeStream(stream);

aclrtBinaryUnLoad(bin);
```

> **placeholder原理**：Launch时，Runtime先将hostArgs整体拷贝到Device，然后根据placeHolderInfo将placeholder数据区拷贝到Device侧对应位置，并刷新hostArgs中指针字段为真实的Device地址。这样小块数据的 H2D 拷贝被合并到一次Launch操作中。

#### 场景 3：带cfg配置 — 调度模式与超时

需要指定调度模式（batch调度、普通调度）或任务超时时间时，通过cfg参数配置。

```c
// 配置batch调度模式：必须所有核空闲才启动
aclrtLaunchKernelAttr attrs[] = {
    {ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE, {.schemMode = 1}}
};
aclrtLaunchKernelCfg cfg = {attrs, 1};

void *args[] = {dX, dY, dZ};
size_t argsSize = sizeof(args);

aclrtLaunchKernelWithHostArgs(func, 8, stream, &cfg, args, argsSize, nullptr, 0);
aclrtSynchronizeStream(stream);
```

### 接口选择

| 需求 | 推荐接口 | 说明 |
|------|---------|------|
| 参数在Host侧，最通用 | `aclrtLaunchKernelWithHostArgs` | Host侧连续组织参数，支持placeholder |
| 参数在Host侧，含小块数据需自动拷贝 | `aclrtLaunchKernelWithHostArgs` + placeholder | 减少H2D拷贝次数 |
| 参数在Host侧，需要调度配置 | `aclrtLaunchKernelWithHostArgs` + cfg | 支持调度模式、超时等配置 |
| 参数已在Device侧连续组织 | `aclrtLaunchKernelV2` | 避免Launch时重复拷贝 |
| 需要精细控制参数布局、多次更新参数 | `aclrtLaunchKernelWithConfig` | 使用argsHandle逐步组装 |

### 约束说明

- 使用本接口前需先调用 `aclrtBinaryLoadFromFile` 加载算子二进制，再调用 `aclrtBinaryGetFunction` 获取核函数句柄。
- placeholder数据建议小于2KB，过大的数据应通过 `aclrtMemcpy` 单独拷贝到Device。
- placeholder参数在hostArgs中的数据区必须放在所有非placeholder参数之后。
- `aclrtPlaceHolderInfo.addrOffset` 指定placeholder真实Device地址需刷新到hostArgs中的位置偏移，`dataOffset` 指定placeholder数据区基于hostArgs的地址偏移。
- 使用结束后需调用 `aclrtBinaryUnLoad` 卸载算子二进制。

## aclrtHostRegisterV2

### 接口声明

```c
aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
```

注册Host内存地址。支持将malloc等申请的Pageable内存注册为锁页内存（PINNED），并映射为Device可访问的内存地址（MAPPED）。相比 `aclrtHostRegister`，本接口支持 PINNED flag，可将普通Host内存直接注册为锁页内存，无需提前调用 `aclrtMallocHost` 申请锁页内存。

### 参数说明

| 参数 | 说明 |
|------|------|
| `ptr` | 输入，Host内存地址，需4K页对齐 |
| `size` | 输入，内存大小，单位Byte |
| `flag` | 输入，注册类型，支持位或组合 |

### 接口对比

| 对比项 | `aclrtHostRegister` | `aclrtHostRegisterV2` |
|------|---------------------|----------------------|
| 锁页能力 | 无，只能处理已有的锁页内存 | 支持 `ACL_HOST_REG_PINNED`，可将malloc内存注册为锁页 |
| flag组合 | 单个枚举值（Mapped/IOmemory/ReadOnly） | 支持位或组合（`PINNED | MAPPED` 等） |
| Device地址获取 | 接口内直接输出devPtr | 需额外调用 `aclrtHostGetDevicePointer`（两步操作更灵活） |
| 编程指南推荐 | 仅在VA一致性场景提及 | **编程指南明确推荐用于锁页+映射场景** |

> **推荐理由**：`aclrtHostRegisterV2` 的 `ACL_HOST_REG_PINNED` 是核心优势。用户可以直接用 malloc 申请内存后注册为锁页，无需改用 `aclrtMallocHost`，最自然、最通用。

### Flag说明

| Flag | 值 | 功能 |
|------|----|------|
| `ACL_HOST_REG_PINNED` | 0x10000000 | 将Host非锁页内存注册为锁页内存（如malloc申请的内存） |
| `ACL_HOST_REG_MAPPED` | 0x02 | 将Host内存映射注册为Device可访问的内存地址 |
| `ACL_HOST_REG_IOMEMORY` | 0x04 | 将第三方PCIe设备的IO space映射注册为Device可访问（预留，当前不支持） |
| `ACL_HOST_REG_READONLY` | 0x08 | Host内存映射注册为Device只读（预留，当前不支持） |

> **注意**：`ACL_HOST_REG_PINNED` 和 `ACL_HOST_REG_MAPPED` 支持位或组合使用。`ACL_HOST_REG_IOMEMORY` 和 `ACL_HOST_REG_READONLY` 当前不支持。

### 使用场景

#### 场景 1：malloc内存注册为锁页 + 映射到Device

最常见的用法：用 malloc 申请普通Pageable内存，通过 `ACL_HOST_REG_PINNED | ACL_HOST_REG_MAPPED` 一次性注册为锁页并映射到Device，供Device直接访问。无需改用 `aclrtMallocHost`。

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

> **约束**：当OS内核版本为5.10或更低时，PINNED会导致异常，此时应改用 `aclrtMallocHost` 申请锁页内存。

#### 场景 2：仅注册锁页（不映射）

只需要提升Host到Device的数据拷贝性能（锁页内存可避免DMA拷贝时的页面锁定开销），但不需要Device侧直接通过映射地址访问。单独使用 `ACL_HOST_REG_PINNED` 即可。

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

#### 场景 3：第三方PCIe设备IO space映射

需要将Host上第三方PCIe设备的寄存器或缓存映射注册为Device可访问，供Device侧直接读写。使用 `ACL_HOST_REG_IOMEMORY | ACL_HOST_REG_MAPPED`。

```c
void *ioPtr = ...;

aclrtHostRegisterV2(ioPtr, ioSize, ACL_HOST_REG_IOMEMORY | ACL_HOST_REG_MAPPED);

void *devicePtr = nullptr;
aclrtHostGetDevicePointer(ioPtr, &devicePtr, 0);

// Device侧通过devicePtr直接读写第三方设备的寄存器
......

aclrtHostUnregister(ioPtr);
```

### Flag组合选择

| 需求 | flag参数 | 适用场景 |
|------|---------|---------|
| 锁页 + 映射到Device | `ACL_HOST_REG_PINNED | ACL_HOST_REG_MAPPED` | malloc内存供Device直接访问（最常用） |
| 仅锁页 | `ACL_HOST_REG_PINNED` | 提升H2D/D2H拷贝性能 |
| 仅映射（已有锁页内存） | `ACL_HOST_REG_MAPPED` | aclrtMallocHost申请的内存映射到Device |
| PCIe IO space映射 | `ACL_HOST_REG_IOMEMORY | ACL_HOST_REG_MAPPED` | 第三方设备寄存器映射 |

### 约束说明

- Host内存地址需4K页对齐，可通过 `posix_memalign` 或 `aligned_alloc` 申请对齐内存。
- 当OS内核版本为5.10或更低时，使用 `ACL_HOST_REG_PINNED` 注册非锁页内存会导致异常，此时应改用 `aclrtMallocHost` 申请锁页内存。
- 映射后的Device内存地址不能用于内存操作（如 `aclrtMemcpy`），仅供Device侧算子直接访问。如需内存复制，仍应使用 `aclrtMemcpy`。
- 注册与取消注册需成对使用：`aclrtHostRegisterV2` 与 `aclrtHostUnregister`。
- `ACL_HOST_REG_IOMEMORY` 和 `ACL_HOST_REG_READONLY` 当前为预留选项，不支持。