# Event 模块架构

## 1. 模块概述

- **功能介绍**：Event 模块提供同步机制，支持事件记录、等待和状态查询。Event 可以在流中记录执行位置，其他流可以等待该事件完成，实现跨流同步。支持 IPC Event 用于进程间同步。
- **设计目标**：
  - 提供高效的跨流同步机制
  - IPC 场景通过共享内存实现进程间事件同步
  - 支持事件状态查询和超时等待
  

## 2. 使用场景与对外接口

### 2.1 使用场景

- **场景一**：跨流同步
  ```cpp
  aclrtRecordEvent(event, stream1);  // 在 stream1 记录事件
  aclrtStreamWaitEvent(stream2, event);  // stream2 等待事件
  ```

- **场景二**：查询事件状态
  ```cpp
  aclrtEventRecordedStatus status;
  aclrtQueryEventStatus(event, &status);  // 查询事件是否完成
  if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
      // 事件已完成
  }
  ```

- **场景三**：阻塞等待事件（Host 端阻塞直到 Event 完成，适用于需要同步等待计算结果再继续处理的场景）
  ```cpp
  aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);  // 创建同步事件
  aclrtRecordEvent(event, stream);                      // 在 Stream 上 Record 事件
  // ... Stream 上下发计算任务 ...
  aclrtSynchronizeEvent(event);                         // 阻塞等待事件完成，确保该 Event 之前的所有 Stream 任务已执行完毕
  aclrtDestroyEvent(event);                             // 销毁事件
  ```

- **场景四**：IPC 进程间同步
  ```cpp
  // 进程 A：创建 IPC Event，Record 并导出 handle
  aclrtCreateEventWithFlag(&event, ACL_EVENT_IPC);
  aclrtRecordEvent(event, streamA);               // 进程 A 在 stream 上 Record 事件
  aclrtIpcGetEventHandle(event, &ipcHandle);
  // 将 ipcHandle 传递给进程 B（如通过共享内存或 socket）

  // 进程 B：打开 IPC Event 并等待
  aclrtIpcOpenEventHandle(ipcHandle, &remoteEvent);
  aclrtStreamWaitEvent(stream, remoteEvent);
  ```

- **场景五**：计算事件间隔时间（需要 startEvent 和 endEvent 两个 Event 分别标记起止时刻，计时前需同步等待两个 Event 完成）
  ```cpp
  aclrtCreateEventWithFlag(&startEvent, ACL_EVENT_TIME_LINE);  // 创建起始事件
  aclrtCreateEventWithFlag(&endEvent, ACL_EVENT_TIME_LINE);    // 创建结束事件
  aclrtRecordEvent(startEvent, stream);        // 在 stream 记录起始事件
  // ... 执行需要计时的任务 ...
  aclrtRecordEvent(endEvent, stream);          // 在 stream 记录结束事件
  aclrtSynchronizeEvent(startEvent);           // 等待起始事件完成
  aclrtSynchronizeEvent(endEvent);             // 等待结束事件完成
  float elapsedTime = 0.0f;
  aclrtEventElapsedTime(&elapsedTime, startEvent, endEvent);  // 计算两个事件之间的耗时（毫秒）
  printf("Task elapsed time: %.3f ms\n", elapsedTime);
  aclrtDestroyEvent(startEvent);
  aclrtDestroyEvent(endEvent);
  ```

### 2.2 对外接口

