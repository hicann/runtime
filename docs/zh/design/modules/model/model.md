# Model 模块架构

## 1. 模块概述

- **功能介绍**：Model 模块负责管理计算图的执行模型，包括模型创建、Stream 绑定、任务加载、模型执行和销毁等全生命周期管理。支持普通模型（Normal Model）和捕获模型（Capture Model）两种类型，通过 SQ/CQ 机制实现任务调度和执行。
- **设计目标**：
  - 提供统一的模型管理接口
  - 支持多 Stream 绑定和调度
  - 实现 Task 的批量提交和执行
  - 支持 Label 分配和跳转控制
  - 提供模型执行同步/异步模式

## 2. 使用场景与对外接口

### 2.1 使用场景

- **场景一**：创建并执行计算模型（使用 ACL 接口）
  ```cpp
  aclmdlRI modelRI;
  aclmdlRIBuildBegin(&modelRI, 0);  // 开始构建模型
  aclmdlRIBindStream(modelRI, stream, ACL_MODEL_STREAM_FLAG_HEAD);  // 绑定 Stream
  // 添加任务到 stream
  aclmdlRIEndTask(modelRI, stream);  // 标记任务结束
  aclmdlRIBuildEnd(modelRI, nullptr);  // 结束构建
  aclmdlRIExecute(modelRI, -1);  // 同步执行
  aclmdlRIDestroy(modelRI);  // 销毁模型
  ```

- **场景二**：异步模型执行（使用 ACL 接口）
  ```cpp
  aclmdlRIExecuteAsync(modelRI, execStream);
  // 通过 Stream 同步等待执行完成
  aclrtSynchronizeStream(execStream);
  ```

### 2.2 对外接口

| ACL 接口 | 文件位置 | 说明 |
|----------|----------|------|
| `aclmdlRIBuildBegin()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 创建模型（开始构建） |
| `aclmdlRIDestroy()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 销毁模型 |
| `aclmdlRIBindStream()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 绑定 Stream 到模型 |
| `aclmdlRIUnbindStream()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 解绑 Stream |
| `aclmdlRIExecute()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 同步执行模型 |
| `aclmdlRIExecuteAsync()` |`include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 异步执行模型 |
| `aclmdlRIBuildEnd()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 完成模型构建（LoadComplete） |
| `aclmdlRIEndTask()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 标记任务结束 |
| `aclmdlRISetName()` | `include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 设置模型名称 |
| `aclmdlRIAbort()` |`include/external/acl/acl_rt.h`<br>`src/acl/aclrt_impl/model_ri.cpp` | 终止模型执行 |

## 3. 架构总览

### 3.1 整体设计思路

Model 采用两层继承结构：基类 Model 提供普通模型的完整功能。每个 Model 绑定多个 Stream，通过 ModelExecuteTask 提交执行任务，使用 Notify 实现执行完成通知。

| 设计点 | 说明 |
|--------|------|
| **Model 作为任务容器** | 绑定多个 Stream，统一管理 SQE 下发和执行 |
| **Stream 作为任务队列** | 每个 Stream 维护 SQ 任务序列，支持任务回收 |
| **Label 实现控制流** | Model 分配 Label ID，Stream 记录跳转点 |
| **headStreams 机制** | 标记入口 Stream，Execute 时从这里激活执行 |
| **执行流机制** | 下发模型执行任务，激活模型流执行 |

### 3.2 架构分层图

```mermaid
graph TB
    subgraph ContextLayer["Context 运行环境"]
        Context["Context<br/>管理多个 Model"]
    end
    
    subgraph ModelLayer["Model 核心容器"]
        Model["Model<br/>计算图容器"]
        ModelStreams["streams_<br/>所有绑定的 Stream"]
        ModelHeadStreams["headStreams_<br/>入口 Stream"]
        ModelLabelMap["labelMap_<br/>Label ID → Label"]
        ModelLabelAllocator["labelAllocator_<br/>Label ID 分配器"]
        ModelArgRecord["argLoaderRecord_<br/>参数句柄记录"]
        
        Model --> ModelStreams
        Model --> ModelHeadStreams
        Model --> ModelLabelMap
        Model --> ModelLabelAllocator
        Model --> ModelArgRecord
    end
    
    subgraph StreamLayer["Stream 任务队列层"]
        Stream1["Stream 1<br/>任务队列"]
        Stream2["Stream 2<br/>任务队列"]
        Stream3["Stream 3<br/>Slave Stream"]
        
        StreamModel["Model*<br/>反向引用"]
        StreamTasks["delayRecycleTaskid_<br/>任务 ID 列表"]
        StreamSQ["SQ 队列<br/>任务执行队列"]
        StreamCQ["CQ 队列<br/>完成队列"]
        StreamAutoSplit["AutoSplitSqContext<br/>自动切分上下文"]
        
        Stream1 --> StreamModel
        Stream1 --> StreamTasks
        Stream1 --> StreamSQ
        Stream1 --> StreamCQ
        
        Stream3 --> StreamAutoSplit
    end
    
    subgraph LabelLayer["Label 控制流层"]
        Label1["Label 1"]
        Label2["Label 2"]
        
        LabelModel["Model*<br/>所属 Model"]
        LabelStream["Stream*<br/>所在 Stream"]
        LabelId["labelId_<br/>由 Model 分配"]
        LabelDevAddr["devDstAddr_<br/>设备跳转地址"]
        
        Label1 --> LabelModel
        Label1 --> LabelStream
        Label1 --> LabelId
        Label1 --> LabelDevAddr
    end
    
    subgraph TaskLayer["任务层"]
        TaskInfo["TaskInfo<br/>任务信息"]
        TaskId["id: 任务 ID"]
        TaskPos["pos: SQE 位置"]
        TaskStream["Stream*<br/>所属 Stream"]
        TaskUpdateFlag["updateFlag<br/>KEEP/UPDATE/DISABLE"]
        
        TaskInfo --> TaskId
        TaskInfo --> TaskPos
        TaskInfo --> TaskStream
        TaskInfo --> TaskUpdateFlag
    end
    
    %% 关系连接
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
    
    %% Stream 与 Label 的跳转关系
    LabelStream -.跳转.-> Stream2
    
    %% AutoSplitSq 关系
    StreamAutoSplit -.Master/Slave.-> Stream1
    StreamAutoSplit -.Slave.-> Stream3
