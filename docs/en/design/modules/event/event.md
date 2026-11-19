# Event Module Architecture

## 1. Module Overview

- **Feature description**: The Event module provides synchronization mechanisms and supports event record, wait, and status query. An Event can record an execution position in a stream. Other streams can wait for the event to complete, which implements cross-stream synchronization. It supports IPC Event for inter-process synchronization.
- **Design goals**:
  - Provide an efficient cross-stream synchronization mechanism
  - Use shared memory for inter-process event synchronization in IPC scenarios
  - Support event status query and timeout wait
  

## 2. Usage Scenarios and External Interfaces

### 2.1 Usage Scenarios

- **Scenario 1**: Cross-stream synchronization

  ```cpp
  aclrtRecordEvent(event, stream1);  // Record the event in stream1
  aclrtStreamWaitEvent(stream2, event);  // stream2 waits for the event
  ```

- **Scenario 2**: Query the event status

  ```cpp
  aclrtEventRecordedStatus status;
  aclrtQueryEventStatus(event, &status);  // Query whether the event is complete
  if (status == ACL_EVENT_RECORDED_STATUS_COMPLETE) {
      // The event is complete
  }
  ```

- **Scenario 3**: Blocking event wait (the host blocks until the Event completes. This is suitable for scenarios that need to wait synchronously for the compute result before continuing)

  ```cpp
  aclrtCreateEventExWithFlag(&event, ACL_EVENT_SYNC);  // Create a synchronous event
  aclrtRecordEvent(event, stream);                      // Record the event on the Stream
  // ... Deliver compute tasks on the Stream ...
  aclrtSynchronizeEvent(event);                         // Block until the event completes. This ensures that all Stream tasks before this Event have finished
  aclrtDestroyEvent(event);                             // Destroy the event
  ```

- **Scenario 4**: IPC inter-process synchronization

  ```cpp
  // Process A: Create an IPC Event, record it, and export the handle
  aclrtCreateEventExWithFlag(&event, ACL_EVENT_IPC);
  aclrtRecordEvent(event, streamA);               // Process A records the event on the stream
  aclrtIpcGetEventHandle(event, &ipcHandle);
  // Pass ipcHandle to process B (for example, through shared memory or a socket)

  // Process B: Open the IPC Event and wait
  aclrtIpcOpenEventHandle(ipcHandle, &remoteEvent);
  aclrtStreamWaitEvent(stream, remoteEvent);
  ```

- **Scenario 5**: Calculate the event elapsed time (requires two Events, startEvent and endEvent, to mark the start and end moments. Before timing, you must wait synchronously for both Events to complete)

  ```cpp
  aclrtCreateEventWithFlag(&startEvent, ACL_EVENT_TIME_LINE);  // Create the start event
  aclrtCreateEventWithFlag(&endEvent, ACL_EVENT_TIME_LINE);    // Create the end event
  aclrtRecordEvent(startEvent, stream);        // Record the start event in the stream
  // ... Execute the tasks to time ...
  aclrtRecordEvent(endEvent, stream);          // Record the end event in the stream
  aclrtSynchronizeEvent(startEvent);           // Wait for the start event to complete
  aclrtSynchronizeEvent(endEvent);             // Wait for the end event to complete
  float elapsedTime = 0.0f;
  aclrtEventElapsedTime(&elapsedTime, startEvent, endEvent);  // Calculate the elapsed time between the two events (milliseconds)
  printf("Task elapsed time: %.3f ms\n", elapsedTime);
  aclrtDestroyEvent(startEvent);
  aclrtDestroyEvent(endEvent);
  ```

### 2.2 External Interfaces