| 接口 | 说明 |
|------|------|
| `aclrtCreateEvent()` | 创建事件（默认 flag） |
| `aclrtCreateEventWithFlag()` | 带 flag 创建事件 |
| `aclrtCreateEventExWithFlag()` ⭐ | 带 flag 创建可复用事件（**推荐**） |
| `aclrtDestroyEvent()` | 销毁事件 |
| `aclrtRecordEvent()` | 在流中记录事件 |
| `aclrtResetEvent()` | 重置事件 |
| `aclrtQueryEventStatus()` ⭐ | 查询事件完成状态（**推荐**） |
| `aclrtQueryEventWaitStatus()` | 查询事件等待状态 |
| `aclrtSynchronizeEvent()` | 阻塞等待事件完成 |
| `aclrtSynchronizeEventWithTimeout()` | 带超时阻塞等待 |
| `aclrtStreamWaitEvent()` | 流等待事件 |
| `aclrtStreamWaitEventWithTimeout()` | 带超时流等待事件 |
| `aclrtEventElapsedTime()` | 计算两个事件间隔时间 |
| `aclrtEventGetTimestamp()` | 获取事件记录时间戳 |
| `aclrtGetEventId()` | 获取事件 ID |
| `aclrtIpcGetEventHandle()` | 获取 IPC Event 跨进程 handle |
| `aclrtIpcOpenEventHandle()` | 在当前进程打开 IPC Event handle |

### 2.3 Event Flag 类型

Event Flag 通过 `aclrtCreateEventWithFlag` 传入，决定 Event 的创建分支和同步行为：

| Flag | 值 | 说明 |
|------|-----|------|
| `ACL_EVENT_SYNC` | 0x01 | 同步事件 |
| `ACL_EVENT_CAPTURE_STREAM_PROGRESS` | 0x02 | 流捕获进度标记 |
| `ACL_EVENT_TIME_LINE` | 0x08 | 时间线事件（用于计时） |
| `ACL_EVENT_DEVICE_USE_ONLY` | 0x10 | 仅设备内部使用 |
| `ACL_EVENT_EXTERNAL` | 0x20 | aclgraph external 标注使用 |
| `ACL_EVENT_IPC` | 0x40 | IPC 事件（进程间同步） |

### 2.4 Event 状态枚举

| 枚举类型 | 值 | 说明 |
|----------|-----|------|
| `aclrtEventRecordedStatus` | `NOT_READY(0)` / `COMPLETE(1)` | 事件记录状态 |
| `aclrtEventWaitStatus` | `COMPLETE(0)` / `NOT_READY(1)` / `RESERVED(0xFFFF)` | 事件等待状态 |

## 3. 架构总览

**整体设计思路**
**Event 管理整体分为两部分：**
- **Record/Wait 处理路径**：DavidEvent 的 Record/Wait 入口由 `event_c.cc` 中 `EvtRecord`/`EvtWait` 函数承接，IpcEvent 的 Record/Wait 由 `IpcEventRecordStarsV2`/`IpcEventWaitStarsV2` 承接。不同 Event 类型和 Flag 组合走不同处理分支。
- **任务下发流程**：配合 API 接口通过 Stream 任务申请、SQE 组装、任务下发等流程完成运行时调度。

### 3.1 Event Record/Wait 处理路径架构

```mermaid

flowchart TD
    classDef entryStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef branchStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef davidStyle fill:#E8F5E9,stroke:#2E7D32,stroke-width:2px,color:#1B5E20
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C

    A["aclrtRecordEvent / aclrtStreamWaitEvent"]:::entryStyle --> B{"Event 类型"}:::branchStyle
    B -->|DavidEvent<br/>普通同步/计时| C["EvtRecord / EvtWait<br/>event_c.cc"]:::davidStyle
    B -->|IpcEvent<br/>IPC 进程间同步| D["IpcEventRecordStarsV2 / IpcEventWaitStarsV2"]:::ipcStyle

    C --> C1["AllocEventIdResource<br/>CntNotifyId 分配"]:::davidStyle
    C --> C2["DavidEventRecordTaskInit<br/>DavidEventWaitTaskInit"]:::davidStyle
    D --> D1["GetIpcRecordIndex<br/>CAS 锁分配空闲索引"]:::ipcStyle
    D --> D2["MemWriteValueTaskInit<br/>MemWaitValueTaskInit"]:::ipcStyle

```

### 3.2 Event 下发流程交互图

