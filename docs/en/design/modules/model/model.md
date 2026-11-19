# Model Module Architecture

## 1. Module Overview

- **Function overview**: The Model module manages the execution model of compute graphs. It covers the full lifecycle, including model creation, Stream binding, task loading, model execution, and destruction. It supports Normal Model and Capture Model. It implements task scheduling and execution through the SQ/CQ mechanism.
- **Design goals**:
  - Provide unified model management interfaces
  - Support multi-Stream binding and scheduling
  - Implement batch submission and execution of tasks
  - Support Label allocation and jump control
  - Provide synchronous and asynchronous model execution modes

## 2. Usage Scenarios and External Interfaces

### 2.1 Usage Scenarios

- **Scenario 1**: Create and execute a compute model (using ACL interfaces)
  ```cpp
  aclmdlRI modelRI;
  aclmdlRIBuildBegin(&modelRI, 0);  // Start building the model
  aclmdlRIBindStream(modelRI, stream, ACL_MODEL_STREAM_FLAG_HEAD);  // Bind a Stream
  // Add tasks to the stream
  aclmdlRIEndTask(modelRI, stream);  // Mark the end of tasks
  aclmdlRIBuildEnd(modelRI, nullptr);  // End building
  aclmdlRIExecute(modelRI, -1);  // Synchronous execution
  aclmdlRIDestroy(modelRI);  // Destroy the model
  ```

- **Scenario 2**: Asynchronous model execution (using ACL interfaces)
  ```cpp
  aclmdlRIExecuteAsync(modelRI, execStream);
  // Wait for execution completion through Stream synchronization
  aclrtSynchronizeStream(execStream);
  ```

### 2.2 External Interfaces

| ACL interface | File location | Description |
|----------|----------|------|
| `aclmdlRIBuildBegin()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Create a model (start building) |
| `aclmdlRIDestroy()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Destroy a model |
| `aclmdlRIBindStream()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Bind a Stream to a model |
| `aclmdlRIUnbindStream()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Unbind a Stream |
| `aclmdlRIExecute()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Execute a model synchronously |
| `aclmdlRIExecuteAsync()` |`include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Execute a model asynchronously |
| `aclmdlRIBuildEnd()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Complete model building (LoadComplete) |
| `aclmdlRIEndTask()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Mark the end of tasks |
| `aclmdlRISetName()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Set the model name |
| `aclmdlRIAbort()` |`include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | Abort model execution |

## 3. Architecture Overview

### 3.1 Overall Design Approach

Model uses a two-layer inheritance structure: the base class Model provides the complete functions of a normal model. Each Model binds multiple Streams, submits execution tasks through ModelExecuteTask, and uses Notify to notify execution completion.

| Design point | Description |
|--------|------|
| **Model as a task container** | Binds multiple Streams and uniformly manages SQE delivery and execution |
| **Stream as a task queue** | Each Stream maintains an SQ task sequence and supports task reclaim |
| **Label implements control flow** | Model allocates Label IDs, and Stream records jump points |
| **headStreams mechanism** | Marks entry Streams and activates execution from them at Execute |
| **Execution stream mechanism** | Delivers model execution tasks and activates model stream execution |

### 3.2 Architecture Layer Diagram

```mermaid
graph TB
    subgraph ContextLayer["Context runtime environment"]
        Context["Context<br/>Manages multiple Models"]
    end
    
    subgraph ModelLayer["Model core container"]
        Model["Model<br/>Compute graph container"]
        ModelStreams["streams_<br/>All bound Streams"]
        ModelHeadStreams["headStreams_<br/>Entry Streams"]
        ModelLabelMap["labelMap_<br/>Label ID → Label"]
        ModelLabelAllocator["labelAllocator_<br/>Label ID allocator"]
        ModelArgRecord["argLoaderRecord_<br/>Parameter handle records"]
        
        Model --> ModelStreams
        Model --> ModelHeadStreams
        Model --> ModelLabelMap
        Model --> ModelLabelAllocator
        Model --> ModelArgRecord
    end
    
    subgraph StreamLayer["Stream task queue layer"]
        Stream1["Stream 1<br/>Task queue"]
        Stream2["Stream 2<br/>Task queue"]
        Stream3["Stream 3<br/>Slave Stream"]
        
        StreamModel["Model*<br/>Back reference"]
        StreamTasks["delayRecycleTaskid_<br/>Task ID list"]
        StreamSQ["SQ queue<br/>Task execution queue"]
        StreamCQ["CQ queue<br/>Completion queue"]
        StreamAutoSplit["AutoSplitSqContext<br/>Auto-split context"]
        
        Stream1 --> StreamModel
        Stream1 --> StreamTasks
        Stream1 --> StreamSQ
        Stream1 --> StreamCQ
        
        Stream3 --> StreamAutoSplit
    end
    
    subgraph LabelLayer["Label control flow layer"]
        Label1["Label 1"]
        Label2["Label 2"]
        
        LabelModel["Model*<br/>Owning Model"]
        LabelStream["Stream*<br/>Owning Stream"]
        LabelId["labelId_<br/>Allocated by Model"]
        LabelDevAddr["devDstAddr_<br/>Device jump address"]
        
        Label1 --> LabelModel
        Label1 --> LabelStream
        Label1 --> LabelId
        Label1 --> LabelDevAddr
    end
    
    subgraph TaskLayer["Task layer"]
        TaskInfo["TaskInfo<br/>Task information"]
        TaskId["id: task ID"]
        TaskPos["pos: SQE position"]
        TaskStream["Stream*<br/>Owning Stream"]
        TaskUpdateFlag["updateFlag<br/>KEEP/UPDATE/DISABLE"]
        
        TaskInfo --> TaskId
        TaskInfo --> TaskPos
        TaskInfo --> TaskStream
        TaskInfo --> TaskUpdateFlag
    end
    
    %% Relationship connections
    Context --> Model
    
    ModelStreams --> Stream1
    ModelStreams --> Stream2
    ModelStreams --> Stream3
    ModelHeadStreams --> Stream1
    
    ModelLabelMap --> Label1
    ModelLabelMap --> Label2
    ModelLabelAllocator --> LabelId
    
    StreamTasks --> TaskInfo
    TaskStream --> Stream1
    
    %% Jump relationships between Stream and Label
    LabelStream -.jump.-> Stream2
    
    %% AutoSplitSq relationships
    StreamAutoSplit -.Master/Slave.-> Stream1
    StreamAutoSplit -.Slave.-> Stream3
```

### 3.3 Three-Layer Architecture Relationship of Model-Stream-Label

