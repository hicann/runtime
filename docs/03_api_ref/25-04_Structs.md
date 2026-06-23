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
- [aclrtTaskUpdateInfo](#aclrtTaskUpdateInfo)
- [aclrtTimeoutUs](#aclrtTimeoutUs)
- [aclrtUniformDisInfo](#aclrtUniformDisInfo)
- [aclrtUtilizationInfo](#aclrtUtilizationInfo)
- [aclrtUuid](#aclrtUuid)

<br>

<a id="aclCANNPackageVersion"></a>

## aclCANNPackageVersion

```
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

```
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

```
typedef struct aclmdlRIEventRecordTaskParams {
    aclrtEvent event;
    uint32_t eventFlag;
    uint32_t recordFlag;
} aclmdlRIEventRecordTaskParams;
```


| 成员名称 | 描述 |
| --- | --- |
| event | 指定Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| eventFlag | Event flag。请参见aclrtCreateEventWithFlag或[aclrtCreateEventExWithFlag](07_Event管理.md#aclrtCreateEventExWithFlag)中的flag说明。 |
| recordFlag | Event Record flag。 |

<br>

<a id="aclmdlRIEventResetTaskParams"></a>

## aclmdlRIEventResetTaskParams

```
typedef struct aclmdlRIEventResetTaskParams {
    aclrtEvent event;
    uint32_t eventFlag;
    uint32_t resetFlag;
} aclmdlRIEventResetTaskParams;
```


| 成员名称 | 描述 |
| --- | --- |
| event | 指定Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| eventFlag | Event flag。请参见[aclrtCreateEventExWithFlag](07_Event管理.md#aclrtCreateEventExWithFlag)中的flag说明。 |
| resetFlag | Event flag。 |

<br>

<a id="aclmdlRIEventWaitTaskParams"></a>

## aclmdlRIEventWaitTaskParams

```
typedef struct aclmdlRIEventWaitTaskParams {
    aclrtEvent event;
    uint32_t eventFlag;
    uint32_t waitFlag;
} aclmdlRIEventWaitTaskParams;
```


| 成员名称 | 描述 |
| --- | --- |
| event | 指定Event。类型定义请参见[aclrtEvent](25-05_Typedefs.md#aclrtEvent)。 |
| eventFlag | Event flag。请参见[aclrtCreateEventExWithFlag](07_Event管理.md#aclrtCreateEventExWithFlag)中的flag说明。 |
| waitFlag | Event flag。 |

<br>

<a id="aclmdlRIKernelTaskParams"></a>

## aclmdlRIKernelTaskParams

```
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

```
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

```
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
| flag | 比较的方式，等满足条件后解除阻塞。取值请参见[aclrtValueWait](11-09_流内存操作.md#aclrtValueWait)中的说明。 |

<br>

<a id="aclmdlRIValueWriteTaskParams"></a>

## aclmdlRIValueWriteTaskParams

```
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

```
typedef struct { 
    void *binHandle;      
    void *funcEntryAddr;  
    void *blockDimAddr;   
    uint32_t rsv[4];      
} aclrtAicAivTaskUpdateAttr;
```


| 成员名称 | 说明 |
| --- | --- |
| binHandle | 存放待刷新的算子二进制句柄，可调用[aclrtBinaryLoadFromFile](14_Kernel加载与执行.md#aclrtBinaryLoadFromFile)或[aclrtBinaryLoadFromData](14_Kernel加载与执行.md#aclrtBinaryLoadFromData)接口获取算子二进制句柄。 |
| funcEntryAddr | 存放Function Entry（用于标识函数的关键字）的Device内存地址。 |
| blockDimAddr | 存放numBlocks(用于指定核函数将会在几个核上执行)的Device内存地址 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtBarrierCmoInfo"></a>

## aclrtBarrierCmoInfo

```
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

```
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

```
typedef struct {
    aclrtBinaryLoadOptionType type;
    aclrtBinaryLoadOptionValue value;
} aclrtBinaryLoadOption;
```

加载算子二进制文件时，每个参数是由参数类型aclrtBinaryLoadOption.type及其对应的参数值aclrtBinaryLoadOption.value组成，例如，[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).type为ACL\_RT\_BINARY\_LOAD\_OPT\_LAZY\_LOAD时，[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).value需根据isLazyLoad的取值来配置。

[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).type的定义请参见[aclrtBinaryLoadOptionType](25-02_Enumerations.md#aclrtBinaryLoadOptionType)。

[aclrtBinaryLoadOption](#aclrtBinaryLoadOption).value的定义请参见[aclrtBinaryLoadOptionValue](25-05_Typedefs.md#aclrtBinaryLoadOptionValue)。

<br>

<a id="aclrtBinaryLoadOptions"></a>

## aclrtBinaryLoadOptions

```
typedef struct aclrtBinaryLoadOptions {
    aclrtBinaryLoadOption *options;
    size_t numOpt;
} aclrtBinaryLoadOptions;
```

options结构体的定义请参见[aclrtBinaryLoadOption](#aclrtBinaryLoadOption)。

<br>

<a id="aclrtCntNotifyRecordInfo"></a>

## aclrtCntNotifyRecordInfo

```
typedef struct {
    aclrtCntNotifyRecordMode mode;     // Record的行为模式
    uint32_t value;                    
} aclrtCntNotifyRecordInfo;
```

mode枚举值的定义请参见[aclrtCntNotifyRecordMode](25-02_Enumerations.md#aclrtCntNotifyRecordMode)。

<br>

<a id="aclrtCntNotifyWaitInfo"></a>

## aclrtCntNotifyWaitInfo

```
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

```
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

```
#define ACL_IPC_EVENT_HANDLE_SIZE 64U
typedef struct aclrtIpcEventHandle {
    char reserved[ACL_IPC_EVENT_HANDLE_SIZE];
} aclrtIpcEventHandle;
```

<br>

<a id="aclrtLaunchKernelAttr"></a>

## aclrtLaunchKernelAttr

```
typedef struct aclrtLaunchKernelAttr {
    aclrtLaunchKernelAttrId id;
    aclrtLaunchKernelAttrValue value;
} aclrtLaunchKernelAttr;
```

Launch Kernel时，每个属性是由属性标识aclrtLaunchKernelAttr.id及其对应的属性值aclrtLaunchKernelAttr.value组成，例如，[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).id为ACL\_RT\_LAUNCH\_KERNEL\_ATTR\_SCHEM\_MODE时，[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).value需根据schemMode的取值来配置。

[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).id的定义请参见[aclrtLaunchKernelAttrId](25-02_Enumerations.md#aclrtLaunchKernelAttrId)。

[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr).value的定义请参见[aclrtLaunchKernelAttrValue](25-05_Typedefs.md#aclrtLaunchKernelAttrValue)。

<br>

<a id="aclrtLaunchKernelCfg"></a>

## aclrtLaunchKernelCfg

```
typedef struct aclrtLaunchKernelCfg {
    aclrtLaunchKernelAttr *attrs;
    size_t numAttrs;
} aclrtLaunchKernelCfg;
```

attrs结构体定义请参见[aclrtLaunchKernelAttr](#aclrtLaunchKernelAttr)。

<br>

<a id="aclrtMallocAttribute"></a>

## aclrtMallocAttribute

```
typedef struct {
    aclrtMallocAttrType attr;   
    aclrtMallocAttrValue value;  
} aclrtMallocAttribute;
```


| 成员名称 | 说明 |
| --- | --- |
| attr | 属性类型。类型定义请参见[aclrtMallocAttrType](25-02_Enumerations.md#aclrtMallocAttrType)。 |
| value | 属性值。类型定义请参见[aclrtMallocAttrValue](25-05_Typedefs.md#aclrtMallocAttrValue)。 |

<br>

<a id="aclrtMallocConfig"></a>

## aclrtMallocConfig

```
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

```
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

```
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

```
typedef struct aclrtMemLocation {
    uint32_t id;                  // Device ID或NUMA（Non-Uniform Memory Access） ID
    aclrtMemLocationType type;    // 内存所在位置
} aclrtMemLocation;
```

内存所在位置请参见[aclrtMemLocationType](25-02_Enumerations.md#aclrtMemLocationType)中的定义。

<br>

<a id="aclrtMemManagedLocation"></a>

## aclrtMemManagedLocation

```
typedef struct {
    aclrtMemManagedLocationType type;  // 内存所在位置
    int id;                            // Device ID或NUMA（Non-Uniform Memory Access） ID
} aclrtMemManagedLocation;
```

当type为ACL\_MEM\_LOCATIONTYPE\_INVALID、ACL\_MEM\_LOCATIONTYPE\_HOST、ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA\_CURRENT时，id无效。

<br>

<a id="aclrtMemPoolProps"></a>

## aclrtMemPoolProps

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
typedef struct {
    uint32_t sdid; 
    int32_t *pid;  
    size_t num; 
} aclrtServerPid;
```


| 成员名称 | 说明 |
| --- | --- |
| sdid | 针对Atlas A3 训练系列产品/Atlas A3 推理系列产品中的超节点产品，sdid（SuperPOD Device ID）表示超节点产品中的Device唯一标识，可提前调用[aclGetDeviceInfo](04_Device管理.md#aclrtGetDeviceInfo)接口获取。 |
| pid | Host侧进程ID白名单数组。 |
| num | pid数组长度。 |

<br>

<a id="aclrtSnapShotBackupArgs"></a>

## aclrtSnapShotBackupArgs

```
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

```
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

<a id="aclrtTaskUpdateInfo"></a>

## aclrtTaskUpdateInfo

```
typedef struct { 
    aclrtUpdateTaskAttrId id;    
    aclrtUpdateTaskAttrVal val;  
} aclrtTaskUpdateInfo;
```


| 成员名称 | 说明 |
| --- | --- |
| id | 待更新的任务类别。类型定义请参见[aclrtUpdateTaskAttrId](25-02_Enumerations.md#aclrtUpdateTaskAttrId)。 |
| val | 待更新的任务信息。类型定义请参见[aclrtUpdateTaskAttrVal](25-05_Typedefs.md#aclrtUpdateTaskAttrVal)。 |

<br>

<a id="aclrtTimeoutUs"></a>

## aclrtTimeoutUs

```
typedef struct {
    uint32_t timeoutLow;  // 超时时间的低32位值
    uint32_t timeoutHigh; // 超时时间的高32位值
} aclrtTimeoutUs;
```

<br>

<a id="aclrtUniformDisInfo"></a>

## aclrtUniformDisInfo

```
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

```
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

```
 typedef struct aclrtUuid {
    char  bytes[16];    // 一个16字节的字符串，作为Device的唯一标识
} aclrtUuid;
```