```mermaid

sequenceDiagram
    autonumber
    participant App as 用户API
    participant Stream as Stream
    participant EventSub as Event子类
    participant Driver as HAL驱动
    participant HW as 硬件

    rect rgba(245, 237, 244, 0.62)
        alt Record 下发
            App->>Stream: aclrtRecordEvent(event, stream)
            Stream->>Stream: StreamLock() <br/> 允许单流多线程下发任务
            Stream->>EventSub: AllocEventIdResource(CntNotifyId) <br/> 或 GetIpcRecordIndex(CAS锁)
            Stream->>Stream: AllocTaskInfo + EventRecordTaskInit
            Stream->>Stream: 组装 SQE
            Stream->>Driver: halSqTaskSend(devId, &sendInfo)
            Driver->>HW: SQE 写入执行地址
            Stream->>Stream: StreamUnLock()
            Stream->>Stream: SubmitTaskPostProc — 触发回收或唤醒回收线程
        end
    end

    rect rgba(227, 242, 253, 0.62)
        alt WaitSendCheck 快路径
            App->>Stream: aclrtStreamWaitEvent(stream, event)
            Stream->>EventSub: WaitSendCheck()
            EventSub-->>Stream: EVT_RECORDED，直接返回 <br/>不下硬件任务
        else Wait 下发慢路径
            App->>Stream: aclrtStreamWaitEvent(stream, event)
            Stream->>Stream: StreamLock()
            Stream->>Stream: AllocTaskInfo + EventWaitTaskInit
            Stream->>Driver: halSqTaskSend(devId, &sendInfo)
            Driver->>HW: SQE 写入执行地址
            Stream->>Stream: StreamUnLock()
            Stream->>Stream: SubmitTaskPostProc
        end
    end

```

## 4. 详细设计

### 4.1 DavidEvent Record 流程

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef allocStyle fill:#E8F5E9,stroke:#4CAF50,stroke-width:2px,color:#1B5E20
    classDef decisionStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["aclrtRecordEvent"]:::userStyle --> B["EvtRecord"]:::userStyle
    B --> C["CheckTaskCanSend<br/>检查流上下文状态"]:::allocStyle
    C --> D["StreamLock + AllocTaskInfo<br/>分配任务和位置"]:::lockStyle
    D --> E{"isNewMode 或<br/>RT_EVENT_DEFAULT?"}:::decisionStyle
    E -->|是| F["AllocEventIdResource<br/>CntNotifyId 分配"]:::allocStyle
    E -->|否| G["使用已有 eventId"]:::allocStyle
    F --> H["DavidEventRecordTaskInit<br/>初始化 Record SQE"]:::successStyle
    G --> H
    H --> I["DavidSendTask<br/>提交到硬件"]:::successStyle
    I --> J["StreamUnLock"]:::lockStyle
    J --> K["SubmitTaskPostProc<br/>回收后处理"]:::successStyle
    K --> L["UpdateLatestRecord<br/>status → EVT_NOT_RECORDED"]:::successStyle