```mermaid
graph LR
    subgraph Layer1["Layer 1: Model container"]
        ModelContainer["Model<br/><b>Core responsibilities</b><br/>1. Bind multiple Streams<br/>2. Allocate Label IDs<br/>3. Manage SQE delivery<br/>4. Manage the execution entry"]
    end
    
    subgraph Layer2["Layer 2: Stream queue"]
        StreamQueue["Stream<br/><b>Core responsibilities</b><br/>1. Maintain the SQ task queue<br/>2. Record the task ID list<br/>3. Reference Model back<br/>4. Support task reclaim"]
    end
    
    subgraph Layer3["Layer 3: Label control flow"]
        LabelCtrl["Label<br/><b>Core responsibilities</b><br/>1. Set jump targets<br/>2. Implement inter-stream jumps<br/>3. Control flow branches<br/>4. Loop control"]
    end
    
    %% Inter-layer relationships
    ModelContainer -->|"Bind (binds)"| StreamQueue
    ModelContainer -->|"Allocate (allocates)"| LabelCtrl
    StreamQueue -->|"Set jump point (set)"| LabelCtrl
    LabelCtrl -->|"Jump (goto)"| StreamQueue
    
    %% Back references
    StreamQueue -.back reference.-> ModelContainer
    LabelCtrl -.back reference.-> ModelContainer
```

### 3.4 Core Module Interaction Diagram (with Hardware Interaction)

This section uses sequence diagrams to show the key differences between AutoSplit and non-AutoSplit scenarios.

#### 3.4.1 Stream Binding Phase

```mermaid
sequenceDiagram
    participant App as Application
    participant ACL as ACL interface layer
    participant RT as Runtime interface layer
    participant Model as Model container
    participant Stream as Stream queue
    participant Device as Device management
    participant Driver as Driver layer
    participant HW as Hardware layer<br/>TS/SQ/CQ

    Note over App,HW: Stream binding phase
    App->>ACL: aclmdlRIBindStream(modelRI, stream)
    ACL->>RT: rtModelBindStream()
    RT->>RT: Check Model.IsAutoSplitSq()
    
    %% AutoSplit path
    alt AutoSplit mode (supports unlimited queue depth)
        RT->>Model: ModelAddStream(mdl, stm, flag)
        Model->>Stream: SetModel(this)
        Model->>Model: streams_.push_back(stream)
        Note right of Model: Runtime-side binding only<br/>Do not submit hardware tasks immediately
        Model-->>RT: Binding succeeded (software side)
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else Non-AutoSplit mode (traditional GE model)
        RT->>Model: BindStream(stream)
        Model->>Stream: SetModel(this)
        Stream-->>Model: bindFlag=true
        Model->>Device: SubmitTask(ModelMaintainceTask)
        Device->>Driver: SubmitTask(taskInfo)
        Driver->>HW: Write to SQ<br/>MSG: MMT_STREAM_ADD
        HW-->>Driver: CQE (completion response)
        Driver-->>Device: RT_ERROR_NONE
        Device-->>Model: Binding succeeded
        Model-->>RT: streams_ updated
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

**Difference description**:
| Comparison item | AutoSplit mode | Non-AutoSplit mode |
|--------|----------------|-------------------|
| Binding timing | Software binding on the Runtime side only | Submit a hardware binding task immediately |
| Hardware interaction | Establish hardware relationships only at LoadComplete | Write to SQ immediately at bind time |
| Task queue | Host SQE buffer (extensible) | Fixed hardware SQ |

#### 3.4.2 Task Submission Phase

```mermaid
sequenceDiagram
    participant App as Application
    participant ACL as ACL interface layer
    participant RT as Runtime interface layer
    participant Stream as Stream queue
    participant AutoSplitCtx as AutoSplitSqContext
    participant SlaveStream as Slave Stream
    participant Device as Device management
    participant HW as Hardware layer<br/>SQ

    Note over App,HW: Task submission phase
    App->>ACL: rtKernelLaunch(kernel, stream)
    ACL->>RT: rtKernelLaunch()
    RT->>Stream: Check IsAutoSplitSq()
    
    %% AutoSplit path
    alt AutoSplit mode
        RT->>Stream: StreamLock()
        Stream->>AutoSplitCtx: GetAutoSplitCtx()
        AutoSplitCtx-->>Stream: curStreamSqeCount, slaveStreams
        
        %% Check whether the capacity requires creating a Slave Stream
        Stream->>Stream: Check curStreamSqeCount + sqeNum > HOST_SQ_MAX_COUNT
        alt Insufficient capacity (close to 32K)
            Stream->>RT: CreateAutoSplitSlaveStream(masterStream)
            RT->>SlaveStream: new SlaveStream()
            SlaveStream->>SlaveStream: SetupForAutoSplit()
            SlaveStream->>Device: AllocSqCqForAutoSplit()
            Device-->>SlaveStream: sqId, cqId
            Stream->>AutoSplitCtx: slaveStreams.push_back(slaveStream)
            Stream->>SlaveStream: CondStreamActive(slaveStream, prevStream)
            Note right of SlaveStream: Automatically create a Slave Stream<br/>Expand the queue capacity
        else Sufficient capacity
            Note right of Stream: Use the current Master/Slave Stream
        end
        
        %% Allocate tasks and write to the Host Buffer
        Stream->>Stream: AllocTaskInfoOnAutoSplitStream()
        Stream->>AutoSplitCtx: curStreamSqeCount += sqeNum
        Stream->>Stream: Write SQE to sqeBuffer_ (Host memory)
        Note right of Stream: Buffer the SQE in the Host Buffer<br/>Do not write to the hardware SQ directly
        Stream->>Stream: StreamUnLock()
        Stream-->>RT: TaskInfo
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else Non-AutoSplit mode
        RT->>Stream: AllocTask()
        Stream->>Stream: Record to delayRecycleTaskid_
        Stream->>Stream: Write SQE directly to the hardware SQ
        Stream->>HW: Write SQE directly to the hardware SQ
        HW-->>Stream : success
        Stream-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

**Difference description**:
| Comparison item | AutoSplit mode | Non-AutoSplit mode |
|--------|----------------|-------------------|
| SQE storage location | Host sqeBuffer_ | Device SQ |
| Capacity limit | Unlimited (Slave Stream expansion) | Fixed depth |
| Submission timing | Batch delivery at LoadComplete | Real-time submission |
| Slave Stream | Created automatically when tasks approach 32K | Not supported |

#### 3.4.3 EndGraph Marking Phase