| Interface | Description |
|------|------|
| `aclrtCreateEvent()` | Create an event (default flag) |
| `aclrtCreateEventWithFlag()` | Create an event with a flag |
| `aclrtCreateEventExWithFlag()` ⭐ | Create a reusable event with a flag (**recommended**) |
| `aclrtDestroyEvent()` | Destroy an event |
| `aclrtRecordEvent()` | Record an event in a stream |
| `aclrtResetEvent()` | Reset an event |
| `aclrtQueryEventStatus()` ⭐ | Query the event completion status (**recommended**) |
| `aclrtQueryEventWaitStatus()` | Query the event wait status |
| `aclrtSynchronizeEvent()` | Block until the event completes |
| `aclrtSynchronizeEventWithTimeout()` | Blocking wait with a timeout |
| `aclrtStreamWaitEvent()` | Stream waits for an event |
| `aclrtStreamWaitEventWithTimeout()` | Stream waits for an event with a timeout |
| `aclrtEventElapsedTime()` | Calculate the elapsed time between two events |
| `aclrtEventGetTimestamp()` | Get the event record timestamp |
| `aclrtGetEventId()` | Get the event ID |
| `aclrtIpcGetEventHandle()` | Get the cross-process handle of an IPC Event |
| `aclrtIpcOpenEventHandle()` | Open an IPC Event handle in the current process |

### 2.3 Event Flag Types

Event flags are passed through `aclrtCreateEventWithFlag` or `aclrtCreateEventExWithFlag` and determine the creation branch and synchronization behavior of the Event. `ACL_EVENT_IPC` is supported only through `aclrtCreateEventExWithFlag`:

| Flag | Value | Description |
|------|-----|------|
| `ACL_EVENT_SYNC` | 0x01 | Synchronous event |
| `ACL_EVENT_CAPTURE_STREAM_PROGRESS` | 0x02 | Stream capture progress marker |
| `ACL_EVENT_TIME_LINE` | 0x08 | Timeline event (used for timing) |
| `ACL_EVENT_DEVICE_USE_ONLY` | 0x10 | For internal device use only |
| `ACL_EVENT_EXTERNAL` | 0x20 | Deprecated in CANN 9.3.0 and planned for removal after December 30, 2027 |
| `ACL_EVENT_IPC` | 0x40 | IPC event (inter-process synchronization) |

### 2.4 Event Status Enumerations

| Enumeration type | Value | Description |
|----------|-----|------|
| `aclrtEventRecordedStatus` | `NOT_READY(0)` / `COMPLETE(1)` | Event record status |
| `aclrtEventWaitStatus` | `COMPLETE(0)` / `NOT_READY(1)` / `RESERVED(0xFFFF)` | Event wait status |

## 3. Architecture Overview

**Overall design idea**
**Event management consists of two parts:**
- **Record/Wait handling path**: The Record/Wait entry points of DavidEvent are handled by the `EvtRecord`/`EvtWait` functions in `event_c.cc`. The Record/Wait of IpcEvent are handled by `IpcEventRecordStarsV2`/`IpcEventWaitStarsV2`. Different Event types and Flag combinations take different handling branches.
- **Task delivery flow**: Together with the API interfaces, it completes runtime scheduling through Stream task allocation, SQE assembly, task delivery, and so on.

### 3.1 Event Record/Wait Handling Path Architecture

```mermaid

flowchart TD
    classDef entryStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef branchStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef davidStyle fill:#E8F5E9,stroke:#2E7D32,stroke-width:2px,color:#1B5E20
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C

    A["aclrtRecordEvent / aclrtStreamWaitEvent"]:::entryStyle --> B{"Event type"}:::branchStyle
    B -->|DavidEvent<br/>Regular synchronization/timing| C["EvtRecord / EvtWait<br/>event_c.cc"]:::davidStyle
    B -->|IpcEvent<br/>IPC inter-process synchronization| D["IpcEventRecordStarsV2 / IpcEventWaitStarsV2"]:::ipcStyle

    C --> C1["AllocEventIdResource<br/>CntNotifyId allocation"]:::davidStyle
    C --> C2["DavidEventRecordTaskInit<br/>DavidEventWaitTaskInit"]:::davidStyle
    D --> D1["GetIpcRecordIndex<br/>CAS lock allocates a free index"]:::ipcStyle
    D --> D2["MemWriteValueTaskInit<br/>MemWaitValueTaskInit"]:::ipcStyle

```

### 3.2 Event Delivery Flow Interaction Diagram