```

### 3.3 Model-Stream-Label 三层架构关系

```mermaid
graph LR
    subgraph Layer1["第一层：Model 容器"]
        ModelContainer["Model<br/><b>核心职责</b><br/>1. 绑定多个 Stream<br/>2. 分配 Label ID<br/>3. 管理 SQE 下发<br/>4. 执行入口管理"]
    end
    
    subgraph Layer2["第二层：Stream 队列"]
        StreamQueue["Stream<br/><b>核心职责</b><br/>1. 维护 SQ 任务队列<br/>2. 记录任务 ID 列表<br/>3. 反向引用 Model<br/>4. 支持任务回收"]
    end
    
    subgraph Layer3["第三层：Label 控制流"]
        LabelCtrl["Label<br/><b>核心职责</b><br/>1. 设置跳转目标<br/>2. 实现流间跳转<br/>3. 控制流分支<br/>4. 循环控制"]
    end
    
    %% 层间关系
    ModelContainer -->|"绑定 (binds)"| StreamQueue
    ModelContainer -->|"分配 (allocates)"| LabelCtrl
    StreamQueue -->|"设置跳转点 (set)"| LabelCtrl
    LabelCtrl -->|"跳转 (goto)"| StreamQueue
    
    %% 反向引用
    StreamQueue -.反向引用.-> ModelContainer
    LabelCtrl -.反向引用.-> ModelContainer
```

### 3.4 核心模块交互图（含硬件交互）

本节通过时序图展示 AutoSplit与非 AutoSplit 两种场景的关键差异。

#### 3.4.1 Stream 绑定阶段

```mermaid
sequenceDiagram
    participant App as 应用程序
    participant ACL as ACL 接口层
    participant RT as Runtime 接口层
    participant Model as Model 容器
    participant Stream as Stream 队列
    participant Device as Device 设备管理
    participant Driver as Driver 驱动层
    participant HW as 硬件层<br/>TS/SQ/CQ

    Note over App,HW: Stream 绑定阶段
    App->>ACL: aclmdlRIBindStream(modelRI, stream)
    ACL->>RT: rtModelBindStream()
    RT->>RT: 检查 Model.IsAutoSplitSq()
    
    %% AutoSplit 路径
    alt AutoSplit 模式（支持无限队列深度）
        RT->>Model: ModelAddStream(mdl, stm, flag)
        Model->>Stream: SetModel(this)
        Model->>Model: streams_.push_back(stream)
        Note right of Model: 仅 Runtime 侧绑定<br/>不立即提交硬件任务
        Model-->>RT: 绑定成功（软件侧）
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else 非 AutoSplit 模式（传统GE模型）
        RT->>Model: BindStream(stream)
        Model->>Stream: SetModel(this)
        Stream-->>Model: bindFlag=true
        Model->>Device: SubmitTask(ModelMaintainceTask)
        Device->>Driver: SubmitTask(taskInfo)
        Driver->>HW: 写入 SQ<br/>MSG: MMT_STREAM_ADD
        HW-->>Driver: CQE (完成响应)
        Driver-->>Device: RT_ERROR_NONE
        Device-->>Model: 绑定成功
        Model-->>RT: streams_ 更新
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

**差异说明**：
| 对比项 | AutoSplit 模式 | 非 AutoSplit 模式 |
|--------|----------------|-------------------|
| 绑定时机 | 仅 Runtime 侧软件绑定 | 立即提交硬件绑定任务 |
| 硬件交互 | LoadComplete 时才建立硬件关系 | 绑定时立即写入 SQ |
| 任务队列 | Host SQE buffer（可扩展） | 固定硬件 SQ |

#### 3.4.2 任务提交阶段

```mermaid
sequenceDiagram
    participant App as 应用程序
    participant ACL as ACL 接口层
    participant RT as Runtime 接口层
    participant Stream as Stream 队列
    participant AutoSplitCtx as AutoSplitSqContext
    participant SlaveStream as Slave Stream
    participant Device as Device 设备管理
    participant HW as 硬件层<br/>SQ

    Note over App,HW: 任务提交阶段
    App->>ACL: rtKernelLaunch(kernel, stream)
    ACL->>RT: rtKernelLaunch()
    RT->>Stream: 检查 IsAutoSplitSq()
    
    %% AutoSplit 路径
    alt AutoSplit 模式
        RT->>Stream: StreamLock()
        Stream->>AutoSplitCtx: GetAutoSplitCtx()
        AutoSplitCtx-->>Stream: curStreamSqeCount, slaveStreams
        
        %% 检查容量是否需要创建 Slave Stream
        Stream->>Stream: 检查 curStreamSqeCount + sqeNum > HOST_SQ_MAX_COUNT
        alt 容量不足（接近32K）
            Stream->>RT: CreateAutoSplitSlaveStream(masterStream)
            RT->>SlaveStream: new SlaveStream()
            SlaveStream->>SlaveStream: SetupForAutoSplit()
            SlaveStream->>Device: AllocSqCqForAutoSplit()
            Device-->>SlaveStream: sqId, cqId
            Stream->>AutoSplitCtx: slaveStreams.push_back(slaveStream)
            Stream->>SlaveStream: CondStreamActive(slaveStream, prevStream)
            Note right of SlaveStream: 自动创建 Slave Stream<br/>扩展队列容量
        else 容量充足
            Note right of Stream: 使用当前 Master/Slave Stream
        end
        
        %% 分配任务并写入 Host Buffer
        Stream->>Stream: AllocTaskInfoOnAutoSplitStream()
        Stream->>AutoSplitCtx: curStreamSqeCount += sqeNum
        Stream->>Stream: SQE 写入 sqeBuffer_（Host内存）
        Note right of Stream: SQE暂存Host Buffer<br/>不直接写入硬件SQ
        Stream->>Stream: StreamUnLock()
        Stream-->>RT: TaskInfo
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else 非 AutoSplit 模式
        RT->>Stream: AllocTaskInfo()
        Stream->>Stream: 记录到 delayRecycleTaskid_
        Stream->>Stream: SQE 直接写入硬件 SQ
        Stream->>HW: SQE 直接写入硬件 SQ
        HW-->>Stream : sucess
        Stream-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

**差异说明**：
| 对比项 | AutoSplit 模式 | 非 AutoSplit 模式 |
|--------|----------------|-------------------|
| SQE存储位置 | Host sqeBuffer_ | 设备 SQ |
| 容量限制 | 无限制（Slave Stream 扩展） | 固定深度 |
| 提交时机 | LoadComplete 时批量下发 | 实时提交 |
| Slave Stream | 任务接近32K时自动创建 | 不支持 |

#### 3.4.3 EndGraph 标记阶段

```mermaid
sequenceDiagram
    participant App as 应用程序
    participant ACL as ACL 接口层
    participant RT as Runtime 接口层
    participant Stream as Stream 队列
    participant Model as Model 容器
    participant Notify as Notify 同步对象
    participant Device as Device 设备管理
    participant Driver as Driver 驱动层
    participant HW as 硬件层<br/>SQ/CQ

    Note over App,HW: EndGraph 标记阶段
    App->>ACL: aclmdlRIEndTask(modelRI, stream)
    ACL->>RT: rtEndGraph()
    
    %% AutoSplit 路径
    alt AutoSplit 模式
        RT->>Stream: AllocTaskInfoOnAutoSplitStream()
        Stream->>Stream: 创建 Notify对象，申请 notifyId
        Stream->>Model: endGraphNotify_ = Notify(notifyId)
        Stream->>Stream: SQE 写入 sqeBuffer_
        Note right of Stream: EndGraph SQE暂存Host Buffer<br/>待LoadComplete时批量下发
        Stream-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else 非 AutoSplit 模式
        RT->>Stream: AddEndGraphTask()
        Stream->>Stream: 创建 Notify对象，申请 notifyId
        Stream->>Model: endGraphNotify_ = Notify(notifyId)
        Stream->>Device: SubmitTask(EndGraphTask)
        Device->>Driver: SubmitTask()
        Driver->>HW: 写入 SQ<br/>MSG: END_GRAPH
        HW-->>Driver: CQE
        Driver-->>Device: success
        Device-->>Stream: success
        Stream-->>RT: EndGraph下发成功
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