```mermaid
sequenceDiagram
    participant App as Application
    participant ACL as ACL interface layer
    participant RT as Runtime interface layer
    participant Stream as Stream queue
    participant Model as Model container
    participant Notify as Notify synchronization object
    participant Device as Device management
    participant Driver as Driver layer
    participant HW as Hardware layer<br/>SQ/CQ

    Note over App,HW: EndGraph marking phase
    App->>ACL: aclmdlRIEndTask(modelRI, stream)
    ACL->>RT: rtEndGraph()
    
    %% AutoSplit path
    alt AutoSplit mode
        RT->>Stream: AllocTaskInfoOnAutoSplitStream()
        Stream->>Stream: Create a Notify object and apply for a notifyId
        Stream->>Model: endGraphNotify_ = Notify(notifyId)
        Stream->>Stream: Write SQE to sqeBuffer_
        Note right of Stream: Buffer the EndGraph SQE in the Host Buffer<br/>Deliver in batches at LoadComplete
        Stream-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else Non-AutoSplit mode
        RT->>Stream: AddEndGraphTask()
        Stream->>Stream: Create a Notify object and apply for a notifyId
        Stream->>Model: endGraphNotify_ = Notify(notifyId)
        Stream->>Device: SubmitTask(EndGraphTask)
        Device->>Driver: SubmitTask()
        Driver->>HW: Write to SQ<br/>MSG: END_GRAPH
        HW-->>Driver: CQE
        Driver-->>Device: success
        Device-->>Stream: success
        Stream-->>RT: EndGraph delivered successfully
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

#### 3.4.4 LoadComplete Phase

```mermaid
sequenceDiagram
    participant App as Application
    participant ACL as ACL interface layer
    participant RT as Runtime interface layer
    participant Model as Model container
    participant Stream as Stream queue
    participant SlaveStream as Slave Stream
    participant Device as Device management
    participant Driver as Driver layer
    participant HW as Hardware layer<br/>TS/SQ/CQ

    Note over App,HW: LoadComplete phase (key difference point)
    App->>ACL: aclmdlRIBuildEnd(modelRI)
    ACL->>RT: rtModelLoadComplete()
    RT->>Model: LoadComplete()
    Model->>Model: Check IsAutoSplitSq()
    
    %% AutoSplit path
    alt AutoSplit mode
        Note right of Model: Step 1: Allocate SQ/CQ for all Streams
        Model->>Model: BuildSqCqForAutoSplit()
        
        %% Iterate over all Streams (including Slave)
        loop Iterate over StreamList_ (including Master + Slave Streams)
            Model->>Stream: AllocAutoSplitSqAddr()
            Stream->>Device: AllocSqCqForAutoSplit()
            Device-->>Stream: sqId, sqAddr, sqDepth
            Stream->>Model: GetSqBaseAddr(), GetSqId()
            Model->>Model: modelSwitchInfo_[i].stream_id = streamId
            Model->>Model: modelSwitchInfo_[i].sq_id = sqId
        end
        
        %% Switch Streams to SQ in batches
        Note right of Model: Step 2: Switch Streams to SQ in batches
        Model->>Device: SqSwitchStreamBatch(modelSwitchInfo_, streamNum)
        Device->>Driver: SqSwitchStreamBatch(deviceId, info, num)
        Driver->>HW: MSG: SQ_SWITCH_STREAM_BATCH
        HW-->>Driver: success
        Driver-->>Device: success
        
        %% Send SQEs
        Note right of Model: Step 3: Deliver SQEs to the device SQ in batches
        Model->>Model: SendSqe()
        Model->>Device: Iterate over StreamList_
        Device->>Driver: StreamTaskFill(deviceId, streamId, sqAddr, sqeBuffer, sqeNum)
        Driver->>HW: Write to SQ in batches<br/>MSG: SQE_BATCH
        HW-->>Driver: CQE_BATCH
        Driver-->>Device: RT_ERROR_NONE
        
        %% Bind Streams to the Model
        Note right of Model: Step 4: Bind Streams to the Model (hardware side)
        loop Iterate over StreamList_
            Model->>Device: EnterBindStream(stm, streamFlag)
            Device->>Driver: SubmitTask(ModelMaintainceTask)
            Driver->>HW: MSG: MMT_STREAM_ADD
            HW-->>Driver: CQE
            Model->>Stream: SetIsTsBind(true)
        end
        
        %% Configure the SQ Tail
        Note right of Model: Step 5: Configure the SQ Tail pointer
        Model->>Model: ConfigSqTail()
        Model->>Device: SetSqTail(deviceId, tsId, sqId, sqTailPos)
        Device->>Driver: SetSqTail()
        Driver->>HW: MSG: SQ_TAIL_UPDATE
        HW-->>Driver: success
        
        Model->>Model: isModelComplete_=true
        Model-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else Non-AutoSplit mode
        Note right of Model: Iterate over StreamList_ and deliver in batches directly
        Model->>Model: SendSqe()
        Model->>Device: Iterate over StreamList_
        Device->>Driver: StreamTaskFill(deviceId, streamId, sqAddr, sqeBuffer, sqeNum)
        Driver->>HW: Write to SQ in batches<br/>MSG: SQE_BATCH<br/>DATA: [SQE1, SQE2, ...]
        HW-->>Driver: CQE_BATCH
        Driver-->>Device: RT_ERROR_NONE
        Model->>Device: ConfigSqTail()
        Device->>Driver: SetSqTail(deviceId, tsId, sqId, sqTailPos)
        Driver->>HW: Configure SQ Tail<br/>MSG: SQ_TAIL_UPDATE
        HW-->>Driver: success
        Driver-->>Device: success
        Device-->>Model: success
        Model->>Model: isModelComplete_=true
        Model-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

**Difference description**:
| Comparison item | AutoSplit mode | Non-AutoSplit mode |
|--------|----------------|-------------------|
| SQ/CQ allocation | Allocated dynamically at LoadComplete | Already allocated at Stream creation |
| Stream switching | Batch switching with SqSwitchStreamBatch | No switching needed |
| Hardware binding | Establish hardware relationships only at LoadComplete | Already established at bind time |
| Slave Stream | Must handle all Master + Slave | Handle only bound Streams |

#### 3.4.5 Model Execution Phase