```mermaid

sequenceDiagram
    autonumber
    participant App as User API
    participant Stream as Stream
    participant EventSub as Event subclass
    participant Driver as HAL driver
    participant HW as Hardware

    rect rgba(245, 237, 244, 0.62)
        alt Record delivery
            App->>Stream: aclrtRecordEvent(event, stream)
            Stream->>Stream: StreamLock() <br/> Allows multiple threads on a single stream to deliver tasks
            Stream->>EventSub: AllocEventIdResource(CntNotifyId) <br/> or GetIpcRecordIndex (CAS lock)
            Stream->>Stream: AllocTask + EventRecordTaskInit
            Stream->>Stream: Assemble the SQE
            Stream->>Driver: halSqTaskSend(devId, &sendInfo)
            Driver->>HW: SQE writes the execution address
            Stream->>Stream: StreamUnLock()
            Stream->>Stream: SubmitTaskPostProc — Trigger reclamation or wake up the reclamation thread
        end
    end

    rect rgba(227, 242, 253, 0.62)
        alt WaitSendCheck fast path
            App->>Stream: aclrtStreamWaitEvent(stream, event)
            Stream->>EventSub: WaitSendCheck()
            EventSub-->>Stream: EVT_RECORDED. Return directly <br/>No hardware task is delivered
        else Wait delivery slow path
            App->>Stream: aclrtStreamWaitEvent(stream, event)
            Stream->>Stream: StreamLock()
            Stream->>Stream: AllocTask + EventWaitTaskInit
            Stream->>Driver: halSqTaskSend(devId, &sendInfo)
            Driver->>HW: SQE writes the execution address
            Stream->>Stream: StreamUnLock()
            Stream->>Stream: SubmitTaskPostProc
        end
    end

```

## 4. Detailed Design

### 4.1 DavidEvent Record Flow

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef allocStyle fill:#E8F5E9,stroke:#4CAF50,stroke-width:2px,color:#1B5E20
    classDef decisionStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["aclrtRecordEvent"]:::userStyle --> B["EvtRecord"]:::userStyle
    B --> C["CheckTaskCanSend<br/>Check the stream context status"]:::allocStyle
    C --> D["StreamLock + AllocTask<br/>Allocate a task and a position"]:::lockStyle
    D --> E{"isNewMode or<br/>RT_EVENT_DEFAULT?"}:::decisionStyle
    E -->|Yes| F["AllocEventIdResource<br/>CntNotifyId allocation"]:::allocStyle
    E -->|No| G["Use the existing eventId"]:::allocStyle
    F --> H["DavidEventRecordTaskInit<br/>Initialize the Record SQE"]:::successStyle
    G --> H
    H --> I["DavidSendTask<br/>Submit to hardware"]:::successStyle
    I --> J["StreamUnLock"]:::lockStyle
    J --> K["SubmitTaskPostProc<br/>Post-reclamation processing"]:::successStyle
    K --> L["UpdateLatestRecord<br/>status → EVT_NOT_RECORDED"]:::successStyle

```

**Flow step description**:

- **CheckTaskCanSend**: Check the stream context status and ensure that the Context is not aborted. Otherwise, return an error.
- **AllocEventIdResource**: DavidEvent uses CntNotifyId instead of the traditional eventId. CntNotifyId is managed by DavidStream (`cntNotifyId_`). On the first Record, it is requested from the driver through `ApplyCntNotifyId`. When `IsCntNotifyReachThreshold` reaches the threshold, wait for previous Wait tasks to complete before requesting a new id.
- **StreamLock / StreamUnLock**: The entire task allocation and submission process runs under the Stream lock. This prevents concurrent modification of the Stream task queue.
- **SubmitTaskPostProc**: Post-reclamation processing after task submission, including updating the Stream queue position and triggering Profiling

### 4.2 DavidEvent Wait Flow

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef allocStyle fill:#E8F5E9,stroke:#4CAF50,stroke-width:2px,color:#1B5E20
    classDef decisionStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef errorStyle fill:#FFEBEE,stroke:#D32F2F,stroke-width:2px,color:#B71C1C
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["aclrtStreamWaitEvent"]:::userStyle --> B["EvtWait"]:::userStyle
    B --> C["WaitSendCheck<br/>Check whether a hardware task is required"]:::allocStyle
    C --> D{"status == EVT_RECORDED<br/>and no Reset?"}:::decisionStyle
    D -->|Yes| E["Return success directly<br/>No hardware task is delivered"]:::successStyle
    D -->|No| F{"Not recorded and<br/>not EXTERNAL/DDSYNC_NS?"}:::decisionStyle
    F -->|Yes| G["Return an error<br/>Cannot wait for an Event that is not recorded"]:::errorStyle
    F -->|No| H["CheckTaskCanSend"]:::allocStyle
    H --> I["StreamLock + AllocTask"]:::lockStyle
    I --> J["DavidEventWaitTaskInit<br/>Initialize the Wait SQE"]:::successStyle
    J --> K["DavidSendTask<br/>Submit to hardware"]:::successStyle
    K --> L["StreamUnLock + SubmitTaskPostProc"]:::lockStyle

```