#### 3.4.4 LoadComplete 阶段

```mermaid
sequenceDiagram
    participant App as 应用程序
    participant ACL as ACL 接口层
    participant RT as Runtime 接口层
    participant Model as Model 容器
    participant Stream as Stream 队列
    participant SlaveStream as Slave Stream
    participant Device as Device 设备管理
    participant Driver as Driver 驱动层
    participant HW as 硬件层<br/>TS/SQ/CQ

    Note over App,HW: LoadComplete 阶段（关键差异点）
    App->>ACL: aclmdlRIBuildEnd(modelRI)
    ACL->>RT: rtModelLoadComplete()
    RT->>Model: LoadComplete()
    Model->>Model: 检查 IsAutoSplitSq()
    
    %% AutoSplit 路径
    alt AutoSplit 模式
        Note right of Model: 步骤1: 为所有 Stream 分配 SQ/CQ
        Model->>Model: BuildSqCqForAutoSplit()
        
        %% 遍历所有 Stream（包含 Slave）
        loop 遍历 StreamList_（含 Master + Slave Streams）
            Model->>Stream: AllocAutoSplitSqAddr()
            Stream->>Device: AllocSqCqForAutoSplit()
            Device-->>Stream: sqId, sqAddr, sqDepth
            Stream->>Model: GetSqBaseAddr(), GetSqId()
            Model->>Model: modelSwitchInfo_[i].stream_id = streamId
            Model->>Model: modelSwitchInfo_[i].sq_id = sqId
        end
        
        %% 批量切换 Stream 到 SQ
        Note right of Model: 步骤2: 批量切换 Stream 到 SQ
        Model->>Device: SqSwitchStreamBatch(modelSwitchInfo_, streamNum)
        Device->>Driver: SqSwitchStreamBatch(deviceId, info, num)
        Driver->>HW: MSG: SQ_SWITCH_STREAM_BATCH
        HW-->>Driver: success
        Driver-->>Device: success
        
        %% 发送 SQE
        Note right of Model: 步骤3: 批量下发 SQE 到设备 SQ
        Model->>Model: SendSqe()
        Model->>Device: 遍历 StreamList_
        Device->>Driver: StreamTaskFill(deviceId, streamId, sqAddr, sqeBuffer, sqeNum)
        Driver->>HW: 批量写入 SQ<br/>MSG: SQE_BATCH
        HW-->>Driver: CQE_BATCH
        Driver-->>Device: RT_ERROR_NONE
        
        %% 绑定 Stream 到 Model
        Note right of Model: 步骤4: 绑定 Stream 到 Model（硬件侧）
        loop 遍历 StreamList_
            Model->>Device: EnterBindStream(stm, streamFlag)
            Device->>Driver: SubmitTask(ModelMaintainceTask)
            Driver->>HW: MSG: MMT_STREAM_ADD
            HW-->>Driver: CQE
            Model->>Stream: SetIsTsBind(true)
        end
        
        %% 配置 SQ Tail
        Note right of Model: 步骤5: 配置 SQ Tail 指针
        Model->>Model: ConfigSqTail()
        Model->>Device: SetSqTail(deviceId, tsId, sqId, sqTailPos)
        Device->>Driver: SetSqTail()
        Driver->>HW: MSG: SQ_TAIL_UPDATE
        HW-->>Driver: success
        
        Model->>Model: isModelComplete_=true
        Model-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    else 非 AutoSplit 模式
        Note right of Model: 直接遍历 StreamList_ 批量下发
        Model->>Model: SendSqe()
        Model->>Device: 遍历 StreamList_
        Device->>Driver: StreamTaskFill(deviceId, streamId, sqAddr, sqeBuffer, sqeNum)
        Driver->>HW: 批量写入 SQ<br/>MSG: SQE_BATCH<br/>DATA: [SQE1, SQE2, ...]
        HW-->>Driver: CQE_BATCH
        Driver-->>Device: RT_ERROR_NONE
        Model->>Device: ConfigSqTail()
        Device->>Driver: SetSqTail(deviceId, tsId, sqId, sqTailPos)
        Driver->>HW: 配置 SQ Tail<br/>MSG: SQ_TAIL_UPDATE
        HW-->>Driver: success
        Driver-->>Device: success
        Device-->>Model: success
        Model->>Model: isModelComplete_=true
        Model-->>RT: success
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

**差异说明**：
| 对比项 | AutoSplit 模式 | 非 AutoSplit 模式 |
|--------|----------------|-------------------|
| SQ/CQ 分配 | LoadComplete 时动态分配 | Stream 创建时已分配 |
| Stream 切换 | SqSwitchStreamBatch 批量切换 | 不需要切换 |
| 硬件绑定 | LoadComplete 时才建立硬件关系 | 绑定时已建立 |
| Slave Stream | 需处理所有 Master + Slave | 仅处理绑定的 Stream |

#### 3.4.5 模型执行阶段

```mermaid
sequenceDiagram
    participant App as 应用程序
    participant ACL as ACL 接口层
    participant RT as Runtime 接口层
    participant Model as Model 容器
    participant Stream as Stream 队列
    participant Notify as Notify 同步对象
    participant Device as Device 设备管理
    participant Driver as Driver 驱动层
    participant HW as 硬件层<br/>TS/SQ/CQ
    
    Note over App,HW: 阶段: Model 执行（AutoSplit与非 AutoSplit 统一流程）
    App->>ACL: aclmdlRIExecute(modelRI)
    ACL->>RT: rtModelExecute()
    RT->>Model: ExecuteSync()
    Model->>Model: SubmitExecuteTask()
    Model->>Device: SubmitTask(ModelExecuteTask)
    Device->>Driver: SubmitTask(exeTask)
    Driver->>HW: 写入 SQ<br/>MSG: MODEL_EXECUTE<br/>DATA: modelId, headStreams
    Driver->>HW: 激活 TS 硬件
    HW->>HW: 硬件调度器从 SQ 读取 SQE
    HW->>HW: AICore/AIVector 执行计算
    HW->>HW: 写入 CQ<br/>MSG: CQE_COMPLETION<br/>DATA: taskId, errorCode
    HW-->>Driver: CQE (执行完成)
    Driver-->>Device: completion event
    Device-->>Notify: 触发 endGraphNotify_
    Notify->>Notify: Notify::Signal()
    Model->>Notify: NtyWait(endGraphNotify_, stream)
    Notify-->>Model: wait success
    Model->>Stream: Synchronize()
    Stream->>Device: StreamSync()
    Device->>Driver: GetCqHead()
    Driver->>HW: 读取 CQ<br/>MSG: CQ_POLL
    HW-->>Driver: CQ status
    Driver-->>Device: all completed
    Device-->>Stream: sync success
    Stream-->>Model: execution done
    Model-->>RT: success
    RT-->>ACL: success
    ACL-->>App: ACL_SUCCESS