```mermaid
sequenceDiagram
    participant App as Application
    participant ACL as ACL interface layer
    participant RT as Runtime interface layer
    participant Model as Model container
    participant Stream as Stream queue
    participant Notify as Notify synchronization object
    participant Device as Device management
    participant Driver as Driver layer
    participant HW as Hardware layer<br/>TS/SQ/CQ
    
    Note over App,HW: Phase: Model execution (unified flow for AutoSplit and non-AutoSplit)
    App->>ACL: aclmdlRIExecute(modelRI)
    ACL->>RT: rtModelExecute()
    RT->>Model: ExecuteSync()
    Model->>Model: SubmitExecuteTask()
    Model->>Device: SubmitTask(ModelExecuteTask)
    Device->>Driver: SubmitTask(exeTask)
    Driver->>HW: Write to SQ<br/>MSG: MODEL_EXECUTE<br/>DATA: modelId, headStreams
    Driver->>HW: Activate the TS hardware
    HW->>HW: The hardware scheduler reads SQEs from the SQ
    HW->>HW: AICore/AIVector performs the computation
    HW->>HW: Write to CQ<br/>MSG: CQE_COMPLETION<br/>DATA: taskId, errorCode
    HW-->>Driver: CQE (execution complete)
    Driver-->>Device: completion event
    Device-->>Notify: Trigger endGraphNotify_
    Notify->>Notify: Notify::Signal()
    Model->>Notify: NtyWait(endGraphNotify_, stream)
    Notify-->>Model: wait success
    Model->>Stream: Synchronize()
    Stream->>Device: StreamSync()
    Device->>Driver: GetCqHead()
    Driver->>HW: Read CQ<br/>MSG: CQ_POLL
    HW-->>Driver: CQ status
    Driver-->>Device: all completed
    Device-->>Stream: sync success
    Stream-->>Model: execution done
    Model-->>RT: success
    RT-->>ACL: success
    ACL-->>App: ACL_SUCCESS
```

**Note**: In the model execution phase, the AutoSplit and non-AutoSplit flows are unified. The difference lies in the SQE source:
- AutoSplit: SQEs are already delivered from the Host Buffer to the device SQ in batches at LoadComplete
- Non-AutoSplit: SQEs are already written directly to the device SQ at task submission

#### 3.4.6 Model Destruction Phase

```mermaid
sequenceDiagram
    participant App as Application
    participant ACL as ACL interface layer
    participant RT as Runtime interface layer
    participant Model as Model container
    participant Stream as Master Stream
    participant SlaveStream as Slave Stream
    participant Notify as Notify synchronization object
    participant Device as Device management
    participant Driver as Driver layer
    participant HW as Hardware layer<br/>SQ/CQ

    Note over App,HW: Model destruction phase
    App->>ACL: aclmdlRIDestroy(modelRI)
    ACL->>RT: rtModelDestroy()
    RT->>Model: TearDown()
    
    %% AutoSplit path
    alt AutoSplit mode
        Note right of Model: Must unbind all Slave Streams first
        Model->>Stream: GetAutoSplitCtx()
        Stream-->>Model: autoSplitCtx->slaveStreams
        loop Iterate over Slave Streams
            Model->>SlaveStream: UnbindStream(slaveStream)
            SlaveStream->>Device: ModelUnBindTaskSubmit()
            Device-->>SlaveStream: Unbind succeeded
        end
        Model->>Stream: UnbindStream(masterStream)
        Model->>Notify: DELETE_O(endGraphNotify_)
        Model->>Model: ClearMemory()
        Model->>Device: SubmitTask(ModelDestroyTask)
        Device->>Driver: SubmitTask()
        Driver->>HW: MSG: MODEL_DESTROY
        HW-->>Driver: CQE
        Model-->>RT: destroyed
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else Non-AutoSplit mode
        Model->>Notify: DELETE_O(endGraphNotify_)
        Model->>Model: ClearMemory()
        Model->>Device: SubmitTask(ModelDestroyTask)
        Device->>Driver: SubmitTask()
        Driver->>HW: Write to SQ<br/>MSG: MODEL_DESTROY
        HW-->>Driver: CQE
        Driver-->>Device: destroyed
        Device-->>Model: destroyed
        Model-->>RT: destroyed
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

## 4. Detailed Design

### 4.1 Core Flows

#### Model Creation and Initialization Flow

```mermaid
flowchart TD
    A["The user calls aclmdlRIBuildBegin()"] --> B["Create a Model object"]
    B --> C["Initialize basic attributes<br/>modelId, name"]
    C --> D["Create core management objects"]
    D --> E["Allocate a LabelAllocator<br/>For control flow jumps"]
    D --> F["Create a Notifier<br/>For execution completion notification"]
    E --> H["Prepare argLoaderRecord_<br/>Parameter handle management"]
    F --> H
    H --> I["Model object ready<br/>"]
    
    style A fill:#e1f5ff
    style I fill:#c8e6c9
```

**Flow description**:
1. The user initiates a model creation request through the ACL interface
2. Runtime creates a Model object and allocates a unique modelId
3. Initialize the Label allocator to support later branch jump control
4. Create a Notifier object for the notification mechanism after model execution completes
5. Allocate device-side memory to store model metadata
6. Prepare the parameter handle record table to manage task parameter memory

#### Stream Binding Flow

```mermaid
flowchart TD
    A["The user calls aclmdlRIBindStream()"] --> B["Check the Stream state"]
    B --> C{"Is the Stream already bound?"}
    C -->|Bound| D["Return an error<br/>Cannot bind repeatedly"]
    C -->|Not bound| J{"Is AutoSplit enabled for the Model?"}
    
    %% AutoSplit path
    J -->|Yes, AutoSplit mode| E1["Add to the streams_ list of the Model<br/>Runtime-side binding only"]
    E1 --> F1{"Is it a head Stream?"}
    F1 -->|Yes| G1["Add to headStreams_<br/>As the model execution start point"]
    F1 -->|No| H1["Add only to streams_<br/>Normal execution stream"]
    G1 --> I1["Establish a bidirectional reference between model and stream"]
    H1 --> I1
    I1 --> O1["Binding complete (software side)<br/>Establish hardware relationships at LoadComplete"]
    
    %% Non-AutoSplit path
    J -->|No, non-AutoSplit mode| E2["Add to the streams_ list of the Model"]
    E2 --> F2{"Is it a head Stream?"}
    F2 -->|Yes| G2["Add to headStreams_<br/>As the model execution start point"]
    F2 -->|No| H2["Add only to streams_<br/>Normal execution stream"]
    G2 --> I2["Establish a bidirectional reference between model and stream"]
    H2 --> I2
    I2 --> K2["Create a maintenance task<br/>ModelMaintainceTask"]
    K2 --> L2["Submit the task to the device"]
    L2 --> M2["The hardware confirms the binding<br/>Return a CQE"]
    M2 --> O2["Binding complete<br/>You can start submitting tasks"]
    
    style A fill:#e1f5ff
    style D fill:#ffcdd2
    style O1 fill:#fff3e0
    style O2 fill:#c8e6c9