**Flow step description**:

- **WaitSendCheck** is the key decision point. If the Event status is EVT_RECORDED and the Event is not reset, return success directly without delivering a hardware task. This is the DavidEvent optimization: when Record is complete, Wait only needs to check the status and does not insert an extra SQE.
- If the Event is not recorded and the flag is not EXTERNAL/DDSYNC_NS, return `ACL_ERROR_RT_INVALID_VALUE` because you cannot wait for an Event that is not recorded.
- Otherwise, deliver a Wait task to hardware and wait for CntNotifyId to complete through the SQE.

### 4.3 IPC Event Record Flow (StarsV2)

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["IPC Record"]:::userStyle --> B["IpcEventRecordStarsV2"]:::ipcStyle
    B --> C["CheckTaskCanSend"]:::ipcStyle
    C --> D["StreamLock + AllocTask"]:::lockStyle
    D --> E["GetIpcRecordIndex<br/>CAS lock allocates a free index"]:::ipcStyle
    E --> F["MemWriteValueTaskInit<br/>Write address = currentDeviceMem_ + curIndex<br/>Write value = 1"]:::ipcStyle
    F --> G["DavidSendTask<br/>Submit the hardware write"]:::successStyle
    G --> H["StreamUnLock + SubmitTaskPostProc"]:::lockStyle
    H --> I["eventStatus → INIT"]:::successStyle

```

**Flow step description**:

- IPC Record does not use CntNotifyId/eventId. It uses a **shared memory index** for synchronization: `GetIpcRecordIndex` allocates a free `curIndex` in `IpcHandleVa.deviceMemRef[]` through a CAS spin lock (`IpcVaLock/IpcVaUnLock`).
- The hardware executes the `MemWriteValue` SQE and writes the value 1 to the `currentDeviceMem_ + curIndex` address. The value is visible across processes through P2P shared memory.
- After the write completes, the MemWaitValue of the remote process detects the value change at that address.

### 4.4 IPC Event Wait Flow (StarsV2)

```mermaid

flowchart TD
    classDef userStyle fill:#E3F2FD,stroke:#1565C0,stroke-width:2px,color:#0D47A1
    classDef lockStyle fill:#FFF3E0,stroke:#FF9800,stroke-width:2px,color:#E65100
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef decisionStyle fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#F57F17
    classDef successStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["IPC Wait"]:::userStyle --> B["IpcEventWaitStarsV2"]:::ipcStyle
    B --> C["IpcVaLock<br/>Check the deviceMemRef of currentIndex"]:::lockStyle
    C --> D{"deviceMemRef == 0?"}:::decisionStyle
    D -->|Yes| E["Already complete or not recorded<br/>Return success directly"]:::successStyle
    D -->|No| F["deviceMemRef++<br/>IpcEventCountAdd"]:::ipcStyle
    F --> G["IpcVaUnLock"]:::lockStyle
    G --> H["StreamLock + AllocTask"]:::lockStyle
    H --> I["MemWaitValueTaskInit<br/>Wait address = currentDeviceMem_ + curIndex<br/>Wait value ≠ 0"]:::ipcStyle
    I --> J["DavidSendTask<br/>Submit the hardware wait"]:::successStyle
    J --> K["StreamUnLock + SubmitTaskPostProc"]:::lockStyle