```

**说明**：模型执行阶段，AutoSplit 与非 AutoSplit 流程统一。差异在于 SQE 来源：
- AutoSplit：SQE 已在 LoadComplete 时从 Host Buffer 批量下发到设备 SQ
- 非 AutoSplit：SQE 在任务提交时已直接写入设备 SQ

#### 3.4.6 模型销毁阶段

```mermaid
sequenceDiagram
    participant App as 应用程序
    participant ACL as ACL 接口层
    participant RT as Runtime 接口层
    participant Model as Model 容器
    participant Stream as Master Stream
    participant SlaveStream as Slave Stream
    participant Notify as Notify 同步对象
    participant Device as Device 设备管理
    participant Driver as Driver 驱动层
    participant HW as 硬件层<br/>SQ/CQ

    Note over App,HW: 模型销毁阶段
    App->>ACL: aclmdlRIDestroy(modelRI)
    ACL->>RT: rtModelDestroy()
    RT->>Model: TearDown()
    
    %% AutoSplit 路径
    alt AutoSplit 模式
        Note right of Model: 需先解绑所有 Slave Streams
        Model->>Stream: GetAutoSplitCtx()
        Stream-->>Model: autoSplitCtx->slaveStreams
        loop 遍历 Slave Streams
            Model->>SlaveStream: UnbindStream(slaveStream)
            SlaveStream->>Device: ModelUnBindTaskSubmit()
            Device-->>SlaveStream: 解绑成功
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
    else 非 AutoSplit 模式
        Model->>Notify: DELETE_O(endGraphNotify_)
        Model->>Model: ClearMemory()
        Model->>Device: SubmitTask(ModelDestroyTask)
        Device->>Driver: SubmitTask()
        Driver->>HW: 写入 SQ<br/>MSG: MODEL_DESTROY
        HW-->>Driver: CQE
        Driver-->>Device: destroyed
        Device-->>Model: destroyed
        Model-->>RT: destroyed
        RT-->>ACL: success
        ACL-->>App: ACL_SUCCESS
    end
```

## 4. 详细设计

### 4.1 核心流程

#### 模型创建与初始化流程

```mermaid
flowchart TD
    A["用户调用 aclmdlRIBuildBegin()"] --> B["创建 Model 对象"]
    B --> C["初始化基本属性<br/>modelId, name"]
    C --> D["创建核心管理对象"]
    D --> E["分配 LabelAllocator<br/>用于控制流跳转"]
    D --> F["创建 Notifier<br/>用于执行完成通知"]
    E --> H["准备 argLoaderRecord_<br/>参数句柄管理"]
    F --> H
    H --> I["Model 对象就绪<br/>"]
    
    style A fill:#e1f5ff
    style I fill:#c8e6c9
```

**流程说明**：
1. 用户通过 ACL 接口发起模型创建请求
2. Runtime 创建 Model 对象，分配唯一的 modelId
3. 初始化 Label 分配器，支持后续的分支跳转控制
4. 创建 Notifier 对象，用于模型执行完成后的通知机制
5. 申请设备侧内存，用于存储模型元数据
6. 准备参数句柄记录表，管理任务的参数内存

#### Stream 绑定流程

```mermaid
flowchart TD
    A["用户调用 aclmdlRIBindStream()"] --> B["检查 Stream 状态"]
    B --> C{"Stream 是否已绑定?"}
    C -->|已绑定| D["返回错误<br/>不可重复绑定"]
    C -->|未绑定| J{"Model 是否启用 AutoSplit?"}
    
    %% AutoSplit 路径
    J -->|是 AutoSplit 模式| E1["添加到 Model 的 streams_ 列表<br/>仅 Runtime 侧绑定"]
    E1 --> F1{"是否为 head Stream?"}
    F1 -->|是| G1["添加到 headStreams_<br/>作为模型执行起点"]
    F1 -->|否| H1["仅添加到 streams_<br/>普通执行流"]
    G1 --> I1["建立 model、stream 双向引用关系"]
    H1 --> I1
    I1 --> O1["绑定完成（软件侧）<br/>等待 LoadComplete 时建立硬件关系"]
    
    %% 非 AutoSplit 路径
    J -->|否 非 AutoSplit 模式| E2["添加到 Model 的 streams_ 列表"]
    E2 --> F2{"是否为 head Stream?"}
    F2 -->|是| G2["添加到 headStreams_<br/>作为模型执行起点"]
    F2 -->|否| H2["仅添加到 streams_<br/>普通执行流"]
    G2 --> I2["建立 model、stream 双向引用关系"]
    H2 --> I2
    I2 --> K2["创建维护任务<br/>ModelMaintainceTask"]
    K2 --> L2["将任务提交到设备"]
    L2 --> M2["硬件确认绑定成功<br/>返回 CQE"]
    M2 --> O2["绑定完成<br/>可开始提交任务"]
    
    style A fill:#e1f5ff
    style D fill:#ffcdd2
    style O1 fill:#fff3e0
    style O2 fill:#c8e6c9