```

**Flow description**:

| Step | AutoSplit mode | Non-AutoSplit mode |
|------|----------------|-------------------|
| 1 | The user requests to bind a Stream to the Model | The user requests to bind a Stream to the Model |
| 2 | Check the Stream state to prevent repeated binding | Check the Stream state to prevent repeated binding |
| 3 | Add to the streams_ list on the Runtime side only | Add to the streams_ list |
| 4 | Determine whether it is a head Stream | Determine whether it is a head Stream |
| 5 | Establish a bidirectional reference | Establish a bidirectional reference |
| 6 | **Do not submit hardware tasks immediately** | Create a maintenance task and notify the hardware |
| 7 | **Wait for LoadComplete** | Submit the task to the device, and the hardware returns a CQE |
| 8 | Binding complete (software side) | Binding complete, and you can start submitting tasks |

**Key difference**: In AutoSplit mode, Stream binding completes only the software-side record. The hardware binding is delayed until the LoadComplete phase. This approach enables more flexible task queue management.

#### Task Submission Flow

```mermaid
flowchart TD
    A["The user calls rtKernelLaunch()"] --> B["Get the target Stream"]
    B --> J{"Is AutoSplit enabled for the Stream?"}
    
    %% AutoSplit path
    J -->|Yes, AutoSplit mode| E1["Get the AutoSplitSqContext"]
    E1 --> F1{"Check curStreamSqeCount + sqeNum > HOST_SQ_MAX_COUNT?"}
    
    %% Insufficient capacity, create a Slave Stream
    F1 -->|Yes, insufficient capacity| G1["Create an AutoSplit Slave Stream"]
    G1 --> H1["SlaveStream.SetupForAutoSplit()"]
    H1 --> I1["Allocate new SQ/CQ"]
    I1 --> K1["Add to the slaveStreams list"]
    K1 --> L1["CondStreamActive(slave, prevStream)"]
    L1 --> M1["Use the currently active Stream (Master or Slave)"]
    
    %% Sufficient capacity
    F1 -->|No, sufficient capacity| M1["Use the current active Stream"]
    
    M1 --> N1["AllocTaskInfoOnAutoSplitStream()"]
    N1 --> O1["curStreamSqeCount += sqeNum"]
    O1 --> P1["Write SQE to sqeBuffer_<br/>(Host memory)"]
    P1 --> Q1["Task allocation complete<br/>Wait for batch delivery at LoadComplete"]
    
    %% Non-AutoSplit path
    J -->|No, non-AutoSplit mode| E2["AllocTask()"]
    E2 --> F2["Record to delayRecycleTaskid_"]
    F2 --> G2["Write SQE directly to the device SQ"]
    G2 --> Q2["Real-time task submission complete"]
    
    style A fill:#e1f5ff
    style Q1 fill:#fff3e0
    style Q2 fill:#c8e6c9
    style G1 fill:#e8f5e9
```

**Flow description**:

| Comparison item | AutoSplit mode | Non-AutoSplit mode |
|--------|----------------|-------------------|
| Capacity check | Check whether curStreamSqeCount approaches 32K | No capacity limit check |
| Slave creation | Create a Slave Stream automatically to expand capacity | Not supported |
| SQE storage | Write to the Host sqeBuffer_ | Write directly to the device SQ |
| Submission timing | Batch delivery at LoadComplete | Real-time submission |

**Key mechanism**:
- `HOST_SQ_MAX_COUNT = 32K`: Maximum capacity of the Host SQE buffer
- `AutoSplitSqContext`: Maintains curStreamSqeCount and the slaveStreams list
- `Slave Stream`: Created automatically when the task count approaches 32K to achieve unlimited queue depth

#### EndGraph Marking Flow

```mermaid
flowchart TD
    A["The user calls aclmdlRIEndTask()"] --> B["Create an EndGraph task"]
    B --> C["Generate a Notify object<br/>endGraphNotify_"]
    C --> D["Apply for a NotifyId<br/>Hardware completion notification identifier"]
    
    D --> J{"Is AutoSplit enabled for the Stream?"}
    
    %% AutoSplit path
    J -->|Yes, AutoSplit mode| E1["Write the EndGraph SQE to sqeBuffer_<br/>(Host memory)"]
    E1 --> F1["EndGraph SQE buffered successfully<br/>Wait for batch delivery at LoadComplete"]
    
    %% Non-AutoSplit path
    J -->|No, non-AutoSplit mode| E2["Write the EndGraph task directly to the SQ"]
    E2 --> F2["EndGraph delivered successfully"]
    
    style A fill:#e1f5ff
    style F1 fill:#fff3e0
    style F2 fill:#c8e6c9
```

**Flow description**:

| Step | AutoSplit mode | Non-AutoSplit mode |
|------|----------------|-------------------|
| 1 | The user marks the end of task delivery | The user marks the end of task delivery |
| 2 | Create an EndGraph task | Create an EndGraph task |
| 3 | Create a Notify object and apply for a NotifyId | Create a Notify object and apply for a NotifyId |
| 4 | **Write the SQE to the Host Buffer** | Write the EndGraph task to the SQ |
| 5 | **Wait for batch delivery at LoadComplete** | Delivery succeeds immediately |
| 6 | Trigger the Notify Signal during hardware execution | Trigger the Notify Signal during hardware execution |

#### Model LoadComplete Flow

```mermaid
flowchart TD
    A["The user calls aclmdlRIBuildEnd()"] --> B["Trigger LoadComplete"]
    
    B --> C{"Is AutoSplitSq enabled?"}
    
    %% AutoSplit path (detailed flow)
    C -->|Yes| D1["BuildSqCqForAutoSplit()"]
    D1 --> E1["Iterate over StreamList_<br/>(including Master + Slave Streams)"]
    E1 --> F1["AllocAutoSplitSqAddr()<br/>Allocate SQ/CQ for each Stream"]
    F1 --> G1["Build modelSwitchInfo_<br/>Record stream_id, sq_id, sq_depth"]
    G1 --> H1["SqSwitchStreamBatch()<br/>Switch Streams to SQ in batches"]
    H1 --> I1["SendSqe()<br/>Deliver SQEs to the device SQ in batches"]
    I1 --> J1["Iterate over StreamList_ and run EnterBindStream()<br/>Establish hardware binding relationships"]
    J1 --> K1["ConfigSqTail()<br/>Configure the SQ Tail pointer"]
    K1 --> L1["SetIsTsBind(true)<br/>Mark the Stream as bound to the TS"]
    L1 --> M1["isModelComplete_=true"]
    M1 --> P["Model loading complete<br/>You can execute the model"]
    
    %% Non-AutoSplit path
    C -->|No| D2["Iterate over the StreamList_ of the Model"]
    D2 --> E2["Deliver a maintenance task for each Stream"]
    E2 --> G2["Deliver SQEs to the device SQ"]
    G2 --> I2["Record the SQ Tail"]
    I2 --> M2["isModelComplete_=true"]
    M2 --> P
    
    style A fill:#e1f5ff
    style P fill:#c8e6c9