```

**Flow step description**:

- IPC Wait uses the `MemWaitValue` SQE to wait until the shared memory address becomes a non-zero value. After the hardware finishes the MemWriteValue of Record, the address changes from 0 to 1, and the Wait task completes.
- `IpcVaLock` (a CAS spin lock) protects the concurrent count of `deviceMemRef[]` and supports reference count management for multiple Wait calls on the same IPC Event.
- `deviceMemRef == 0` means that Record is already complete (the Ref is consumed) or not yet recorded. In both cases, no hardware task is required, and the interface returns directly.

### 4.5 Core Mechanism Details

#### DavidEvent State Machine and CntNotify Mechanism

**Design idea**: DavidEvent simplifies the three-state state machine of the base class (INIT/RECORDING/RECORDED) into two states (`EVT_NOT_RECORDED`/`EVT_RECORDED`). It uses the CntNotifyId maintained by DavidStream instead of traditional eventId pool allocation, which reduces cross-component resource management overhead.

```mermaid
stateDiagram-v2
    [*] --> EVT_RECORDED : Created in isNewMode
    [*] --> EVT_NOT_RECORDED : Created in the old mode
    EVT_NOT_RECORDED --> EVT_NOT_RECORDED : Record submitted
    EVT_NOT_RECORDED --> EVT_RECORDED : RecordComplete callback
    EVT_RECORDED --> EVT_NOT_RECORDED : Reset / ClearRecordStatus
```

CntNotifyId is managed by DavidStream:
- The `cntNotifyId_` member maintains the NotifyId of the current Stream
- It is requested from the driver through `ApplyCntNotifyId` on first use
- When `IsCntNotifyReachThreshold` reaches the threshold, wait for previous Wait tasks to complete
- The `isCntNotify_` flag distinguishes two id sources: pre-allocation (newMode/RT_EVENT_DEFAULT) and driver allocation

#### IPC Event Shared Memory Synchronization Mechanism

**Design idea**: IPC Event does not rely on CntNotifyId hardware synchronization. It uses P2P shared memory and the MemWriteValue/MemWaitValue SQE to implement cross-process event synchronization. This avoids the limitation that NotifyId cannot be shared between processes.

Core data structure `IpcHandleVa`:

| Field | Type | Description |
|------|------|------|
| `lockStatus` | `uint64_t volatile` | CAS spin lock (LOCK_RELEASED/LOCK_OCCUPIED) |
| `deviceMemHandle` | `void*` | P2P shared memory handle (exported by Export) |
| `deviceMemRef[8192]` | `uint64_t[IPC_EVENT_P2P_SIZE]` | Ring index array. Each slot records the Record/Wait count |
| `currentIndex` | `uint16_t` | Current Record position |

**Setup flow (creator side)**:

```mermaid

flowchart TD
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef memStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["IpcEvent::Setup"]:::ipcStyle --> B["GetAllocationGranularity"]:::ipcStyle
    B --> C["IpcVaAndPaOperation<br/>P2P memory mapping"]:::ipcStyle
    C --> C1["ReserveMemAddress"]:::memStyle
    C1 --> C2["MallocPhysical"]:::memStyle
    C2 --> C3["MapMem"]:::memStyle
    C3 --> C4["ExportToShareableHandle<br/>Export the shareable handle"]:::memStyle
    C4 --> C5["MemSetAccess<br/>Set P2P access permissions"]:::memStyle
    B --> D["IpcHandleAllocAndExport<br/>IPC Handle mapping"]:::ipcStyle
    D --> D1["ReserveMemAddress"]:::memStyle
    D1 --> D2["MallocPhysical"]:::memStyle
    D2 --> D3["MapMem"]:::memStyle
    D3 --> D4["ExportToShareableHandle<br/>Export the IPC handle to the remote end"]:::memStyle
    D4 --> D5["IpcVaLockInit<br/>Initialize the CAS lock"]:::memStyle

```

**Open flow (remote process)**:

```mermaid