```

**流程说明**：

| 步骤 | AutoSplit 模式 | 非 AutoSplit 模式 |
|------|----------------|-------------------|
| 1 | 用户请求将 Stream 绑定到 Model | 用户请求将 Stream 绑定到 Model |
| 2 | 检查 Stream 状态，防止重复绑定 | 检查 Stream 状态，防止重复绑定 |
| 3 | 仅在 Runtime侧添加到 streams_列表 | 添加到 streams_列表 |
| 4 | 判断是否为 head Stream | 判断是否为 head Stream |
| 5 | 建立双向引用关系 | 建立双向引用关系 |
| 6 | **不立即提交硬件任务** | 创建维护任务，通知硬件 |
| 7 | **等待 LoadComplete** | 提交任务到设备，硬件返回 CQE |
| 8 | 绑定完成（软件侧） | 绑定完成，可开始提交任务 |

**关键差异**：AutoSplit模式下，Stream 绑定仅完成软件侧的记录，硬件绑定延迟到 LoadComplete 阶段执行，这样可以实现更灵活的任务队列管理。

#### 任务提交流程

```mermaid
flowchart TD
    A["用户调用 rtKernelLaunch()"] --> B["获取目标 Stream"]
    B --> J{"Stream 是否启用 AutoSplit?"}
    
    %% AutoSplit 路径
    J -->|是 AutoSplit 模式| E1["获取 AutoSplitSqContext"]
    E1 --> F1{"检查 curStreamSqeCount + sqeNum > HOST_SQ_MAX_COUNT?"}
    
    %% 容量不足，创建 Slave Stream
    F1 -->|是 容量不足| G1["创建 AutoSplit Slave Stream"]
    G1 --> H1["SlaveStream.SetupForAutoSplit()"]
    H1 --> I1["分配新的 SQ/CQ"]
    I1 --> K1["添加到 slaveStreams 列表"]
    K1 --> L1["CondStreamActive(slave, prevStream)"]
    L1 --> M1["使用当前活跃 Stream（Master 或 Slave）"]
    
    %% 容量充足
    F1 -->|否 容量充足| M1["使用当前活跃 Stream"]
    
    M1 --> N1["AllocTaskInfoOnAutoSplitStream()"]
    N1 --> O1["curStreamSqeCount += sqeNum"]
    O1 --> P1["SQE 写入 sqeBuffer_<br/>（Host内存）"]
    P1 --> Q1["任务分配完成<br/>等待 LoadComplete 批量下发"]
    
    %% 非 AutoSplit 路径
    J -->|否 非 AutoSplit 模式| E2["AllocTaskInfo()"]
    E2 --> F2["记录到 delayRecycleTaskid_"]
    F2 --> G2["SQE 直接写入设备 SQ"]
    G2 --> Q2["任务实时提交完成"]
    
    style A fill:#e1f5ff
    style Q1 fill:#fff3e0
    style Q2 fill:#c8e6c9
    style G1 fill:#e8f5e9
```

**流程说明**：

| 对比项 | AutoSplit 模式 | 非 AutoSplit 模式 |
|--------|----------------|-------------------|
| 容量检查 | 检查 curStreamSqeCount 是否接近32K | 无容量限制检查 |
| Slave创建 | 自动创建 Slave Stream 扩展容量 | 不支持 |
| SQE存储 | 写入 Host sqeBuffer_ | 直接写入设备 SQ |
| 提交时机 | LoadComplete 时批量下发 | 实时提交 |

**关键机制**：
- `HOST_SQ_MAX_COUNT = 32K`：Host SQE buffer 最大容量
- `AutoSplitSqContext`：维护 curStreamSqeCount 和 slaveStreams 列表
- `Slave Stream`：当任务数量接近32K时自动创建，实现无限队列深度

#### EndGraph 标记流程

```mermaid
flowchart TD
    A["用户调用 aclmdlRIEndTask()"] --> B["创建 EndGraph 任务"]
    B --> C["生成 Notify 对象<br/>endGraphNotify_"]
    C --> D["申请 NotifyId<br/>硬件完成通知标识"]
    
    D --> J{"Stream 是否启用 AutoSplit?"}
    
    %% AutoSplit 路径
    J -->|是 AutoSplit 模式| E1["将 EndGraph SQE 写入 sqeBuffer_<br/>（Host内存）"]
    E1 --> F1["EndGraph SQE暂存成功<br/>等待 LoadComplete 批量下发"]
    
    %% 非 AutoSplit 路径
    J -->|否 非 AutoSplit 模式| E2["将 EndGraph 任务直接写入 SQ"]
    E2 --> F2["EndGraph 下发成功"]
    
    style A fill:#e1f5ff
    style F1 fill:#fff3e0
    style F2 fill:#c8e6c9
```

**流程说明**：

| 步骤 | AutoSplit 模式 | 非 AutoSplit 模式 |
|------|----------------|-------------------|
| 1 | 用户标记任务下发结束 | 用户标记任务下发结束 |
| 2 | 创建 EndGraph 任务 | 创建 EndGraph 任务 |
| 3 | 创建 Notify 对象，申请 NotifyId | 创建 Notify 对象，申请 NotifyId |
| 4 | **SQE 写入 Host Buffer** | EndGraph 任务写入 SQ |
| 5 | **等待 LoadComplete 批量下发** | 立即下发成功 |
| 6 | 硬件执行时触发 Notify Signal | 硬件执行时触发 Notify Signal |

#### Model LoadComplete 流程

```mermaid
flowchart TD
    A["用户调用 aclmdlRIBuildEnd()"] --> B["触发 LoadComplete"]
    
    B --> C{"是否启用 AutoSplitSq?"}
    
    %% AutoSplit 路径（详细流程）
    C -->|是| D1["BuildSqCqForAutoSplit()"]
    D1 --> E1["遍历 StreamList_<br/>（含 Master + Slave Streams）"]
    E1 --> F1["AllocAutoSplitSqAddr()<br/>为每个 Stream 分配 SQ/CQ"]
    F1 --> G1["构建 modelSwitchInfo_<br/>记录 stream_id, sq_id, sq_depth"]
    G1 --> H1["SqSwitchStreamBatch()<br/>批量切换 Stream 到 SQ"]
    H1 --> I1["SendSqe()<br/>批量下发 SQE 到设备 SQ"]
    I1 --> J1["遍历 StreamList_ 执行 EnterBindStream()<br/>建立硬件绑定关系"]
    J1 --> K1["ConfigSqTail()<br/>配置 SQ Tail 指针"]
    K1 --> L1["SetIsTsBind(true)<br/>标记 Stream 已绑定到 TS"]
    L1 --> M1["isModelComplete_=true"]
    M1 --> P["模型加载完成<br/>可执行模型"]
    
    %% 非 AutoSplit 路径
    C -->|否| D2["遍历 Model 的 StreamList_"]
    D2 --> E2["每个 Stream下发mailtaince任务"]
    E2 --> G2["下发 SQE 到设备 SQ"]
    G2 --> I2["记录 SQ Tail"]
    I2 --> M2["isModelComplete_=true"]
    M2 --> P
    
    style A fill:#e1f5ff
    style P fill:#c8e6c9