```

**Flow description**:

| Step | AutoSplit mode | Non-AutoSplit mode |
|------|----------------|-------------------|
| 1 | BuildSqCqForAutoSplit() | Iterate over StreamList_ directly |
| 2 | Allocate SQ/CQ for all Streams (including Slave) | SQ/CQ is already allocated at creation |
| 3 | Build modelSwitchInfo_ | Not needed |
| 4 | Batch switching with SqSwitchStreamBatch | Not needed |
| 5 | Deliver SQEs in batches with SendSqe | Deliver SQEs |
| 6 | **Establish hardware binding with EnterBindStream** | **Hardware binding already established** |
| 7 | SQ Tail |Configure SQ Tail |
| 8 | SetIsTsBind(true) | Not needed |
| 9 | isModelComplete_=true | isModelComplete_=true |

**Key difference**: In AutoSplit mode, LoadComplete requires:
1. Dynamically allocate SQ/CQ resources
2. Switch Streams to SQ in batches
3. Establish hardware binding relationships (EnterBindStream)
4. Mark the Stream as bound to the TS (SetIsTsBind)

#### Model Execution Flow

```mermaid
flowchart TD
    A["The user calls aclmdlRIExecute()"] --> B["Trigger model execution"]
    
    B --> D["Get the execution stream<br/>(Use the default or specified Stream)"]
    D --> E["Check the model state"]
    
    E --> F{"Is the model LoadComplete?"}
    F -->|Not complete| G["Return an error<br/>The model is not ready"]
    F -->|Complete| H["Create an ExecuteTask"]
    
    H --> J["Submit the ExecuteTask to the device"]
    
    J --> K["Write to SQ: MODEL_EXECUTE"]
    K --> L["The hardware receives the execution instruction"]
    L --> M["Activate headStreams_<br/>Start from the entry Stream"]
    
    M --> N["The hardware scheduler reads SQEs from the SQ"]
    N --> O["Execute compute tasks one by one"]
    
    O --> P["Reach the EndGraph task"]
    P --> Q["Trigger Notify Signal"]
    Q --> S["The Host side waits for completion"]
    S --> T["Call NtyWait to wait for the Notify"]
    T --> U["Wait for the hardware to return a completion signal"]
    
    U --> V{"Is the completion signal received?"}
    V -->|Success| W["Stream synchronization complete"]
    V -->|Timeout| X["Return a timeout error"]
    
    W --> Y["Poll the CQ state"]
    Y --> Z["Confirm that all tasks are complete"]
    Z --> AA["Model execution complete<br/>Return success"]
    
    style A fill:#e1f5ff
    style G fill:#ffcdd2
    style X fill:#ffcdd2
    style AA fill:#c8e6c9
```

**Flow description**:

| Step | Description | Difference between AutoSplit and non-AutoSplit |
|------|------|------------------------------|
| 1 | The user calls Execute to trigger model execution | No difference |
| 2 | Prepare the execution environment and get the execution Stream | No difference |
| 3 | Check the model state to ensure LoadComplete is finished | No difference |
| 4 | Create an ExecuteTask and set execution parameters | No difference |
| 5 | Submit the ExecuteTask to the device and write it to the SQ | No difference |
| 6 | The hardware TS receives the execution instruction and activates headStreams_ | No difference |
| 7 | **The TS reads SQEs from the SQ** | **SQE source difference** |
| 8 | AICore/AIVector executes compute tasks | No difference |
| 9 | Reach the EndGraph task and trigger Notify Signal | No difference |
| 10 | The Host side waits for completion (NtyWait) | No difference |
| 11 | After receiving the completion signal, poll the CQ state | No difference |
| 12 | Confirm that all tasks are complete and return success | No difference |

**SQE source difference description**:
- **AutoSplit mode**: SQEs are already delivered from the Host sqeBuffer_ to the device SQ in batches during LoadComplete
  - Write to the Host Buffer at task submission (delayed submission)
  - Deliver all SQEs in one batch at LoadComplete
  - Support unlimited queue depth (Slave Stream expansion)
  
- **Non-AutoSplit mode**: SQEs are already written directly to the device SQ at task submission
  - Write directly to the device SQ at task submission (real-time submission)
  - Deliver immediately at EndGraph marking
  - Fixed queue depth

**Unified execution phase**: In either mode, all SQEs reside in the device SQ at execution time. The hardware TS reads from the SQ and executes directly. The flow is completely the same.

#### Label Control Flow Setup Flow

```mermaid
flowchart TD
    A["The user creates a Label"] --> B["Apply to the Model for a LabelId"]
    B --> C["The Model allocates a unique LabelId"]
    C --> D["Record to labelMap_<br/>LabelId → Label object"]
    
    D --> E["Bind the Label to the Model"]
    E --> F["Set the Stream that contains the Label"]
    
    F --> G["The user calls Label::Set()"]
    G --> H["Set the jump point on the Stream"]
    H --> I["Record the current position to devDstAddr_<br/>Hardware jump target address"]
    I --> J["Generate a SetLabel SQE"]
    J --> K["Write the SQE to the SQ"]
    K --> L["Jump point setup complete"]
    
    style A fill:#e1f5ff
    style L fill:#c8e6c9
```

**Flow description**:
1. The user creates a Label and applies to the Model for a unique LabelId
2. The Model allocates an ID through the LabelAllocator and records the mapping
3. The Label binds to the Model and the Stream
4. The user calls Label::Set to set the jump target point on the Stream
5. Record the current position to the device-side address (devDstAddr_)
6. Generate a SetLabel SQE and write it to the Stream cache
7. The jump point setup completes, and the Label waits for later jumps

#### Label Control Flow Jump Flow

```mermaid
flowchart TD
    A["The user calls LabelSwitch"] --> B["Prepare the jump instruction"]
    B --> C["Get the target Label information"]
    
    C --> D["Read devDstAddr_ of the Label<br/>Target jump address"]
    D --> E["Generate a LabelSwitch SQE (the SQE contains the target address)"]
    
    E --> F["Write to the SQ of the current Stream"]
    F --> G["The hardware reaches the Switch operation"]
    G--> H["Jump to the target Stream"]
    H --> I["Jump complete"]
    
    style A fill:#e1f5ff
