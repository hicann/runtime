# Structs

<!-- md-trans-meta sourceCommit=2f8767a8ea410c0e1fd4474732451a0c69efd6b1 translatedAt=2026-11-06T11:39:16.822Z pushedAt=2026-11-09T10:46:54.845Z nl=2 -->

Data of the struct type.

<br>

- [aclCANNPackageVersion](#aclCANNPackageVersion)
- [acldumpTensorInfo](#acldumpTensorInfo)
- [aclmdlRICondTaskParams](#aclmdlRICondTaskParams)
- [aclmdlRIEventRecordTaskParams](#aclmdlRIEventRecordTaskParams)
- [aclmdlRIEventResetTaskParams](#aclmdlRIEventResetTaskParams)
- [aclmdlRIEventWaitTaskParams](#aclmdlRIEventWaitTaskParams)
- [aclmdlRIKernelTaskParams](#aclmdlRIKernelTaskParams)
- [aclmdlRITaskParams](#aclmdlRITaskParams)
- [aclmdlRIValueWaitTaskParams](#aclmdlRIValueWaitTaskParams)
- [aclmdlRIValueWriteTaskParams](#aclmdlRIValueWriteTaskParams)
- [aclrtAddrRange](#aclrtAddrRange)
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
- [aclrtPlaceHolderInfo](#aclrtPlaceHolderInfo)
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
- [aclrtUpdateTaskAttrVal](#aclrtUpdateTaskAttrVal)
- [aclrtUtilizationInfo](#aclrtUtilizationInfo)
- [aclrtUuid](#aclrtUuid)
- [dim3](#dim3)

<br>

<a id="aclrtAddrRange"></a>

## aclrtAddrRange

```c
typedef struct aclrtAddrRange {
    void *startAddr;
    void *endAddr;
} aclrtAddrRange;
```

### Member Description

| Member Name | Description |
| --- | --- |
| startAddr | Start address of the address range. |
| endAddr | End address of the address range. |

<br>

<a id="aclCANNPackageVersion"></a>

## aclCANNPackageVersion

```c
#define ACL_PKG_VERSION_MAX_SIZE       128
#define ACL_PKG_VERSION_PARTS_MAX_SIZE 64

typedef struct aclCANNPackageVersion {
    char version[ACL_PKG_VERSION_MAX_SIZE];               // Full version number
    char majorVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // Major version number
    char minorVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // Minor version number
    char releaseVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];  // Release number. If it cannot be queried, pad with 0.
    char patchVersion[ACL_PKG_VERSION_PARTS_MAX_SIZE];    // Patch version number. If it cannot be queried, pad with 0.
    char reserved[ACL_PKG_VERSION_MAX_SIZE];
} aclCANNPackageVersion;
```

<br>

<a id="acldumpTensorInfo"></a>

## acldumpTensorInfo

```c
#define ACL_DUMP_MAX_SHAPE_NUM 25

typedef struct acldumpTensorInfo {
    acldumpTensorType type;
    size_t tensorSize;
    int32_t format;
    int32_t dataType;
    int64_t *tensorAddr;
    acldumpTensorAddressType addrType;
    acldumpTensorPlacement placement;
    uint32_t argsOffset;
    uint32_t shapeNum;
    uint32_t originShapeNum;
    uint64_t shape[ACL_DUMP_MAX_SHAPE_NUM];
    uint64_t originShape[ACL_DUMP_MAX_SHAPE_NUM];
} acldumpTensorInfo;
```

| Member Name | Description |
| --- | --- |
| type | Tensor type. For the type definition, see [acldumpTensorType](25-02_Enumerations.md#acldumpTensorType). |
| tensorSize | Tensor size, in bytes. |
| format | Tensor data format. For the type definition values, see [aclFormat](25-02_Enumerations.md#aclFormat). |
| dataType | Tensor data type. For the type definition values, see [aclDataType](25-02_Enumerations.md#aclDataType). |
| tensorAddr | Tensor address. |
| addrType | Tensor address type. For the type definition, see [acldumpTensorAddressType](25-02_Enumerations.md#acldumpTensorAddressType). |
| placement | Tensor data location. For the type definition, see [acldumpTensorPlacement](25-02_Enumerations.md#acldumpTensorPlacement). |
| argsOffset | Offset of the tensor relative to the first parameter of the operator. |
| shapeNum | Number of valid dimensions of the tensor shape, which does not exceed ACL_DUMP_MAX_SHAPE_NUM. |
| originShapeNum | Number of valid dimensions of the original tensor shape, which does not exceed ACL_DUMP_MAX_SHAPE_NUM. |
| shape | Dimension array of the tensor shape. |
| originShape | Dimension array of the original tensor shape. |

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

| Member Name | Description |
| --- | --- |
| handle | Condition handle. For the type definition, see [aclmdlRICondHandle](25-05_Typedefs.md#aclmdlRICondHandle). |
| type | Condition type. For the type definition, see [aclmdlRICondTaskType](25-02_Enumerations.md#aclmdlRICondTaskType). |
| size | Number of branches. The value is 1 or 2 for an IF condition, 1 for a WHILE condition, and a value greater than 0 for a SWITCH condition. |
| modelRIArray | Array of subgraph model running instances. For the type definition, see [aclmdlRI](25-05_Typedefs.md#aclmdlRI). |

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

| Member Name | Description |
| --- | --- |
| event | Specifies the event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| eventFlag | Event flag. For details, see the flag Description in aclrtCreateEventWithFlag or [aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag). |
| recordFlag | Specifies the behavior of the record action. The values of recordFlag are as follows: when recordFlag is ACL_EVENT_RECORD_DEFAULT, it indicates the default behavior, which applies to common scenarios and is equivalent to the aclrtRecordEvent API. When recordFlag is ACL_EVENT_RECORD_EXTERNAL, it applies only to graph capture scenarios. When the user is capturing tasks on a stream into a compute graph, this flag makes the event recorded this time visible to the outside, and is used to synchronize between a graph and an external stream, as well as between graphs. In non-graph-capture scenarios, when the flag is ACL_EVENT_RECORD_EXTERNAL, an error is returned. |

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

| Member Name | Description |
| --- | --- |
| event | Specifies the Event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| eventFlag | Event flag. For details, see the flag description in [aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag). |
| resetFlag | Reserved parameter. The default value is 0. |

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

| Member Name | Description |
| --- | --- |
| event | Specifies the event. For the type definition, see [aclrtEvent](25-05_Typedefs.md#aclrtEvent). |
| eventFlag | Event flag. For details, see the flag description in [aclrtCreateEventExWithFlag](07_event_management.md#aclrtCreateEventExWithFlag). |
| waitFlag | Specifies the behavior of the wait action. The values of waitFlag are as follows: when waitFlag is ACL_EVENT_WAIT_DEFAULT, it indicates the default flag, which applies to common scenarios and is equivalent to the aclrtStreamWaitEventWithTimeout interface. When waitFlag is ACL_EVENT_WAIT_EXTERNAL, it is dedicated to graph capture scenarios. When the user is capturing tasks on a stream into a compute graph, this flag indicates that the current wait is for an event outside the graph, which is used to synchronize between a graph and an external stream, and between graphs. |

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

| Member Name | Description |
| --- | --- |
| funcHandle | Kernel function handle. For the type definition, see [aclrtFuncHandle](25-05_Typedefs.md#aclrtFuncHandle). |
| cfg | Configuration information for delivering the operator task. For the type definition, see [aclrtLaunchKernelCfg](#aclrtLaunchKernelCfg). |
| args | Address pointer that stores all input parameter data of the kernel function. |
| isHostArgs | Identifies the memory attribute of args. This parameter is fixed to 0 in the query interface.<br>The values are as follows:<br><br>  - 0: device memory.<br>  - 1: host memory. |
| argsSize | Memory size at the args parameter, in bytes. |
| numBlocks | Specifies the number of cores on which the kernel function will execute. |
| rsv | Reserved parameter. |

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

| Member Name | Description |
| --- | --- |
| type | Task type. For the type definition, please refer to [aclmdlRITaskType](25-02_Enumerations.md#aclmdlRITaskType). |
| rsv0 | Reserved parameter. |
| taskGrp | Handle that identifies the task group. For the type definition, please refer to [aclrtTaskGrp](25-05_Typedefs.md#aclrtTaskGrp).<br>This parameter is an output of the query API and does not need to be set by the caller for the configuration API. |
| opInfoPtr | Address pointer of the operator shape information. |
| rsv1 | Reserved parameter. |
| rsv2 | Reserved parameter. |
| kernelTaskParams | Parameter of the operator task. For the type definition, please refer to [aclmdlRIKernelTaskParams](#aclmdlRIKernelTaskParams). |
| eventRecordTaskParams | Parameter of the Event Record task (usually corresponds to the task delivered by the aclrtRecordEvent interface). For the type definition, please refer to [aclmdlRIEventRecordTaskParams](#aclmdlRIEventRecordTaskParams).<br>This parameter is an output of the query API and does not need to be set by the caller for the configuration API. |
| eventWaitTaskParams | Parameter of the Event Wait task (usually corresponds to the task delivered by the aclrtStreamWaitEvent or aclrtStreamWaitEventWithTimeout interface). For the type definition, please refer to [aclmdlRIEventWaitTaskParams](#aclmdlRIEventWaitTaskParams).<br>This parameter is an output of the query API and does not need to be set by the caller for the configuration API. |
| eventResetTaskParams | Parameter of the Event Reset task (usually corresponds to the task delivered by the aclrtResetEvent interface). For the type definition, please refer to [aclmdlRIEventResetTaskParams](#aclmdlRIEventResetTaskParams).<br>This parameter is an output of the query API and does not need to be set by the caller for the configuration API. |
| valueWriteTaskParams | Parameter of the Value Write task (usually corresponds to the task delivered by the aclrtValueWrite interface). For the type definition, please refer to [aclmdlRIValueWriteTaskParams](#aclmdlRIValueWriteTaskParams). |
| valueWaitTaskParams | Parameter of the Value Wait task (usually corresponds to the task delivered by the aclrtValueWait interface). For the type definition, please refer to [aclmdlRIValueWaitTaskParams](#aclmdlRIValueWaitTaskParams). |

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

| Member Name | Description |
| --- | --- |
| devAddr | Memory address on the device.<br>The valid memory bit width of devAddr is 64 bits. |
| value | Value to be compared with the data in the memory. |
| flag | Comparison mode. The blocking is released after the condition is met. For details about the values, see [aclrtValueWait](11-09_stream_memory_operation.md#aclrtValueWait). |

<br>

<a id="aclmdlRIValueWriteTaskParams"></a>

## aclmdlRIValueWriteTaskParams

```c
typedef struct aclmdlRIValueWriteTaskParams {
    void *devAddr;
    uint64_t value;
} aclmdlRIValueWriteTaskParams;
```

| Member Name | Description |
| --- | --- |
| devAddr | Memory address on the device.<br>The user must allocate device memory in advance (for example, by calling the aclrtMalloc API). devAddr must be 8-byte aligned, and the effective memory bit width is 64 bits. |
| value | Data to be written to the memory. |

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

| Member Name | Description |
| --- | --- |
| binHandle | Stores the operator binary handle to be refreshed. You can call [aclrtBinaryLoadFromFile](14_Kernel_loading_and_execution.md#aclrtBinaryLoadFromFile) or [aclrtBinaryLoadFromData](14_Kernel_loading_and_execution.md#aclrtBinaryLoadFromData) to obtain the operator binary handle. |
| funcEntryAddr | Stores the device memory address of the Function Entry (a keyword used to identify a function). |
| blockDimAddr | Stores the device memory address of numBlocks (used to specify the number of cores on which the kernel function will execute). |
| rsv | Reserved parameter. Currently fixed to 0. |

<br>

<a id="aclrtBarrierCmoInfo"></a>

## aclrtBarrierCmoInfo

```c
typedef struct { 
    aclrtCmoType cmoType;  
    uint32_t barrierId;  
} aclrtBarrierCmoInfo;
```

| Member Name | Description |
| --- | --- |
| cmoType | Cache memory operation type. For the type definition, see [aclrtCmoType](25-02_Enumerations.md#aclrtCmoType). |
| barrierId | Barrier identifier. |

<br>

<a id="aclrtBarrierTaskInfo"></a>

## aclrtBarrierTaskInfo

```c
typedef struct { 
    size_t barrierNum;   
    aclrtBarrierCmoInfo cmoInfo[ACL_RT_CMO_MAX_BARRIER_NUM]; 
} aclrtBarrierTaskInfo;
```

| Member Name | Description |
| --- | --- |
| barrierNum | Length of the cmoInfo array. |
| cmoInfo | Task information of cache memory operations. For the type definition, please refer to [aclrtBarrierCmoInfo](#aclrtBarrierCmoInfo).<br>#define ACL_RT_CMO_MAX_BARRIER_NUM 6U |

<br>

<a id="aclrtBinaryLoadOption"></a>

## aclrtBinaryLoadOption

```c
typedef struct {
    aclrtBinaryLoadOptionType type;
    aclrtBinaryLoadOptionValue value;
} aclrtBinaryLoadOption;
```

When loading an operator binary file, each parameter consists of the parameter type aclrtBinaryLoadOption.type and its corresponding parameter value aclrtBinaryLoadOption.value. For example, when [aclrtBinaryLoadOption](#aclrtBinaryLoadOption).type is ACL\_RT\_BINARY\_LOAD\_OPT\_LAZY\_LOAD, [aclrtBinaryLoadOption](#aclrtBinaryLoadOption).value must be configured based on the value of isLazyLoad.

For the definition of [aclrtBinaryLoadOption](#aclrtBinaryLoadOption).type, please refer to [aclrtBinaryLoadOptionType](25-02_Enumerations.md#aclrtBinaryLoadOptionType).

For the definition of [aclrtBinaryLoadOption](#aclrtBinaryLoadOption).value, please refer to [aclrtBinaryLoadOptionValue](#aclrtBinaryLoadOptionValue).

<br>

<a id="aclrtBinaryLoadOptions"></a>

## aclrtBinaryLoadOptions

```c
typedef struct aclrtBinaryLoadOptions {
    aclrtBinaryLoadOption *options;
    size_t numOpt;
} aclrtBinaryLoadOptions;
```

For the definition of the options structure, please refer to [aclrtBinaryLoadOption](#aclrtBinaryLoadOption).

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

| Member Name | Description |
| --- | --- |
| isLazyLoad | Specifies whether to load the operator to the device after parsing the operator binary and registering the operator.<br>Values are as follows:<br><br>  - 1: The operator is not loaded to the device when this API is called.<br>  - 0: The operator is loaded to the device when this API is called. If the ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD option is not specified, the system processes it based on this value by default. |
| magic | Magic number that identifies the operator compute unit.<br>The value is one of the following macros:<br><br>  - ACL_RT_BINARY_MAGIC_ELF_AICORE<br>  - ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE<br>  - ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE<br><br>The macros are defined as follows:<br>#define ACL_RT_BINARY_MAGIC_ELF_AICORE  0x43554245U<br>#define ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE 0x41415246U<br>#define ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE  0x41494343U<br>For the definition and detailed description of core, see [aclrtDevAttr](25-02_Enumerations.md#aclrtDevAttr). |
| cpuKernelMode | AI CPU operator registration mode.<br>Values are as follows:<br><br>  - 0: When the [aclrtBinaryLoadFromFile](14_Kernel_loading_and_execution.md#aclrtBinaryLoadFromFile) API is called to load the operator, the operator is registered using the operator information library file (.json). In this scenario, the AI CPU operator library file (.so) has already been loaded to the device when the [aclrtSetDevice](04_device_management.md#aclrtSetDevice) API is called. This applies to loading CANN built-in operators.<br>  - 1: When the [aclrtBinaryLoadFromFile](14_Kernel_loading_and_execution.md#aclrtBinaryLoadFromFile) API is called to load the operator, the operator is registered using the operator information library file (.json). In this scenario, the [aclrtBinaryLoadFromFile](14_Kernel_loading_and_execution.md#aclrtBinaryLoadFromFile) API searches for the AI CPU operator library file (.so) with the same name as the operator information library file. This applies to loading user-defined operators.<br>  - 2: The [aclrtBinaryLoadFromData](14_Kernel_loading_and_execution.md#aclrtBinaryLoadFromData) API is called to load the operator, and the [aclrtRegisterCpuFunc](14_Kernel_loading_and_execution.md#aclrtRegisterCpuFunc) API is used to register the AI CPU operator information. This applies to scenarios where neither the operator information library file nor the operator library file exists. |
| rsv | Reserved value. |

<br>

<a id="aclrtCntNotifyRecordInfo"></a>

## aclrtCntNotifyRecordInfo

```c
typedef struct {
    aclrtCntNotifyRecordMode mode;     // Behavior mode of record
    uint32_t value;                    
} aclrtCntNotifyRecordInfo;
```

For the definition of the mode enum values, see [aclrtCntNotifyRecordMode](25-02_Enumerations.md#aclrtCntNotifyRecordMode).

<br>

<a id="aclrtCntNotifyWaitInfo"></a>

## aclrtCntNotifyWaitInfo

```c
typedef struct {
    aclrtCntNotifyWaitMode mode;  // Behavior mode of Wait
    uint32_t value;
    uint32_t timeout;             // Timeout period, in seconds. 0 indicates waiting forever.
    uint8_t  isClear;             // Whether the count value of CntNotify is automatically cleared to 0 after Wait is unblocked. Values: 1 indicates clearing, and 0 indicates no clearing.
    uint8_t rsv[3];
} aclrtCntNotifyWaitInfo;
```

For the definition of the mode structure, see [aclrtCntNotifyWaitMode](25-02_Enumerations.md#aclrtCntNotifyWaitMode).

<br>

<a id="aclrtDropoutBitmaskInfo"></a>

## aclrtDropoutBitmaskInfo

```c
typedef struct {
    aclrtRandomParaInfo dropoutRation;
} aclrtDropoutBitmaskInfo;
```

| Member Name | Description |
| --- | --- |
| dropoutRation | Dropout ratio parameter. For the type definition, please refer to [aclrtRandomParaInfo](#aclrtRandomParaInfo). |

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

When launching a kernel, each attribute consists of an attribute identifier aclrtLaunchKernelAttr.id and its corresponding attribute value aclrtLaunchKernelAttr.value. For example, when [aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).id is set to ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_SCHEM\_MODE, [aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).value must be configured based on the value of schemMode.

For the definition of [aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).id, please refer to [aclrtLaunchKernelAttrId](25-02_Enumerations.md#aclrtLaunchKernelAttrId).

For the definition of [aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).value, please refer to [aclrtLaunchKernelAttrValue](#aclrtLaunchKernelAttrValue).

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

The member descriptions are as follows:

- schemMode

    Indicates the scheduling mode.

    The values are as follows:

    - 0: normal scheduling mode. The operator starts execution as soon as a core is idle. For example, when numBlocks is 8, the operator kernel function will execute on 8 cores. In this case, if the normal scheduling mode is specified, the operator starts execution as soon as 1 core is idle.
    - 1: batch scheduling mode. The operator starts execution only after all required cores are idle. For example, when numBlocks is 8, the operator kernel function will execute on 8 cores. In this case, if the batch scheduling mode is specified, the operator starts execution only after all 8 cores are idle.

- dynUBufSize

    Used to specify the dynamic memory size of the UB (Unified Buffer) required for SIMT (Single Instruction Multiple Thread) operator execution, in bytes. For pure SIMD operators, this parameter only supports being set to 0.

    The maximum value of the dynUBufSize parameter can be obtained through the [aclrtFunctionGetAvailDynUbufPerBlock](14_Kernel_loading_and_execution.md#aclrtFunctionGetAvailDynUbufPerBlock) API.

    <!-- npu="950" id1 -->
    This parameter is supported only by Ascend 950PR&950DT products.
    <!-- end id1 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-05_Typedefs_res.md#id1 -->

- engineType

    Indicates the operator execution engine. For the type definition, see [aclrtEngineType](25-02_Enumerations.md#aclrtEngineType).

    <!-- npu="310p" id3 -->
    This parameter is supported only by Atlas inference products.
    <!-- end id3 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-05_Typedefs_res.md#id2 -->

- blockDimOffset

    Indicates the numBlocks offset. numBlocks is used to specify the number of cores on which the kernel function of the operator will be executed.

    <!-- npu="310p" id5 -->
    This parameter is supported only by Atlas inference products.
    <!-- end id5 -->

    - **If numBlocks ≤ the number of AI Cores**, there is no need to compute on the Vector Core. You can configure engineType as ACL\_RT\_ENGINE\_TYPE\_AIC (indicating computation on the AI Core), and configure blockDimOffset here as 0.
    - **If numBlocks \> the number of AI Cores**, you need to:
        - Deliver a task on a Stream, configure engineType as ACL\_RT\_ENGINE\_TYPE\_AIC (indicating computation on the AI Core), and configure blockDimOffset here as 0.
        - Deliver a task on another Stream, configure engineType to ACL\_RT\_ENGINE\_TYPE\_AIV (indicating computation on the Vector Core), and configure blockDimOffset to aicorenumBlocks. The formula for calculating aicorenumBlocks is as follows:
            - When numBlocks ≤ the number of AI Cores + the number of Vector Cores, aicorenumBlocks = the number of AI Cores
            - Otherwise, aicorenumBlocks = round up \( numBlocks \* \( the number of AI Cores \) / \( the number of AI Cores + the number of Vector Cores \)\)

    <!-- @ref: runtime/res/docs/zh/api_ref/25-05_Typedefs_res.md#id3 -->

- isBlockTaskPrefetch

    When a task is delivered, whether to prevent the hardware from prefetching the information of this task. The values are as follows: 0, do not prevent; 1, prevent.

- isDataDump

    Indicates whether to enable Dump. The values are as follows: 0, disable; 1, enable.

- timeout

    Indicates the timeout period for the task scheduler to wait for task execution. It applies only to the scenario of executing AI CPU or AI Core operators.

    The values are as follows:

    - 0: indicates permanent waiting.
    - \>0: configures the specific timeout, in seconds.

- timeoutUs

    Indicates the timeout for the task scheduler to wait for task execution, in microseconds. For the type definition, see [aclrtTimeoutUs](25-04_Structs.md#aclrtTimeoutUs).

    If both timeoutLow and timeoutHigh in the aclrtTimeoutUs structure are configured as 0, it indicates permanent waiting.

    For the same Launch Kernel task, the timeoutUs and timeout parameters cannot be configured at the same time; otherwise, an error is returned.

- rsv

    Reserved parameter. Currently fixed to 0.

<br>

<a id="aclrtLaunchKernelCfg"></a>

## aclrtLaunchKernelCfg

```c
typedef struct aclrtLaunchKernelCfg {
    aclrtLaunchKernelAttr *attrs;
    size_t numAttrs;
} aclrtLaunchKernelCfg;
```

For the definition of the attrs structure, refer to [aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).

<br>

<a id="aclrtMallocAttribute"></a>

## aclrtMallocAttribute

```c
typedef struct {
    aclrtMallocAttrType attr;   
    aclrtMallocAttrValue value;  
} aclrtMallocAttribute;
```

| Member Name | Description |
| --- | --- |
| attr | Attribute type. For the type definition, see [aclrtMallocAttrType](25-02_Enumerations.md#aclrtMallocAttrType). |
| value | Attribute value. For the type definition, see [aclrtMallocAttrValue](#aclrtMallocAttrValue). |

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

| Member Name | Description |
| --- | --- |
| moduleId | Module ID. It is recommended to configure it as 33, which indicates APP and is used to indicate that the memory is allocated by the user's application, facilitating problem locating in maintenance and testing scenarios. |
| deviceId | Device ID. If the Device ID configured here is inconsistent with the Device ID currently used for computation, the API returns an error. It is recommended not to configure this attribute value. |
| vaFlag | Whether to use the VA (virtual address) consistency feature when allocating Host memory using the aclrtMallocHostWithCfg API:<br>  - 0: Not used (default value).<br>  - 1: Used. After the allocated Host memory is registered through the [aclrtHostRegister](11-02_host_memory_management.md#aclrtHostRegister) API, the returned devPtr is consistent with ptr (indicating the Host memory address), and the Host and Device can access it using the same VA.<br><br>Only some product models support the VA consistency feature. Using this feature on unsupported models returns an error. |
| rsv | Reserved parameter. Currently fixed to 0. |

<!-- npu="A3,910b" id7 -->
Note that only Atlas A3 products and Atlas A2 products support vaFlag.
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

| Member Name | Description |
| --- | --- |
| attrs | Attribute. This parameter is an array that can store multiple attributes. For the type definition, see [aclrtMallocAttribute](#aclrtMallocAttribute). |
| numAttrs | Number of attributes. |

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

| Member Name | Description |
| --- | --- |
| flags | Memory access protection flag. For the type definition, please refer to [aclrtMemAccessFlags](25-02_Enumerations.md#aclrtMemAccessFlags).<br>Currently only supports ACL_RT_MEM_ACCESS_FLAGS_READWRITE, which indicates that the address range is readable and writable. |
| location | Memory location. For the type definition, please refer to [aclrtMemLocation](#aclrtMemLocation).<br>Currently only supports setting aclrtMemLocation.type to ACL_MEM_LOCATION_TYPE_HOST or ACL_MEM_LOCATION_TYPE_DEVICE. When aclrtMemLocation.type is ACL_MEM_LOCATION_TYPE_HOST, [aclrtMemLocation](#aclrtMemLocation).id is invalid and can be fixed to 0. |
| rsv | Reserved parameter, currently fixed to 0. |

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

| Member Name | Description |
| --- | --- |
| dstLoc | Memory location of the destination. For the type definition, see [aclrtMemLocation](#aclrtMemLocation). |
| srcLoc | Memory location of the source. For the type definition, see [aclrtMemLocation](#aclrtMemLocation). |
| rsv | Reserved parameter, currently fixed to 0. |

<br>

<a id="aclrtMemLocation"></a>

## aclrtMemLocation

```c
typedef struct aclrtMemLocation {
    uint32_t id;                  // Device ID or NUMA (Non-Uniform Memory Access) ID
    aclrtMemLocationType type;    // Memory location
} aclrtMemLocation;
```

For the memory location, see the definition in [aclrtMemLocationType](25-02_Enumerations.md#aclrtMemLocationType).

<br>

<a id="aclrtMemManagedLocation"></a>

## aclrtMemManagedLocation

```c
typedef struct {
    aclrtMemManagedLocationType type;  // Memory location
    int32_t id;                        // Device ID or Non-Uniform Memory Access (NUMA) ID
} aclrtMemManagedLocation;
```

When type is ACL\_MEM\_LOCATIONTYPE\_INVALID, ACL\_MEM\_LOCATIONTYPE\_HOST, or ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA\_CURRENT, id is invalid.

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

| Member Name | Description |
| --- | --- |
| allocationType | Memory allocation type. For the type definition, please refer to [aclrtMemAllocationType](25-02_Enumerations.md#aclrtMemAllocationType).<br>Currently only supports ACL_MEM_ALLOCATION_TYPE_PINNED, which indicates pinned memory. |
| handleType | Handle type. For the type definition, please refer to [aclrtMemHandleType](25-02_Enumerations.md#aclrtMemHandleType). |
| location | Memory location. For the type definition, please refer to [aclrtMemLocation](#aclrtMemLocation).<br>type currently only supports being set to ACL_MEM_LOCATION_TYPE_DEVICE. |
| maxSize | Memory pool size, in bytes. |
| reserved | Reserved field, which must be an all-zero string. |

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

| Member Name | Description |
| --- | --- |
| addr | Error virtual start address of the memory UCE. |
| len | Memory size, in bytes.<br>The memory within the len range starting from addr is abnormal. |
| reserved | Reserved parameter. |

<br>

<a id="aclrtMemUsageInfo"></a>

## aclrtMemUsageInfo

```c
typedef struct aclrtMemUsageInfo {
    char name[32];          // Component name
    uint64_t curMemSize;    // Currently occupied memory size, in bytes
    uint64_t memPeakSize;   // Peak memory of the component, in bytes
    size_t reserved[8];     // Reserved parameter
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

| Member Name | Description |
| --- | --- |
| mean | Mean parameter. For the type definition, see [aclrtRandomParaInfo](#aclrtRandomParaInfo). |
| stddev | Standard deviation parameter. For the type definition, see [aclrtRandomParaInfo](#aclrtRandomParaInfo). |

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

| Member Name | Description |
| --- | --- |
| handleType | Handle type. For the type definition, please refer to [aclrtMemHandleType](25-02_Enumerations.md#aclrtMemHandleType).<br>Currently only supports ACL_MEM_HANDLE_TYPE_NONE. |
| allocationType | Memory allocation type. For the type definition, please refer to [aclrtMemAllocationType](25-02_Enumerations.md#aclrtMemAllocationType).<br>Currently only supports ACL_MEM_ALLOCATION_TYPE_PINNED, which indicates pinned memory. |
| memAttr | Memory attribute. For the type definition, please refer to [aclrtMemAttr](25-02_Enumerations.md#aclrtMemAttr). |
| location | Memory location. For the type definition, please refer to [aclrtMemLocation](#aclrtMemLocation).<br>When type is ACL_MEM_LOCATION_TYPE_HOST, id is invalid and can be fixed to 0. |
| reserve | Reserved. |

<br>

<a id="aclrtPlaceHolderInfo"></a>

## aclrtPlaceHolderInfo

```c
typedef struct {
    uint32_t addrOffset;
    uint32_t dataOffset;
} aclrtPlaceHolderInfo;
```

| Member Name | Description |
| --- | --- |
| addrOffset | Position offset to be refreshed. During launch, the runtime allocates device memory and refreshes the device memory address into hostArgs. This parameter is used to specify the position offset to be refreshed. |
| dataOffset | Offset of the data area. The data area pointed to by the placeholder needs to be copied to the device side. This parameter is used to specify the address offset of the data area relative to hostArgs. |

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

| Member Name | Description |
| --- | --- |
| location | Memory location. For the type definition, please refer to [aclrtMemLocation](#aclrtMemLocation).<br>When type is ACL_MEM_LOCATION_TYPE_HOST, id is invalid. |
| pageSize | Page table size, in bytes. |
| rsv | Reserved parameter. Currently fixed at 0. |

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

| Member Name | Description |
| --- | --- |
| funcType | Function type. For the type definition, see [aclrtRandomNumFuncType](25-02_Enumerations.md#aclrtRandomNumFuncType). |
| dropoutBitmaskInfo | Dropout bitmask information. For the type definition, see [aclrtDropoutBitmaskInfo](#aclrtDropoutBitmaskInfo). |
| uniformDisInfo | Uniform distribution information. For the type definition, see [aclrtUniformDisInfo](#aclrtUniformDisInfo). |
| normalDisInfo | Normal distribution information or truncated normal distribution information. For the type definition, see [aclrtNormalDisInfo](#aclrtNormalDisInfo). |

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

| Member Name | Description |
| --- | --- |
| dataType | Data type of the random number. For the type definition, see [aclDataType](25-02_Enumerations.md#aclDataType).<br>Only the following data types are supported: ACL_INT32, ACL_INT64, ACL_UINT32, ACL_UINT64, ACL_BF16, ACL_FLOAT16, and ACL_FLOAT. |
| randomNumFuncParaInfo | Random number function information, including the function type and parameter information. For the type definition, see [aclrtRandomNumFuncParaInfo](#aclrtRandomNumFuncParaInfo). |
| randomParaAddr | If NULL is passed here, the interface allocates device memory internally to store the data in the randomNumFuncParaInfo parameter. Otherwise, the user allocates device memory and passes the memory address as a parameter. |
| randomResultAddr | Memory address for storing the random number result.<br>The user allocates device memory in advance and passes the memory address as a parameter. |
| randomCounterAddr | Offset for generating random numbers.<br>The user allocates device memory in advance, reads the offset data, and then passes the memory address as a parameter. |
| randomSeed | Random seed. For the type definition, see [aclrtRandomParaInfo](#aclrtRandomParaInfo). |
| randomNum | Number of random numbers. For the type definition, see [aclrtRandomParaInfo](#aclrtRandomParaInfo). |
| rsv | Reserved parameter. Currently fixed to 0. |

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

| Member Name | Description |
| --- | --- |
| isAddr | Value: 0, indicating that the parameter value is stored; 1, indicating that the memory address pointing to the parameter value is stored. |
| valueOrAddr | Stores the parameter value or the memory address pointing to the parameter value.<br>When isAddr=0, fill the corresponding number of bytes based on the data type. For example, for fp16 and bf16, fill the first 2 bytes; for fp32, uint32, and int32, fill the first 4 bytes; for uint64 and int64, fill 8 bytes.<br>When isAddr=1, fill an 8-byte memory address value. |
| size | Number of bytes actually filled in valueOrAddr. |
| rsv | Reserved parameter. Currently fixed to 0. |

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

| Member Name | Description |
| --- | --- |
| srcAddr | Device memory address that stores the data to be refreshed. The data must be organized according to the [aclrtRandomNumTaskInfo](#aclrtRandomNumTaskInfo) structure, and only the randomParaAddr, randomResultAddr, randomCounterAddr, randomSeed, and randomNum parameter values in this structure can be updated. |
| size | Memory size, in bytes. |
| rsv | Reserved parameter. Currently fixed to 0. |

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

| Member Name | Description |
| --- | --- |
| sdid | For the SuperPoD product in Atlas A3 products, sdid (SuperPOD Device ID) indicates the unique device identifier in the SuperPoD product. It can be obtained in advance by calling the [aclGetDeviceInfo](04_device_management.md#aclrtGetDeviceInfo) API. |
| pid | Trustlist array of process IDs on the host. |
| num | Length of the pid array. |

<br>

<a id="aclrtSnapShotBackupArgs"></a>

## aclrtSnapShotBackupArgs

```c
typedef struct aclrtSnapShotBackupArgs {
    uint32_t backupFlags;
    char reserved[60];
} aclrtSnapShotBackupArgs;
```

| Member Name | Description |
| --- | --- |
| backupFlags | Backup flag. |
| reserved | Reserved field. |

<br>

<a id="aclrtSnapShotRestoreArgs"></a>

## aclrtSnapShotRestoreArgs

```c
typedef struct aclrtSnapShotRestoreArgs {
    uint32_t restoreFlags;
    char reserved[60];
} aclrtSnapShotRestoreArgs;
```

| Member Name | Description |
| --- | --- |
| restoreFlags | Restore flag. |
| reserved | Reserved field. |

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
    uint32_t launchBlockingMode;
    uint32_t reserve[4];
} aclrtStreamAttrValue;
```

| Member Name | Description |
| --- | --- |
| failureMode | When setting the ACL_STREAM_ATTR_FAILURE_MODE attribute in aclrtStreamAttr (which indicates the task scheduling mode of a Stream), the attribute values are as follows:<br><br>  - 0: After a task fails, continue to execute the next task. The default value is 0.<br>  - 1: After a task fails, stop executing subsequent tasks, which is usually called stop-on-error. After stop-on-error is triggered, no new tasks can be delivered. When stop-on-error mode is set on a Stream, other Streams in the Context where this Stream resides are also in stop-on-error mode. This constraint applies to the following product models:<br>Atlas A3 products<br>Atlas A2 products |
| overflowSwitch | When setting the ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK attribute in aclrtStreamAttr (which indicates the overflow detection switch), the attribute values are as follows:<br><br>  - 0: Disable overflow detection. The default value is 0.<br>  - 1: Enable overflow detection. |
| userCustomTag | When setting the ACL_STREAM_ATTR_USER_CUSTOM_TAG attribute in aclrtStreamAttr (which indicates the overflow detection group tag), the attribute value range is 0 to the maximum value of the uint32_t type. |
| cacheOpInfoSwitch | When setting the ACL_STREAM_ATTR_CACHE_OP_INFO attribute in aclrtStreamAttr (which indicates the operator information cache switch), the attribute values are as follows:<br><br>  - 0: Disable the operator information cache switch. The default value is 0.<br>  - 1: Enable the operator information cache switch. |
| streamPriority | When setting the ACL_STREAM_ATTR_PRIORITY attribute in aclrtStreamAttr (which indicates the stream priority), the attribute value range is 0 to 7. A smaller value indicates a higher priority level. The default value is 0.|
| launchBlockingMode | When setting the ACL_STREAM_LAUNCH_BLOCKING_MODE attribute in aclrtStreamAttr, it is used to control whether the following APIs execute in synchronous mode or asynchronous mode on the specified Stream:<br><br>  - aclrtLaunchKernel<br>  - aclrtLaunchKernelV2<br>  - aclrtLaunchKernelWithConfig<br>  - aclrtLaunchKernelWithHostArgs<br>  - aclrtLaunchKernelWithArgsArray<br>  - aclrtLaunchSIMTKernelWithArgsArray<br>  - aclrtLaunchSIMTKernelWithHostArgs<br>  - aclmdlRIExecuteAsync<br><br>The attribute values are the following macros:<br><br>  - ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV: default value. The execution mode of the above APIs is controlled by the ASCEND_RT_LAUNCH_BLOCKING environment variable. When the environment variable is configured as 1, synchronous mode is used; in other cases, asynchronous mode is used.<br>  - ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING: the above APIs use asynchronous mode.<br>  - ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING: the above APIs use synchronous mode.<br><br>The macro definitions are as follows:<br>#define ACL_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV 0x00000000U<br>#define ACL_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING 0x00000001U<br>#define ACL_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING 0x00000002U<br><br>Between the [aclrtNonBlockingLaunchBegin](06_stream_management.md#aclrtNonBlockingLaunchBegin) and [aclrtNonBlockingLaunchEnd](06_stream_management.md#aclrtNonBlockingLaunchEnd) APIs, the specified Stream remains in asynchronous mode and does not perform synchronous waiting. |
| reserve | Reserved value. |

<br>

<a id="aclrtTaskUpdateInfo"></a>

## aclrtTaskUpdateInfo

```c
typedef struct { 
    aclrtUpdateTaskAttrId id;    
    aclrtUpdateTaskAttrVal val;  
} aclrtTaskUpdateInfo;
```

| Member Name | Description |
| --- | --- |
| id | Task category to be updated. For the type definition, see [aclrtUpdateTaskAttrId](25-02_Enumerations.md#aclrtUpdateTaskAttrId). |
| val | Task information to be updated. For the type definition, see [aclrtUpdateTaskAttrVal](#aclrtUpdateTaskAttrVal). |

<!-- npu="A3,910b" id8 -->
Atlas A3 products and Atlas A2 products support random number generation tasks.
<!-- end id8 -->

<!-- npu="310p" id9 -->
Atlas inference products do not support random number generation tasks.
<!-- end id9 -->

<br>

<a id="aclrtTimeoutUs"></a>

## aclrtTimeoutUs

```c
typedef struct {
    uint32_t timeoutLow;  // Low 32 bits of the timeout value.
    uint32_t timeoutHigh; // High 32 bits of the timeout value.
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

| Member Name | Description |
| --- | --- |
| min | Minimum value parameter. For the type definition, see [aclrtRandomParaInfo](#aclrtRandomParaInfo). |
| max | Maximum value parameter. For the type definition, see [aclrtRandomParaInfo](#aclrtRandomParaInfo). |

<br>

<a id="aclrtUpdateTaskAttrVal"></a>

## aclrtUpdateTaskAttrVal

```c
typedef union { 
    aclrtRandomTaskUpdateAttr randomTaskAttr; 
    aclrtAicAivTaskUpdateAttr aicAivTaskAttr; 
} aclrtUpdateTaskAttrVal;
```

| Member Name | Description |
| --- | --- |
| randomTaskAttr | Random number generation task. For the type definition, please refer to [aclrtRandomTaskUpdateAttr](25-04_Structs.md#aclrtRandomTaskUpdateAttr).<br>Different models support this task differently:<br>Atlas A3 products support the random number generation task.<br>Atlas A2 products support the random number generation task. |
| aicAivTaskAttr | Compute task executed on the Cube\Vector compute unit. For the type definition, please refer to [aclrtAicAivTaskUpdateAttr](25-04_Structs.md#aclrtAicAivTaskUpdateAttr). |

<br>

<a id="aclrtUtilizationInfo"></a>

## aclrtUtilizationInfo

```c
typedef struct aclrtUtilizationInfo {
    int32_t cubeUtilization;   // Cube utilization
    int32_t vectorUtilization; // Vector utilization
    int32_t aicpuUtilization;  // AI CPU utilization
    int32_t memoryUtilization; // Device memory utilization
    aclrtUtilizationExtendInfo *utilizationExtend; // Reserved parameter, currently set to null
} aclrtUtilizationInfo;
```

<br>

<a id="aclrtUuid"></a>

## aclrtUuid

```c
 typedef struct aclrtUuid {
    char  bytes[16];    // A 16-byte string that serves as the unique identifier of a device.
} aclrtUuid;
```

<br>

<a id="dim3"></a>

## dim3

```c
typedef struct dim3 {
    uint32_t x;
    uint32_t y;
    uint32_t z;
#ifdef __cplusplus
#if __cplusplus >= 201103L
    constexpr dim3(uint32_t vx = 1, uint32_t vy = 1, uint32_t vz = 1) : x(vx), y(vy), z(vz) {}
#else
    dim3(uint32_t vx = 1, uint32_t vy = 1, uint32_t vz = 1) : x(vx), y(vy), z(vz) {}
#endif
#endif // __cplusplus
} dim3;
```

- In a C++ environment, dim3 provides a default constructor, and the three member variables are initialized to 1 by default.
- In a C language environment, dim3 is an ordinary structure, and each member variable must be explicitly initialized when it is used.

<br>