```

**流程说明**：

| 步骤 | AutoSplit 模式 | 非 AutoSplit 模式 |
|------|----------------|-------------------|
| 1 | BuildSqCqForAutoSplit() | 直接遍历 StreamList_ |
| 2 | 为所有 Stream（含 Slave）分配 SQ/CQ | SQ/CQ 已在创建时分配 |
| 3 | 构建 modelSwitchInfo_ | 不需要 |
| 4 | SqSwitchStreamBatch 批量切换 | 不需要 |
| 5 | SendSqe 批量下发 SQE | 下发 SQE |
| 6 | **EnterBindStream 建立硬件绑定** | **已建立硬件绑定** |
| 7 | SQ Tail |配置 SQ Tail |
| 8 | SetIsTsBind(true) | 不需要 |
| 9 | isModelComplete_=true | isModelComplete_=true |

**关键差异**：AutoSplit 模式在 LoadComplete 时需要：
1. 动态分配 SQ/CQ 资源
2. 批量切换 Stream 到 SQ
3. 建立硬件绑定关系（EnterBindStream）
4. 标记 Stream 已绑定到 TS（SetIsTsBind）

#### 模型执行流程

```mermaid
flowchart TD
    A["用户调用 aclmdlRIExecute()"] --> B["触发模型执行"]
    
    B --> D["获取执行流<br/>(使用默认或指定 Stream)"]
    D --> E["检查模型状态"]
    
    E --> F{"模型是否 LoadComplete?"}
    F -->|未完成| G["返回错误<br/>模型未就绪"]
    F -->|已完成| H["创建 ExecuteTask"]
    
    H --> J["提交 ExecuteTask 到设备"]
    
    J --> K["写入 SQ: MODEL_EXECUTE"]
    K --> L["硬件接收到执行指令"]
    L --> M["激活 headStreams_<br/>从入口 Stream 开始"]
    
    M --> N["硬件调度器从 SQ 读取 SQE"]
    N --> O["逐个执行任务计算任务"]
    
    O --> P["执行到 EndGraph 任务"]
    P --> Q["触发 Notify Signal"]
    Q --> S["Host 端等待完成"]
    S --> T["调用 NtyWait 等待 Notify"]
    T --> U["等待硬件返回完成信号"]
    
    U --> V{"收到完成信号?"}
    V -->|成功| W["Stream 同步完成"]
    V -->|超时| X["返回超时错误"]
    
    W --> Y["轮询 CQ 状态"]
    Y --> Z["确认所有任务完成"]
    Z --> AA["模型执行完成<br/>返回成功"]
    
    style A fill:#e1f5ff
    style G fill:#ffcdd2
    style X fill:#ffcdd2
    style AA fill:#c8e6c9
```

**流程说明**：

| 步骤 | 说明 | AutoSplit 与非 AutoSplit 差异 |
|------|------|------------------------------|
| 1 | 用户调用 Execute，触发模型执行 | 无差异 |
| 2 | 准备执行环境，获取执行 Stream | 无差异 |
| 3 | 检查模型状态，确保 LoadComplete 已完成 | 无差异 |
| 4 | 创建 ExecuteTask，设置执行参数 | 无差异 |
| 5 | 提交 ExecuteTask 到设备，写入 SQ | 无差异 |
| 6 | 硬件 TS 接收执行指令，激活 headStreams_ | 无差异 |
| 7 | **TS 从 SQ 读取 SQE** | **SQE来源差异** |
| 8 | AICore/AIVector 执行计算任务 | 无差异 |
| 9 | 执行到 EndGraph 任务，触发 Notify Signal | 无差异 |
| 10 | Host 端等待完成（NtyWait） | 无差异 |
| 11 | 收到完成信号后，轮询 CQ 状态 | 无差异 |
| 12 | 确认所有任务完成，返回成功 | 无差异 |

**SQE来源差异说明**：
- **AutoSplit 模式**：SQE 已在 LoadComplete 阶段从 Host sqeBuffer_ 批量下发到设备 SQ
  - 任务提交时写入 Host Buffer（延迟提交）
  - LoadComplete 时一次性批量下发所有 SQE
  - 支持无限队列深度（Slave Stream 扩展）
  
- **非 AutoSplit 模式**：SQE 在任务提交时已直接写入设备 SQ
  - 任务提交时直接写入设备 SQ（实时提交）
  - EndGraph 标记时立即下发
  - 固定队列深度

**执行阶段统一**：无论哪种模式，执行时 SQE 已全部驻留在设备 SQ，硬件 TS 直接从 SQ 读取并执行，流程完全一致。

#### Label 控制流设置流程

```mermaid
flowchart TD
    A["用户创建 Label"] --> B["向 Model 申请 LabelId"]
    B --> C["Model 分配唯一 LabelId"]
    C --> D["记录到 labelMap_<br/>LabelId → Label 对象"]
    
    D --> E["Label 绑定到 Model"]
    E --> F["设置 Label 所在 Stream"]
    
    F --> G["用户调用 Label::Set()"]
    G --> H["在 Stream 上设置跳转点"]
    H --> I["记录当前位置到 devDstAddr_<br/>硬件跳转目标地址"]
    I --> J["生成 SetLabel SQE"]
    J --> K["SQE 写入 SQ"]
    K --> L["跳转点设置完成"]
    
    style A fill:#e1f5ff
    style L fill:#c8e6c9
```

**流程说明**：
1. 用户创建 Label，向 Model 申请唯一的 LabelId
2. Model 通过 LabelAllocator 分配 ID，记录映射关系
3. Label 绑定到 Model 和 Stream
4. 用户调用 Label::Set，在 Stream 上设置跳转目标点
5. 记录当前位置到设备侧地址（devDstAddr_）
6. 生成 SetLabel SQE，写入 Stream 缓存
7. 跳转点设置完成，等待后续跳转

#### Label 控制流跳转流程

```mermaid
flowchart TD
    A["用户调用LabelSwitch"] --> B["准备跳转指令"]
    B --> C["获取目标 Label 信息"]
    
    C --> D["读取 Label 的 devDstAddr_<br/>目标跳转地址"]
    D --> E["生成 LabelSwitch SQE（SQE 包含目标地址）"]
    
    E --> F["写入当前 Stream 的 SQ"]
    F --> G["硬件执行到Switch操作"]
    G--> H["跳转到目标Stream"]
    H --> I["跳转完成"]
    
    style A fill:#e1f5ff