```

**Flow description**:
1. The user calls the LabelSwitch interface to initiate a jump instruction
2. Get the device-side address of the target Label (devDstAddr_)
3. Generate a LabelSwitch SQE that contains the target jump address
4. Write to the SQ of the current Stream
5. The hardware TS reaches the Switch operation and jumps to the target position

#### Model Destruction Flow

```mermaid
flowchart TD
    A["The user calls aclmdlRIDestroy()"] --> C["Release Notify resources"]

    C --> D["Delete endGraphNotify_"]
    D --> E["Release device memory"]
    
    E --> F["Clean up argLoaderRecord_<br/>Release parameter handles"]
    F --> G["Clean up dmaAddrRecord_<br/>Release DMA addresses"]
    G --> H["Unbind all Labels"]
    
    H --> I["Iterate over labelMap_<br/>Remove the relationship between Label and Model"]
    I --> J["Release the LabelAllocator"]
    J --> K["Create a destruction task"]
    
    K --> L["Submit ModelDestroyTask"]
    L --> M["Notify the hardware to destroy the model"]
    M --> N["The hardware confirms the destruction<br/>Return a CQE"]
    
    N --> O["Clean up the Model object"]
    O --> P["Remove the Model from the Context"]
    P --> Q["Model destruction complete"]
    
    style A fill:#e1f5ff
    style Q fill:#c8e6c9
```

**Flow description**:
1. The user calls Destroy to trigger model destruction
2. Release Notify resources and delete endGraphNotify_
3. Release device memory and clean up parameter handle records
4. Release DMA address records
5. Unbind all Labels and remove their relationships with the Model
6. Release LabelAllocator resources
7. Create a destruction task and notify the hardware to destroy the model
8. The hardware confirms the destruction and returns a CQE
9. Clean up the Model object and remove it from the Context
10. Model destruction completes, and all resources are released

### 4.2 Core Mechanism Details

#### Model Container Management Mechanism

**Design concept**: Model is the container of the compute graph. It uniformly manages all bound Streams and Labels and implements batch task delivery and execution entry control.

```mermaid
graph TB
    subgraph ModelManagement["Model container management"]
        StreamBinding["Stream binding management<br/>streams_: all Streams<br/>headStreams_: entry Streams"]
        LabelMgmt["Label control flow management<br/>labelMap_: Label mappings<br/>labelAllocator_: ID allocation"]
        ArgMgmt["Parameter memory management<br/>argLoaderRecord_: parameter handles"]
        ExecMgmt["Execution control<br/>endGraphNotify_: completion notification<br/>isModelComplete_: state flag"]
    end
    
    Model["Model container"]
    
    Model --> StreamBinding
    Model --> LabelMgmt
    Model --> ArgMgmt
    Model --> ExecMgmt
    
    StreamBinding -->|"Batch delivery"| SQE["Batch SQE delivery<br/>StreamTaskFill"]
    StreamBinding -->|"Entry activation"| Head["Execution start point<br/>headStreams_"]
    
    LabelMgmt -->|"ID allocation"| LabelId["LabelId<br/>Unique identifier"]
    LabelMgmt -->|"Jump control"| Jump["Stream jump<br/>Cross-stream control"]
    
    ExecMgmt -->|"Completion notification"| Notify["Notify wait<br/>NtyWait"]
    ExecMgmt -->|"State check"| Ready["Readiness check<br/>LoadComplete"]
```

**Mechanism description**:
- **Stream binding management**: Maintains the list of all Streams, and headStreams_ serves as the execution start point
- **Label control flow management**: Allocates Label IDs and manages jump relationships
- **Parameter memory management**: Records task parameter handles to avoid repeated allocation
- **Execution control**: The Notify mechanism implements asynchronous waits, and state flags ensure execution order

#### Stream Task Queue Mechanism

**Design concept**: Stream acts as a task queue. It buffers SQEs and supports task reclaim and automatic SQ splitting.

```mermaid
graph TB
    subgraph StreamQueue["Stream task queue"]
        TaskCache["Task cache<br/>delayRecycleTaskid_<br/>Task ID list"]
        SQEBuffer["SQE buffer<br/>sqeBuffer_<br/>Task descriptors"]
        PosMap["Position mapping<br/>posToTaskIdMap_<br/>Position → task"]
        AutoSplit["Automatic splitting<br/>AutoSplitSqContext<br/>Master/Slave"]
    end
    
    Submit["Task submission"]
    
    Submit --> TaskCache
    TaskCache --> SQEBuffer
    SQEBuffer --> PosMap
    
    TaskCache -->|"Cached count"| Count["Task count<br/>curStreamSqeCount"]
    Count -->|"Exceeds 32K"| AutoSplit
    AutoSplit -->|"Create Slave"| Slave["Slave Stream"]
    AutoSplit -->|"Master management"| Master["Master Stream"]
    
    SQEBuffer -->|"Batch delivery"| Batch["LoadComplete<br/>Batch delivery"]
    PosMap -->|"Task reclaim"| Recycle["Task reclaim<br/>TaskReclaim"]
```

**Mechanism description**:
- **Task cache**: delayRecycleTaskid_ records task IDs and waits for batch delivery
- **SQE buffer**: sqeBuffer_ stores task descriptors and prepares them for writing to the hardware SQ
- **Position mapping**: posToTaskIdMap_ records the correspondence between SQE positions and tasks
- **Automatic splitting**: When tasks exceed 32K, automatically create a Slave Stream to expand capacity

#### Label Control Flow Jump Mechanism

**Design concept**: Label implements cross-Stream jumps and loop control. It performs hardware-level jumps through device-side addresses.

```mermaid
graph TB
    subgraph LabelAlloc["Label allocation"]
        Request["The user applies for a Label"]
        Alloc["The Model allocates an ID"]
        Record["Record to labelMap_"]
    end
    
    subgraph LabelSet["Label setup"]
        ChooseStream["Select the target Stream"]
        RecordPos["Record the current position"]
        DevAddr["Set devDstAddr_<br/>Device jump address"]
    end
    
    subgraph LabelGoto["Label jump"]
        GetAddr["Read devDstAddr_"]
        GenSQE["Generate a Label Switch SQE"]
        HWJump["Hardware jump execution"]
    end
    
    Request --> Alloc --> Record
    Record --> ChooseStream --> RecordPos --> DevAddr
    
    DevAddr --> GetAddr --> GenSQE --> HWJump
    
    HWJump -->|"Same Stream"| Loop["Loop control"]
    HWJump -->|"Cross Stream"| Switch["Inter-stream switching"]
    
    style Request fill:#e1f5ff
    style HWJump fill:#c8e6c9
