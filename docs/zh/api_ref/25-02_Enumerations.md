# Enumerations

enum 类型数据。

<br>

- [aclCannAttr](#aclCannAttr)
- [aclCANNPackageName](#aclCANNPackageName)
- [aclDataType](#aclDataType)
- [aclDeviceInfo](#aclDeviceInfo)
- [acldumpType](#acldumpType)
- [aclFormat](#aclFormat)
- [aclmdlRICaptureMode](#aclmdlRICaptureMode)
- [aclmdlRICaptureStatus](#aclmdlRICaptureStatus)
- [aclmdlRICondHandleFlag](#aclmdlRICondHandleFlag)
- [aclmdlRICondTaskType](#aclmdlRICondTaskType)
- [aclmdlRITaskType](#aclmdlRITaskType)
- [aclMemType](#aclMemType)
- [aclplatformCoreType](#aclplatformCoreType)
- [aclplatformDevInfo](#aclplatformDevInfo)
- [aclplatformLocalMemType](#aclplatformLocalMemType)
- [aclplatformNpuArch](#aclplatformNpuArch)
- [aclprofAicoreMetrics](#aclprofAicoreMetrics)
- [aclprofConfigType](#aclprofConfigType)
- [aclprofEventAttributes](#aclprofEventAttributes)
- [aclprofStepTag](#aclprofStepTag)
- [aclRegisterCallbackType](#aclRegisterCallbackType)
- [aclrtAtomicOperation](#aclrtAtomicOperation)
- [aclrtAtomicOperationCapability](#aclrtAtomicOperationCapability)
- [aclrtBinaryLoadOptionType](#aclrtBinaryLoadOptionType)
- [aclrtCmoType](#aclrtCmoType)
- [aclrtCntNotifyRecordMode](#aclrtCntNotifyRecordMode)
- [aclrtCntNotifyWaitMode](#aclrtCntNotifyWaitMode)
- [aclrtCompareDataType](#aclrtCompareDataType)
- [aclrtCondition](#aclrtCondition)
- [aclrtDevAttr](#aclrtDevAttr)
- [aclrtDevFeatureType](#aclrtDevFeatureType)
- [aclrtDeviceStatus](#aclrtDeviceStatus)
- [aclrtDevResLimitType](#aclrtDevResLimitType)
- [aclrtEngineType](#aclrtEngineType)
- [aclrtEventRecordedStatus](#aclrtEventRecordedStatus)
- [aclrtEventStatus](#aclrtEventStatus)
- [aclrtEventWaitStatus](#aclrtEventWaitStatus)
- [aclrtFloatOverflowMode](#aclrtFloatOverflowMode)
- [aclrtFuncAttribute](#aclrtFuncAttribute)
- [aclrtGroupAttr](#aclrtGroupAttr)
- [aclrtHacType](#aclrtHacType)
- [aclrtHostMemMapCapability](#aclrtHostMemMapCapability)
- [aclrtHostRegisterType](#aclrtHostRegisterType)
- [aclrtIpcMemAttrType](#aclrtIpcMemAttrType)
- [aclrtKernelType](#aclrtKernelType)
- [aclrtLastErrLevel](#aclrtLastErrLevel)
- [aclrtLaunchKernelAttrId](#aclrtLaunchKernelAttrId)
- [aclrtMallocAttrType](#aclrtMallocAttrType)
- [aclrtMemAccessFlags](#aclrtMemAccessFlags)
- [aclrtMemAllocationType](#aclrtMemAllocationType)
- [aclrtMemAttr](#aclrtMemAttr)
- [aclrtMemcpyKind](#aclrtMemcpyKind)
- [aclrtMemGranularityOptions](#aclrtMemGranularityOptions)
- [aclrtMemHandleType](#aclrtMemHandleType)
- [aclrtMemLocationType](#aclrtMemLocationType)
- [aclrtMemMallocPolicy](#aclrtMemMallocPolicy)
- [aclrtMemManagedAdviseType](#aclrtMemManagedAdviseType)
- [aclrtMemManagedLocationType](#aclrtMemManagedLocationType)
- [aclrtMemManagedRangeAttribute](#aclrtMemManagedRangeAttribute)
- [aclrtMemPoolAttr](#aclrtMemPoolAttr)
- [aclrtMemSharedHandleType](#aclrtMemSharedHandleType)
- [aclrtRandomNumFuncType](#aclrtRandomNumFuncType)
- [aclrtReduceKind](#aclrtReduceKind)
- [aclrtRunMode](#aclrtRunMode)
- [aclrtSnapShotStage](#aclrtSnapShotStage)
- [aclrtStreamAttr](#aclrtStreamAttr)
- [aclrtStreamConfigAttr](#aclrtStreamConfigAttr)
- [aclrtStreamStatus](#aclrtStreamStatus)
- [aclrtUpdateTaskAttrId](#aclrtUpdateTaskAttrId)
- [aclSysParamOpt](#aclSysParamOpt)
- [acltdtQueueAttrType](#acltdtQueueAttrType)
- [acltdtQueueRouteParamType](#acltdtQueueRouteParamType)
- [acltdtQueueRouteQueryInfoParamType](#acltdtQueueRouteQueryInfoParamType)
- [acltdtQueueRouteQueryMode](#acltdtQueueRouteQueryMode)
- [acltdtTensorType](#acltdtTensorType)

<br>

<a id="aclCannAttr"></a>

## aclCannAttr

```c
typedef enum {
    ACL_CANN_ATTR_UNDEFINED = -1,   // 未知特性
    ACL_CANN_ATTR_INF_NAN = 0,      // 溢出检测Inf/NaN模式
    ACL_CANN_ATTR_BF16 = 1,         // bf16数据类型
    ACL_CANN_ATTR_JIT_COMPILE = 2   // 算子二进制特性
} aclCannAttr;
```

<br>

<a id="aclCANNPackageName"></a>

## aclCANNPackageName

设置为ACL\_PKG\_NAME\_CANN，表示查询CANN的版本号；设置为其它值，表示查询CANN中具体某个模块的版本号。

```c
typedef enum aclCANNPackageName {
    ACL_PKG_NAME_CANN, 
    ACL_PKG_NAME_RUNTIME,
    ACL_PKG_NAME_COMPILER,
    ACL_PKG_NAME_HCCL,
    ACL_PKG_NAME_TOOLKIT,
    ACL_PKG_NAME_OPP,
    ACL_PKG_NAME_OPP_KERNEL,
    ACL_PKG_NAME_DRIVER
} aclCANNPackageName;
```

<br>

<a id="aclDataType"></a>

## aclDataType

```c
typedef enum {
    ACL_DT_UNDEFINED = -1,  //未知数据类型，默认值
    ACL_FLOAT = 0,          // fp32
    ACL_FLOAT16 = 1,
    ACL_INT8 = 2,
    ACL_INT32 = 3,
    ACL_UINT8 = 4,
    ACL_INT16 = 6,
    ACL_UINT16 = 7,
    ACL_UINT32 = 8,
    ACL_INT64 = 9,
    ACL_UINT64 = 10,
    ACL_DOUBLE = 11,
    ACL_BOOL = 12,
    ACL_STRING = 13,
    ACL_COMPLEX64 = 16,
    ACL_COMPLEX128 = 17,
    ACL_BF16 = 27,
    ACL_INT4 = 29,
    ACL_UINT1 = 30,
    ACL_COMPLEX32 = 33,
    ACL_HIFLOAT8 = 34,      
    ACL_FLOAT8_E5M2 = 35,   
    ACL_FLOAT8_E4M3FN = 36, 
    ACL_FLOAT8_E8M0 = 37,   
    ACL_FLOAT6_E3M2 = 38,   
    ACL_FLOAT6_E2M3 = 39,   
    ACL_FLOAT4_E2M1 = 40,   
    ACL_FLOAT4_E1M2 = 41,   
} aclDataType;
```

<!-- npu="950" id1 -->
对于Ascend 950PR/Ascend 950DT，支持33\~41的枚举选项。
<!-- end id1 -->

<!-- npu="A3,910b" id2 -->
对于Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，不支持33\~41的枚举选项。
<!-- end id2 -->

<!-- npu="910,310p,310b" id3 -->
对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，不支持33\~41的枚举选项。
<!-- end id3 -->

<!-- npu="IPV350" id4 -->
对于33\~41的枚举选项，当前不支持。
<!-- end id4 -->

<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id1 -->

<br>

<a id="aclDeviceInfo"></a>

## aclDeviceInfo

```c
typedef enum {
    ACL_DEVICE_INFO_UNDEFINED = -1,       // 未知规格
    ACL_DEVICE_INFO_AI_CORE_NUM = 0,      // AI Core数量
    ACL_DEVICE_INFO_VECTOR_CORE_NUM = 1,  // Vector Core数量
    ACL_DEVICE_INFO_L2_SIZE = 2           // L2 Buffer大小，单位Byte
} aclDeviceInfo;
```

<br>

<a id="acldumpType"></a>

## acldumpType

```c
enum acldumpType {
    AIC_ERR_BRIEF_DUMP = 1,         // 轻量化exception dump
    AIC_ERR_NORM_DUMP = 2,          // 普通exception dump，在轻量化exception dump基础上，还会导出Shape、Data Type、Format以及属性信息
    AIC_ERR_DETAIL_DUMP = 3,        // 在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息
    DATA_DUMP = 4,                  // 模型Dump配置、单算子Dump配置
    OVERFLOW_DUMP = 5               // 溢出算子Dump
};
```

<br>

<a id="aclFormat"></a>

## aclFormat

```c
typedef enum {
    ACL_FORMAT_UNDEFINED = -1,
    ACL_FORMAT_NCHW = 0,
    ACL_FORMAT_NHWC = 1,
    ACL_FORMAT_ND = 2,
    ACL_FORMAT_NC1HWC0 = 3,
    ACL_FORMAT_FRACTAL_Z = 4,
    ACL_FORMAT_NC1HWC0_C04 = 12,
    ACL_FORMAT_HWCN = 16,
    ACL_FORMAT_NDHWC = 27,
    ACL_FORMAT_FRACTAL_NZ = 29,
    ACL_FORMAT_NCDHW = 30,
    ACL_FORMAT_NDC1HWC0 = 32,
    ACL_FRACTAL_Z_3D = 33,
    ACL_FORMAT_NC = 35,
    ACL_FORMAT_NCL = 47,
    ACL_FORMAT_FRACTAL_NZ_C0_16 = 50,
    ACL_FORMAT_FRACTAL_NZ_C0_32 = 51,
    ACL_FORMAT_FRACTAL_NZ_C0_2 = 52, 
    ACL_FORMAT_FRACTAL_NZ_C0_4 = 53, 
    ACL_FORMAT_FRACTAL_NZ_C0_8 = 54, 
} aclFormat;
```

各维度的含义如下：N（Batch）表示批量大小、H（Height）表示特征图高度、W（Width）表示特征图宽度、C（Channels）表示特征图通道、D（Depth）表示特征图深度、L是特征图长度。

aclFormat各项含义如下：

- UNDEFINED：未知格式，默认值。
- NCHW：4维数据格式。
- NHWC：4维数据格式。
- ND：表示支持任意格式，除了Square、Tanh等这些单输入对自身处理的算子外，其他算子需谨慎使用。
- NC1HWC0：5维数据格式。其中，C0与微架构强相关，该值等于cube单元的size，例如16；C1是将C维度按照C0切分：C1=C/C0， 若结果不整除，最后一份数据需要padding到C0。
- FRACTAL\_Z：卷积的权重的格式。
- NC1HWC0\_C04：5维数据格式。其中，C0固定为4，C1是将C维度按照C0切分：C1=C/C0， 若结果不整除，最后一份数据需要padding到C0。当前版本不支持。
- HWCN：4维数据格式。
- NDHWC：NDHWC格式。对于3维图像就需要使用带D（Depth）维度的格式。
- FRACTAL\_NZ：内部分形格式。用户目前无需使用。
- NCDHW：NCDHW格式。对于3维图像就需要使用带D（Depth）维度的格式。
- NDC1HWC0：6维数据格式。相比于NC1HWC0，仅多了D（Depth）维度。
- FRACTAL\_Z\_3D：3D卷积权重格式，例如Conv3D/MaxPool3D/AvgPool3D这些算子都需要这种格式来表达。
- NC：2维数据格式。
- NCL：3维数据格式。
- FRACTAL\_NZ\_C0\__\[M\]_：内部用于分形的特殊数据排布格式，_\[M\]_代表C0的数值，当前支持（2, 4, 8, 16, 32）。用户目前无需使用。

    <!-- npu="950" id5 -->
    仅Ascend 950PR/Ascend 950DT支持该类型。
    <!-- end id5 -->

<br>

<a id="aclmdlRICaptureMode"></a>

## aclmdlRICaptureMode

```c
typedef enum {
    ACL_MODEL_RI_CAPTURE_MODE_GLOBAL = 0,   // 全局禁止，所有线程都不可以调用非安全函数
    ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL, // 当前线程禁止调用非安全函数
    ACL_MODEL_RI_CAPTURE_MODE_RELAXED,      // 全局不禁止，所有线程都可以调用非安全函数
} aclmdlRICaptureMode;
```

<br>

<a id="aclmdlRICaptureStatus"></a>

## aclmdlRICaptureStatus

```c
typedef enum {
    ACL_MODEL_RI_CAPTURE_STATUS_NONE = 0,    // Stream不在捕获状态
    ACL_MODEL_RI_CAPTURE_STATUS_ACTIVE,      // Stream处于正常捕获状态
    ACL_MODEL_RI_CAPTURE_STATUS_INVALIDATED, // 捕获失败状态
} aclmdlRICaptureStatus;
```

<br>

<a id="aclmdlRICondHandleFlag"></a>

## aclmdlRICondHandleFlag

```c
typedef enum {
    ACL_MODEL_RI_COND_HANDLE_ASSIGN_DEFAULT = 1,     // 条件变量在每次模型执行开始时初始化为defaultLaunchValue
} aclmdlRICondHandleFlag;
```

<br>

<a id="aclmdlRICondTaskType"></a>

## aclmdlRICondTaskType

```c
typedef enum {
    ACL_MODEL_RI_COND_TYPE_IF = 0,      // IF条件类型
    ACL_MODEL_RI_COND_TYPE_WHILE = 1,   // WHILE条件类型
    ACL_MODEL_RI_COND_TYPE_SWITCH = 2,  // SWITCH条件类型
} aclmdlRICondTaskType;
```

<br>

<a id="aclmdlRITaskType"></a>

## aclmdlRITaskType

```c
typedef enum aclmdlRITaskType {
    ACL_MODEL_RI_TASK_DEFAULT,      // 除以下类型之外的其他类型
    ACL_MODEL_RI_TASK_KERNEL,       // Cube Core或Vector Core上计算任务
    ACL_MODEL_RI_TASK_EVENT_RECORD, // Event Record任务，通常对应aclrtRecordEvent接口下发的任务
    ACL_MODEL_RI_TASK_EVENT_WAIT,   // Event Wait任务，通常对应aclrtStreamWaitEvent或aclrtStreamWaitEventWithTimeout接口下发的任务
    ACL_MODEL_RI_TASK_EVENT_RESET,  // Event Reset任务，通常对应aclrtResetEvent接口下发的任务
    ACL_MODEL_RI_TASK_VALUE_WRITE,  // Value Write任务，通常对应aclrtValueWrite接口下发的任务
    ACL_MODEL_RI_TASK_VALUE_WAIT,   // Value Wait任务，通常对应aclrtValueWait接口下发的任务
} aclmdlRITaskType;
```

<br>

<a id="aclMemType"></a>

## aclMemType

<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id2 -->

```c
typedef enum {
    ACL_MEMTYPE_DEVICE = 0,  //Device内存
    ACL_MEMTYPE_HOST = 1,    //Host内存
    ACL_MEMTYPE_HOST_COMPILE_INDEPENDENT = 2   //Host内存
} aclMemType;
```

ACL\_MEMTYPE\_HOST和ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT都标识Host内存，但在使用上有区别：

- ACL\_MEMTYPE\_HOST：若通过aclSetCompileopt接口将ACL\_OP\_JIT\_COMPILE设置为disable，设置该选项时，算子输入或输出的值的变化，不会触发算子重新编译；若通过aclSetCompileopt接口将ACL\_OP\_JIT\_COMPILE设置为enable，算子输入或输出的值的变化，会触发算子重新编译。
- ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT ：设置该选项时，算子输入或输出的值的变化，都不会触发算子重新编译。若算子编译时依赖其输入或输出的值，此时如果设置为ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT，则可能会导致编译失败。

<br>

<a id="aclplatformCoreType"></a>

## aclplatformCoreType

```c
typedef enum aclplatformCoreType {
    ACL_PLATFORM_CORE_TYPE_AI_CORE     = 0,
    ACL_PLATFORM_CORE_TYPE_VECTOR_CORE = 1,
} aclplatformCoreType;
```

| 枚举项 | 说明 |
| --- | --- |
| ACL_PLATFORM_CORE_TYPE_AI_CORE | Cube Core，负责矩阵乘等高算力运算。 |
| ACL_PLATFORM_CORE_TYPE_VECTOR_CORE | Vector Core，负责向量及标量类运算。 |

<br>

<a id="aclplatformDevInfo"></a>

## aclplatformDevInfo

```c
typedef enum aclplatformDevInfo {
    ACL_PLATFORM_AICORE_CNT        = 0,
    ACL_PLATFORM_AICORE_UB_SIZE    = 1,
    ACL_PLATFORM_CUBE_CORE_CNT     = 2,
    ACL_PLATFORM_VECTOR_CORE_CNT   = 3,
    ACL_PLATFORM_L2_SIZE           = 4,
    ACL_PLATFORM_MEMORY_SIZE       = 5,
    ACL_PLATFORM_CUBE_FREQ         = 6,
    ACL_PLATFORM_VEC_FREQ          = 7,
    ACL_PLATFORM_BT_SIZE           = 8,
    ACL_PLATFORM_L0_A_SIZE         = 9,
    ACL_PLATFORM_L0_B_SIZE         = 10,
    ACL_PLATFORM_L0_C_SIZE         = 11,
    ACL_PLATFORM_L1_SIZE           = 12,
    ACL_PLATFORM_SOC_VERSION       = 13,
    ACL_PLATFORM_AIC_VERSION       = 14,
    ACL_PLATFORM_NPU_ARCH          = 15,
    ACL_PLATFORM_MEMORY_TYPE       = 16,
} aclplatformDevInfo;
```

| 枚举项 | 说明 |
| --- | --- |
| ACL_PLATFORM_AICORE_CNT | AI Core的数量。 |
| ACL_PLATFORM_AICORE_UB_SIZE | 单个AI Core的UB（Unified Buffer）大小，单位Byte。 |
| ACL_PLATFORM_CUBE_CORE_CNT | Cube Core的数量。 |
| ACL_PLATFORM_VECTOR_CORE_CNT | Vector Core的数量。 |
| ACL_PLATFORM_L2_SIZE | L2 Cache的大小，单位Byte。 |
| ACL_PLATFORM_MEMORY_SIZE | 设备内存大小，单位Byte。 |
| ACL_PLATFORM_CUBE_FREQ | Cube Core的工作频率，单位MHz。 |
| ACL_PLATFORM_VEC_FREQ | Vector Core的工作频率，单位MHz。 |
| ACL_PLATFORM_BT_SIZE | Base Tile基础分块大小，单位Byte。 |
| ACL_PLATFORM_L0_A_SIZE | L0-A缓冲区大小，单位Byte。用于Cube Core矩阵运算的左矩阵输入缓存。 |
| ACL_PLATFORM_L0_B_SIZE | L0-B缓冲区大小，单位Byte。用于Cube Core矩阵运算的右矩阵输入缓存。 |
| ACL_PLATFORM_L0_C_SIZE | L0-C缓冲区大小，单位Byte。用于Cube Core矩阵运算的输出结果缓存。 |
| ACL_PLATFORM_L1_SIZE | L1缓冲区大小，单位Byte。 |
| ACL_PLATFORM_SOC_VERSION | AI处理器型号名称。 |
| ACL_PLATFORM_AIC_VERSION | AI Core版本字符串。 |
| ACL_PLATFORM_NPU_ARCH | NPU架构版本，返回值对应[aclplatformNpuArch](#aclplatformNpuArch)枚举的整数值。<br><br> Ascend 950PR/Ascend 950DT对应NPU架构版本为3510，Atlas A3训练系列产品/Atlas A3推理系列产品对应NPU架构版本为2201，Atlas A2训练系列产品/Atlas A2推理系列产品对应NPU架构版本为2201。 |
| ACL_PLATFORM_MEMORY_TYPE | 设备内存类型，返回值对应[aclplatformLocalMemType](#aclplatformLocalMemType)枚举的整数值。 |

<br>

<a id="aclplatformLocalMemType"></a>

## aclplatformLocalMemType

```c
typedef enum aclplatformLocalMemType {
    L0_A = 0,
    L0_B = 1,
    L0_C = 2,
    L1   = 3,
    L2   = 4,
    UB   = 5,
    HBM  = 6
} aclplatformLocalMemType;
```

| 枚举项 | 说明 |
| --- | --- |
| L0_A | AI Core内部物理存储单元，通常用于存储矩阵计算的左矩阵。 |
| L0_B | AI Core内部物理存储单元，通常用于存储矩阵计算的右矩阵。 |
| L0_C | AI Core内部物理存储单元，通常用于存储矩阵计算的结果。 |
| L1  | AI Core内部物理存储单元，空间相对较大，通常用于缓存矩阵计算的输入数据。 |
| L2  | 二级缓存，专门用于存储频繁访问的数据，以便减少对Global Memory的读写。 |
| UB  | AI Core内部存储单元，主要用于矢量计算。 |
| HBM | 设备HBM（高带宽内存）。 |

<br>

<a id="aclplatformNpuArch"></a>

## aclplatformNpuArch

```c
typedef enum aclplatformNpuArch {
    DAV_1001 = 1001,
    DAV_2002 = 2002,
    DAV_2102 = 2102,
    DAV_2201 = 2201,
    DAV_3002 = 3002,
    DAV_3003 = 3003,
    DAV_3004 = 3004,
    DAV_3102 = 3102,
    DAV_3113 = 3113,
    DAV_3505 = 3505,
    DAV_3510 = 3510,
    DAV_5102 = 5102,
    DAV_RESV = 0xFFFF
} aclplatformNpuArch;
```

产品型号和NPU架构版本的对应关系如下所示：
<!-- npu="950" id6 -->
- Ascend 950PR/Ascend 950DT：3510
<!-- end id6 -->
<!-- npu="A3" id7 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：2201
<!-- end id7 -->
<!-- npu="910b" id8 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：2201
<!-- end id8 -->
<!-- npu="310b" id9 -->
- Atlas 200I/500 A2 推理产品：3002
<!-- end id9 -->
<!-- npu="310p" id10 -->
- Atlas 推理系列产品：2002
<!-- end id10 -->
<!-- npu="910" id11 -->
- Atlas 训练系列产品：1001
<!-- end id11 -->
<!-- npu="IPV350" id12 -->
- IPV350：3505
<!-- end id12 -->
<!-- npu="9030" id13 -->
- Kirin 9030：3113
<!-- end id13 -->
<!-- npu="x90" id14 -->
- Kirin X90：3003
<!-- end id14 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id3 -->

<br>

<a id="aclprofAicoreMetrics"></a>

## aclprofAicoreMetrics

```c
typedef enum {
    ACL_AICORE_ARITHMETIC_UTILIZATION = 0,     // 各种计算类指标占比统计
    ACL_AICORE_PIPE_UTILIZATION = 1,           // 计算单元和搬运单元耗时占比
    ACL_AICORE_MEMORY_BANDWIDTH = 2,           // 外部内存读写类指令占比
    ACL_AICORE_L0B_AND_WIDTH = 3,              // 内部内存读写类指令占比
    ACL_AICORE_RESOURCE_CONFLICT_RATIO = 4,    // 流水线队列类指令占比
    ACL_AICORE_MEMORY_UB = 5,                  // 内部内存读写指令占比
    ACL_AICORE_L2_CACHE = 6,                   // 读写cache命中次数和缺失后重新分配次数
    ACL_AICORE_PIPE_EXECUTE_UTILIZATION = 7,   // 计算单元和搬运单元耗时占比
    ACL_AICORE_MEMORY_ACCESS = 8,              // 算子在核上访存的带宽数据量
    ACL_AICORE_NONE = 0xFF
}aclprofAicoreMetrics;
```

<!-- npu="310b" id97 -->
Atlas 200I/500 A2 推理产品：不支持ACL\_AICORE\_MEMORY\_ACCESS
<!-- end id97 -->

<!-- npu="310p" id98 -->
Atlas 推理系列产品：不支持ACL\_AICORE\_L2\_CACHE、ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION、ACL\_AICORE\_MEMORY\_ACCESS
<!-- end id98 -->

<!-- npu="910" id99 -->
Atlas 训练系列产品：不支持ACL\_AICORE\_L2\_CACHE、ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION、ACL\_AICORE\_MEMORY\_ACCESS
<!-- end id99 -->

<!-- npu="910b" id100 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION
<!-- end id100 -->

<!-- npu="A3" id101 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION
<!-- end id101 -->

<!-- npu="950" id102 -->
Ascend 950PR/Ascend 950DT：不支持ACL\_AICORE\_L2\_CACHE、ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION、ACL\_AICORE\_MEMORY\_ACCESS
<!-- end id102 -->

<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id16 -->

<br>

<a id="aclprofConfigType"></a>

## aclprofConfigType

```c
typedef enum {
    ACL_PROF_ARGS_MIN                   = 0,
    ACL_PROF_STORAGE_LIMIT              = 1, 
    ACL_PROF_SYS_HARDWARE_MEM_FREQ      = 3,
    ACL_PROF_LLC_MODE                   = 4,
    ACL_PROF_SYS_IO_FREQ                = 5,
    ACL_PROF_SYS_INTERCONNECTION_FREQ   = 6,
    ACL_PROF_DVPP_FREQ                  = 7,
    ACL_PROF_HOST_SYS                   = 8,
    ACL_PROF_HOST_SYS_USAGE             = 9,
    ACL_PROF_HOST_SYS_USAGE_FREQ        = 10,
    ACL_PROF_LOW_POWER_FREQ             = 11,
    ACL_PROF_SYS_MEM_SERVICEFLOW        = 12,
    ACL_PROF_SYS_CPU_FREQ               = 13,
    ACL_PROF_OPTYPE                     = 14,
    ACL_PROF_PATH                       = 16,
    ACL_PROF_ARGS_MAX                   = 17
} aclprofConfigType;
```
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id17 -->
<!-- npu="950" id87 -->
Ascend 950PR/Ascend 950DT：不支持ACL\_PROF\_DVPP\_FREQ、ACL\_PROF\_HOST\_SYS、ACL\_PROF\_HOST\_SYS\_USAGE、ACL\_PROF\_HOST\_SYS\_USAGE\_FREQ、ACL\_PROF\_NTS\_METRICS、ACL\_PROF\_OPTYPE。
<!-- end id87 -->

<!-- npu="310p" id88 -->
Atlas 推理系列产品：不支持ACL\_PROF\_SYS\_IO\_FREQ、ACL\_PROF\_NTS\_METRICS、ACL\_PROF\_OPTYPE。
<!-- end id88 -->

<!-- npu="310b" id89 -->
Atlas 200I/500 A2 推理产品：不支持ACL\_PROF\_SYS\_INTERCONNECTION\_FREQ、ACL\_PROF\_NTS\_METRICS、ACL\_PROF\_OPTYPE。
<!-- end id89 -->

<!-- npu="910" id90 -->
Atlas 训练系列产品：不支持ACL\_PROF\_OPTYPE。
<!-- end id90 -->

<!-- npu="910b" id91 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持ACL\_PROF\_OPTYPE。
<!-- end id91 -->

<!-- npu="A3" id92 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持ACL\_PROF\_OPTYPE。
<!-- end id92 -->

枚举项说明如下：

- ACL\_PROF\_STORAGE\_LIMIT ：指定落盘目录允许存放的最大文件容量，有效取值范围为\[200, 4294967295\]，单位为MB。
- ACL\_PROF\_SYS\_HARDWARE\_MEM\_FREQ：片上内存读写速率、QoS传输带宽、LLC三级缓存带宽、加速器带宽、SoC传输带宽、组件内存占用等的采集频率，范围\[1,100\]，单位Hz。不同产品的采集内容略有差异，请以实际结果为准。已知在安装有glibc<2.34的环境上采集memory数据，可能触发glibc的一个已知[Bug 19329](https://sourceware.org/bugzilla/show_bug.cgi?id=19329)，通过升级环境的glibc版本可解决此问题。

    <!-- npu="950" id93 -->
    Ascend 950PR/Ascend 950DT，Qos和SoC支持的采集频率最大支持配置10000，其他采集项支持的最大采集频率仍为100，若配置超出范围，其他采集项则按照最大采集频率100进行采集。
    <!-- end id93 -->

    <!-- npu="310b" id94 -->
    Atlas 200I/500 A2 推理产品：采集任务结束后，不建议用户增大采集频率，否则可能导致SoC传输带宽数据丢失。
    <!-- end id94 -->

    <!-- npu="910b" id95 -->
    Atlas A2 训练系列产品/Atlas A2 推理系列产品：采集任务结束后，不建议用户增大采集频率，否则可能导致SoC传输带宽数据丢失。
    <!-- end id95 -->

    <!-- npu="A3" id96 -->
    Atlas A3 训练系列产品/Atlas A3 推理系列产品：采集任务结束后，不建议用户增大采集频率，否则可能导致SoC传输带宽数据丢失。
    <!-- end id96 -->

- ACL\_PROF\_LLC\_MODE：LLC Profiling采集事件。要求同时设置ACL\_PROF\_SYS\_HARDWARE\_MEM\_FREQ。可以设置为：
    - read：读事件，三级缓存读速率。
    - write：写事件，三级缓存写速率。默认为read。

- ACL\_PROF\_SYS\_IO\_FREQ：NIC、ROCE、UB带宽数据采集频率，范围\[1,100\]，单位Hz。不同产品的采集内容略有差异，请以实际结果为准。
- ACL\_PROF\_SYS\_INTERCONNECTION\_FREQ：集合通信带宽数据（HCCS）、PCIe数据采集开关、片间传输带宽信息采集频率、SIO数据、UB带宽数据采集开关，范围\[1,50\]，单位Hz。不同产品的采集内容略有差异，请以实际结果为准。
- ACL\_PROF\_DVPP\_FREQ：DVPP采集频率，范围\[1,100\]。
- ACL\_PROF\_HOST\_SYS：Host侧进程级别的性能数据采集开关，取值包括cpu和mem。
- ACL\_PROF\_HOST\_SYS\_USAGE：Host侧系统和所有进程的性能数据采集开关，取值包括cpu和mem。
- ACL\_PROF\_HOST\_SYS\_USAGE\_FREQ：CPU利用率、内存利用率的采集频率，范围\[1,50\]。
- ACL\_PROF\_NTS\_METRICS：V380 PMU信息和NTS task运行时间统计信息采集开关，取值只能是PipeUtilization。
- ACL\_PROF\_PATH：设置数据落盘路径。

<br>

<a id="aclprofEventAttributes"></a>

## aclprofEventAttributes

```c
typedef struct { 
    uint16_t version;
    uint16_t size;
    uint32_t messageType;   // MESSAGE_TYPE_TENSOR_INFO
    union Message {
        aclprofTensorInfo *tensorInfo;
    } message;
} aclprofEventAttributes;

typedef struct { 
    uint64_t opNameId;      // 通过uint64_t aclprofStr2Id(const char *message)转化
    uint64_t opTypeId;
    uint32_t resv;
    uint32_t tensorNum;
    uint32_t kernelType;
    uint32_t blockNums;
    void *stream;           // stream信息
    aclprofTensor *tensors;
} aclprofTensorInfo;

typedef struct {
    uint32_t type;          // tensor类型，0: input, 1: output
    uint32_t format;        // format类型: aclFormat
    uint32_t dataType;      // dataType类型 aclDataType
    uint32_t shapeDim;      // shape dim <= 8
    uint32_t shape[8];      // tensor内存大小
}aclprofTensor;

typedef enum{
    MESSAGE_TYPE_TENSOR_INFO = 0
}ProfMessageType;
```

<br>

<a id="aclprofStepTag"></a>

## aclprofStepTag

```c
typedef enum{
    ACL_STEP_START = 0, // step  start
    ACL_STEP_END = 1    // step  end
} aclprofStepTag
```

> **说明：**
>同一个[aclprofStepInfo](25-03_Operation_APIs.md#aclprofStepInfo)对象、同一个tag只能设置一次，否则Profiling解析会出错。

<br>

<a id="aclRegisterCallbackType"></a>

## aclRegisterCallbackType

```c
typedef enum aclRegisterCallbackType {
    ACL_REG_TYPE_ACL_MODEL,           // 模型管理
    ACL_REG_TYPE_ACL_OP_EXECUTOR,     // 单算子调用
    ACL_REG_TYPE_ACL_OP_CBLAS,        // 单算子调用中的CBLAS接口
    ACL_REG_TYPE_ACL_OP_COMPILER,     // 单算子编译
    ACL_REG_TYPE_ACL_TDT_CHANNEL,     // Tensor数据传输
    ACL_REG_TYPE_ACL_TDT_QUEUE,       // 共享队列管理
    ACL_REG_TYPE_ACL_DVPP,            // 媒体数据处理
    ACL_REG_TYPE_ACL_RETR,            // 特征向量检索
    ACL_REG_TYPE_OTHER = 0xFFFF,      // 自定义功能
} aclRegisterCallbackType;
```

<br>

<a id="aclrtAtomicOperation"></a>

## aclrtAtomicOperation

```c
typedef enum aclrtAtomicOperation {
    ACL_RT_ATOMIC_OPERATION_INTEGER_ADD = 0,       // 整型数据原子加操作，对应Ascend C的asc_atomic_add接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_MIN = 1,       // 整型数据原子求最小值操作，对应Ascend C的asc_atomic_min接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_MAX = 2,       // 整型数据原子求最大值操作，对应Ascend C的asc_atomic_max接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_INCREMENT = 3, // 原子加1操作，对应Ascend C的asc_atomic_inc接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_DECREMENT = 4, // 原子减1操作，对应Ascend C的asc_atomic_dec接口
    ACL_RT_ATOMIC_OPERATION_AND = 5,               // 原子与（&）操作，对应Ascend C的asc_atomic_and接口
    ACL_RT_ATOMIC_OPERATION_OR = 6,                // 原子或（|）操作，对应Ascend C的asc_atomic_or接口
    ACL_RT_ATOMIC_OPERATION_XOR = 7,               // 原子异或（^）操作，对应Ascend C的asc_atomic_xor接口
    ACL_RT_ATOMIC_OPERATION_EXCHANGE = 8,          // 原子赋值操作，对应Ascend C的asc_atomic_exch接口
    ACL_RT_ATOMIC_OPERATION_CAS = 9,               // 原子比较赋值操作，对应Ascend C的asc_atomic_cas接口
    ACL_RT_ATOMIC_OPERATION_FLOAT_ADD = 10,        // 浮点型数据原子加操作，对应Ascend C的asc_atomic_add接口
    ACL_RT_ATOMIC_OPERATION_FLOAT_MIN = 11,        // 浮点型数据原子求最小值操作，对应Ascend C的asc_atomic_min接口
    ACL_RT_ATOMIC_OPERATION_FLOAT_MAX = 12,        // 浮点型数据原子求最大值操作，对应Ascend C的asc_atomic_max接口

    /* 以上选项是基于SIMT（Single Instruction Multiple Thread）编程的原子操作 */
    /* 以下选项是基于SIMD（Single Instruction Multiple Data）编程的原子操作 */

    ACL_RT_ATOMIC_OPERATION_DMA_ADD = 30,          // 原子加操作，对应Ascend C的SetAtomicAdd接口         
    ACL_RT_ATOMIC_OPERATION_DMA_MIN = 31,          // 原子求最小值操作，对应Ascend C的SetAtomicMin接口
    ACL_RT_ATOMIC_OPERATION_DMA_MAX = 32,          // 原子求最大值操作，对应Ascend C的SetAtomicMax接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_ADD = 40,  // 原子加操作，对应Ascend C的AtomicAdd接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_MIN = 41,  // 原子求最小值操作，对应Ascend C的AtomicMin接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_MAX = 42,  // 原子求最大值操作，对应Ascend C的AtomicMax接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_CAS = 43,  // 原子比较赋值操作，对应Ascend C的AtomicCas接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_EXCH = 44, // 原子赋值操作，对应Ascend C的AtomicExch接口
} aclrtAtomicOperation;
```

<br>

<a id="aclrtAtomicOperationCapability"></a>

## aclrtAtomicOperationCapability

```c
typedef enum aclrtAtomicOperationCapability {
    ACL_RT_ATOMIC_CAPABILITY_SIGNED = 1U << 0,       // 有符号类型
    ACL_RT_ATOMIC_CAPABILITY_UNSIGNED = 1U << 1,     // 无符号类型
    ACL_RT_ATOMIC_CAPABILITY_REDUCATION = 1U << 2,   // 归约操作
    ACL_RT_ATOMIC_CAPABILITY_SCALAR8 = 1U << 3,      // 8位(1字节)标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR16 = 1U << 4,     // 16位 (2字节) 标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR32 = 1U << 5,     // 32位 (4字节) 标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR64 = 1U << 6,     // 64位 (8字节) 标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR128 = 1U << 7,    // 128位 (16字节) 标量数据
    ACL_RT_ATOMIC_CAPABILITY_VECTOR32X4 = 1U << 8,   // 4个32位的向量数据操作，即一次性对连续的4个32位数据执行原子计算
} aclrtAtomicOperationCapability;
```

<br>

<a id="aclrtBinaryLoadOptionType"></a>

## aclrtBinaryLoadOptionType

```c
typedef enum aclrtBinaryLoadOptionType {
    ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD = 1,       // 指定解析算子二进制、注册算子后，是否加载算子到Device侧
    ACL_RT_BINARY_LOAD_OPT_LAZY_MAGIC = 2,      // 废弃，请使用ACL_RT_BINARY_LOAD_OPT_MAGIC
    ACL_RT_BINARY_LOAD_OPT_MAGIC = 2,           // 标识算子类型的魔术数字
    ACL_RT_BINARY_LOAD_OPT_CPU_KERNEL_MODE = 3, // AI CPU算子注册模式
} aclrtBinaryLoadOptionType;
```

<br>

<a id="aclrtCmoType"></a>

## aclrtCmoType

```c
typedef enum aclrtCmoType {
    ACL_RT_CMO_TYPE_PREFETCH = 0,     // 内存预取，从内存预取到Cache
    ACL_RT_CMO_TYPE_WRITEBACK,        // 把Cache中的数据刷新到内存中，并在Cache中保留副本
    ACL_RT_CMO_TYPE_INVALID,          // 丢弃Cache中的数据
    ACL_RT_CMO_TYPE_FLUSH,            // 把Cache中的数据刷新到内存中，不保留Cache中的副本
} aclrtCmoType;
```

<br>

<a id="aclrtCntNotifyRecordMode"></a>

## aclrtCntNotifyRecordMode

```c
typedef enum {
    ACL_RT_CNT_NOTIFY_RECORD_SET_VALUE_MODE = 0,      // 覆盖模式，CntNotify计数值 = value
    ACL_RT_CNT_NOTIFY_RECORD_ADD_MODE = 1,            // 累加模式，CntNotify计数值 = 当前值 + value
    ACL_RT_CNT_NOTIFY_RECORD_BIT_OR_MODE = 2,         // bit或模式，CntNotify计数值 = 当前值 | value
    ACL_RT_CNT_NOTIFY_RECORD_BIT_AND_MODE = 4,        // bit与模式，CntNotify计数值 = 当前值 & value
} aclrtCntNotifyRecordMode;
```

<br>

<a id="aclrtCntNotifyWaitMode"></a>

## aclrtCntNotifyWaitMode

```c
typedef enum {
    ACL_RT_CNT_NOTIFY_WAIT_LESS_MODE = 0,               // CntNotify的当前计数值 < value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_EQUAL_MODE = 1,              // CntNotify的当前计数值 = value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_BIGGER_MODE = 2,             // CntNotify的当前计数值 > value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_BIGGER_OR_EQUAL_MODE = 3,    // CntNotify的当前计数值 >= value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_EQUAL_WITH_BITMASK_MODE = 4, // CntNotify的当前计数值 & value = value，则解除Wait
} aclrtCntNotifyWaitMode;
```

<br>

<a id="aclrtCompareDataType"></a>

## aclrtCompareDataType

```c
typedef enum { 
    ACL_RT_SWITCH_INT32 = 0, 
    ACL_RT_SWITCH_INT64 = 1, 
} aclrtCompareDataType;
```

<br>

<a id="aclrtCondition"></a>

## aclrtCondition

```c
typedef enum { 
    ACL_RT_EQUAL = 0, 
    ACL_RT_NOT_EQUAL, 
    ACL_RT_GREATER, 
    ACL_RT_GREATER_OR_EQUAL, 
    ACL_RT_LESS, 
    ACL_RT_LESS_OR_EQUAL 
} aclrtCondition;
```

<br>

<a id="aclrtDevAttr"></a>

## aclrtDevAttr

### 定义

```c
typedef enum { 
    ACL_DEV_ATTR_AICPU_CORE_NUM  = 1, 
    ACL_DEV_ATTR_AICORE_CORE_NUM = 101, 
    ACL_DEV_ATTR_CUBE_CORE_NUM = 102,
    ACL_DEV_ATTR_VECTOR_CORE_NUM = 201,      
    ACL_DEV_ATTR_WARP_SIZE = 202,
    ACL_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE,
    ACL_DEV_ATTR_UBUF_PER_VECTOR_CORE,
    ACL_DEV_ATTR_MAX_GRID_DIM_X = 205,
    ACL_DEV_ATTR_MAX_GRID_DIM_Y = 206,
    ACL_DEV_ATTR_MAX_GRID_DIM_Z = 207,
    ACL_DEV_ATTR_MAX_BLOCK_PER_GRID = 208,
    ACL_DEV_ATTR_MAX_THREADS_PER_BLOCK = 209,
    ACL_DEV_ATTR_MAX_BLOCK_DIM_X = 210,
    ACL_DEV_ATTR_MAX_BLOCK_DIM_Y = 211,
    ACL_DEV_ATTR_MAX_BLOCK_DIM_Z = 212,

    ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE = 301,
    ACL_DEV_ATTR_L2_CACHE_SIZE,
    ACL_DEV_ATTR_SMP_ID = 401U,
    ACL_DEV_ATTR_PHY_CHIP_ID = 402U,
    ACL_DEV_ATTR_SUPER_POD_DEVICE_ID = 403U,
    ACL_DEV_ATTR_SUPER_POD_SERVER_ID = 404U,
    ACL_DEV_ATTR_SUPER_POD_ID = 405U, 
    ACL_DEV_ATTR_CUST_OP_PRIVILEGE = 406U,
    ACL_DEV_ATTR_MAINBOARD_ID = 407U,
    ACL_DEV_ATTR_HD_CONNECT_TYPE = 408U,
    ACL_DEV_ATTR_IS_VIRTUAL = 501U,

    ACL_DEV_ATTR_NPU_ARCH = 601U,
} aclrtDevAttr;
```

枚举项说明如下：

- ACL\_DEV\_ATTR\_AICPU\_CORE\_NUM

    AI CPU数量。

- ACL\_DEV\_ATTR\_AICORE\_CORE\_NUM

    AI Core数量。

- ACL\_DEV\_ATTR\_CUBE\_CORE\_NUM

    Cube Core数量。

- ACL\_DEV\_ATTR\_VECTOR\_CORE\_NUM

    Vector Core数量。

- ACL\_DEV\_ATTR\_WARP\_SIZE

    一个Warp里的线程数，在SIMT（单指令多线程，Single Instruction Multiple Thread）编程模型中，Warp是指执行相同指令的线程集合。

    <!-- npu="950" id15 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id15 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_THREAD\_PER\_VECTOR\_CORE

    每个VECTOR\_CORE上可同时驻留的最大线程数。

    <!-- npu="950" id16 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id16 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_UBUF\_PER\_VECTOR\_CORE

    每个VECTOR\_CORE上可以使用的最大Unified Buffer的大小，单位Byte。

    <!-- npu="950" id17 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id17 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_X

    Grid维度X的最大值，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id18 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id18 -->

    对于不支持该选项的产品型号，默认返回0。

    说明：Grid表示线程块网格，由多个线程块（Thread Block）组成。Grid采用三维结构，其维度X、Y和Z分别表示不同维度下线程块的大小。线程块同样采用三维结构，其维度X、Y和Z分别表示线程块中三个维度的线程数。

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_Y

    Grid维度Y的最大值，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id19 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id19 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_Z

    Grid维度Z的最大值，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id20 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id20 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_PER\_GRID

    每个Grid中Block的最大数量，用于SIMT编程模型中线程块的网格配置。

    <!-- npu="950" id21 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id21 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_THREADS\_PER\_BLOCK

    每个Block中线程的最大数量，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id22 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id22 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_X

    Block维度X的最大值，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id23 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id23 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_Y

    Block维度Y的最大值，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id24 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id24 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_Z

    Block维度Z的最大值，用于SIMT编程模型中线程块的配置。

    <!-- npu="950" id25 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id25 -->

    对于不支持该选项的产品型号，默认返回0。

- ACL\_DEV\_ATTR\_TOTAL\_GLOBAL\_MEM\_SIZE

    Device上的可用总内存，单位Byte。

- ACL\_DEV\_ATTR\_SMP\_ID

    SMP（Symmetric Multiprocessing） ID，用于标识设备是否运行在同一操作系统上。

- ACL\_DEV\_ATTR\_PHY\_CHIP\_ID

    芯片物理ID。

- ACL\_DEV\_ATTR\_SUPER\_POD\_DEVICE\_ID

    SuperPOD Device ID表示超节点产品中的Device标识。

- ACL\_DEV\_ATTR\_SUPER\_POD\_SERVER\_ID

    SuperPOD Server ID表示超节点产品中的服务器标识。

- ACL\_DEV\_ATTR\_SUPER\_POD\_ID

    SuperPOD ID表示集群中的超节点ID。

- ACL\_DEV\_ATTR\_CUST\_OP\_PRIVILEGE

    表示查询自定义算子是否可以执行更多的系统调用权限。

    取值如下：

    - 0：自定义算子执行系统调用权限受控（例如不能执行Write操作）。
    - 1：自定义算子可以执行更多的系统调用权限。

    <!-- npu="950" id26 -->
    Ascend 950PR/Ascend 950DT不支持该选项。
    <!-- end id26 -->

- ACL\_DEV\_ATTR\_MAINBOARD\_ID

    主板ID。

- ACL\_DEV\_ATTR\_HD\_CONNECT\_TYPE

    Host和Device间的互联协议。

    取值如下：

    - 0：通过PCIe互联传输。
    - 1：通过HCCS（Huawei Cache Coherence System，华为缓存一致性系统）互联传输。
    - 2：通过UB（Unified Bus，统一总线）互联传输。

    <!-- npu="950" id27 -->
    仅Ascend 950PR/Ascend 950DT支持该选项。
    <!-- end id27 -->

    对于不支持该选项的产品型号，返回报错。

- ACL\_DEV\_ATTR\_IS\_VIRTUAL

    是否为昇腾虚拟化实例。

    - 0：不是昇腾虚拟化实例，是物理机。
    - 1：是昇腾虚拟化实例，可能是虚拟机或容器。

- ACL\_DEV\_ATTR\_NPU\_ARCH

    NPU的架构版本。

    产品型号和NPU架构版本的对应关系如下所示：

    <!-- npu="950" id28 -->
    - Ascend 950PR/Ascend 950DT：3510
    <!-- end id28 -->
    <!-- npu="A3" id29 -->
    - Atlas A3 训练系列产品/Atlas A3 推理系列产品：2201
    <!-- end id29 -->
    <!-- npu="910b" id30 -->
    - Atlas A2 训练系列产品/Atlas A2 推理系列产品：2201
    <!-- end id30 -->
    <!-- npu="310b" id31 -->
    - Atlas 200I/500 A2 推理产品：3002
    <!-- end id31 -->
    <!-- npu="310p" id32 -->
    - Atlas 推理系列产品：2002
    <!-- end id32 -->
    <!-- npu="910" id33 -->
    - Atlas 训练系列产品：1001
    <!-- end id33 -->
    <!-- npu="IPV350" id34 -->
    - IPV350：3505
    <!-- end id34 -->
    <!-- npu="9030" id35 -->
    - Kirin 9030：3113
    <!-- end id35 -->
    <!-- npu="x90" id36 -->
    - Kirin X90：3003
    <!-- end id36 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id4 -->

### 了解AI Core、Cube Core、Vector Core的关系

为便于理解AI Core、Cube Core、Vector Core的关系，此处先明确Core的定义，Core是指拥有独立Scalar计算单元的一个计算核，通常Scalar计算单元承担了一个计算核的SIMD（单指令多数据，Single Instruction Multiple Data）指令发射等功能，所以我们也通常也把这个Scalar计算单元称为核内的调度单元。不同产品上的AI数据处理核心单元不同，当前分为以下几类：

- 当AI数据处理核心单元是AI Core：
    - 在AI Core内，Cube和Vector共用一个Scalar调度单元。
        
        <!-- npu="910" id37 -->
        此处以Atlas 训练系列产品为例。
        <!-- end id37 -->

        ![](figures/aicore_shares_one_scalar.png)

    - 在AI Core内，Cube和Vector都有各自的Scalar调度单元，因此又被称为Cube Core、Vector Core。这时，一个Cube Core和一组Vector Core被定义为一个AI Core，AI Core数量通常是以多少个Cube Core为基准计算的，例如Atlas A2 训练系列产品/Atlas A2 推理系列产品。

        <!-- npu="910b" id38 -->
        此处以Atlas A2 训练系列产品/Atlas A2 推理系列产品为例。
        <!-- end id38 -->

        ![](figures/aicore_contains_multi_scalars.png)

- 当AI数据处理核心单元是AI Core以及单独的Vector Core：AI Core和Vector Core都拥有独立的Scalar调度单元。

    <!-- npu="310p" id39 -->
    此处以Atlas 推理系列产品为例。
    <!-- end id39 -->

    ![](figures/aicore_and_vectorcore.png)

### 了解SuperPOD ID、SuperPOD Server ID、SuperPOD Device ID之间的关系

![](figures/podid_serverid_deviceid.png)

<br>

<a id="aclrtDevFeatureType"></a>

## aclrtDevFeatureType

```c
typedef enum { 
    ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV = 1, // 更新AI Core算子的计算任务
    ACL_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV      = 21, // 跨设备发送队列事件消息
} aclrtDevFeatureType;
```

<br>

<a id="aclrtDeviceStatus"></a>

## aclrtDeviceStatus

```c
typedef enum aclrtDeviceStatus {
    ACL_RT_DEVICE_STATUS_NORMAL = 0,     // Device正常可用
    ACL_RT_DEVICE_STATUS_ABNORMAL,       // Device异常
    ACL_RT_DEVICE_STATUS_END = 0xFFFF,   // 预留值
} aclrtDeviceStatus;
```

<br>

<a id="aclrtDevResLimitType"></a>

## aclrtDevResLimitType

```c
typedef enum { 
    ACL_RT_DEV_RES_CUBE_CORE = 0,   // AI Core或Cube Core
    ACL_RT_DEV_RES_VECTOR_CORE,     // Vector Core
} aclrtDevResLimitType;
```

关于Core的定义及详细说明，请参见[aclrtDevAttr](#aclrtDevAttr)。

<!-- npu="910,310p" id40 -->
- 对于以下产品，ACL\_RT\_DEV\_RES\_CUBE\_CORE表示AI Core。

    <!-- npu="910" id41 -->
    Atlas 训练系列产品
    <!-- end id41 -->

    <!-- npu="310p" id42 -->
    Atlas 推理系列产品
    <!-- end id42 -->
<!-- end id40 -->

<!-- npu="950,A3,910b,310b" id43 -->
- 对于以下产品，ACL\_RT\_DEV\_RES\_CUBE\_CORE表示Cube Core。

    <!-- npu="950" id44 -->
    Ascend 950PR/Ascend 950DT
    <!-- end id44 -->

    <!-- npu="A3" id45 -->
    Atlas A3 训练系列产品/Atlas A3 推理系列产品
    <!-- end id45 -->

    <!-- npu="910b" id46 -->
    Atlas A2 训练系列产品/Atlas A2 推理系列产品
    <!-- end id46 -->

    <!-- npu="310b" id47 -->
    Atlas 200I/500 A2 推理产品
    <!-- end id47 -->
<!-- end id43 -->

<br>

<a id="aclrtEngineType"></a>

## aclrtEngineType

```c
typedef enum { 
    ACL_RT_ENGINE_TYPE_AIC = 0,  // AI Core
    ACL_RT_ENGINE_TYPE_AIV,      // Vector Core
} aclrtEngineType;
```

<br>

<a id="aclrtEventRecordedStatus"></a>

## aclrtEventRecordedStatus

```c
typedef enum aclrtEventRecordedStatus {
    ACL_EVENT_RECORDED_STATUS_NOT_READY = 0,  //Event未被记录到Stream中，或记录到Stream中的Event未被执行或执行失败
    ACL_EVENT_RECORDED_STATUS_COMPLETE = 1,   //记录到Stream中的Event执行成功
} aclrtEventRecordedStatus;
```

<br>

<a id="aclrtEventStatus"></a>

## aclrtEventStatus

```c
typedef enum aclrtEventStatus {
    ACL_EVENT_STATUS_COMPLETE  = 0, //完成
    ACL_EVENT_STATUS_NOT_READY = 1, //未完成
    ACL_EVENT_STATUS_RESERVED  = 2, //预留
} aclrtEventStatus;
```

<br>

<a id="aclrtEventWaitStatus"></a>

## aclrtEventWaitStatus

```c
typedef enum aclrtEventWaitStatus {
    ACL_EVENT_WAIT_STATUS_COMPLETE  = 0,      // 完成
    ACL_EVENT_WAIT_STATUS_NOT_READY = 1,      // 未完成
    ACL_EVENT_WAIT_STATUS_RESERVED  = 0xFFFF, // 预留
} aclrtEventWaitStatus;
```

<br>

<a id="aclrtFloatOverflowMode"></a>

## aclrtFloatOverflowMode

```c
typedef enum aclrtFloatOverflowMode {
    ACL_RT_OVERFLOW_MODE_SATURATION = 0, // 溢出检测饱和模式
    ACL_RT_OVERFLOW_MODE_INFNAN,         // 溢出检测Inf/NaN模式，默认值
    ACL_RT_OVERFLOW_MODE_UNDEF,
} aclrtFloatOverflowMode;
```

对比于Inf/NaN模式，饱和模式下，计算结果如果是Inf，最终结果是一个极大值；计算结果如果是NaN，最终结果是0。若设置成饱和模式，计算精度可能存在误差，该模式仅为兼容旧版本，后续不演进。

<!-- npu="950,A3,910b" id48 -->
对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，默认为Inf/NaN模式。其中，Ascend 950PR/Ascend 950DT仅支持Inf/NaN模式。
<!-- end id48 -->

<!-- npu="910,310p,310b" id49 -->
对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，仅支持设置饱和模式。
<!-- end id49 -->

<br>

<a id="aclrtFuncAttribute"></a>

## aclrtFuncAttribute

```c
typedef enum {
    ACL_FUNC_ATTR_KERNEL_TYPE = 1,     // Kernel类型
    ACL_FUNC_ATTR_KERNEL_RATIO = 2,    // Kernel执行时需要的Cube Core与Vector Core的比例
    ACL_FUNC_ATTR_KERNEL_SCHED_MODE = 3,    // Kernel调度模式
} aclrtFuncAttribute;
```

- 当属性设置为ACL\_FUNC\_ATTR\_KERNEL\_TYPE时，属性值说明请参见[aclrtKernelType](#aclrtKernelType)。
<!-- npu="950,A3,910b,910,310p,310b" id50 -->
- 当属性设置为ACL\_FUNC\_ATTR\_KERNEL\_RATIO时，属性值需要使用以下方式获取：

    ```c
    uint16_t* ratioArr = reinterpret_cast<uint16_t*>(&attrValue);
    uint16_t aicratio = ratioArr[1];   // 表示Cube Core的比例
    uint16_t aivratio = ratioArr[0];   // 表示Vector Core的比例
    ```
 
    该属性在各产品型号上支持的情况不同，如下：

    <!-- npu="950" id51 -->
    - Ascend 950PR/Ascend 950DT，不支持
    <!-- end id51 -->
    <!-- npu="A3" id52 -->
    - Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持
    <!-- end id52 -->
    <!-- npu="910b" id53 -->
    - Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持
    <!-- end id53 -->
    <!-- npu="310b" id54 -->
    - Atlas 200I/500 A2 推理产品，不支持
    <!-- end id54 -->
    <!-- npu="310p" id55 -->
    - Atlas 推理系列产品，支持
    <!-- end id55 -->
    <!-- npu="910" id56 -->
    - Atlas 训练系列产品，不支持
    <!-- end id56 -->
<!-- end id50 -->
<!-- npu="IPV350" id57 -->
- 当前不支持设置ACL\_FUNC\_ATTR\_KERNEL\_RATIO属性。
<!-- end id57 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id5 -->
- 当属性设置为ACL\_FUNC\_ATTR\_KERNEL\_SCHED\_MODE时，取值如下：

    - 0：普通调度模式，有空闲的核，就启动算子执行。例如，当numBlocks为8时，表示算子核函数将会在8个核上执行，这时如果指定普通调度模式，则表示只要有1个核空闲了，就启动算子执行。
    - 1：batch调度模式，必须所有所需的核都空闲了，才启动算子执行。例如，当numBlocks为8时，表示算子核函数将会在8个核上执行，这时如果指定batch调度模式，则表示必须等8个核都空闲了，才启动算子执行。

<br>

<a id="aclrtGroupAttr"></a>

## aclrtGroupAttr

```c
typedef enum aclrtGroupAttr
{
    ACL_GROUP_AICORE_INT,     //指定Group对应的AI Core个数，属性值的数据类型为整型
    ACL_GROUP_AIV_INT,       //指定Group对应的Vector Core个数，属性值的数据类型为整型
    ACL_GROUP_AIC_INT,       //指定Group对应的AI CPU线程数，属性值的数据类型为整型
    ACL_GROUP_SDMANUM_INT,   //内存异步拷贝的通道数，属性值的数据类型为整型
    ACL_GROUP_ASQNUM_INT,    //指定Group下可以被同时调度执行的Stream个数，小于或等于32，当前系统级最大一共可以同时调度32个Stream，属性值的数据类型为整型
    ACL_GROUP_GROUPID_INT    //指定Group的ID，属性值的数据类型为整型
} aclrtGroupAttr;
```

<br>

<a id="aclrtHacType"></a>

## aclrtHacType

```c
typedef enum {
    ACL_RT_HAC_TYPE_STARS = 0,    // System Task and Resource Scheduler
    ACL_RT_HAC_TYPE_AICPU,        // AI CPU
    ACL_RT_HAC_TYPE_AIC,          // AI Core或Cube Core
    ACL_RT_HAC_TYPE_AIV,          // Vector Core
    ACL_RT_HAC_TYPE_PCIEDMA,      // PCIe Direct Memory Access
    ACL_RT_HAC_TYPE_RDMA,         // Remote Direct Memory Asscess
    ACL_RT_HAC_TYPE_SDMA,         // System Direct Memory Access
    ACL_RT_HAC_TYPE_DVPP,         // Digital Vision Pre-Processing
    ACL_RT_HAC_TYPE_UDMA,         // Unified Buffer Direct Memory Asscess
    ACL_RT_HAC_TYPE_CCU           // Collective Communication Unit
} aclrtHacType;
```

<br>

<a id="aclrtHostMemMapCapability"></a>

## aclrtHostMemMapCapability

```c
typedef enum {
    ACL_RT_HOST_MEM_MAP_NOT_SUPPORTED = 0,  // 不支持
    ACL_RT_HOST_MEM_MAP_SUPPORTED           // 支持
} aclrtHostMemMapCapability;
```

<br>

<a id="aclrtHostRegisterType"></a>

## aclrtHostRegisterType

```c
typedef enum {
    ACL_HOST_REGISTER_MAPPED = 0,
    ACL_HOST_REGISTER_IOMEMORY = 0x04,
    ACL_HOST_REGISTER_READONLY = 0x08
}aclrtHostRegisterType;
```

| 枚举项 | 说明 |
| --- | --- |
| ACL_HOST_REGISTER_MAPPED | Host内存映射注册为Device可访问，包括读写。 |
| ACL_HOST_REGISTER_IOMEMORY | 将Host上第三方PCIe设备的IO space(寄存器、缓存)映射注册为Device可访问，包括读写。预留选项，当前不支持。 |
| ACL_HOST_REGISTER_READONLY | Host内存映射注册为Device只读。预留选项，当前不支持。 |

<!-- npu="A3" id58 -->
对于Atlas A3 训练系列产品/Atlas A3 推理系列产品，如果设置了ACL\_HOST\_REGISTER\_IOMEMORY选项，则仅支持X86架构，不支持ARM架构。
<!-- end id58 -->

<br>

<a id="aclrtIpcMemAttrType"></a>

## aclrtIpcMemAttrType

```c
typedef enum {
    ACL_RT_IPC_MEM_ATTR_ACCESS_LINK,    // 通信方式
} aclrtIpcMemAttrType;
```

<br>

<a id="aclrtKernelType"></a>

## aclrtKernelType

```c
typedef enum {
    ACL_KERNEL_TYPE_AICORE = 0,    // AI Core
    ACL_KERNEL_TYPE_CUBE = 1,      // Cube Core
    ACL_KERNEL_TYPE_VECTOR = 2,    // Vector Core
    ACL_KERNEL_TYPE_MIX = 3,       // 会同时启动AI Core上的Cube Core和Vector Core
    ACL_KERNEL_TYPE_AICPU = 100,   // AI CPU
} aclrtKernelType;
```

不同产品上的AI数据处理核心单元不同，关于Core的定义及详细说明，请参见[aclrtDevAttr](#aclrtDevAttr)。

<br>

<a id="aclrtLastErrLevel"></a>

## aclrtLastErrLevel

```c
typedef enum aclrtLastErrLevel {
    ACL_RT_THREAD_LEVEL = 0,
} aclrtLastErrLevel;
```

<br>

<a id="aclrtLaunchKernelAttrId"></a>

## aclrtLaunchKernelAttrId

```c
typedef enum aclrtLaunchKernelAttrId {
    ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE = 1,        // 调度模式
    ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE = 2, // 用于指定SIMT算子执行时需要的VECTOR CORE内部UB buffer的大小
    ACL_RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE = 3,       // 算子执行引擎
    ACL_RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET,       // numBlocks偏移量
    ACL_RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH,   // 任务下发时，是否阻止硬件预取本任务的信息
    ACL_RT_LAUNCH_KERNEL_ATTR_DATA_DUMP,             // 是否开启Dump
    ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT,               // 任务调度器等待任务执行的超时时间，单位秒
    ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US = 8,        // 任务调度器等待任务执行的超时时间，单位微秒
} aclrtLaunchKernelAttrId;
```

<br>

<a id="aclrtMallocAttrType"></a>

## aclrtMallocAttrType

```c
typedef enum {
    ACL_RT_MEM_ATTR_RSV = 0,    // 预留值
    ACL_RT_MEM_ATTR_MODULE_ID,  // 表示模块ID
    ACL_RT_MEM_ATTR_DEVICE_ID,  // 表示Device ID
    ACL_RT_MEM_ATTR_VA_FLAG,    // 使用aclrtMallocHostWithCfg接口申请Host内存时，是否使用VA（virtual address）一致性功能
} aclrtMallocAttrType;
```

<br>

<a id="aclrtMemAccessFlags"></a>

## aclrtMemAccessFlags

```c
typedef enum {
    ACL_RT_MEM_ACCESS_FLAGS_NONE = 0x0,      // 该地址范围不可访问 
    ACL_RT_MEM_ACCESS_FLAGS_READ = 0x1,      // 地址范围可读
    ACL_RT_MEM_ACCESS_FLAGS_READWRITE = 0x3, // 地址范围可读可写
} aclrtMemAccessFlags;
```

<br>

<a id="aclrtMemAllocationType"></a>

## aclrtMemAllocationType

```c
typedef enum aclrtMemAllocationType {
    ACL_MEM_ALLOCATION_TYPE_PINNED = 0,     // 锁页内存
} aclrtMemAllocationType;
```

<br>

<a id="aclrtMemAttr"></a>

## aclrtMemAttr

```c
typedef enum aclrtMemAttr {
    ACL_DDR_MEM,             // 大页内存+普通内存
    ACL_HBM_MEM,             // 大页内存+普通内存
    ACL_DDR_MEM_HUGE,        // 大页内存
    ACL_DDR_MEM_NORMAL,      // 普通内存
    ACL_HBM_MEM_HUGE,        // 大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_HBM_MEM_NORMAL,      // 普通内存
    ACL_DDR_MEM_P2P_HUGE,    // 用于Device间数据复制的大页内存
    ACL_DDR_MEM_P2P_NORMAL,  // 用于Device间数据复制的普通内存
    ACL_HBM_MEM_P2P_HUGE,    // 用于Device间数据复制的大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_HBM_MEM_P2P_NORMAL,  // 用于Device间数据复制的普通内存
    ACL_HBM_MEM_HUGE1G,      // 大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐
    ACL_HBM_MEM_P2P_HUGE1G   // 用于Device间数据复制的大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐

    /* 以上选项兼容旧版本，需由用户根据硬件内存（DDR、HBM）选择相应的内存属性选项 */
    /* 以下选项由接口内部根据底层硬件内存自动选择DDR或HBM，用户无需关注硬件细节，建议使用以下选项 */

    ACL_MEM_NORMAL,          // 普通内存
    ACL_MEM_HUGE,            // 大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_MEM_HUGE1G,          // 大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐
    ACL_MEM_P2P_NORMAL,      // 用于Device间数据复制的普通内存
    ACL_MEM_P2P_HUGE,        // 用于Device间数据复制的大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_MEM_P2P_HUGE1G,      // 用于Device间数据复制的大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐
} aclrtMemAttr;
```

对于申请大页内存的场景，当内存申请粒度为2M时，如果要申请1G大小的大页内存，会占用1024/2=512个页表，当内存申请粒度为1G时，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

<!-- npu="A3,910b" id59 -->
仅Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持HUGE1G相关选项。
<!-- end id59 -->

<!-- npu="IPV350" id60 -->
其它型号当前不支持HUGE1G相关选项。
<!-- end id60 -->

<!-- npu="IPV350" id61 -->
当前不支持P2P相关选项。
<!-- end id61 -->

<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id6 -->

<br>

<a id="aclrtMemcpyKind"></a>

## aclrtMemcpyKind

```c
typedef enum aclrtMemcpyKind {
    ACL_MEMCPY_HOST_TO_HOST,     // Host内的内存复制
    ACL_MEMCPY_HOST_TO_DEVICE,   // Host到Device的内存复制
    ACL_MEMCPY_DEVICE_TO_HOST,   // Device到Host的内存复制
    ACL_MEMCPY_DEVICE_TO_DEVICE, // Device内或两个Device间的内存复制
    ACL_MEMCPY_DEFAULT,          // 由系统根据源、目的内存地址自行判断拷贝方向
    ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE,   // Host到Device的内存复制，但Host内存会暂存在Runtime管理的缓存中，内存复制接口调用成功后，就可以释放Host内存 
    ACL_MEMCPY_INNER_DEVICE_TO_DEVICE,  // Device内的内存复制 
    ACL_MEMCPY_INTER_DEVICE_TO_DEVICE,  // 两个Device之间的内存复制 
} aclrtMemcpyKind;
```

<br>

<a id="aclrtMemGranularityOptions"></a>

## aclrtMemGranularityOptions

```c
typedef enum aclrtMemGranularityOptions {
    ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM,
    ACL_RT_MEM_ALLOC_GRANULARITY_RECOMMENDED,
    ACL_RT_MEM_ALLOC_GRANULARITY_UNDEF = 0xFFFF,
} aclrtMemGranularityOptions;
```

<br>

<a id="aclrtMemHandleType"></a>

## aclrtMemHandleType

```c
typedef enum aclrtMemHandleType {
    ACL_MEM_HANDLE_TYPE_NONE = 0,   // 通用handle，无类型标识
    ACL_MEM_HANDLE_TYPE_POSIX = 2,  // POSIX类型的handle，表示内存可以通过POSIX文件描述符导出，建议仅在POSIX系统中配置该属性
} aclrtMemHandleType;
```

<br>

<a id="aclrtMemLocationType"></a>

## aclrtMemLocationType

```c
typedef enum aclrtMemLocationType {
    ACL_MEM_LOCATION_TYPE_HOST = 0,      // 通过acl接口（例如aclrtMallocHost）申请的Host内存
    ACL_MEM_LOCATION_TYPE_DEVICE,        // 通过acl接口（例如aclrtMalloc）申请的Device内存
    ACL_MEM_LOCATION_TYPE_UNREGISTERED,  // 未通过acl接口申请的内存
    ACL_MEM_LOCATION_TYPE_HOST_NUMA =4,  // 通过aclrtMallocPhysical接口按照NUMA ID申请Host内存
} aclrtMemLocationType;
```

<br>

<a id="aclrtMemMallocPolicy"></a>

## aclrtMemMallocPolicy

```c
typedef enum aclrtMemMallocPolicy {
    ACL_MEM_MALLOC_HUGE_FIRST,
    ACL_MEM_MALLOC_HUGE_ONLY,
    ACL_MEM_MALLOC_NORMAL_ONLY,
    ACL_MEM_MALLOC_HUGE_FIRST_P2P,
    ACL_MEM_MALLOC_HUGE_ONLY_P2P,
    ACL_MEM_MALLOC_NORMAL_ONLY_P2P,
    ACL_MEM_MALLOC_HUGE1G_ONLY, 
    ACL_MEM_MALLOC_HUGE1G_ONLY_P2P,
    ACL_MEM_TYPE_LOW_BAND_WIDTH   = 0x0100U,
    ACL_MEM_TYPE_HIGH_BAND_WIDTH  = 0x1000U,
    ACL_MEM_ACCESS_USER_SPACE_READONLY = 0x100000U,
} aclrtMemMallocPolicy;
```

**枚举项说明如下：**

- ACL\_MEM\_MALLOC\_HUGE\_FIRST

    申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

    当申请的内存小于等于1M时，即使使用该内存分配规则，也是申请普通页的内存。当申请的内存大于1M时，优先申请大页内存，如果大页内存不够，则使用普通页的内存。

- ACL\_MEM\_MALLOC\_HUGE\_ONLY

    申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

    配置该选项时，表示仅申请大页，如果大页内存不够，则返回错误。

- ACL\_MEM\_MALLOC\_NORMAL\_ONLY

    仅申请普通页，如果普通页内存不够，则返回错误。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

- ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P

    两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

    配置该选项时，表示优先申请大页内存，如果大页内存不够，则使用普通页的内存。

    <!-- npu="310b" id62 -->
    Atlas 200I/500 A2 推理产品不支持该选项。
    <!-- end id62 -->

    <!-- npu="310p" id63 -->
    对于Atlas 推理系列产品，若涉及集合通信业务，通信域初始化需要在其他任何涉及Device内存申请的操作之前，否则可能因P2P内存不足导致初始化失败。
    <!-- end id63 -->

    <!-- npu="IPV350" id64 -->
    当前版本不支持该选项。
    <!-- end id64 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id7 -->

- ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P

    两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

    配置该选项时，表示仅申请大页内存，如果大页内存不够，则返回错误。

    <!-- npu="310b" id65 -->
    Atlas 200I/500 A2 推理产品不支持该选项。
    <!-- end id65 -->

    <!-- npu="310p" id66 -->
    对于Atlas 推理系列产品，若涉及集合通信业务，通信域初始化需要在其他任何涉及Device内存申请的操作之前，否则可能因P2P内存不足导致初始化失败。
    <!-- end id66 -->

    <!-- npu="IPV350" id67 -->
    当前版本不支持该选项。
    <!-- end id67 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id8 -->

- ACL\_MEM\_MALLOC\_NORMAL\_ONLY\_P2P

    两个Device之间内存复制场景下使用该选项，表示仅申请普通页的内存。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

    <!-- npu="310b" id68 -->
    Atlas 200I/500 A2 推理产品不支持该选项。
    <!-- end id68 -->

    <!-- npu="310p" id69 -->
    对于Atlas 推理系列产品，若涉及集合通信业务，通信域初始化需要在其他任何涉及Device内存申请的操作之前，否则可能因P2P内存不足导致初始化失败。
    <!-- end id69 -->

    <!-- npu="IPV350" id70 -->
    当前版本不支持该选项。
    <!-- end id70 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id9 -->

- ACL\_MEM\_MALLOC\_HUGE1G\_ONLY

    申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

    配置为该选项时，表示仅申请大页，如果大页内存不够，则返回错误。

    该选项与ACL\_MEM\_MALLOC\_HUGE\_ONLY选项相比，ACL\_MEM\_MALLOC\_HUGE\_ONLY的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL\_MEM\_MALLOC\_HUGE1G\_ONLY的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

    <!-- npu="910,310p,310b" id71 -->
    Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，不支持该选项。
    <!-- end id71 -->

    <!-- npu="IPV350" id72 -->
    当前版本不支持该选项。
    <!-- end id72 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id10 -->

- ACL\_MEM\_MALLOC\_HUGE1G\_ONLY\_P2P：

    两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。

    配置为该选项时，表示仅申请大页，如果大页内存不够，则返回错误。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

    该选项与ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P选项相比，ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL\_MEM\_MALLOC\_HUGE1G\_ONLY\_P2P的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

    <!-- npu="910,310p,310b" id73 -->
    Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，不支持该选项。
    <!-- end id73 -->

    <!-- npu="IPV350" id74 -->
    当前版本不支持该选项。
    <!-- end id74 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id11 -->

- ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH

    从带宽低的物理内存上申请内存。

    <!-- npu="950,A3,910b,910,310p,310b" id75 -->
    设置该选项无效，系统默认会根据硬件支持的内存类型选择。
    <!-- end id75 -->

    <!-- npu="IPV350" id76 -->
    若配置ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH，则系统内部会默认采取ACL\_MEM\_MALLOC\_HUGE\_FIRST，优先申请大页。
    <!-- end id76 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id12 -->

- ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH

    从带宽高的物理内存上申请内存。

    <!-- npu="950,A3,910b,910,310p,310b" id77 -->
    设置该选项无效，系统默认会根据硬件支持的内存类型选择。
    <!-- end id77 -->

    <!-- npu="IPV350" id78 -->
    若配置ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH，则系统内部会默认采取ACL\_MEM\_MALLOC\_HUGE\_FIRST，优先申请大页。
    <!-- end id78 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id13 -->

- ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY

    用于控制申请的内存在用户态为只读，若在用户态修改此内存都会导致失败。另外，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

<br>

<a id="aclrtMemManagedAdviseType"></a>

## aclrtMemManagedAdviseType

```c
typedef enum aclrtMemManagedAdviseType {
     ACL_MEM_ADVISE_SET_READ_MOSTLY = 0,
     ACL_MEM_ADVISE_UNSET_READ_MOSTLY,
     ACL_MEM_ADVISE_SET_PREFERRED_LOCATION,
     ACL_MEM_ADVISE_UNSET_PREFERRED_LOCATION,
     ACL_MEM_ADVISE_SET_ACCESSED_BY,
     ACL_MEM_ADVISE_UNSET_ACCESSED_BY,
} aclrtMemManagedAdviseType;
```

枚举项说明如下：

- **ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY**

    设置内存多副本属性，通常称为read mostly属性。

    若为某段UVM内存设置read mostly属性，除了首次访问该段内存的对象外（注：此处的对象指Host或Device），其他对象访问时，都会创建一个只读内存副本，即一个虚拟地址可以拥有多个只读副本。在有只读内存副本的对象上，只有首次访问时，需建立虚拟内存到物理内存的页表映射关系。再次在有只读内存副本的对象访问内存时，就不会触发缺页中断，以减少缺页中断带来的性能开销。

    但如果对设置了read mostly属性的内存进行了写操作，除了发生写操作的对象，其他对象上的副本都将会失效并取消read mostly属性，再次访问时会触发缺页中断，系统需要重新建立页表映射，从而影响性能。所以建议对通常只读、极少进行写操作的UVM内存设置read mostly属性。

    若设置为ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY选项，则location参数被忽略，这时会在Host上建立一个只读副本，默认拥有一份数据。

- **ACL\_MEM\_ADVISE\_UNSET\_READ\_MOSTLY**

    取消设置read mostly属性。

    取消之后，该段UVM内存仅保留一个内存副本，保留哪个对象上的内存副本，取决于传入的location参数，若传invalid，则认为保留Host上的内存副本；若传入的location上没有副本，则会建立一个副本。同时，除了保留内存副本的对象，其他对象上的内存副本都会失效，相应的物理内存会释放。

- **ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION**

    设置内存首选位置属性，通常称为preferred location属性，表示访问该段内存的首选位置是Host或Device。

    该属性可与内存访问者属性（即ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY）配合使用，当location相同时，用于提前分配物理内存，建立页表映射，从而避免在首选位置访问内存时出现缺页中断的开销。

    在设置preferred location属性时，需要注意read mostly属性是否设置：

    - read mostly属性未设置时，若将首选位置设置在Host上，则接口内部会检查当前内存地址在Device上是否已有映射，如果有映射，则返回报错；如果没有映射，接口内部会检查当前内存地址在Host上是否已有映射，有映射，则直接返回，没有映射，则申请物理内存、建立readwrite属性的页表映射后再返回。
    - read mostly属性未设置时，若将首选位置设置在某个指定Device上，则接口内部会检查当前地址在Host或其他Device上是否有映射，如果有映射，则返回报错；如果没有映射，则在该指定Device上申请物理内存、建立readwrite属性的页表映射后再返回。
    - read mostly属性已设置时，若将首选位置设置在Host上，则接口内部无需操作直接返回。
    - read mostly属性已设置时，若将首选位置设置在某个指定Device上，则接口内部会检查指定Device上是否已有副本，如果有，则直接返回，如果没有，则建立只读副本后再返回。

- **ACL\_MEM\_ADVISE\_UNSET\_PREFERRED\_LOCATION**

    取消设置preferred location属性。

- **ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY**

    设置远端映射属性，通常称为accessed by属性。

    该属性需与首选位置属性（即ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION）配合使用，当location相同时，用于提前分配物理内存，建立页表映射，从而避免在首选位置访问内存时出现缺页中断的开销。

- **ACL\_MEM\_ADVISE\_UNSET\_ACCESSED\_BY**

    取消设置accessed by属性。

<br>

<a id="aclrtMemManagedLocationType"></a>

## aclrtMemManagedLocationType

```c
typedef enum aclrtMemManagedLocationType {
    ACL_MEM_LOCATIONTYPE_INVALID = 0,
    ACL_MEM_LOCATIONTYPE_DEVICE,
    ACL_MEM_LOCATIONTYPE_HOST,
    ACL_MEM_LOCATIONTYPE_HOST_NUMA,
    ACL_MEM_LOCATIONTYPE_HOST_NUMA_CURRENT,
} aclrtMemManagedLocationType;
```

**表 1**  枚举项说明

| 枚举项 | 说明 |
| --- | --- |
| ACL_MEM_LOCATIONTYPE_INVALID | 无效位置。 |
| ACL_MEM_LOCATIONTYPE_DEVICE | 位置在Device。 |
| ACL_MEM_LOCATIONTYPE_HOST | 位置在Host。 |
| ACL_MEM_LOCATIONTYPE_HOST_NUMA | 位置在Host NUMA节点，设置该类型location时，需传入合理的NUMA ID。 |
| ACL_MEM_LOCATIONTYPE_HOST_NUMA_CURRENT | 位置在当前线程关联的NUMA节点上，设置该类型location时，用户传入的id无效，接口内部会自动获取当前线程所在NUMA节点的id并使用。 |

<br>

<a id="aclrtMemManagedRangeAttribute"></a>

## aclrtMemManagedRangeAttribute

```c
typedef enum aclrtMemManagedRangeAttribute {
    ACL_MEM_RANGE_ATTRIBUTE_READ_MOSTLY  = 1,
    ACL_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION,
    ACL_MEM_RANGE_ATTRIBUTE_ACCESSED_BY,
    ACL_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION_TYPE,
    ACL_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION_ID,
    ACL_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION,
    ACL_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION_TYPE,
    ACL_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION_ID
} aclrtMemManagedRangeAttribute;
```

枚举项说明如下：

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_READ\_MOSTLY**

    查询指定内存是否设置了read mostly属性。

    对于通过aclrtMemManagedAdvise接口设置ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY或ACL\_MEM\_ADVISE\_UNSET\_READ\_MOSTLY策略属性的情况，可以通过ACL\_MEM\_RANGE\_ATTRIBUTE\_READ\_MOSTLY选项查询read mostly属性值。

    当指定内存范围内的所有内存页都设置了read mostly属性，则返回1，否则返回0。由于属性值为整数，因此dataSize必须设置为4。

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION**

    查询指定内存是否设置了preferred location属性。

    对于通过aclrtMemManagedAdvise接口设置ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION或ACL\_MEM\_ADVISE\_UNSET\_PREFERRED\_LOCATION策略属性的情况，可以通过ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION选项查询preferred location属性值。

    属性值说明如下：

    - 如果指定内存范围内所有内存页都设置了将某个Device或NUMA节点作为首选位置，则返回结果为该Device的ID或NUMA节点ID，否则返回-2。
    - 如果指定内存范围内所有内存页都设置了将Host作为首选位置，则返回结果为-1，否则返回-2。

    由于属性值为整数，因此dataSize必须设置为4。

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_ACCESSED\_BY**

    查询指定内存是否设置了accessed by属性。

    对于通过aclrtMemManagedAdvise接口设置ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY或ACL\_MEM\_ADVISE\_UNSET\_ACCESSED\_BY策略属性的情况，可以通过ACL\_MEM\_RANGE\_ATTRIBUTE\_ACCESSED\_BY选项查询accessed by属性值。

    属性值为对指定内存范围设置了ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY属性的Host或Device或NUMA节点ID列表，但需注意：

    - 如果用户申请的data数组大小大于设置了accessed by属性的Host或Device或NUMA节点数量时，则超出部分将返回-2。
    - 如果用户申请的data数组大小小于设置了accessed by属性的Host或Device或NUMA节点数量时，则以data数组大小为准，但无法保证存放的是哪些节点的ID。

    由于属性值为整数，dataSize必须设置为4的非零整数倍。

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION\_TYPE**

    查询指定内存的首选位置的类型。需要注意的是，待查询的内存页的实际位置类型可能与首选位置类型不同。

    如果指定内存范围内的所有内存页都设置Host或相同Device或相同NUMA节点作为其首选位置，则分别返回ACL\_MEM\_LOCATIONTYPE\_HOST、ACL\_MEM\_LOCATIONTYPE\_DEVICE或ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA，否则返回ACL\_MEM\_LOCATIONTYPE\_INVALID。

    dataSize必须为sizeof\([aclrtMemManagedLocationType](#aclrtMemManagedLocationType)\)，data会被解析为aclrtMemManagedLocationType类型。

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION\_ID**

    查询指定内存的首选位置的ID。

    如果指定内存范围内的所有内存页都设置相同Device或相同NUMA节点作为其首选位置，则分别返回Device ID或NUMA节点ID；否则ID无效。

    由于属性值为整数，因此dataSize必须设置为4。

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION**（预留属性）

    查询指定内存最后一次通过预取接口显式预取到的位置。该返回值仅表示应用程序最后一次请求预取内存范围的位置，并不表示预取操作是否已经完成。

    属性值说明如下：

    - 如果指定内存范围内所有内存页最后一次预取的位置为某个Device或NUMA节点，则返回结果为该Device的ID或NUMA节点ID，否则返回-2。
    - 如果指定内存范围内所有内存页最后一次预取的位置为Host，则返回结果为-1，否则返回-2。

    由于属性值为整数，因此dataSize必须设置为4。

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION\_TYPE**（预留属性）

    查询指定内存最后一次通过内存预取接口显式预取到的位置类型。该返回值仅表示应用程序最后一次请求预取内存范围的位置，并不表示预取操作是否已经完成。

    如果指定内存范围内的所有内存页最后一次预取的位置都是Host或相同Device或相同NUMA节点，则分别返回ACL\_MEM\_LOCATIONTYPE\_HOST、ACL\_MEM\_LOCATIONTYPE\_DEVICE或ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA，否则返回ACL\_MEM\_LOCATIONTYPE\_INVALID。

    dataSize必须为sizeof\([aclrtMemManagedLocationType](#aclrtMemManagedLocationType)\)，data会被解析为aclrtMemManagedLocationType类型。

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION\_ID**（预留属性）

    查询指定内存最后一次通过预取接口显式预取到的位置的ID。

    如果指定内存范围内的所有内存页最后一次预取的位置为相同Device或相同NUMA节点，则分别返回Device ID或NUMA节点ID；否则ID无效。

    由于属性值为整数，因此dataSize必须设置为4。

<br>

<a id="aclrtMemPoolAttr"></a>

## aclrtMemPoolAttr

```c
typedef enum aclrtMemPoolAttr{
    ACL_RT_MEM_POOL_REUSE_FOLLOW_EVENT_DEPENDENCIES = 0x1,
    ACL_RT_MEM_POOL_REUSE_ALLOW_OPPORTUNISTIC = 0x2,
    ACL_RT_MEM_POOL_REUSE_ALLOW_INTERNAL_DEPENDENCIES = 0x3,
    ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD = 0x4,
    ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_CURRENT = 0x5,
    ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_HIGH = 0x6,
    ACL_RT_MEM_POOL_ATTR_USED_MEM_CURRENT = 0x7,
    ACL_RT_MEM_POOL_ATTR_USED_MEM_HIGH = 0x8
} aclrtMemPoolAttr;
```

**表 1**  枚举项说明

| 枚举项 | 说明 |
| --- | --- |
| ACL_RT_MEM_POOL_REUSE_FOLLOW_EVENT_DEPENDENCIES | 事件依赖内存复用开关。<br>在执行某个Stream的任务时，系统会查找与该Stream通过Event关联的其他Stream，并复用这些关联Stream中的任务已归还到内存池中的内存。此机制适用于用户应用程序中通过Event实现Stream间任务同步的场景。<br>属性值类型为uint32_t，取值如下：<br><br>  - 1：启用事件依赖内存复用。<br>  - 0：关闭事件依赖内存复用。 |
| ACL_RT_MEM_POOL_REUSE_ALLOW_OPPORTUNISTIC | 机会主义内存复用开关。<br>在执行某个Stream的任务时，系统会检索内存池中可复用的内存，但不保证内存复用一定成功。当内存复用失败时，程序会报错停止。<br>属性值类型为uint32_t，取值如下：<br><br>  - 1：启用机会主义内存复用。<br>  - 0：关闭机会主义内存复用。 |
| ACL_RT_MEM_POOL_REUSE_ALLOW_INTERNAL_DEPENDENCIES | 隐式依赖内存复用开关。<br>在执行某个Stream的任务时，系统会检索内存池中可复用的内存。若这些内存曾被其他Stream使用，但相关Stream之间不存在任务依赖关系，则系统将自动在相关Stream之间增加Event同步等待逻辑，以确保前一个Stream中的任务对内存的访问已经结束，从而实现安全的内存复用。<br>属性值类型为uint32_t，取值如下：<br><br>  - 1：启用隐式依赖内存复用。<br>  - 0：关闭隐式依赖内存复用。 |
| ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD | 释放空闲物理内存时，内存池中要保留的内存大小阈值，单位Byte。默认值为0。<br>当内存池中的空闲物理内存超过该阈值时，在下一次Stream同步（例如调用aclrtSynchronizeStream接口）时，系统将尝试释放空闲内存。<br>属性值类型为uint64_t。 |
| ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_CURRENT | 内存池中当前被申请的内存总量，该属性只读。<br>属性值类型为uint64_t。 |
| ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_HIGH | 内存池中当前被申请的内存总量的历史峰值。<br>属性值类型为uint64_t。<br>设置该属性时，属性值只能为0。 |
| ACL_RT_MEM_POOL_ATTR_USED_MEM_CURRENT | 内存池中实际正在使用的内存总量，该属性只读。<br>属性值类型为uint64_t。 |
| ACL_RT_MEM_POOL_ATTR_USED_MEM_HIGH | 内存池中实际正在使用的内存总量的历史峰值。<br>属性值类型为uint64_t。<br>设置该属性时，属性值只能为0。 |

<br>

<a id="aclrtMemSharedHandleType"></a>

## aclrtMemSharedHandleType

```c
typedef enum aclrtMemSharedHandleType {
    ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT = 0x1,  
    ACL_MEM_SHARE_HANDLE_TYPE_FABRIC = 0x2,
} aclrtMemSharedHandleType;
```

**表 1**  枚举项说明

| 枚举项 | 说明 |
| --- | --- |
| ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT | 默认值，AI Server内跨进程共享内存。 |
| ACL_MEM_SHARE_HANDLE_TYPE_FABRIC | 跨AI Server跨进程共享内存，包含一个AI Server内的场景。 |

<!-- npu="A3" id79 -->
仅Atlas A3 训练系列产品/Atlas A3 推理系列产品支持ACL\_MEM\_SHARE\_HANDLE\_TYPE\_FABRIC选项。
<!-- end id79 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id14 -->

<br>

<a id="aclrtRandomNumFuncType"></a>

## aclrtRandomNumFuncType

```c
typedef enum { 
    ACL_RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK = 0,   // Dropout bitmask
    ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS,           // 均匀分布
    ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS,            // 正态分布
    ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS,  // 截断正态分布
} aclrtRandomNumFuncType;
```

<br>

<a id="aclrtReduceKind"></a>

## aclrtReduceKind

```c
typedef enum { 
    ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM   = 10, 
    ACL_RT_MEMCPY_SDMA_AUTOMATIC_MAX   = 11, 
    ACL_RT_MEMCPY_SDMA_AUTOMATIC_MIN   = 12, 
    ACL_RT_MEMCPY_SDMA_AUTOMATIC_EQUAL = 13,
} aclrtReduceKind;
```

<!-- npu="310p" id80 -->
Atlas 推理系列产品仅支持SUM操作。
<!-- end id80 -->

<!-- npu="910" id81 -->
Atlas 训练系列产品仅支持SUM操作。
<!-- end id81 -->

<br>

<a id="aclrtRunMode"></a>

## aclrtRunMode

```c
typedef enum aclrtRunMode {
    ACL_DEVICE,
    ACL_HOST,
} aclrtRunMode;
```

**表 1**  枚举项说明

| 枚举项 | 说明 |
| --- | --- |
| ACL_DEVICE | AI软件栈运行在Device的Control CPU或板端环境上。<br>Ascend 950PR/Ascend 950DT，不支持该选项。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，不支持该选项。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，不支持该选项。 |
| ACL_HOST | AI软件栈运行在Host CPU上。 |

<br>

<a id="aclrtSnapShotStage"></a>

## aclrtSnapShotStage

```c
typedef enum {
    ACL_RT_SNAPSHOT_LOCK_PRE = 0,    // 锁定前
    ACL_RT_SNAPSHOT_BACKUP_PRE,      // 备份前
    ACL_RT_SNAPSHOT_BACKUP_POST,     // 备份后
    ACL_RT_SNAPSHOT_RESTORE_PRE,     // 恢复前
    ACL_RT_SNAPSHOT_RESTORE_POST,    // 恢复后
    ACL_RT_SNAPSHOT_UNLOCK_POST,     // 解锁后
} aclrtSnapShotStage;
```

<br>

<a id="aclrtStreamAttr"></a>

## aclrtStreamAttr

```c
typedef enum { 
    ACL_STREAM_ATTR_FAILURE_MODE         = 1,
    ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK = 2,
    ACL_STREAM_ATTR_USER_CUSTOM_TAG      = 3, 
    ACL_STREAM_ATTR_CACHE_OP_INFO        = 4, 
    ACL_STREAM_ATTR_PRIORITY             = 5,
} aclrtStreamAttr;
```

| 枚举项 | 说明 |
| --- | --- |
| ACL_STREAM_ATTR_FAILURE_MODE | 当Stream上的任务执行出错时，可通过该属性设置Stream的任务调度模式，以便控制某个任务失败后是否继续执行下一个任务<br>默认Stream不支持设置任务调度模式。<br>通过该属性设置任务调度模式，与[aclrtSetStreamFailureMode](06_stream_management.md#aclrtSetStreamFailureMode)接口的功能一致。 |
| ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK | 当与上层训练框架（例如PyTorch）对接时，针对指定Stream，可通过该属性打开或关闭溢出检测开关。关闭后，将无法通过溢出检测算子获取任务是否溢出。<br>打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。<br>通过该属性设置溢出检测开关，与[aclrtSetStreamOverflowSwitch](06_stream_management.md#aclrtSetStreamOverflowSwitch)接口的功能一致。 |
| ACL_STREAM_ATTR_USER_CUSTOM_TAG | 设置Stream上的溢出检测分组标签，以确定溢出发生时检测的粒度。如果不设置分组标签，默认为进程粒度。如果设置了分组标签，则仅检测与发生溢出的Stream具有相同分组标签的Stream。 |
| ACL_STREAM_ATTR_CACHE_OP_INFO | 基于捕获方式构建模型运行实例场景下，通过该属性设置Stream的算子信息缓存开关，以便于控制后续采集性能数据时是否附带算子信息。<br>该属性需与其它接口配合使用，请参见[aclrtCacheLastTaskOpInfo](24_other_APIs.md#aclrtCacheLastTaskOpInfo)中的接口调用流程。<br>跨Stream的任务捕获时，与主流关联的其他Stream，其算子信息缓存开关状态与主流一致。 |
| ACL_STREAM_ATTR_PRIORITY | 基于该属性值动态设置/查询stream优先级。 |

<!-- npu="950,A3,910b" id84 -->
对于Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持设置Stream优先级。
<!-- end id84 -->

<!-- npu="910,310p,310b" id82 -->
对于Atlas 200I/500 A2 推理产品、Atlas 推理系列产品、Atlas 训练系列产品，不支持设置Stream优先级。
<!-- end id82 -->

<!-- npu="IPV350" id83 -->
当前不支持设置Stream优先级。
<!-- end id83 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id15 -->

<br>

<a id="aclrtStreamConfigAttr"></a>

## aclrtStreamConfigAttr

```c
typedef enum {
    ACL_RT_STREAM_WORK_ADDR_PTR = 0, 
    ACL_RT_STREAM_WORK_SIZE, 
    ACL_RT_STREAM_FLAG,
    ACL_RT_STREAM_PRIORITY,
} aclrtStreamConfigAttr;
```

**表 1**  枚举项说明

| 枚举项 | 说明 |
| --- | --- |
| ACL_RT_STREAM_WORK_ADDR_PTR | 某一个Stream上的模型所需工作内存（Device上存放模型执行过程中的临时数据）的指针，由用户管理工作内存。该配置主要用于多模型在同一个Stream上串行执行时想共享工作内存的场景，此时需按多个模型中最大的工作内存来申请内存，可提前使用aclmdlQuerySize查询各模型所需的工作内存大小。<br>如果同时配置ACL_RT_STREAM_WORK_ADDR_PTR以及aclmdlExecConfigAttr中的ACL_MDL_WORK_ADDR_PTR（表示某个模型的工作内存），则以aclmdlExecConfigAttr中的ACL_MDL_WORK_ADDR_PTR优先。 |
| ACL_RT_STREAM_WORK_SIZE | 模型所需工作内存的大小，单位为Byte。 |
| ACL_RT_STREAM_FLAG | 预留配置，默认值为0。 |
| ACL_RT_STREAM_PRIORITY | Stream的优先级，数字越小优先级越高，取值[0,7]。默认值为0。 |

<br>

<a id="aclrtStreamStatus"></a>

## aclrtStreamStatus

```c
typedef enum aclrtStreamStatus {
    ACL_STREAM_STATUS_COMPLETE  = 0,      // Stream上的所有任务已完成
    ACL_STREAM_STATUS_NOT_READY = 1,      // Stream上至少有一个任务未完成
    ACL_STREAM_STATUS_RESERVED  = 0xFFFF, // 预留
} aclrtStreamStatus;
```

<br>

<a id="aclrtUpdateTaskAttrId"></a>

## aclrtUpdateTaskAttrId

```c
typedef enum { 
    ACL_RT_UPDATE_RANDOM_TASK = 1, 
    ACL_RT_UPDATE_AIC_AIV_TASK,     
} aclrtUpdateTaskAttrId;
```

| 枚举项 | 说明 |
| --- | --- |
| ACL_RT_UPDATE_RANDOM_TASK | 随机数生成任务。 |
| ACL_RT_UPDATE_AIC_AIV_TASK | 在Cube\Vector计算单元上执行的计算任务。 |

<!-- npu="A3,910b" id85 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持随机数生成任务。
<!-- end id85 -->

<!-- npu="310p" id86 -->
Atlas 推理系列产品不支持随机数生成任务。
<!-- end id86 -->

<br>

<a id="aclSysParamOpt"></a>

## aclSysParamOpt

```c
typedef enum { 
    ACL_OPT_DETERMINISTIC = 0,
    ACL_OPT_ENABLE_DEBUG_KERNEL = 1,
    ACL_OPT_STRONG_CONSISTENCY = 2,
} aclSysParamOpt;
```

**表 1**  枚举项说明

| 枚举项 | 说明 |
| --- | --- |
| ACL_OPT_DETERMINISTIC | 是否开启确定性计算。<br><br>  - 0：不开启确定性计算。默认不开启。<br>  - 1：开启确定性计算。<br><br>当开启确定性计算功能时，算子在相同的硬件和输入下，多次执行将产生相同的输出。但启用确定性计算往往导致算子执行变慢。<br>默认情况下，不开启确定性计算，算子在相同的硬件和输入下，多次执行的结果可能不同。这个差异的来源，一般是因为在算子实现中，存在异步的多线程执行，会导致浮点数累加的顺序变化。<br>通常建议不开启确定性计算，因为确定性计算往往会导致算子执行变慢，进而影响性能。当发现模型多次执行结果不同，或者是进行精度调优时，可开启确定性计算，辅助模型调试、调优。 |
| ACL_OPT_ENABLE_DEBUG_KERNEL | 是否开启算子执行阶段的Global Memory访问越界检测。<br><br>  - 0：不开启内存访问越界检测。默认不开启。<br>  - 1：开启内存访问越界检测。<br><br>编译算子前调用aclSetCompileopt接口将ACL_OP_DEBUG_OPTION配置为oom，同时配合调用aclrtCtxSetSysParamOpt接口（作用域是Context）或aclrtSetSysParamOpt接口（作用域是进程）将ACL_OPT_ENABLE_DEBUG_KERNEL配置为1，开启Global Memory访问越界检测，这时执行算子过程中，若从Global Memory中读写数据（例如读算子输入数据、写算子输出数据等）出现内存越界，则会返回“EZ9999”错误码，表示存在算子AI Core Error问题。 |
| ACL_OPT_STRONG_CONSISTENCY | 是否开启强一致性计算。<br>0：不开启强一致性计算。默认不开启。<br>1：开启强一致性计算。<br>当开启强一致性计算功能时，计算结果是确定的，多次执行将产生相同的输出。此外，计算结果与数据的位置无关。例如，在进行矩阵乘时，不同行的累加顺序可能不同，这可能会导致相同数据在不同行的计算结果出现细微差异。然而，在启用强一致性计算的情况下，即使在不同的行中，只要输入相同，计算结果也将一致。<br>默认情况下，不开启强一致性计算，这可能导致相同数据位于不同行时，计算结果出现不一致的现象。<br>通常建议不开启强一致性计算，因为这会导致算子执行速度变慢，影响性能。只有在需要严格保证不同位置上的相同数据计算结果一致，或进行精度调优时，才应开启强一致性计算，以辅助模型调试和优化。<br>须知：本参数为试验参数，后续版本可能会存在变更，不支持应用于生产环境中。 |

<br>

<a id="acltdtQueueAttrType"></a>

## acltdtQueueAttrType

```c
typedef enum {
    ACL_TDT_QUEUE_NAME_PTR = 0,  //队列名
    ACL_TDT_QUEUE_DEPTH_UINT32   //队列深度
} acltdtQueueAttrType;
```

<br>

<a id="acltdtQueueRouteParamType"></a>

## acltdtQueueRouteParamType

```c
typedef enum {
    ACL_TDT_QUEUE_ROUTE_SRC_UINT32 = 0,  //源队列ID
    ACL_TDT_QUEUE_ROUTE_DST_UINT32,      //目标队列ID
    ACL_TDT_QUEUE_ROUTE_STATUS_INT32     //路由绑定状态，0表示未绑定，1表示绑定，2表示绑定异常
} acltdtQueueRouteParamType;
```

<br>

<a id="acltdtQueueRouteQueryInfoParamType"></a>

## acltdtQueueRouteQueryInfoParamType

```c
typedef enum {
    ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM = 0,  //查询匹配模式
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32,  //指定要查询的源队列ID
    ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32   //指定要查询的目标队列ID
} acltdtQueueRouteQueryInfoParamType;
```

选择ACL\_TDT\_QUEUE\_ROUTE\_QUERY\_MODE\_ENUM类型后，参数值来源于[acltdtQueueRouteQueryMode](#acltdtQueueRouteQueryMode)枚举值。

<br>

<a id="acltdtQueueRouteQueryMode"></a>

## acltdtQueueRouteQueryMode

```c
typedef enum {
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC = 0,         // 指定为只根据源队列ID匹配查询
    ACL_TDT_QUEUE_ROUTE_QUERY_DST = 1,         // 指定为只根据目标队列ID匹配查询
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST = 2  // 指定为同时根据源、目标队列ID匹配查询
    ACL_TDT_QUEUE_ROUTE_QUERY_ABNORMAL = 100   // 指定为查询异常路由
} acltdtQueueRouteQueryMode;
```

<br>

<a id="acltdtTensorType"></a>

## acltdtTensorType

```c
enum acltdtTensorType {
    ACL_TENSOR_DATA_UNDEFINED = -1,
    ACL_TENSOR_DATA_TENSOR,           // 正常tensor数据标识
    ACL_TENSOR_DATA_END_OF_SEQUENCE,  // end数据标识
    ACL_TENSOR_DATA_ABNORMAL,         // 异常数据标识
    ACL_TENSOR_DATA_SLICE_TENSOR,     // tensor分片场景下的tensor数据
    ACL_TENSOR_DATA_END_TENSOR        // tensor分片场景下标识最后一个tensor
};
```

<br>

<a id="aclrtDeviceLimit"></a>

## aclrtDeviceLimit

```c
typedef enum tagAclrtDeviceLimit {
    ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE = 0,
    ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE = 1,
    ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE = 2,
    ACL_RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE = 3,
    ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE = 4,
} aclrtDeviceLimit;
```

| 枚举项 | 说明 |
| --- | --- |
| ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE | SIMT栈大小（per-thread）。 |
| ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE | SIMT分支栈大小（per-warp）。 |
| ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE | AI Core栈大小（每核）。 |
| ACL_RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE | SIMD printf FIFO大小（每核）。 |
| ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE | SIMT printf FIFO大小。 |

<!-- npu="950" id90 -->
对于Ascend 950PR/Ascend 950DT，支持以上全部枚举选项。
<!-- end id90 -->

<!-- npu="A3,910b" id91 -->
对于Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品，不支持`ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE`、`ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE`、`ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE`枚举选项。
<!-- end id91 -->