```

**流程说明**：
1. 用户调用 LabelSwitch接口，发起跳转指令
2. 获取目标 Label 的设备侧地址（devDstAddr_）
3. 生成 LabelSwitch SQE，包含目标跳转地址
4. 写入当前 Stream 的 SQ
5. 硬件 TS 执行到 Switch操作 ，跳转到目标位置

#### 模型销毁流程

```mermaid
flowchart TD
    A["用户调用 aclmdlRIDestroy()"] --> C["释放 Notify 资源"]

    C --> D["删除 endGraphNotify_"]
    D --> E["释放设备内存"]
    
    E --> F["清理 argLoaderRecord_<br/>释放参数句柄"]
    F --> G["清理 dmaAddrRecord_<br/>释放 DMA 地址"]
    G --> H["解绑所有 Label"]
    
    H --> I["遍历 labelMap_<br/>解除 Label 与 Model 关系"]
    I --> J["释放 LabelAllocator"]
    J --> K["创建销毁任务"]
    
    K --> L["提交 ModelDestroyTask"]
    L --> M["通知硬件销毁模型"]
    M --> N["硬件确认销毁<br/>返回 CQE"]
    
    N --> O["清理 Model 对象"]
    O --> P["从 Context 移除 Model"]
    P --> Q["模型销毁完成"]
    
    style A fill:#e1f5ff
    style Q fill:#c8e6c9
```

**流程说明**：
1. 用户调用 Destroy，触发模型销毁
2. 释放 Notify 资源，删除 endGraphNotify_
3. 释放设备内存，清理参数句柄记录
4. 释放 DMA 地址记录
5. 解绑所有 Label，解除与 Model 的关系
6. 释放 LabelAllocator 资源
7. 创建销毁任务，通知硬件销毁模型
8. 硬件确认销毁，返回 CQE
9. 清理 Model 对象，从 Context 移除
10. 模型销毁完成，释放所有资源

### 4.2 核心机制详解

#### Model 容器管理机制

**设计思想**：Model 作为计算图的容器，统一管理所有绑定的 Stream 和 Label，实现任务批量下发和执行入口控制。

```mermaid
graph TB
    subgraph ModelManagement["Model 容器管理"]
        StreamBinding["Stream 绑定管理<br/>streams_: 所有 Stream<br/>headStreams_: 入口 Stream"]
        LabelMgmt["Label 控制流管理<br/>labelMap_: Label 映射<br/>labelAllocator_: ID 分配"]
        ArgMgmt["参数内存管理<br/>argLoaderRecord_: 参数句柄"]
        ExecMgmt["执行控制<br/>endGraphNotify_: 完成通知<br/>isModelComplete_: 状态标记"]
    end
    
    Model["Model 容器"]
    
    Model --> StreamBinding
    Model --> LabelMgmt
    Model --> ArgMgmt
    Model --> ExecMgmt
    
    StreamBinding -->|"批量下发"| SQE["SQE 批量下发<br/>StreamTaskFill"]
    StreamBinding -->|"入口激活"| Head["执行起点<br/>headStreams_"]
    
    LabelMgmt -->|"ID 分配"| LabelId["LabelId<br/>唯一标识"]
    LabelMgmt -->|"跳转控制"| Jump["Stream 跳转<br/>跨流控制"]
    
    ExecMgmt -->|"完成通知"| Notify["Notify 等待<br/>NtyWait"]
    ExecMgmt -->|"状态检查"| Ready["就绪检查<br/>LoadComplete"]
```

**机制说明**：
- **Stream 绑定管理**：维护所有 Stream 列表，headStreams_ 作为执行起点
- **Label 控制流管理**：分配 Label ID，管理跳转关系
- **参数内存管理**：记录任务参数句柄，避免重复分配
- **执行控制**：Notify 机制实现异步等待，状态标记确保执行顺序

#### Stream 任务队列机制

**设计思想**：Stream 作为任务队列，缓存 SQE，支持任务回收和自动 SQ 切分。

```mermaid
graph TB
    subgraph StreamQueue["Stream 任务队列"]
        TaskCache["任务缓存<br/>delayRecycleTaskid_<br/>任务 ID 列表"]
        SQEBuffer["SQE 缓冲<br/>sqeBuffer_<br/>任务描述符"]
        PosMap["位置映射<br/>posToTaskIdMap_<br/>位置→任务"]
        AutoSplit["自动切分<br/>AutoSplitSqContext<br/>Master/Slave"]
    end
    
    Submit["任务提交"]
    
    Submit --> TaskCache
    TaskCache --> SQEBuffer
    SQEBuffer --> PosMap
    
    TaskCache -->|"缓存数量"| Count["任务计数<br/>curStreamSqeCount"]
    Count -->|"超过 32K"| AutoSplit
    AutoSplit -->|"创建 Slave"| Slave["Slave Stream"]
    AutoSplit -->|"Master 管理"| Master["Master Stream"]
    
    SQEBuffer -->|"批量下发"| Batch["LoadComplete<br/>批量下发"]
    PosMap -->|"任务回收"| Recycle["任务回收<br/>TaskReclaim"]
```

**机制说明**：
- **任务缓存**：delayRecycleTaskid_ 记录任务 ID，等待批量下发
- **SQE 缓冲**：sqeBuffer_ 存储任务描述符，准备写入硬件 SQ
- **位置映射**：posToTaskIdMap_ 记录 SQE 位置与任务的对应关系
- **自动切分**：超过 32K 任务时自动创建 Slave Stream 扩展容量

#### Label 控制流跳转机制

**设计思想**：Label 实现跨 Stream 跳转和循环控制，通过设备侧地址实现硬件级跳转。

```mermaid
graph TB
    subgraph LabelAlloc["Label 分配"]
        Request["用户申请 Label"]
        Alloc["Model 分配 ID"]
        Record["记录到 labelMap_"]
    end
    
    subgraph LabelSet["Label 设置"]
        ChooseStream["选择目标 Stream"]
        RecordPos["记录当前位置"]
        DevAddr["设置 devDstAddr_<br/>设备跳转地址"]
    end
    
    subgraph LabelGoto["Label 跳转"]
        GetAddr["读取 devDstAddr_"]
        GenSQE["生成 Lable Switch SQE"]
        HWJump["硬件跳转执行"]
    end
    
    Request --> Alloc --> Record
    Record --> ChooseStream --> RecordPos --> DevAddr
    
    DevAddr --> GetAddr --> GenSQE --> HWJump
    
    HWJump -->|"同 Stream"| Loop["循环控制"]
    HWJump -->|"跨 Stream"| Switch["流间切换"]
    
    style Request fill:#e1f5ff
    style HWJump fill:#c8e6c9