```

**流程步骤说明**：

- **CheckTaskCanSend**：检查流上下文状态，确保 Context 未 abort，否则返回错误
- **AllocEventIdResource**：DavidEvent 使用 CntNotifyId 替代传统 eventId。CntNotifyId 由 DavidStream 管理（`cntNotifyId_`），首次 Record 时通过 `ApplyCntNotifyId` 从驱动申请。当 `IsCntNotifyReachThreshold` 达到阈值时，需先等待之前 Wait 任务完成再申请新 id
- **StreamLock / StreamUnLock**：整个任务分配和提交过程在 Stream 锁保护下完成，防止并发修改 Stream 任务队列
- **SubmitTaskPostProc**：任务提交后的回收处理，包括更新 Stream 队列位置和触发 Profiling

### 4.2 DavidEvent Wait 流程

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef allocStyle fill:#E8F5E9,stroke:#4CAF50,stroke-width:2px,color:#1B5E20
    classDef decisionStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef errorStyle fill:#FFEBEE,stroke:#D32F2F,stroke-width:2px,color:#B71C1C
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["aclrtStreamWaitEvent"]:::userStyle --> B["EvtWait"]:::userStyle
    B --> C["WaitSendCheck<br/>检查是否需要下硬件任务"]:::allocStyle
    C --> D{"status == EVT_RECORDED<br/>且无 Reset?"}:::decisionStyle
    D -->|是| E["直接返回成功<br/>不下硬件任务"]:::successStyle
    D -->|否| F{"未 Record 且<br/>非 EXTERNAL/DDSYNC_NS?"}:::decisionStyle
    F -->|是| G["返回错误<br/>不能 Wait 未 Record 的 Event"]:::errorStyle
    F -->|否| H["CheckTaskCanSend"]:::allocStyle
    H --> I["StreamLock + AllocTaskInfo"]:::lockStyle
    I --> J["DavidEventWaitTaskInit<br/>初始化 Wait SQE"]:::successStyle
    J --> K["DavidSendTask<br/>提交到硬件"]:::successStyle
    K --> L["StreamUnLock + SubmitTaskPostProc"]:::lockStyle

```

**流程步骤说明**：

- **WaitSendCheck** 是关键决策点：若 Event 状态为 EVT_RECORDED 且未 Reset，直接返回成功不下硬件任务。这是 DavidEvent 的优化：当 Record 已完成，Wait 只需检查状态，无需插入额外 SQE
- 若 Event 未 Record 且 Flag 不是 EXTERNAL/DDSYNC_NS，返回 `ACL_ERROR_RT_INVALID_VALUE`，因为不能 Wait 一个未 Record 的 Event
- 否则下发 Wait 任务到硬件，通过 SQE 等待 CntNotifyId 完成

### 4.3 IPC Event Record 流程（StarsV2）

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["IPC Record"]:::userStyle --> B["IpcEventRecordStarsV2"]:::ipcStyle
    B --> C["CheckTaskCanSend"]:::ipcStyle
    C --> D["StreamLock + AllocTaskInfo"]:::lockStyle
    D --> E["GetIpcRecordIndex<br/>CAS 锁分配空闲索引"]:::ipcStyle
    E --> F["MemWriteValueTaskInit<br/>写入地址 = currentDeviceMem_ + curIndex<br/>写入值 = 1"]:::ipcStyle
    F --> G["DavidSendTask<br/>提交硬件写入"]:::successStyle
    G --> H["StreamUnLock + SubmitTaskPostProc"]:::lockStyle
    H --> I["eventStatus → INIT"]:::successStyle

```

**流程步骤说明**：

- IPC Record 不使用 CntNotifyId/eventId，而是通过**共享内存索引**实现同步：`GetIpcRecordIndex` 在 `IpcHandleVa.deviceMemRef[]` 中通过 CAS 自旋锁（`IpcVaLock/IpcVaUnLock`）分配一个空闲 `curIndex`
- 硬件执行 `MemWriteValue` SQE，将值 1 写入 `currentDeviceMem_ + curIndex` 地址，跨进程通过 P2P 共享内存可见
- 写入完成后，远端进程的 MemWaitValue 即可感知该地址值变化

### 4.4 IPC Event Wait 流程（StarsV2）

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef decisionStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["IPC Wait"]:::userStyle --> B["IpcEventWaitStarsV2"]:::ipcStyle
    B --> C["IpcVaLock<br/>检查 currentIndex 的 deviceMemRef"]:::lockStyle
    C --> D{"deviceMemRef == 0?"}:::decisionStyle
    D -->|是| E["已完成或未记录<br/>直接返回成功"]:::successStyle
    D -->|否| F["deviceMemRef++<br/>IpcEventCountAdd"]:::ipcStyle
    F --> G["IpcVaUnLock"]:::lockStyle
    G --> H["StreamLock + AllocTaskInfo"]:::lockStyle
    H --> I["MemWaitValueTaskInit<br/>等待地址 = currentDeviceMem_ + curIndex<br/>等待值 ≠ 0"]:::ipcStyle
    I --> J["DavidSendTask<br/>提交硬件等待"]:::successStyle
    J --> K["StreamUnLock + SubmitTaskPostProc"]:::lockStyle

```

