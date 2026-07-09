# Structs

struct 类型数据。

<br>

- [aclCANNPackageVersion](#aclCANNPackageVersion)
- [aclmdlRICondTaskParams](#aclmdlRICondTaskParams)
- [aclmdlRIEventRecordTaskParams](#aclmdlRIEventRecordTaskParams)
- [aclmdlRIEventResetTaskParams](#aclmdlRIEventResetTaskParams)
- [aclmdlRIEventWaitTaskParams](#aclmdlRIEventWaitTaskParams)
- [aclmdlRIKernelTaskParams](#aclmdlRIKernelTaskParams)
- [aclmdlRITaskParams](#aclmdlRITaskParams)
- [aclmdlRIValueWaitTaskParams](#aclmdlRIValueWaitTaskParams)
- [aclmdlRIValueWriteTaskParams](#aclmdlRIValueWriteTaskParams)
- [aclrtAicAivTaskUpdateAttr](#aclrtAicAivTaskUpdateAttr)
- [aclrtBarrierCmoInfo](#aclrtBarrierCmoInfo)
- [aclrtBarrierTaskInfo](#aclrtBarrierTaskInfo)
- [aclrtBinaryLoadOption](#aclrtBinaryLoadOption)
- [aclrtBinaryLoadOptions](#aclrtBinaryLoadOptions)
- [aclrtBinaryLoadOptionValue](#aclrtBinaryLoadOptionValue)
- [aclrtCntNotifyRecordInfo](#aclrtCntNotifyRecordInfo)
- [aclrtCntNotifyWaitInfo](#aclrtCntNotifyWaitInfo)
- [aclrtDropoutBitmaskInfo](#aclrtDropoutBitmaskInfo)
- [aclrtIpcEventHandle](#aclrtIpcEventHandle)
- [aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr)
- [aclrtLaunchKernelCfg](#aclrtLaunchKernelCfg)
- [aclrtMallocAttribute](#aclrtMallocAttribute)
- [aclrtMallocConfig](#aclrtMallocConfig)
- [aclrtMemAccessDesc](#aclrtMemAccessDesc)
- [aclrtMemcpyBatchAttr](#aclrtMemcpyBatchAttr)
- [aclrtMemLocation](#aclrtMemLocation)
- [aclrtMemManagedLocation](#aclrtMemManagedLocation)
- [aclrtMemPoolProps](#aclrtMemPoolProps)
- [aclrtMemUceInfo](#aclrtMemUceInfo)
- [aclrtMemUsageInfo](#aclrtMemUsageInfo)
- [aclrtNormalDisInfo](#aclrtNormalDisInfo)
- [aclrtPhysicalMemProp](#aclrtPhysicalMemProp)
- [aclrtPtrAttributes](#aclrtPtrAttributes)
- [aclrtRandomNumFuncParaInfo](#aclrtRandomNumFuncParaInfo)
- [aclrtRandomNumTaskInfo](#aclrtRandomNumTaskInfo)
- [aclrtRandomParaInfo](#aclrtRandomParaInfo)
- [aclrtRandomTaskUpdateAttr](#aclrtRandomTaskUpdateAttr)
- [aclrtServerPid](#aclrtServerPid)
- [aclrtSnapShotBackupArgs](#aclrtSnapShotBackupArgs)
- [aclrtSnapShotRestoreArgs](#aclrtSnapShotRestoreArgs)
- [aclrtStreamAttrValue](#aclrtStreamAttrValue)
- [aclrtTaskUpdateInfo](#aclrtTaskUpdateInfo)
- [aclrtTimeoutUs](#aclrtTimeoutUs)
- [aclrtUniformDisInfo](#aclrtUniformDisInfo)
- [aclrtUtilizationInfo](#aclrtUtilizationInfo)
- [aclrtUuid](#aclrtUuid)

<br>

<a id="aclCANNPackageVersion"></a>

## aclCANNPackageVersion

```c
#define ACL_PKG_VERSION_MAX_SIZE       128
#define ACL_PKG_VERSION_PARTS_MAX_SIZE 64

typedef struct aclCANNPackageVersion {
    char version[ACL_PKG_VERSION_MAX_SIZE];               // 完整版本号
    char majorVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // 主版本号
    char minorVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // 次版本号
    char releaseVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];  // 发布号，如果查询不到，就补0
    char patchVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // 补丁版本号，如果查询不到，就补0
    char reserved[ACL_PKG_VERSION_MAX_SIZE];
} aclCANNPackageVersion;
```

<br>

<a id="aclmdlRICondTaskParams"></a>

## aclmdlRICondTaskParams

```c
typedef struct tagAclmdlRICondTaskParams {
    aclmdlRICondHandle handle;
    aclmdlRICondTaskType type;
    uint32_t size;
    aclmdlRI *modelRIArray;
} aclmdlRICondTaskParams;
```

| 成员名 | 说明 |
| --- | --- |
| handle | 条件句柄。类型定义请参见[aclmdlRICondHandle](25-05_Typedefs.md#aclmdlRICondHandle)。 |
| type | 条件类型。类型定义请参见[aclmdlRICondTaskType](25-02_Enumerations.md#aclmdlRICondTaskType)。 |
| size | 分支数量。IF条件取1或2，WHILE条件取1，SWITCH条件取大于0的值。 |
| modelRIArray | 子图模型运行实例数组。类型定义请参见[aclmdlRI](25-05_Typedefs.md#aclmdlRI)。 |

<br>

<a id="aclmdlRIEventRecordTaskParams"></a>

## aclmdlRIEventRecordTaskParams

```c
typedef struct aclmdlRIEventRecordTaskParams {
    aclrtEvent event;
    uint32_t eventFlag;
    uint32_t recordFlag;
} aclmdlRIEventRecordTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| event | 指定Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| eventFlag | Event flag。请参见aclrtCreateEventWithFlag或[aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag)中的flag说明。 |
| recordFlag | 指定记录动作的行为。 recordFlag取值如下：当recordFlag为ACL_EVENT_RECORD_DEFAULT时，表示默认行为，适用于普通场景，等价于aclrtRecordEvent接口。当recordFlag为ACL_EVENT_RECORD_EXTERNAL时，仅适用于图捕获场景，当用户正在把Stream上的任务捕获成计算图时，带上这个flag，本次记录的事件对外部可见，用于实现图和外部Stream之间做同步、以及实现图和图之间做同步。非图捕获场景下，flag为ACL_EVENT_RECORD_EXTERNAL时，返回报错。 |

<br>

<a id="aclmdlRIEventResetTaskParams"></a>

## aclmdlRIEventResetTaskParams

```c
typedef struct aclmdlRIEventResetTaskParams {
    aclrtEvent event;
    uint32_t eventFlag;
    uint32_t resetFlag;
} aclmdlRIEventResetTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| event | 指定Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| eventFlag | Event flag。请参见[aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag)中的flag说明。 |
| resetFlag | 预留参数，默认值为0。 |

<br>

<a id="aclmdlRIEventWaitTaskParams"></a>

## aclmdlRIEventWaitTaskParams

```c
typedef struct aclmdlRIEventWaitTaskParams {
    aclrtEvent event;
    uint32_t eventFlag;
    uint32_t waitFlag;
} aclmdlRIEventWaitTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| event | 指定Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| eventFlag | Event flag。请参见[aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag)中的flag说明。 |
| waitFlag | 指定等待动作的行为。waitFlag取值如下：当waitFlag为ACL_EVENT_WAIT_DEFAULT时，表示默认标记，适用于普通场景，等价于aclrtStreamWaitEventWithTimeout接口。当waitFlag为ACL_EVENT_WAIT_EXTERNAL时，图捕获场景专用，当用户正在把Stream上的任务捕获成计算图时，带上这个flag，表示本次等待一个图之外的事件，用于实现图和外部Stream之间做同步、以及实现图和图之间做同步。 |

<br>

<a id="aclmdlRIKernelTaskParams"></a>

## aclmdlRIKernelTaskParams

```c
typedef struct aclmdlRIKernelTaskParams {
    aclrtFuncHandle funcHandle;
    aclrtLaunchKernelCfg* cfg;
    void* args;
    uint32_t isHostArgs;
    size_t argsSize;
    uint32_t numBlocks;
    uint32_t rsv[10];
} aclmdlRIKernelTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| funcHandle | 核函数句柄。类型定义请参见[aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle)。 |
| cfg | 下发算子任务的配置信息。类型定义请参见[aclrtLaunchKernelCfg](#aclrtLaunchKernelCfg)。 |
| args | 存放核函数所有入参数据的地址指针。 |
| isHostArgs | 标识args的内存属性。该参数在查询接口中固定为0。<br>取值如下：<br><br>  - 0：Device内存。<br>  - 1：Host内存。 |
| argsSize | args参数处的内存大小，单位Byte。 |
| numBlocks | 指定核函数将会在几个核上执行。 |
| rsv | 预留参数。 |

<br>

<a id="aclmdlRITaskParams"></a>

## aclmdlRITaskParams

```c
typedef struct aclmdlRITaskParams {
    aclmdlRITaskType type;
    uint32_t rsv0[3];
    aclrtTaskGrp taskGrp;
    void* opInfoPtr;
    size_t opInfoSize;
    uint8_t rsv1[32];

    union {
        uint8_t rsv2[128]; 
        struct aclmdlRIKernelTaskParams kernelTaskParams;
        struct aclmdlRIEventRecordTaskParams eventRecordTaskParams;
    struct aclmdlRIEventWaitTaskParams eventWaitTaskParams;
    struct aclmdlRIEventResetTaskParams eventResetTaskParams;
    struct aclmdlRIValueWriteTaskParams valueWriteTaskParams;
    struct aclmdlRIValueWaitTaskParams valueWaitTaskParams;
    };
} aclmdlRITaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| type | 任务类型。类型定义请参见[aclmdlRITaskType](25-02_Enumerations.md#aclmdlRITaskType)。 |
| rsv0 | 预留参数。 |
| taskGrp | 标识任务组的句柄。类型定义请参见[aclrtTaskGrp](25-05_Typedefs.md#aclrtTaskGrp)。<br>该参数作为查询接口的输出，设置接口无需关注。 |
| opInfoPtr | 算子Shape信息的地址指针。 |
| rsv1 | 预留参数。 |
| rsv2 | 预留参数。 |
| kernelTaskParams | 算子任务的参数。类型定义请参见[aclmdlRIKernelTaskParams](#aclmdlRIKernelTaskParams)。 |
| eventRecordTaskParams | Event Record任务（通常对应aclrtRecordEvent接口下发的任务）的参数。类型定义请参见[aclmdlRIEventRecordTaskParams](#aclmdlRIEventRecordTaskParams)。<br>该参数作为查询接口的输出，设置接口无需关注。 |
| eventWaitTaskParams | Event Wait任务（通常对应aclrtStreamWaitEvent或aclrtStreamWaitEventWithTimeout接口下发的任务）的参数。类型定义请参见[aclmdlRIEventWaitTaskParams](#aclmdlRIEventWaitTaskParams)。<br>该参数作为查询接口的输出，设置接口无需关注。 |
| eventResetTaskParams | Event Reset任务（通常对应aclrtResetEvent接口下发的任务）的参数。类型定义请参见[aclmdlRIEventResetTaskParams](#aclmdlRIEventResetTaskParams)。<br>该参数作为查询接口的输出，设置接口无需关注。 |
| valueWriteTaskParams | Value Write任务（通常对应aclrtValueWrite接口下发的任务）的参数。类型定义请参见[aclmdlRIValueWriteTaskParams](#aclmdlRIValueWriteTaskParams)。 |
| valueWaitTaskParams | Value Wait任务（通常对应aclrtValueWait接口下发的任务）的参数。类型定义请参见[aclmdlRIValueWaitTaskParams](#aclmdlRIValueWaitTaskParams)。 |

<br>

<a id="aclmdlRIValueWaitTaskParams"></a>

## aclmdlRIValueWaitTaskParams

```c
typedef struct aclmdlRIValueWaitTaskParams {
    void *devAddr;
    uint64_t value;
    uint32_t flag;
} aclmdlRIValueWaitTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| devAddr | Device侧内存地址。<br>devAddr的有效内存位宽为64bit。 |
| value | 需与内存中的数据作比较的值。 |
| flag | 比较的方式，等满足条件后解除阻塞。取值请参见[aclrtValueWait](11-09_stream_memory_operation.md#aclrtValueWait)中的说明。 |

<br>

<a id="aclmdlRIValueWriteTaskParams"></a>

## aclmdlRIValueWriteTaskParams

```c
typedef struct aclmdlRIValueWriteTaskParams {
    void *devAddr;
    uint64_t value;
} aclmdlRIValueWriteTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| devAddr | Device侧内存地址。<br>此处需用户提前申请Device内存（例如调用aclrtMalloc接口），devAddr要求8字节对齐，有效内存位宽为64bit。 |
| value | 需向内存中写入的数据。 |

<br>

<a id="aclrtAicAivTaskUpdateAttr"></a>

## aclrtAicAivTaskUpdateAttr

```c
typedef struct { 
    void *binHandle;      
    void *funcEntryAddr;  
    void *blockDimAddr;   
    uint32_t rsv[4];      
} aclrtAicAivTaskUpdateAttr;
```

| 成员名称 | 说明 |
| --- | --- |
| binHandle | 存放待刷新的算子二进制句柄，可调用[aclrtBinaryLoadFromFile](14_kerne_loading_and_execution.md#aclrtBinaryLoadFromFile)或[aclrtBinaryLoadFromData](14_kerne_loading_and_execution.md#aclrtBinaryLoadFromData)接口获取算子二进制句柄。 |
| funcEntryAddr | 存放Function Entry（用于标识函数的关键字）的Device内存地址。 |
| blockDimAddr | 存放numBlocks(用于指定核函数将会在几个核上执行)的Device内存地址 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtBarrierCmoInfo"></a>

## aclrtBarrierCmoInfo

```c
typedef struct { 
    aclrtCmoType cmoType;  
    uint32_t barrierId;  
} aclrtBarrierCmoInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| cmoType | Cache内存操作类型。类型定义请参见[aclrtCmoType](25-02_Enumerations.md#aclrtCmoType)。 |
| barrierId | 屏障标识。 |

<br>

<a id="aclrtBarrierTaskInfo"></a>

## aclrtBarrierTaskInfo

```c
typedef struct { 
    size_t barrierNum;   
    aclrtBarrierCmoInfo cmoInfo[ACL_RT_CMO_MAX_BARRIER_NUM]; 
} aclrtBarrierTaskInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| barrierNum | cmoInfo数组的长度。 |
| cmoInfo | Cache内存操作的任务信息。类型定义请参见[aclrtBarrierCmoInfo](#aclrtBarrierCmoInfo)。<br>#define ACL_RT_CMO_MAX_BARRIER_NUM 6U |

<br>

<a id="aclrtBinaryLoadOption"></a>

## aclrtBinaryLoadOption

```c
typedef struct {
    aclrtBinaryLoadOptionType type;
    aclrtBinaryLoadOptionValue value;
} aclrtBinaryLoadOption;
```

加载算子二进制文件时，每个参数是由参数类型aclrtBinaryLoadOption.type及其对应的参数值aclrtBinaryLoadOption.value组成，例如，[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).type为ACL\_RT\_BINARY\_LOAD\_OPT\_LAZY\_LOAD时，[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).value需根据isLazyLoad的取值来配置。

[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).type的定义请参见[aclrtBinaryLoadOptionType](25-02_Enumerations.md#aclrtBinaryLoadOptionType)。

[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).value的定义请参见[aclrtBinaryLoadOptionValue](#aclrtBinaryLoadOptionValue)。

<br>

<a id="aclrtBinaryLoadOptions"></a>

## aclrtBinaryLoadOptions

```c
typedef struct aclrtBinaryLoadOptions {
    aclrtBinaryLoadOption *options;
    size_t numOpt;
} aclrtBinaryLoadOptions;
```

options结构体的定义请参见[aclrtBinaryLoadOption](#aclrtBinaryLoadOption)。

<br>

<a id="aclrtBinaryLoadOptionValue"></a>

## aclrtBinaryLoadOptionValue

```c
typedef union aclrtBinaryLoadOptionValue {
    uint32_t isLazyLoad;
    uint32_t magic;
    int32_t cpuKernelMode;
    uint32_t rsv[4];
} aclrtBinaryLoadOptionValue;
```

| 成员名称 | 描述 |
| --- | --- |
| isLazyLoad | 指定解析算子二进制、注册算子后，是否加载算子到Device侧。<br>取值如下：<br><br>  - 1：调用本接口时不加载算子到Device侧。<br>  - 0：调用本接口时加载算子到Device侧。如果不指定ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD选项，系统默认按此值处理。 |
| magic | 标识算子计算单元的魔术数字。<br>取值为如下宏：<br><br>  - ACL_RT_BINARY_MAGIC_ELF_AICORE<br>  - ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE<br>  - ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE<br><br>宏的定义如下：<br>#define ACL_RT_BINARY_MAGIC_ELF_AICORE  0x43554245U<br>#define ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE 0x41415246U<br>#define ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE  0x41494343U<br>关于Core的定义及详细说明，请参见[aclrtDevAttr](25-02_Enumerations.md#aclrtDevAttr)。 |
| cpuKernelMode | AI CPU算子注册模式。<br>取值如下：<br><br>  - 0：调用[aclrtBinaryLoadFromFile](14_kerne_loading_and_execution.md#aclrtBinaryLoadFromFile)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，AI CPU算子库文件（.so）已经在调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口时被加载到Device。适用于加载CANN内置算子。<br>  - 1：调用[aclrtBinaryLoadFromFile](14_kerne_loading_and_execution.md#aclrtBinaryLoadFromFile)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，[aclrtBinaryLoadFromFile](14_kerne_loading_and_execution.md#aclrtBinaryLoadFromFile)接口会查找算子信息库文件同名的AI CPU算子库文件（.so）。适用于加载用户自定义算子。<br>  - 2：调用[aclrtBinaryLoadFromData](14_kerne_loading_and_execution.md#aclrtBinaryLoadFromData)接口加载算子，并配合使用[aclrtRegisterCpuFunc](14_kerne_loading_and_execution.md#aclrtRegisterCpuFunc)接口注册AI CPU算子信息。适用于没有算子信息库文件，也没有算子库文件的场景。 |
| rsv | 预留值。 |

<br>

<a id="aclrtCntNotifyRecordInfo"></a>

## aclrtCntNotifyRecordInfo

```c
typedef struct {
    aclrtCntNotifyRecordMode mode;     // Record的行为模式
    uint32_t value;                    
} aclrtCntNotifyRecordInfo;
```

mode枚举值的定义请参见[aclrtCntNotifyRecordMode](25-02_Enumerations.md#aclrtCntNotifyRecordMode)。

<br>

<a id="aclrtCntNotifyWaitInfo"></a>

## aclrtCntNotifyWaitInfo

```c
typedef struct {
    aclrtCntNotifyWaitMode mode;  // Wait的行为模式
    uint32_t value;
    uint32_t timeout;             // 超时时间，单位是秒，其中，0表示永久等待
    uint8_t  isClear;             // wait解除阻塞后是否CntNotify的计数值自动清空为0，取值：1表示清空，0表示不清空
    uint8_t rev[3];
} aclrtCntNotifyWaitInfo;
```

mode结构体定义请参见[aclrtCntNotifyWaitMode](25-02_Enumerations.md#aclrtCntNotifyWaitMode)。

<br>

<a id="aclrtDropoutBitmaskInfo"></a>

## aclrtDropoutBitmaskInfo

```c
typedef struct {
    aclrtRandomParaInfo dropoutRation;
} aclrtDropoutBitmaskInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| dropoutRation | 失活比参数。类型定义请参见[aclrtRandomParaInfo](#aclrtRandomParaInfo)。 |

<br>

<a id="aclrtIpcEventHandle"></a>

## aclrtIpcEventHandle

```c
#define ACL_IPC_EVENT_HANDLE_SIZE 64U
typedef struct aclrtIpcEventHandle {
    char reserved[ACL_IPC_EVENT_HANDLE_SIZE];
} aclrtIpcEventHandle;
```

<br>

<a id="aclrtLaunchKernelAttr"></a>

## aclrtLaunchKernelAttr

```c
typedef struct aclrtLaunchKernelAttr {
    aclrtLaunchKernelAttrId id;
    aclrtLaunchKernelAttrValue value;
} aclrtLaunchKernelAttr;
```

Launch Kernel时，每个属性是由属性标识aclrtLaunchKernelAttr.id及其对应的属性值aclrtLaunchKernelAttr.value组成，例如，[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).id为ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_SCHEM\_MODE时，[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).value需根据schemMode的取值来配置。

[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).id的定义请参见[aclrtLaunchKernelAttrId](25-02_Enumerations.md#aclrtLaunchKernelAttrId)。

[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).value的定义请参见[aclrtLaunchKernelAttrValue](#aclrtLaunchKernelAttrValue)。

<br>

<a id="aclrtLaunchKernelAttrValue"></a>

## aclrtLaunchKernelAttrValue

```c
typedef union aclrtLaunchKernelAttrValue {
    uint8_t schemMode;
    uint32_t dynUBufSize;
    aclrtEngineType engineType; 
    uint32_t blockDimOffset; 
    uint8_t isBlockTaskPrefetch; 
    uint8_t isDataDump; 
    uint16_t timeout;
    aclrtTimeoutUs timeoutUs;
    uint32_t rsv[4];
} aclrtLaunchKernelAttrValue;
```

成员说明如下：

- schemMode

    表示调度模式。

    取值如下：

    - 0：普通调度模式，有空闲的核，就启动算子执行。例如，当numBlocks为8时，表示算子核函数将会在8个核上执行，这时如果指定普通调度模式，则表示只要有1个核空闲了，就启动算子执行。
    - 1：batch调度模式，必须所有所需的核都空闲了，才启动算子执行。例如，当numBlocks为8时，表示算子核函数将会在8个核上执行，这时如果指定batch调度模式，则表示必须等8个核都空闲了，才启动算子执行。

- dynUBufSize

    用于指定SIMT（Single Instruction Multiple Thread）算子执行时需要的UB（Unified Buffer，统一缓冲区）动态内存大小，单位Byte。纯SIMD算子该参数仅支持设置为0。

    可通过[aclrtFunctionGetAvailDynUbufPerBlock](14_kerne_loading_and_execution.md#aclrtFunctionGetAvailDynUbufPerBlock)接口获取dynUBufSize参数的最大值。

    <!-- npu="950" id1 -->
    仅Ascend 950PR/Ascend 950DT支持该参数。
    <!-- end id1 -->

    <!-- npu="IPV350" id2 -->
    当前不支持该参数，配置该参数不生效。
    <!-- end id2 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-05_Typedefs_res.md#id1 -->

- engineType

    表示算子执行引擎。类型定义请参见[aclrtEngineType](25-02_Enumerations.md#aclrtEngineType)。

    <!-- npu="310p" id3 -->
    仅Atlas 推理系列产品支持该参数。
    <!-- end id3 -->

    <!-- npu="IPV350" id4 -->
    当前不支持该参数，配置该参数不生效。
    <!-- end id4 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-05_Typedefs_res.md#id2 -->

- blockDimOffset

    表示numBlocks偏移量。numBlocks用于指定算子的核函数将会在几个核上执行。

    <!-- npu="310p" id5 -->
    仅Atlas 推理系列产品支持该参数。
    <!-- end id5 -->

    - **如果numBlocks ≤ AI Core核数**，则无需使用Vector Core上计算，可将engineType配置为ACL\_RT\_ENGINE\_TYPE\_AIC（表示在AI Core上计算），则此处的blockDimOffset配置为0。
    - **如果numBlocks \> AI Core核数**，则需：
        - 在一个Stream上下发任务，将engineType配置为ACL\_RT\_ENGINE\_TYPE\_AIC（表示在AI Core上计算），此处的blockDimOffset配置为0。
        - 在另一个Stream上下发任务，将engineType配置为ACL\_RT\_ENGINE\_TYPE\_AIV（表示在Vector Core上计算），此处的blockDimOffset配置为aicorenumBlocks，aicorenumBlocks的计算公式如下：
            - numBlocks ≤ AI Core核数+Vector Core核数时，aicorenumBlocks = AI Core核数
            - 否则，aicorenumBlocks = 向上取整 \( numBlocks \* \( AI Core核数 \) / \( AI Core核数 + Vector Core核数 \)\)

    <!-- npu="IPV350" id6 -->
    当前不支持该参数，配置该参数不生效。
    <!-- end id6 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-05_Typedefs_res.md#id3 -->

- isBlockTaskPrefetch

    任务下发时，是否阻止硬件预取本任务的信息。取值如下：0，不阻止；1，阻止。

- isDataDump

    表示是否开启Dump。取值如下：0，不开启；1，开启。

- timeout

    表示任务调度器等待任务执行的超时时间。仅适用于执行AI CPU或AI Core算子的场景。

    取值如下：

    - 0：表示永久等待；
    - \>0：配置具体的超时时间，单位是秒。

- timeoutUs

    表示任务调度器等待任务执行的超时时间，单位微秒。类型定义请参见[aclrtTimeoutUs](25-04_Structs.md#aclrtTimeoutUs)。

    若aclrtTimeoutUs结构体中，timeoutLow和timeoutHigh均被配置为0，则表示永久等待。

    对于同一个Launch Kernel任务，不能同时配置timeoutUs和timeout参数，否则返回报错。

- rsv

    预留参数。当前固定配置为0。

<br>

<a id="aclrtLaunchKernelCfg"></a>

## aclrtLaunchKernelCfg

```c
typedef struct aclrtLaunchKernelCfg {
    aclrtLaunchKernelAttr *attrs;
    size_t numAttrs;
} aclrtLaunchKernelCfg;
```

attrs结构体定义请参见[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr)。

<br>

<a id="aclrtMallocAttribute"></a>

## aclrtMallocAttribute

```c
typedef struct {
    aclrtMallocAttrType attr;   
    aclrtMallocAttrValue value;  
} aclrtMallocAttribute;
```

| 成员名称 | 说明 |
| --- | --- |
| attr | 属性类型。类型定义请参见[aclrtMallocAttrType](25-02_Enumerations.md#aclrtMallocAttrType)。 |
| value | 属性值。类型定义请参见[aclrtMallocAttrValue](#aclrtMallocAttrValue)。 |

<br>

<a id="aclrtMallocAttrValue"></a>

## aclrtMallocAttrValue

```c
typedef union {
    uint16_t moduleId; 
    uint32_t deviceId;  
    uint32_t vaFlag;
    uint8_t rsv[8]; 
} aclrtMallocAttrValue;
```

| 成员名称 | 说明 |
| --- | --- |
| moduleId | 模块ID，建议配置为33，表示APP，用于表示该内存是由用户的应用程序申请的，便于维测场景下定位问题。 |
| deviceId | Device ID，若此处配置的Device ID与当前用于计算的Device ID不一致，接口会返回报错，建议不配置该属性值。 |
| vaFlag | 使用aclrtMallocHostWithCfg接口申请Host内存时，是否使用VA（virtual address）一致性功能：<br>  - 0：不使用（默认值）。<br>  - 1：使用，申请的Host内存通过[aclrtHostRegister](11-02_host_memory_management.md#aclrtHostRegister)接口注册后，返回的devPtr与ptr（表示Host内存地址）一致，Host和Device可以使用相同的VA访问。<br><br>仅部分产品型号支持使用VA一致性功能，不支持的型号使用该功能将返回报错。 |
| rsv | 预留参数。当前固定配置为0。 |

<!-- npu="A3,910b" id7 -->
注意，仅Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持vaFlag。
<!-- end id7 -->

<br>

<a id="aclrtMallocConfig"></a>

## aclrtMallocConfig

```c
typedef struct {
    aclrtMallocAttribute* attrs; 
    size_t numAttrs;     
} aclrtMallocConfig;
```

| 成员名称 | 说明 |
| --- | --- |
| attrs | 属性，本参数是数组，可存放多个属性。类型定义请参见[aclrtMallocAttribute](#aclrtMallocAttribute)。 |
| numAttrs | 属性个数。 |

<br>

<a id="aclrtMemAccessDesc"></a>

## aclrtMemAccessDesc

```c
typedef struct {
    aclrtMemAccessFlags flags;   
    aclrtMemLocation location;   
    uint8_t rsv[12];             
} aclrtMemAccessDesc;
```

| 成员名称 | 描述 |
| --- | --- |
| flags | 内存访问保护标志。类型定义请参见[aclrtMemAccessFlags](25-02_Enumerations.md#aclrtMemAccessFlags)。<br>当前仅支持ACL_RT_MEM_ACCESS_FLAGS_READWRITE，表示地址范围可读可写。 |
| location | 内存所在位置。类型定义请参见[aclrtMemLocation](#aclrtMemLocation)。<br>当前仅支持将aclrtMemLocation.type设置为ACL_MEM_LOCATION_TYPE_HOST或ACL_MEM_LOCATION_TYPE_DEVICE。当aclrtMemLocation.type为ACL_MEM_LOCATION_TYPE_HOST时，[aclrtMemLocation](#aclrtMemLocation).id无效，固定设置为0即可。 |
| rsv | 预留参数，当前固定配置为0。 |

<br>

<a id="aclrtMemcpyBatchAttr"></a>

## aclrtMemcpyBatchAttr

```c
typedef struct {
    aclrtMemLocation dstLoc;   
    aclrtMemLocation srcLoc;   
    uint8_t rsv[16];           
} aclrtMemcpyBatchAttr;
```

| 成员名称 | 说明 |
| --- | --- |
| dstLoc | 目的内存所在位置。类型定义请参见[aclrtMemLocation](#aclrtMemLocation)。 |
| srcLoc | 源内存所在位置。类型定义请参见[aclrtMemLocation](#aclrtMemLocation)。 |
| rsv | 预留参数，当前固定配置为0。 |

<br>

<a id="aclrtMemLocation"></a>

## aclrtMemLocation

```c
typedef struct aclrtMemLocation {
    uint32_t id;                  // Device ID或NUMA（Non-Uniform Memory Access） ID
    aclrtMemLocationType type;    // 内存所在位置
} aclrtMemLocation;
```

内存所在位置请参见[aclrtMemLocationType](25-02_Enumerations.md#aclrtMemLocationType)中的定义。

<br>

<a id="aclrtMemManagedLocation"></a>

## aclrtMemManagedLocation

```c
typedef struct {
    aclrtMemManagedLocationType type;  // 内存所在位置
    int id;                            // Device ID或NUMA（Non-Uniform Memory Access） ID
} aclrtMemManagedLocation;
```

当type为ACL\_MEM\_LOCATIONTYPE\_INVALID、ACL\_MEM\_LOCATIONTYPE\_HOST、ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA\_CURRENT时，id无效。

<br>

<a id="aclrtMemPoolProps"></a>

## aclrtMemPoolProps

```c
typedef struct {
    aclrtMemAllocationType allocType;
    aclrtMemHandleType handleType;
    aclrtMemLocation location;
    size_t maxSize;
    unsigned char reserved[32];
} aclrtMemPoolProps;
```

| 成员名称 | 描述 |
| --- | --- |
| allocationType | 内存分配类型。类型定义请参见[aclrtMemAllocationType](25-02_Enumerations.md#aclrtMemAllocationType)。<br>当前仅支持ACL_MEM_ALLOCATION_TYPE_PINNED，表示锁页内存。 |
| handleType | handle类型。类型定义请参见[aclrtMemHandleType](25-02_Enumerations.md#aclrtMemHandleType)。 |
| location | 内存所在位置。类型定义请参见[aclrtMemLocation](#aclrtMemLocation)。<br>type当前仅支持设置为ACL_MEM_LOCATION_TYPE_DEVICE。 |
| maxSize | 内存池大小，单位Byte。 |
| reserved | 保留字段，当前必须为全0字符串。 |

<br>

<a id="aclrtMemUceInfo"></a>

## aclrtMemUceInfo

```c
#define MAX_MEM_UCE_INFO_ARRAY_SIZE 128 
#define UCE_INFO_RESERVED_SIZE 14

typedef struct aclrtMemUceInfo {
    void* addr;
    size_t len;
    size_t reserved[UCE_INFO_RESERVED_SIZE];
} aclrtMemUceInfo;
```

| 成员名称 | 描述 |
| --- | --- |
| addr | 内存UCE的错误虚拟起始地址。 |
| len | 内存大小，单位Byte。<br>从addr开始的len大小范围内的内存都是异常的。 |
| reserved | 预留参数。 |

<br>

<a id="aclrtMemUsageInfo"></a>

## aclrtMemUsageInfo

```c
typedef struct aclrtMemUsageInfo {
    char name[32];          // 组件名称
    uint64_t curMemSize;    // 当前占用的内存大小，单位Byte
    uint64_t memPeakSize;   // 该组件的峰值内存，单位Byte
    size_t reserved[8];     // 预留参数
} aclrtMemUsageInfo;
```

<br>

<a id="aclrtNormalDisInfo"></a>

## aclrtNormalDisInfo

```c
typedef struct { 
    aclrtRandomParaInfo mean;
    aclrtRandomParaInfo stddev;  
} aclrtNormalDisInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| mean | 均值参数。类型定义请参见[aclrtRandomParaInfo](#aclrtRandomParaInfo)。 |
| stddev | 标准差参数。类型定义请参见[aclrtRandomParaInfo](#aclrtRandomParaInfo)。 |

<br>

<a id="aclrtPhysicalMemProp"></a>

## aclrtPhysicalMemProp

```c
typedef struct aclrtPhysicalMemProp {
    aclrtMemHandleType handleType;
    aclrtMemAllocationType allocationType;
    aclrtMemAttr memAttr;
    aclrtMemLocation location;
    uint64_t reserve; 
} aclrtPhysicalMemProp;
```

| 成员名称 | 描述 |
| --- | --- |
| handleType | handle类型。类型定义请参见[aclrtMemHandleType](25-02_Enumerations.md#aclrtMemHandleType)。<br>当前仅支持ACL_MEM_HANDLE_TYPE_NONE 。 |
| allocationType | 内存分配类型。类型定义请参见[aclrtMemAllocationType](25-02_Enumerations.md#aclrtMemAllocationType)。<br>当前仅支持ACL_MEM_ALLOCATION_TYPE_PINNED，表示锁页内存。 |
| memAttr | 内存属性。类型定义请参见[aclrtMemAttr](25-02_Enumerations.md#aclrtMemAttr)。 |
| location | 内存所在位置。类型定义请参见[aclrtMemLocation](#aclrtMemLocation)。<br>当type为ACL_MEM_LOCATION_TYPE_HOST时，id无效，固定设置为0即可。 |
| reserve | 预留。 |

<br>

<a id="aclrtPtrAttributes"></a>

## aclrtPtrAttributes

```c
typedef struct aclrtPtrAttributes {
    aclrtMemLocation location; 
    uint32_t pageSize;   
    uint32_t rsv[4];    
} aclrtPtrAttributes;
```

| 成员名称 | 说明 |
| --- | --- |
| location | 内存所在位置。类型定义请参见[aclrtMemLocation](#aclrtMemLocation)。<br>当type为ACL_MEM_LOCATION_TYPE_HOST时，id无效。 |
| pageSize | 页表大小，单位Byte。 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtRandomNumFuncParaInfo"></a>

## aclrtRandomNumFuncParaInfo

```c
typedef struct { 
    aclrtRandomNumFuncType funcType;
    union { 
        aclrtDropoutBitmaskInfo dropoutBitmaskInfo; 
        aclrtUniformDisInfo uniformDisInfo;
        aclrtNormalDisInfo normalDisInfo; 
    } paramInfo; 
} aclrtRandomNumFuncParaInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| funcType | 函数类别。类型定义请参见[aclrtRandomNumFuncType](25-02_Enumerations.md#aclrtRandomNumFuncType)。 |
| dropoutBitmaskInfo | Dropout bitmask信息。类型定义请参见[aclrtDropoutBitmaskInfo](#aclrtDropoutBitmaskInfo)。 |
| uniformDisInfo | 均匀分布信息。类型定义请参见[aclrtUniformDisInfo](#aclrtUniformDisInfo)。 |
| normalDisInfo | 正态分布信息或截断正态分布信息。类型定义请参见[aclrtNormalDisInfo](#aclrtNormalDisInfo)。 |

<br>

<a id="aclrtRandomNumTaskInfo"></a>

## aclrtRandomNumTaskInfo

```c
typedef struct { 
    aclDataType dataType; 
    aclrtRandomNumFuncParaInfo randomNumFuncParaInfo;
    void *randomParaAddr;  
    void *randomResultAddr; 
    void *randomCounterAddr;
    aclrtRandomParaInfo randomSeed; 
    aclrtRandomParaInfo randomNum; 
    uint8_t rsv[8]; 
} aclrtRandomNumTaskInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| dataType | 随机数数据类型。类型定义请参见[aclDataType](25-02_Enumerations.md#aclDataType)。<br>仅支持如下数据类型：ACL_INT32、ACL_INT64、ACL_UINT32、ACL_UINT64、ACL_BF16、ACL_FLOAT16、ACL_FLOAT。 |
| randomNumFuncParaInfo | 随机数函数信息，包括函数类别、参数信息。类型定义请参见[aclrtRandomNumFuncParaInfo](#aclrtRandomNumFuncParaInfo)。 |
| randomParaAddr | 此处传NULL时，由接口内部自行申请Device内存，存放randomNumFuncParaInfo参数中的数据；否则，由用户申请Device内存，将内存地址作为参数传入。 |
| randomResultAddr | 存放随机数结果的内存地址。<br>由用户提前申请Device内存，将内存地址作为参数传入。 |
| randomCounterAddr | 生成随机数的偏移量。<br>由用户提前申请Device内存，读入偏移量数据后，再将内存地址作为参数传入。 |
| randomSeed | 随机种子。类型定义请参见[aclrtRandomParaInfo](#aclrtRandomParaInfo)。 |
| randomNum | 随机数个数。类型定义请参见[aclrtRandomParaInfo](#aclrtRandomParaInfo)。 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtRandomParaInfo"></a>

## aclrtRandomParaInfo

```c
typedef struct {
    uint8_t isAddr;
    uint8_t valueOrAddr[8];
    uint8_t size;
    uint8_t rsv[6];
} aclrtRandomParaInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| isAddr | 取值：0，表示存放参数值；1，表示存放指向参数值的内存地址。 |
| valueOrAddr | 存放参数值或者存放指向参数值的内存地址。<br>当isAddr=0，请根据数据类型填充相应字节数，例如fp16,、bf16，填充前2个字节；fp32、uint32、int32，填充前4个字节；uint64、int64，填充8个字节。<br>当isAddr=1时，则填充8字节的内存地址值。 |
| size | 对valueOrAddr实际填充的字节数。 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtRandomTaskUpdateAttr"></a>

## aclrtRandomTaskUpdateAttr

```c
typedef struct { 
    void *srcAddr;    
    size_t size;      
    uint32_t rsv[4];  
} aclrtRandomTaskUpdateAttr;
```

| 成员名称 | 说明 |
| --- | --- |
| srcAddr | 存放待刷新数据的Device内存地址，需按照[aclrtRandomNumTaskInfo](#aclrtRandomNumTaskInfo)结构体组织数据，且仅支持更新该结构体内的randomParaAddr、randomResultAddr、randomCounterAddr、randomSeed、randomNum参数值。 |
| size | 内存大小，单位Byte。 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtServerPid"></a>

## aclrtServerPid

```c
typedef struct {
    uint32_t sdid; 
    int32_t *pid;  
    size_t num; 
} aclrtServerPid;
```

| 成员名称 | 说明 |
| --- | --- |
| sdid | 针对Atlas A3 训练系列产品/Atlas A3 推理系列产品中的超节点产品，sdid（SuperPOD Device ID）表示超节点产品中的Device唯一标识，可提前调用[aclGetDeviceInfo](04_device_management.md#aclrtGetDeviceInfo)接口获取。 |
| pid | Host侧进程ID白名单数组。 |
| num | pid数组长度。 |

<br>

<a id="aclrtSnapShotBackupArgs"></a>

## aclrtSnapShotBackupArgs

```c
typedef struct aclrtSnapShotBackupArgs {
    uint32_t backupFlags;
    char reserved[60];
} aclrtSnapShotBackupArgs;
```

| 成员名称 | 说明 |
| --- | --- |
| backupFlags | 备份标志位。 |
| reserved | 预留字段。 |

<br>

<a id="aclrtSnapShotRestoreArgs"></a>

## aclrtSnapShotRestoreArgs

```c
typedef struct aclrtSnapShotRestoreArgs {
    uint32_t restoreFlags;
    char reserved[60];
} aclrtSnapShotRestoreArgs;
```

| 成员名称 | 说明 |
| --- | --- |
| restoreFlags | 备份标志位。 |
| reserved | 预留字段。 |

<br>

<a id="aclrtStreamAttrValue"></a>

## aclrtStreamAttrValue

```c
typedef union {
    uint64_t failureMode;
    uint32_t overflowSwitch; 
    uint32_t userCustomTag; 
    uint32_t cacheOpInfoSwitch;
    uint32_t streamPriority;
    uint32_t reserve[4];
} aclrtStreamAttrValue;
```

| 成员名称 | 说明 |
| --- | --- |
| failureMode | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_FAILURE_MODE（表示Stream的任务调度模式）属性时，属性值的取值如下：<br><br>  - 0：某个任务失败后，继续执行下一个任务。默认值为0。<br>  - 1：某个任务失败后，停止执行后续的任务，通常称作遇错即停。触发遇错即停之后，不支持再下发新任务。当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停 。该约束适用于以下产品型号：<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| overflowSwitch | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK（表示溢出检测开关）属性时，属性值的取值如下：<br><br>  - 0：关闭溢出检测。默认值为0。<br>  - 1：打开溢出检测。 |
| userCustomTag | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_USER_CUSTOM_TAG（表示溢出检测分组标签）属性时，属性值的取值范围：0~uint32_t类型的最大值。 |
| cacheOpInfoSwitch | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_CACHE_OP_INFO （表示算子信息缓存开关）属性时，属性值的取值如下：<br><br>  - 0：关闭算子信息缓存开关。默认值为0。<br>  - 1：开启算子信息缓存开关。 |
| streamPriority | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_PRIORITY （表示stream优先级）属性时，属性值的取值范围：0~7 值越小优先级级别越高，默认值为0。|
| reserve | 预留值。 |

<br>

<a id="aclrtTaskUpdateInfo"></a>

## aclrtTaskUpdateInfo

```c
typedef struct { 
    aclrtUpdateTaskAttrId id;    
    aclrtUpdateTaskAttrVal val;  
} aclrtTaskUpdateInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| id | 待更新的任务类别。类型定义请参见[aclrtUpdateTaskAttrId](25-02_Enumerations.md#aclrtUpdateTaskAttrId)。 |
| val | 待更新的任务信息。类型定义请参见[aclrtUpdateTaskAttrVal](25-05_Typedefs.md#aclrtUpdateTaskAttrVal)。 |

<!-- npu="A3,910b" id8 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持随机数生成任务。
<!-- end id8 -->

<!-- npu="310p" id9 -->
Atlas 推理系列产品不支持随机数生成任务。
<!-- end id9 -->

<br>

<a id="aclrtTimeoutUs"></a>

## aclrtTimeoutUs

```c
typedef struct {
    uint32_t timeoutLow;  // 超时时间的低32位值
    uint32_t timeoutHigh; // 超时时间的高32位值
} aclrtTimeoutUs;
```

<br>

<a id="aclrtUniformDisInfo"></a>

## aclrtUniformDisInfo

```c
typedef struct { 
    aclrtRandomParaInfo min;   
    aclrtRandomParaInfo max;            
} aclrtUniformDisInfo;
```

| 成员名称 | 说明 |
| --- | --- |
| min | 最小值参数。类型定义请参见[aclrtRandomParaInfo](#aclrtRandomParaInfo)。 |
| max | 最大值参数。类型定义请参见[aclrtRandomParaInfo](#aclrtRandomParaInfo)。 |

<br>

<a id="aclrtUtilizationInfo"></a>

## aclrtUtilizationInfo

```c
typedef struct aclrtUtilizationInfo {
    int32_t cubeUtilization;   // Cube利用率
    int32_t vectorUtilization; // Vector利用率
    int32_t aicpuUtilization;  // AI CPU利用率
    int32_t memoryUtilization; // Device内存利用率
    aclrtUtilizationExtendInfo *utilizationExtend; // 预留参数，当前设置为null
} aclrtUtilizationInfo;
```

<br>

<a id="aclrtUuid"></a>

## aclrtUuid

```c
 typedef struct aclrtUuid {
    char  bytes[16];    // 一个16字节的字符串，作为Device的唯一标识
} aclrtUuid;
```