```

**机制说明**：
- **Label 分配**：Model 通过 LabelAllocator 分配唯一 ID
- **Label 设置**：在目标 Stream 上记录跳转位置，设置设备侧地址
- **Label 跳转**：读取设备地址，生成跳转 SQE，硬件执行跳转
- **控制流实现**：支持循环（同 Stream）和跨 Stream 任务切换

#### Notify 完成通知机制

**设计思想**：Notify 实现硬件完成通知，Host 通过等待 Notify 获取执行结果。

```mermaid
sequenceDiagram
    participant Model as Model
    participant EndGraph as EndGraphTask
    participant Notify as endGraphNotify_
    participant Driver as Driver
    participant HW as 硬件 TS
    
    %% EndGraph 创建 Notify
    Model->>EndGraph: rtEndGraph(model, stream)
    EndGraph->>Notify: 创建 Notify 对象
    Notify->>Driver: AllocNotifyId()
    Driver->>HW: 申请 notifyId
    HW-->>Driver: notifyId
    Driver-->>Notify: notifyId
    Notify-->>Model: endGraphNotify_
    
    %% 执行时写入 EndGraph Task
    Model->>EndGraph: Execute()
    EndGraph->>Driver: SubmitTask(EndGraphTask)
    Driver->>HW: SQE: END_GRAPH<br/>notifyId=notifyId_
    HW->>HW: 执行所有前置任务
    HW->>HW: 执行 EndGraph Task
    HW->>HW: Signal Notify<br/>notifyId ← value++
    
    %% Host 等待 Notify
    Model->>Notify: NtyWait(endGraphNotify_, stream)
    Notify->>Driver: Notify::Wait()
    Driver->>HW: Poll Notify Value<br/>MSG: NOTIFY_POLL
    HW-->>Driver: notifyValue
    Driver-->>Notify: value matched
    Notify-->>Model: wait success
    Model->>Model: 执行完成
```

**机制说明**：
- **Notify 创建**：EndGraph 任务申请 NotifyId，绑定到 Model
- **Notify 等待**：Host 通过 NtyWait 轮询 Notify Value
- **Notify 触发**：硬件执行到 EndGraph，Signal Notify，更新 Value
- **完成确认**：Host 检测到 Value 匹配，确认执行完成

### 4.3 模块职责划分

Model 模块按照功能划分为核心容器、任务管理、接口层、辅助工具等子模块，各模块职责清晰，协同完成模型全生命周期管理。

#### 核心容器模块

| 模块名称 | 核心职责 | 代码位置 | 主要功能 |
|----------|----------|----------|----------|
| **Model 核心类** | 计算图容器，统一管理 Stream/Label/Notify | `src/runtime/core/inc/model/model.hpp`<br/>`src/runtime/feature/model/model.cc` | • 绑定/解绑 Stream<br/>• 分配/释放 Label<br/>• 执行同步/异步模型<br/>• 批量下发 SQE<br/>• 管理 argLoaderRecord |
| **Model C 接口** | 对外 C 风格 API 封装 | `src/runtime/api/api_c_model.cc` | • rtModelCreate<br/>• rtModelDestroy<br/>• rtModelBindStream<br/>• rtModelExecute<br/>• rtEndGraph<br/>• rtModelLoadComplete |

#### 任务管理模块

| 任务类型 | 任务职责 | 代码位置 | 触发时机 |
|----------|----------|----------|----------|
| **ModelExecuteTask** | 触发模型执行，激活 headStreams | `src/runtime/core/src/task/task_info/model/model_execute_task.cc`<br/>`src/runtime/core/src/task/task_info/model/model_execute_task_v100.cc`<br/>`src/runtime/core/src/task/task_info/model/model_execute_task_v200_base.cc` | Execute/ExecuteAsync 调用时 |
| **ModelMaintainceTask** | 维护 Stream 与 Model 关系 | `src/runtime/core/src/task/task_info/model/model_maintaince_task.cc`<br/>`src/runtime/core/src/task/task_info/model/model_maintaince_task_v100.cc`<br/>`src/runtime/core/src/task/task_info/model/model_maintaince_task_v200_base.cc` | BindStream/UnbindStream<br/>LoadComplete 时 |
| **ModelGraphTask** | EndGraph 标记，创建 Notify | `src/runtime/core/src/task/task_info/model/model_graph_task.cc`<br/>`src/runtime/core/src/task/task_info/model/model_graph_task_v100.cc`<br/>`src/runtime/core/src/task/task_info/model/model_graph_task_v200_base.cc` | rtEndGraph 调用时 |

#### 辅助工具模块

| 工具模块 | 辅助职责 | 代码位置 | 服务对象 |
|----------|----------|----------|----------|
| **LabelAllocator** | Label ID 分配器 | `src/runtime/core/inc/launch/label.hpp` | Model Label 管理 |
| **Notify** | 硬件完成通知对象 | `src/runtime/core/inc/notify/notify.hpp`<br/>`src/runtime/core/src/notify/notify.cc` | EndGraph Notify |

#### 接口适配层

| 适配层 | 适配职责 | 代码位置 | 服务对象 |
|----------|----------|----------|----------|
| **ACL 接口封装** | ACL → RT 接口映射 | `src/acl/aclrt_impl/model_ri.cpp` | 用户调用 aclmdlRI 接口 |
| **API 装饰器** | API 错误处理装饰 | `src/runtime/core/src/api_impl/api_decorator.cc`| ApiImpl 调用链 |


### 5 关键文件路径索引

| 模块类别 | 文件路径 | 核心内容 |
|----------|----------|----------|
| **Model 头文件** | `src/runtime/core/inc/model/model.hpp` | Model 类定义、数据结构 |
| **Model 实现** | `src/runtime/feature/model/model.cc` | Model 核心实现 |
| **Model C 接口** | `src/runtime/feature/model/model_c.cc` | C 风格接口实现 |
| **Model Execute Task** | `src/runtime/core/src/task/task_info/model/model_execute_task.cc` | 执行任务实现 |
| **Model Execute Task V100** | `src/runtime/core/src/task/task_info/model/model_execute_task_v100.cc` | V100 版本适配 |
| **Model Execute Task V200** | `src/runtime/core/src/task/task_info/model/model_execute_task_v200_base.cc` | V200 版本适配 |
| **Model Maintaince Task** | `src/runtime/core/src/task/task_info/model/model_maintaince_task.cc` | 维护任务实现 |
| **ACL 接口头文件** | `include/external/acl/acl_rt.h` | ACL 外部接口定义 |
| **ACL 接口实现** | `src/acl/aclrt_impl/model_ri.cpp` | ACL 接口实现（aclmdlRI 系列） |