```

**Mechanism description**:
- **Label allocation**: The Model allocates a unique ID through the LabelAllocator
- **Label setup**: Record the jump position on the target Stream and set the device-side address
- **Label jump**: Read the device address, generate a jump SQE, and let the hardware execute the jump
- **Control flow implementation**: Support loops (same Stream) and cross-Stream task switching

#### Notify Completion Notification Mechanism

**Design concept**: Notify implements hardware completion notification. The Host gets the execution result by waiting for the Notify.

```mermaid
sequenceDiagram
    participant Model as Model
    participant EndGraph as EndGraphTask
    participant Notify as endGraphNotify_
    participant Driver as Driver
    participant HW as Hardware TS
    
    %% EndGraph creates the Notify
    Model->>EndGraph: rtEndGraph(model, stream)
    EndGraph->>Notify: Create a Notify object
    Notify->>Driver: AllocNotifyId()
    Driver->>HW: Apply for a notifyId
    HW-->>Driver: notifyId
    Driver-->>Notify: notifyId
    Notify-->>Model: endGraphNotify_
    
    %% Write the EndGraph Task at execution
    Model->>EndGraph: Execute()
    EndGraph->>Driver: SubmitTask(EndGraphTask)
    Driver->>HW: SQE: END_GRAPH<br/>notifyId=notifyId_
    HW->>HW: Execute all preceding tasks
    HW->>HW: Execute the EndGraph Task
    HW->>HW: Signal Notify<br/>notifyId ← value++
    
    %% The Host waits for the Notify
    Model->>Notify: NtyWait(endGraphNotify_, stream)
    Notify->>Driver: Notify::Wait()
    Driver->>HW: Poll Notify Value<br/>MSG: NOTIFY_POLL
    HW-->>Driver: notifyValue
    Driver-->>Notify: value matched
    Notify-->>Model: wait success
    Model->>Model: Execution complete
```

**Mechanism description**:
- **Notify creation**: The EndGraph task applies for a NotifyId and binds it to the Model
- **Notify wait**: The Host polls the Notify Value through NtyWait
- **Notify trigger**: The hardware reaches EndGraph, signals the Notify, and updates the Value
- **Completion confirmation**: The Host detects a Value match and confirms that execution is complete

### 4.3 Module Responsibility Division

The Model module is divided into submodules by function, including the core container, task management, interface layer, and auxiliary tools. Each module has clear responsibilities and works together to complete full model lifecycle management.

#### Core Container Modules

| Module name | Core responsibility | Code location | Main functions |
|----------|----------|----------|----------|
| **Model core class** | Compute graph container that uniformly manages Stream/Label/Notify | `src/runtime/core/inc/model/model.hpp`<br/>`src/runtime/feature/model/model.cc` | • Bind/unbind Streams<br/>• Allocate/release Labels<br/>• Execute models synchronously/asynchronously<br/>• Deliver SQEs in batches<br/>• Manage argLoaderRecord |
| **Model C interface** | C-style API wrapper for external use | `src/runtime/api/api_c_model.cc` | • rtModelCreate<br/>• rtModelDestroy<br/>• rtModelBindStream<br/>• rtModelExecute<br/>• rtEndGraph<br/>• rtModelLoadComplete |

#### Task Management Modules

| Task type | Task responsibility | Code location | Trigger timing |
|----------|----------|----------|----------|
| **ModelExecuteTask** | Trigger model execution and activate headStreams | `src/runtime/core/src/task/task_info/model/model_execute_task.cc`<br/>`src/runtime/core/src/task/task_info/model/model_execute_task_v100.cc`<br/>`src/runtime/core/src/task/task_info/model/model_execute_task_v200_base.cc` | On Execute/ExecuteAsync calls |
| **ModelMaintainceTask** | Maintain the relationship between Stream and Model | `src/runtime/core/src/task/task_info/model/model_maintaince_task.cc`<br/>`src/runtime/core/src/task/task_info/model/model_maintaince_task_v100.cc`<br/>`src/runtime/core/src/task/task_info/model/model_maintaince_task_v200_base.cc` | On BindStream/UnbindStream<br/>At LoadComplete |
| **ModelGraphTask** | Mark EndGraph and create a Notify | `src/runtime/core/src/task/task_info/model/model_graph_task.cc`<br/>`src/runtime/core/src/task/task_info/model/model_graph_task_v100.cc`<br/>`src/runtime/core/src/task/task_info/model/model_graph_task_v200_base.cc` | On rtEndGraph calls |

#### Auxiliary Tool Modules

| Tool module | Auxiliary responsibility | Code location | Service target |
|----------|----------|----------|----------|
| **LabelAllocator** | Label ID allocator | `src/runtime/core/inc/launch/label.hpp` | Model Label management |
| **Notify** | Hardware completion notification object | `src/runtime/core/inc/notify/notify.hpp`<br/>`src/runtime/core/src/notify/notify.cc` | EndGraph Notify |

#### Interface Adaptation Layer

| Adaptation layer | Adaptation responsibility | Code location | Service target |
|----------|----------|----------|----------|
| **ACL interface wrapper** | ACL → RT interface mapping | `src/acl/aclrt_impl/model_ri.cpp` | Calls to aclmdlRI interfaces by users |
| **API decorator** | API error handling decoration | `src/runtime/api/impl/api_decorator.cc`| ApiImpl call chain |


### 5 Key File Path Index

| Module category | File path | Core content |
|----------|----------|----------|
| **Model header file** | `src/runtime/core/inc/model/model.hpp` | Model class definition and data structures |
| **Model implementation** | `src/runtime/feature/model/model.cc` | Core Model implementation |
| **Model C interface** | `src/runtime/feature/model/model_c.cc` | C-style interface implementation |
| **Model Execute Task** | `src/runtime/core/src/task/task_info/model/model_execute_task.cc` | Execution task implementation |
| **Model Execute Task V100** | `src/runtime/core/src/task/task_info/model/model_execute_task_v100.cc` | V100 version adaptation |
| **Model Execute Task V200** | `src/runtime/core/src/task/task_info/model/model_execute_task_v200_base.cc` | V200 version adaptation |
| **Model Maintaince Task** | `src/runtime/core/src/task/task_info/model/model_maintaince_task.cc` | Maintenance task implementation |
| **ACL interface header file** | `include/external/acl/acl_rt.h` | External ACL interface definitions |
| **ACL interface implementation** | `src/acl/aclrt_impl/model_ri.cpp` | ACL interface implementation (aclmdlRI series) |