**流程步骤说明**：

- IPC Wait 使用 `MemWaitValue` SQE 等待共享内存地址变为非零值。当硬件执行完 Record 的 MemWriteValue 后，该地址从 0 变为 1，Wait 任务即完成
- `IpcVaLock`（CAS 自旋锁）保护 `deviceMemRef[]` 的并发计数，支持同一 IPC Event 多次 Wait 的引用计数管理
- `deviceMemRef == 0` 意味着 Record 已完成（Ref 已被消耗）或尚未 Record，两种情况均无需下硬件任务，直接返回

### 4.5 核心机制详解

#### DavidEvent 状态机与 CntNotify 机制

**设计思想**：DavidEvent 将基类的三态状态机（INIT/RECORDING/RECORDED）简化为两态（`EVT_NOT_RECORDED`/`EVT_RECORDED`），并用 DavidStream 维护的 CntNotifyId 替代传统 eventId 池分配，减少跨组件资源管理开销。

```mermaid
stateDiagram-v2
    [*] --> EVT_RECORDED : isNewMode 创建
    [*] --> EVT_NOT_RECORDED : 旧模式创建
    EVT_NOT_RECORDED --> EVT_NOT_RECORDED : Record 提交
    EVT_NOT_RECORDED --> EVT_RECORDED : RecordComplete 回调
    EVT_RECORDED --> EVT_NOT_RECORDED : Reset / ClearRecordStatus
```

CntNotifyId 由 DavidStream 管理：
- `cntNotifyId_` 成员维护当前 Stream 的 NotifyId
- 首次通过 `ApplyCntNotifyId` 从驱动申请
- `IsCntNotifyReachThreshold` 达到阈值时需等待之前 Wait 任务完成
- `isCntNotify_` 标志区分预分配（newMode/RT_EVENT_DEFAULT）和驱动分配两种 id 来源

#### IPC Event 共享内存同步机制

**设计思想**：IPC Event 不依赖 CntNotifyId 硬件同步，而是通过 P2P 共享内存 + MemWriteValue/MemWaitValue SQE 实现跨进程事件同步，避免进程间 NotifyId 不可共享的限制。

核心数据结构 `IpcHandleVa`：

| 字段 | 类型 | 说明 |
|------|------|------|
| `lockStatus` | `uint64_t volatile` | CAS 自旋锁（LOCK_RELEASED/LOCK_OCCUPIED） |
| `deviceMemHandle` | `void*` | P2P 共享内存 handle（由 Export 导出） |
| `deviceMemRef[8192]` | `uint64_t[IPC_EVENT_P2P_SIZE]` | 环形索引数组，每个 slot 记录 Record/Wait 计数 |
| `currentIndex` | `uint16_t` | 当前 Record 位置 |

**Setup 流程（创建端）**：

```mermaid

flowchart TD
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef memStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["IpcEvent::Setup"]:::ipcStyle --> B["GetAllocationGranularity"]:::ipcStyle
    B --> C["IpcVaAndPaOperation<br/>P2P 内存映射"]:::ipcStyle
    C --> C1["ReserveMemAddress"]:::memStyle
    C1 --> C2["MallocPhysical"]:::memStyle
    C2 --> C3["MapMem"]:::memStyle
    C3 --> C4["ExportToShareableHandle<br/>导出共享 handle"]:::memStyle
    C4 --> C5["MemSetAccess<br/>设置 P2P 访问权限"]:::memStyle
    B --> D["IpcHandleAllocAndExport<br/>IPC Handle 映射"]:::ipcStyle
    D --> D1["ReserveMemAddress"]:::memStyle
    D1 --> D2["MallocPhysical"]:::memStyle
    D2 --> D3["MapMem"]:::memStyle
    D3 --> D4["ExportToShareableHandle<br/>导出 IPC handle 给远端"]:::memStyle
    D4 --> D5["IpcVaLockInit<br/>初始化 CAS 锁"]:::memStyle

```