flowchart TD
    classDef ipcStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C
    classDef memStyle fill:#E0F7FA,stroke:#00838F,stroke-width:2px,color:#004D40

    A["aclrtIpcOpenEventHandle"]:::ipcStyle --> B["IpcOpenEventHandle"]:::ipcStyle
    B --> C["IpcHandleAllocAndImport<br/>Import the IPC Handle"]:::ipcStyle
    C --> C1["ReserveMemAddress"]:::memStyle
    C1 --> C2["ImportFromShareableHandle<br/>Import physical memory from the handle"]:::memStyle
    C2 --> C3["MapMem"]:::memStyle
    B --> D["EnableP2PForIpc<br/>Establish the P2P channel"]:::ipcStyle
    D --> E["IpcMemHandleImport<br/>Host-side import"]:::ipcStyle
    E --> E1["ReserveMemAddress + Import + Map"]:::memStyle
    B --> F["IpcMemHandleImport<br/>Device-side import"]:::ipcStyle
    F --> F1["ReserveMemAddress + Import + Map"]:::memStyle

```

- **Creator side**: Allocate P2P shared memory and the IPC Handle, and export two shareable handles (deviceMemHandle + ipcHandle)
- **Remote process**: Import the IPC Handle → Obtain the IpcHandleVa pointer → Enable P2P → Import shared memory on both the host and device sides
- Cross-process synchronization: The creator side writes to `currentDeviceMem_ + curIndex` through MemWriteValue. The remote side waits for the value change at the same address through MemWaitValue.

### 4.6 Module Responsibility Division

| Module | Responsibility | Location |
|------|------|------|
| Event | Event base class, state management, taskId mapping, Synchronize | `core/inc/event/event.hpp` |
| DavidEvent | Stars architecture Event subclass, CntNotifyId mode, two-state state machine | `core/inc/event/event_david.hpp` |
| IpcEvent | IPC Event subclass, P2P shared memory synchronization | `core/inc/event/ipc_event.hpp` |
| event_c.cc | Stars architecture Record/Wait/Reset entry points | `core/src/event/event_c.cc` |
| event_david.cc | DavidEvent implementation | `core/src/event/event_david.cc` |
| ipc_event.cc | IpcEvent basic implementation (Setup/Open) | `core/src/event/ipc_event.cc` |
| ipc_event_starsV2.cc | IPC StarsV2 Record/Wait | `core/src/event/ipc_event_starsV2.cc` |

### 4.7 Core Data Structures

#### 4.7.1 Event Inheritance Class Diagram

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
        +RecordComplete(tsk, timestamp, timeline)
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

#### 4.7.2 IpcHandleVa Data Structure Class Diagram

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

## 5. Key File Index

| Module | File path | Core content |
|------|----------|----------|
| Event base class | `src/runtime/core/inc/event/event.hpp` | Event class definition |
| Event base class implementation | `src/runtime/core/src/event/event.cc` | Event base class core implementation |
| DavidEvent definition | `src/runtime/core/inc/event/event_david.hpp` | DavidEvent class definition, two-state state machine |
| DavidEvent implementation | `src/runtime/core/src/event/event_david.cc` | CntNotifyId, state management, Query |
| Stars entry | `src/runtime/core/src/event/event_c.cc` | EvtRecord/EvtWait/EvtReset |
| IpcEvent definition | `src/runtime/core/inc/event/ipc_event.hpp` | IpcEvent class, IpcHandleVa |
| IpcEvent implementation | `src/runtime/core/src/event/ipc_event.cc` | Setup/Open flow |
| IPC StarsV2 | `src/runtime/core/src/event/ipc_event_starsV2.cc` | IPC Record/Wait StarsV2 |
| C interface layer | `src/runtime/api/api_c_event.cc` | aclrt/rt Event external interfaces |
| Task definition | `src/runtime/core/src/task/task_info/event/` | Event/Notify task types |

## 6. Performance Optimization Strategies

- **CntNotifyId mode**: DavidEvent uses the CntNotifyId maintained by the Stream instead of global pool allocation, which reduces cross-component id management overhead
- **Two-state state machine**: DavidEvent is simplified to the two states EVT_NOT_RECORDED/EVT_RECORDED, which reduces state-check complexity
- **Wait fast path**: When WaitSendCheck detects a completed Event, it returns directly and does not deliver a hardware task

---

_This module document is based on an analysis of the source code in `src/runtime/core/src/event/` and `src/runtime/core/inc/event/`._