**Open 流程（远端进程）**：

```mermaid

flowchart TD
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef memStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["aclrtIpcOpenEventHandle"]:::ipcStyle --> B["IpcOpenEventHandle"]:::ipcStyle
    B --> C["IpcHandleAllocAndImport<br/>导入 IPC Handle"]:::ipcStyle
    C --> C1["ReserveMemAddress"]:::memStyle
    C1 --> C2["ImportFromShareableHandle<br/>从 handle 导入物理内存"]:::memStyle
    C2 --> C3["MapMem"]:::memStyle
    B --> D["EnableP2PForIpc<br/>建立 P2P 通道"]:::ipcStyle
    D --> E["IpcMemHandleImport<br/>Host 端导入"]:::ipcStyle
    E --> E1["ReserveMemAddress + Import + Map"]:::memStyle
    B --> F["IpcMemHandleImport<br/>Device 端导入"]:::ipcStyle
    F --> F1["ReserveMemAddress + Import + Map"]:::memStyle

```

- **创建端**：分配 P2P 共享内存 + IPC Handle，导出两个 shareable handle（deviceMemHandle + ipcHandle）
- **远端进程**：Import IPC Handle → 获取 IpcHandleVa 指针 → Enable P2P → Host/Device 双端 Import 共享内存
- 跨进程同步：创建端通过 MemWriteValue 写入 `currentDeviceMem_ + curIndex`，远端通过 MemWaitValue 等待同一地址值变化

### 4.6 模块职责划分

| 模块 | 职责 | 位置 |
|------|------|------|
| Event | 事件基类，状态管理、taskId 映射、Synchronize | `core/inc/event/event.hpp` |
| DavidEvent | Stars 架构 Event 子类，CntNotifyId 模式、两态状态机 | `core/inc/event/event_david.hpp` |
| IpcEvent | IPC Event 子类，P2P 共享内存同步 | `core/inc/event/ipc_event.hpp` |
| event_c.cc | Stars 架构 Record/Wait/Reset 入口 | `core/src/event/event_c.cc` |
| event_david.cc | DavidEvent 实现 | `core/src/event/event_david.cc` |
| ipc_event.cc | IpcEvent 基础实现（Setup/Open） | `core/src/event/ipc_event.cc` |
| ipc_event_starsV2.cc | IPC StarsV2 Record/Wait | `core/src/event/ipc_event_starsV2.cc` |

### 4.7 核心数据结构

#### 4.7.1 Event 继承体系类图

```mermaid

classDiagram
    classDef baseStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef eventStyle fill:#E8F5E9,stroke:#2E7D32,stroke-width:2px,color:#1B5E20
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef streamStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100

    class Event:::baseStyle {
        <<base>>
        -Device* device_
        -int32_t eventId_
        -uint64_t eventFlag_
        -Atomic~bool~ hasRecord_
        -Atomic~bool~ hasReset_
        -Atomic~bool~ isSync_
        -RecordTaskInfo latestRecord_
        -Context* context_
        +Record(stm) rtError_t
        +Wait(stm, timeout) rtError_t
        +Synchronize(timeout) rtError_t
        +Query() rtError_t
    }

    class DavidEvent:::eventStyle {
        -bool isCntNotify_
        -uint32_t cntValue_
        -DavidEventState_t status_
        -DavidRecordTaskInfo latestRecordTask_
        +GenEventId() rtError_t
        +WaitSendCheck(stm, eventId) bool
        +AllocEventIdResource(stm, eventId) rtError_t
        +UpdateLatestRecord(info, status, ts)
        +RecordDavidEventComplete(tsk, ts)
        +ClearRecordStatus() rtError_t
    }

    class IpcEvent:::ipcStyle {
        -IpcHandleVa* ipcHandleVa_
        -void* currentDeviceMem_
        -void* currentHostMem_
        -uint64_t ipcHandle_
        -Atomic~bool~ isNeedDestroy_
        -rtEventState_t eventStatus_
        +Setup() rtError_t
        +IpcGetEventHandle(handle) rtError_t
        +IpcOpenEventHandle(handle) rtError_t
        +IpcVaLock() / IpcVaUnLock()
        +GetIpcRecordIndex(curIndex) rtError_t
        +IpcEventRecordStarsV2(stm) rtError_t
        +IpcEventWaitStarsV2(stm) rtError_t
    }

    class DavidStream:::streamStyle {
        -uint32_t cntNotifyId_
        -mutex cntNotifyInfoLock_
        +ApplyCntNotifyId(newEventId) rtError_t
        +GetCntNotifyId(newEventId)
        +IsCntNotifyReachThreshold() bool
    }

    Event <|-- DavidEvent
    Event <|-- IpcEvent
    DavidEvent --> DavidStream

```

#### 4.7.2 IpcHandleVa 数据结构类图

```mermaid

classDiagram
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef dataStyle fill:#E0F2F1,stroke:#00695C,stroke-width:2px,color:#004D40

    class IpcEvent:::ipcStyle {
        -IpcHandleVa* ipcHandleVa_
        -void* currentDeviceMem_
    }

    class IpcHandleVa:::dataStyle {
        +uint64_t volatile lockStatus
        +void* deviceMemHandle
        +uint64_t deviceMemRef[IPC_EVENT_P2P_SIZE]
        +uint16_t currentIndex
    }

    IpcEvent *-- IpcHandleVa

```

## 5. 关键文件索引

| 模块 | 文件路径 | 核心内容 |
|------|----------|----------|
| Event 基类 | `src/runtime/core/inc/event/event.hpp` | Event 类定义 |
| Event 基类实现 | `src/runtime/core/src/event/event.cc` | Event 基类核心实现 |
| DavidEvent 定义 | `src/runtime/core/inc/event/event_david.hpp` | DavidEvent 类定义、两态状态机 |
| DavidEvent 实现 | `src/runtime/core/src/event/event_david.cc` | CntNotifyId、状态管理、Query |
| Stars 入口 | `src/runtime/core/src/event/event_c.cc` | EvtRecord/EvtWait/EvtReset |
| IpcEvent 定义 | `src/runtime/core/inc/event/ipc_event.hpp` | IpcEvent 类、IpcHandleVa |
| IpcEvent 实现 | `src/runtime/core/src/event/ipc_event.cc` | Setup/Open 流程 |
| IPC StarsV2 | `src/runtime/core/src/event/ipc_event_starsV2.cc` | IPC Record/Wait StarsV2 |
| C 接口层 | `src/runtime/api/api_c_event.cc` | aclrt/rt Event 外部接口 |
| 任务定义 | `src/runtime/core/src/task/task_info/event/` | Event/Notify 任务类型 |

## 6. 性能优化策略

- **CntNotifyId 模式**：DavidEvent 使用 Stream 维护的 CntNotifyId 替代全局池分配，减少跨组件 id 管理开销
- **两态状态机**：DavidEvent 简化为 EVT_NOT_RECORDED/EVT_RECORDED 两态，减少状态判断复杂度
- **Wait 快捷路径**：WaitSendCheck 检测到已完成 Event 时直接返回，不下硬件任务

---

_本模块文档基于源码 `src/runtime/core/src/event/` 和 `src/runtime/core/inc/event/` 分析。_