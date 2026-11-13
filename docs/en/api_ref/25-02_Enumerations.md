# Enumerations

<!-- md-trans-meta sourceCommit=38b96f2f5dac11a35f0826562336a151f2fda79e translatedAt=2026-11-06T11:38:45.408Z pushedAt=2026-11-09T10:44:40.410Z nl=2 -->

This topic provides data of the enum type.

<br>

- [aclCannAttr](#aclCannAttr)
- [aclCANNPackageName](#aclCANNPackageName)
- [aclDataType](#aclDataType)
- [aclDeviceInfo](#aclDeviceInfo)
- [acldumpTensorAddressType](#acldumpTensorAddressType)
- [acldumpTensorPlacement](#acldumpTensorPlacement)
- [acldumpTensorType](#acldumpTensorType)
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
- [aclrtDeviceLimit](#aclrtDeviceLimit)
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
- [aclrtMemLinkType](#aclrtMemLinkType)
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
    ACL_CANN_ATTR_UNDEFINED = -1,   // Unknown feature.
    ACL_CANN_ATTR_INF_NAN = 0,      // Overflow detection Inf/NaN mode.
    ACL_CANN_ATTR_BF16 = 1,         // bf16 data type.
    ACL_CANN_ATTR_JIT_COMPILE = 2   // Operator binary feature.
} aclCannAttr;
```

<br>

<a id="aclCANNPackageName"></a>

## aclCANNPackageName

When set to **ACL\_PKG\_NAME\_CANN**, it indicates the query of the CANN version number; when set to other values, it indicates the query of the version number of a specific module in CANN.

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
    ACL_DT_UNDEFINED = -1,  // Unknown data type, which is the default value.
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
    ACL_HIFLOAT4 = 42,
    ACL_HIFLOAT4_SCALE = 43,
} aclDataType;
```

<!-- npu="950" id1 -->
For Ascend 950PR&950DT products, enumeration options of 33\~41 are supported.
<!-- end id1 -->

<!-- npu="A3,910b" id2 -->
For Atlas A3 products and Atlas A2 products, enumeration options of 33\~41 are not supported.
<!-- end id2 -->

<!-- npu="910,310p,310b" id3 -->
For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, enumeration options of 33\~41 are not supported.
<!-- end id3 -->

<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id1 -->

<br>

<a id="aclDeviceInfo"></a>

## aclDeviceInfo

```c
typedef enum {
    ACL_DEVICE_INFO_UNDEFINED = -1,       // Unknown specification.
    ACL_DEVICE_INFO_AI_CORE_NUM = 0,      // Number of AI Cores.
    ACL_DEVICE_INFO_VECTOR_CORE_NUM = 1,  // Number of Vector Cores.
    ACL_DEVICE_INFO_L2_SIZE = 2           // L2 buffer size, in bytes.
} aclDeviceInfo;
```

<br>

<a id="acldumpTensorAddressType"></a>

## acldumpTensorAddressType

```c
typedef enum acldumpTensorAddressType {
    ACL_DUMP_ADDR_PTR = 0,
    ACL_DUMP_ADDR_PTR_PTR,
    ACL_DUMP_ADDR_RAW
} acldumpTensorAddressType;
```

| Item | Description |
| --- | --- |
| ACL_DUMP_ADDR_PTR | **address** is a second-level address, and the data address requires one dereference. |
| ACL_DUMP_ADDR_PTR_PTR | **address** is a third-level address, and the data address requires two dereferences. |
| ACL_DUMP_ADDR_RAW | **address** is a raw address that directly points to the data address. |

<br>

<a id="acldumpTensorPlacement"></a>

## acldumpTensorPlacement

```c
typedef enum acldumpTensorPlacement {
    ACL_DUMP_PLACEMENT_DEVICE = 0,
    ACL_DUMP_PLACEMENT_HOST,
    ACL_DUMP_PLACEMENT_END
} acldumpTensorPlacement;
```

| Item | Description |
| --- | --- |
| ACL_DUMP_PLACEMENT_DEVICE | The tensor is located on the device. |
| ACL_DUMP_PLACEMENT_HOST | The tensor is located on the host. |
| ACL_DUMP_PLACEMENT_END | Boundary of the enumerated value, which is a reserved value and is not a valid tensor placement. |

<br>

<a id="acldumpTensorType"></a>

## acldumpTensorType

```c
typedef enum acldumpTensorType {
    ACL_DUMP_TENSOR_INPUT = 0,
    ACL_DUMP_TENSOR_OUTPUT,
    ACL_DUMP_TENSOR_WORKSPACE
} acldumpTensorType;
```

| Item | Description |
| --- | --- |
| ACL_DUMP_TENSOR_INPUT | Input tensor. |
| ACL_DUMP_TENSOR_OUTPUT | Output tensor. |
| ACL_DUMP_TENSOR_WORKSPACE | Workspace tensor. |

<br>

<a id="acldumpType"></a>

## acldumpType

```c
typedef enum acldumpType {
    AIC_ERR_BRIEF_DUMP = 1,         // Lightweight exception dump.
    AIC_ERR_NORM_DUMP = 2,          // Normal exception dump. In addition to the lightweight exception dump, it also exports Shape, Data Type, Format, and attribute information.
    AIC_ERR_DETAIL_DUMP = 3,        // In addition to the lightweight exception dump, it also exports the internal storage, registers, and call stack information of the AI Core.
    DATA_DUMP = 4,                  // Model dump configuration and single-operator dump configuration.
    OVERFLOW_DUMP = 5               // Overflow operator dump.
} acldumpType;
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

The meaning of each dimension is as follows: N (Batch) indicates the batch size, H (Height) indicates the feature map height, W (Width) indicates the feature map width, C (Channels) indicates the feature map channels, D (Depth) indicates the feature map depth, and L is the feature map length.

The meaning of each **aclFormat** value is as follows:

- **UNDEFINED**: unknown format, the default value.
- **NCHW**: 4-dimensional data format.
- **NHWC**: 4-dimensional data format.
- **ND**: any format. Except for single-input operators that process themselves, such as **Square** and **Tanh**, other operators should use this format with caution.
- **NC1HWC0**: 5-dimensional data format. **C0** is strongly related to the microarchitecture and equals the size of the cube unit, for example, **16**. **C1** is obtained by splitting the C dimension by **C0**: C1 = C/C0. If the result is not divisible, the last portion of data needs to be padded to **C0**.
- **FRACTAL\_Z**: format of the convolution weight.
- **NC1HWC0\_C04**: 5-dimensional data format. **C0** is fixed to **4**, and **C1** is obtained by splitting the C dimension by **C0**: C1 = C/C0. If the result is not divisible, the last portion of data needs to be padded to **C0**. This format is not supported in the current version.
- **HWCN**: 4-dimensional data format.
- **NDHWC**: NDHWC format. For 3-dimensional images, a format with the D (Depth) dimension is required.
- **FRACTAL\_NZ**: internal fractal format. Users do not need to use it currently.
- **NCDHW**: NCDHW format. For 3-dimensional images, a format with the D (Depth) dimension is required.
- **NDC1HWC0**: 6-dimensional data format. Compared with **NC1HWC0**, it only adds the D (Depth) dimension.
- **FRACTAL\_Z\_3D**: 3D convolution weight format. For example, operators such as **Conv3D**, **MaxPool3D**, and **AvgPool3D** all require this format for expression.
- **NC**: 2-dimensional data format.
- **NCL**: 3-dimensional data format.
- **FRACTAL\_NZ\_C0\__\[M\]_**: special data layout format used internally for fractal, where _\[M\]_ represents the value of **C0**, currently supporting (2, 4, 8, 16, 32). Users do not need to use it currently.

    <!-- npu="950" id5 -->
    Only Ascend 950PR&950DT products support this type.
    <!-- end id5 -->

<br>

<a id="aclmdlRICaptureMode"></a>

## aclmdlRICaptureMode

```c
typedef enum {
    ACL_MODEL_RI_CAPTURE_MODE_GLOBAL = 0,   // Globally prohibited; no thread can call non-secure functions.
    ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL, // The current thread is prohibited from calling non-secure functions.
    ACL_MODEL_RI_CAPTURE_MODE_RELAXED,      // Globally not prohibited; all threads can call non-secure functions.
} aclmdlRICaptureMode;
```

<br>

<a id="aclmdlRICaptureStatus"></a>

## aclmdlRICaptureStatus

```c
typedef enum {
    ACL_MODEL_RI_CAPTURE_STATUS_NONE = 0,    // The stream is not in capture state.
    ACL_MODEL_RI_CAPTURE_STATUS_ACTIVE,      // The stream is in normal capture state.
    ACL_MODEL_RI_CAPTURE_STATUS_INVALIDATED, // Capture failed.
} aclmdlRICaptureStatus;
```

<br>

<a id="aclmdlRICondHandleFlag"></a>

## aclmdlRICondHandleFlag

```c
typedef enum {
    ACL_MODEL_RI_COND_HANDLE_ASSIGN_DEFAULT = 1,     // The condition variable is initialized to defaultLaunchValue at the start of each model execution.
} aclmdlRICondHandleFlag;
```

<br>

<a id="aclmdlRICondTaskType"></a>

## aclmdlRICondTaskType

```c
typedef enum {
    ACL_MODEL_RI_COND_TYPE_IF = 0,      // IF condition.
    ACL_MODEL_RI_COND_TYPE_WHILE = 1,   // WHILE condition.
    ACL_MODEL_RI_COND_TYPE_SWITCH = 2,  // SWITCH condition.
} aclmdlRICondTaskType;
```

<br>

<a id="aclmdlRITaskType"></a>

## aclmdlRITaskType

```c
typedef enum aclmdlRITaskType {
    ACL_MODEL_RI_TASK_DEFAULT,      // Other types except the following types.
    ACL_MODEL_RI_TASK_KERNEL,       // Computation task on the Cube Core or Vector Core.
    ACL_MODEL_RI_TASK_EVENT_RECORD, // Event Record task, typically corresponding to the task dispatched by the aclrtRecordEvent API.
    ACL_MODEL_RI_TASK_EVENT_WAIT,   // Event Wait task, typically corresponding to the task dispatched by the aclrtStreamWaitEvent or aclrtStreamWaitEventWithTimeout API.
    ACL_MODEL_RI_TASK_EVENT_RESET,  // Event Reset task, typically corresponding to the task dispatched by the aclrtResetEvent API.
    ACL_MODEL_RI_TASK_VALUE_WRITE,  // Value Write task, typically corresponding to the task dispatched by the aclrtValueWrite API.
    ACL_MODEL_RI_TASK_VALUE_WAIT,   // Value Wait task, typically corresponding to the task dispatched by the aclrtValueWait API.
} aclmdlRITaskType;
```

<br>

<a id="aclMemType"></a>

## aclMemType

<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id2 -->

```c
typedef enum {
    ACL_MEMTYPE_DEVICE = 0,  // Device memory.
    ACL_MEMTYPE_HOST = 1,    // Host memory.
    ACL_MEMTYPE_HOST_COMPILE_INDEPENDENT = 2   // Host memory.
} aclMemType;
```

**ACL\_MEMTYPE\_HOST** and **ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT** both identify host memory, but they differ in usage:

- **ACL\_MEMTYPE\_HOST**: If **ACL\_OP\_JIT\_COMPILE** is set to **disable** through the **aclSetCompileopt** API, when this option is set, operator input or output value changes do not trigger operator recompilation; if **ACL\_OP\_JIT\_COMPILE** is set to **enable** through the **aclSetCompileopt** API, operator input or output value changes trigger operator recompilation.
- **ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT**: When this option is set, operator input or output value changes never trigger operator recompilation. If operator compilation depends on its input or output values, setting **ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT** in this case may cause compilation to fail.

<br>

<a id="aclplatformCoreType"></a>

## aclplatformCoreType

```c
typedef enum aclplatformCoreType {
    ACL_PLATFORM_CORE_TYPE_AI_CORE     = 0,
    ACL_PLATFORM_CORE_TYPE_VECTOR_CORE = 1,
} aclplatformCoreType;
```

| Item | Description |
| --- | --- |
| ACL_PLATFORM_CORE_TYPE_AI_CORE | Cube Core, responsible for high-compute operations such as cube multiplication. |
| ACL_PLATFORM_CORE_TYPE_VECTOR_CORE | Vector Core, responsible for vector and scalar operations. |

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

| Item | Description |
| --- | --- |
| ACL_PLATFORM_AICORE_CNT | Number of AI Cores. |
| ACL_PLATFORM_AICORE_UB_SIZE | Size of the Unified Buffer (UB) of a single AI Core, in bytes. |
| ACL_PLATFORM_CUBE_CORE_CNT | Number of Cube Cores. |
| ACL_PLATFORM_VECTOR_CORE_CNT | Number of Vector Cores. |
| ACL_PLATFORM_L2_SIZE | L2 buffer size, in bytes. |
| ACL_PLATFORM_MEMORY_SIZE | Device memory size, in bytes. |
| ACL_PLATFORM_CUBE_FREQ | Operating frequency of the Cube Core, in MHz. |
| ACL_PLATFORM_VEC_FREQ | Operating frequency of the Vector Core, in MHz. |
| ACL_PLATFORM_BT_SIZE | Base Tile size, in bytes. |
| ACL_PLATFORM_L0_A_SIZE | L0-A buffer size, in bytes. It is used as the left cube input buffer for Cube Core cube operations. |
| ACL_PLATFORM_L0_B_SIZE | L0-B buffer size, in bytes. It is used as the right cube input buffer for Cube Core cube operations. |
| ACL_PLATFORM_L0_C_SIZE | L0-C buffer size, in bytes. It is used as the output result buffer for Cube Core cube operations. |
| ACL_PLATFORM_L1_SIZE | L1 buffer size, in bytes. |
| ACL_PLATFORM_SOC_VERSION | AI processor model name. |
| ACL_PLATFORM_AIC_VERSION | AI Core version string. |
| ACL_PLATFORM_NPU_ARCH | NPU architecture version. The return value corresponds to the integer value of the [aclplatformNpuArch](#aclplatformNpuArch) enumeration.<br><br> Ascend 950PR&950DT products correspond to NPU architecture version 3510, Atlas A3 training products/Atlas A3 inference products correspond to NPU architecture version 2201, and Atlas A2 training products/Atlas A2 inference products correspond to NPU architecture version 2201. |
| ACL_PLATFORM_MEMORY_TYPE | Device memory type. The return value corresponds to the integer value of the [aclplatformLocalMemType](#aclplatformLocalMemType) enumeration. |

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

| Item | Description |
| --- | --- |
| L0_A | Internal physical storage unit of the AI Core, typically used for storing the left cube of cube operations. |
| L0_B | Internal physical storage unit of the AI Core, typically used for storing the right cube of cube operations. |
| L0_C | Internal physical storage unit of the AI Core, typically used for storing the result of cube operations. |
| L1  | Internal physical storage unit of the AI Core, relatively large in space, typically used for caching the input data of cube operations. |
| L2  | L2 cache, specifically used for storing frequently accessed data to reduce reads and writes to global memory. |
| UB  | Internal storage unit of the AI Core, mainly used for vector computation. |
| HBM | Device high bandwidth memory (HBM). |

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
    DAV_5162 = 5162,
    DAV_RESV = 0xFFFF
} aclplatformNpuArch;
```

The correspondence between product models and NPU architecture versions is as follows:
<!-- npu="950" id6 -->
- Ascend 950PR&950DT products: 3510
<!-- end id6 -->
<!-- npu="A3" id7 -->
- Atlas A3 products: 2201
<!-- end id7 -->
<!-- npu="910b" id8 -->
- Atlas A2 products: 2201
<!-- end id8 -->
<!-- npu="310b" id9 -->
- Atlas 200I/500 A2 inference products: 3002
<!-- end id9 -->
<!-- npu="310p" id10 -->
- Atlas inference products: 2002
<!-- end id10 -->
<!-- npu="910" id11 -->
- Atlas training products: 1001
<!-- end id11 -->
<!-- npu="9030" id13 -->
- Kirin 9030: 3113
<!-- end id13 -->
<!-- npu="x90" id14 -->
- Kirin X90: 3003
<!-- end id14 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id3 -->

<br>

<a id="aclprofAicoreMetrics"></a>

## aclprofAicoreMetrics

```c
typedef enum {
    ACL_AICORE_ARITHMETIC_UTILIZATION = 0,     // Statistics on the proportion of various computation metrics.
    ACL_AICORE_PIPE_UTILIZATION = 1,           // Proportion of time consumed by compute units and data movement units.
    ACL_AICORE_MEMORY_BANDWIDTH = 2,           // Proportion of external memory read/write class instructions.
    ACL_AICORE_L0B_AND_WIDTH = 3,              // Proportion of internal memory read/write class instructions.
    ACL_AICORE_RESOURCE_CONFLICT_RATIO = 4,    // Proportion of pipeline queue instructions.
    ACL_AICORE_MEMORY_UB = 5,                  // Proportion of internal memory read/write instructions.
    ACL_AICORE_L2_CACHE = 6,                   // Number of cache read/write hits and reallocations after misses.
    ACL_AICORE_PIPE_EXECUTE_UTILIZATION = 7,   // Proportion of time consumed by compute units and data movement units.
    ACL_AICORE_MEMORY_ACCESS = 8,              // Bandwidth data volume of operator memory access on the core.
    ACL_AICORE_NONE = 0xFF
}aclprofAicoreMetrics;
```

<!-- npu="310b" id97 -->
Atlas 200I/500 A2 inference products: **ACL\_AICORE\_MEMORY\_ACCESS** is not supported.
<!-- end id97 -->

<!-- npu="310p" id98 -->
Atlas inference products: **ACL\_AICORE\_L2\_CACHE**, **ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION**, and **ACL\_AICORE\_MEMORY\_ACCESS** are not supported.
<!-- end id98 -->

<!-- npu="910" id99 -->
Atlas training products: **ACL\_AICORE\_L2\_CACHE**, **ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION**, and **ACL\_AICORE\_MEMORY\_ACCESS** are not supported.
<!-- end id99 -->

<!-- npu="910b" id100 -->
Atlas A2 products: **ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION** is not supported.
<!-- end id100 -->

<!-- npu="A3" id101 -->
Atlas A3 products: **ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION** is not supported.
<!-- end id101 -->

<!-- npu="950" id102 -->
Ascend 950PR&950DT products: **ACL\_AICORE\_L2\_CACHE**, **ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION**, and **ACL\_AICORE\_MEMORY\_ACCESS** are not supported.
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
    ACL_PROF_NTS_METRICS                = 15,
    ACL_PROF_PATH                       = 16,
    ACL_PROF_ARGS_MAX                   = 17
} aclprofConfigType;
```
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id17 -->
<!-- npu="950" id87 -->
Ascend 950PR&950DT products: **ACL\_PROF\_DVPP\_FREQ, ACL\_PROF\_HOST\_SYS**, **ACL\_PROF\_HOST\_SYS\_USAGE**, **ACL\_PROF\_HOST\_SYS\_USAGE\_FREQ**, and **ACL\_PROF\_NTS\_METRICS, ACL\_PROF\_OPTYPE** are not supported.
<!-- end id87 -->

<!-- npu="310p" id88 -->
Atlas inference products: **ACL\_PROF\_SYS\_IO\_FREQ**, **ACL\_PROF\_NTS\_METRICS**, and **ACL\_PROF\_OPTYPE** are not supported.
<!-- end id88 -->

<!-- npu="310b" id89 -->
Atlas 200I/500 A2 inference products: **ACL\_PROF\_SYS\_INTERCONNECTION\_FREQ**, **ACL\_PROF\_NTS\_METRICS**, and **ACL\_PROF\_OPTYPE** are not supported.
<!-- end id89 -->

<!-- npu="910" id90 -->
Atlas training products: **ACL\_PROF\_OPTYPE** is not supported.
<!-- end id90 -->

<!-- npu="910b" id91 -->
Atlas A2 products: **ACL\_PROF\_OPTYPE** is not supported.
<!-- end id91 -->

<!-- npu="A3" id92 -->
Atlas A3 products: **ACL\_PROF\_OPTYPE** is not supported.
<!-- end id92 -->

The enumeration item descriptions are as follows:

- **ACL\_PROF\_STORAGE\_LIMIT**: maximum file capacity allowed in the dump directory. The valid value range is \[200, 4294967295\], in MB.
- **ACL\_PROF\_SYS\_HARDWARE\_MEM\_FREQ**: sampling frequency of on-chip memory read/write rate, QoS transmission bandwidth, LLC L3 buffer bandwidth, accelerator bandwidth, SoC transmission bandwidth, and component memory usage, ranging from \[1,100\], in Hz. The collected content slightly differs across different products, which is subject to the actual results. It is known that collecting memory data in an environment with glibc < 2.34 may trigger a known glibc [bug 19329](https://sourceware.org/bugzilla/show_bug.cgi?id=19329), which can be resolved by upgrading the glibc version of the environment.

    <!-- npu="950" id93 -->
    For Ascend 950PR&950DT products, the maximum sampling frequency supported by Qos and SoC can be set to 10000, while the maximum sampling frequency supported by other collection items remains 100. If the set value exceeds the range, other collection items are sampled at the maximum sampling frequency of 100.
    <!-- end id93 -->

    <!-- npu="310b" id94 -->
    Atlas 200I/500 A2 inference products: After the collection task ends, it is not recommended to increase the sampling frequency; otherwise, SoC transmission bandwidth data loss may occur.
    <!-- end id94 -->

    <!-- npu="910b" id95 -->
    Atlas A2 products: After the collection task ends, it is not recommended to increase the sampling frequency; otherwise, SoC transmission bandwidth data loss may occur.
    <!-- end id95 -->

    <!-- npu="A3" id96 -->
    Atlas A3 products: After the collection task ends, it is not recommended to increase the sampling frequency; otherwise, SoC transmission bandwidth data loss may occur.
    <!-- end id96 -->

- **ACL\_PROF\_LLC\_MODE**: LLC profiling collection event. **ACL\_PROF\_SYS\_HARDWARE\_MEM\_FREQ** is required to be set at the same time. It can be set to:
    - **read**: read event, with L3 buffer read rate.
    - **write**: write event, with L3 buffer write rate. The default value is **read**.

- **ACL\_PROF\_SYS\_IO\_FREQ**: sampling frequency for NIC, ROCE, and UB bandwidth data. The value range is \[1,100\], in Hz. The collection content of different products is slightly different, which is subject to the actual results.
- **ACL\_PROF\_SYS\_INTERCONNECTION\_FREQ**: Collective communication bandwidth data (HCCS), PCIe data collection switch, inter-chip transmission bandwidth information sampling frequency, SIO data, and UB bandwidth data collection switch. The value range is \[1,50\], in Hz. The collection content of different products is slightly different, which is subject to the actual results.
- **ACL\_PROF\_DVPP\_FREQ**: DVPP sampling frequency. The value range is \[1,100\].
- **ACL\_PROF\_HOST\_SYS**: switch for process-level performance data collection on the host side. Values include **cpu** and **mem**.
- **ACL\_PROF\_HOST\_SYS\_USAGE**: switch for system-level and all-process performance data collection on the host side. Values include **cpu** and **mem**.
- **ACL\_PROF\_HOST\_SYS\_USAGE\_FREQ**: sampling frequency of CPU utilization and memory utilization. The value range is \[1,50\].
- **ACL\_PROF\_NTS\_METRICS**: switch for collecting V380 PMU information and NTS task runtime statistics. The value can only be **PipeUtilization**.
- **ACL\_PROF\_PATH**: path for writing data to disk.

<br>

<a id="aclprofEventAttributes"></a>

## aclprofEventAttributes

```c
typedef struct { 
    uint16_t version;
    uint16_t size;
    uint32_t messageType;   // ACL_PROF_MESSAGE_TYPE_TENSOR_INFO
    union Message {
        aclprofTensorInfo *tensorInfo;
    } message;
} aclprofEventAttributes;

typedef struct { 
    uint64_t opNameId;      // Conversion through uint64_t aclprofStr2Id(const char *message).
    uint64_t opTypeId;
    uint32_t resv;
    uint32_t tensorNum;
    uint32_t kernelType;
    uint32_t blockNums;
    void *stream;           // Stream information.
    aclprofTensor *tensors;
} aclprofTensorInfo;

typedef struct {
    uint32_t type;                                       // Tensor type: 0: input; 1: output.
    uint32_t format;                                     // Format type: aclFormat.
    uint32_t dataType;                                   // Data type: aclDataType.
    uint32_t shapeDim;                                   // shape dim <= 8
    uint32_t shape[ACL_PROF_TENSOR_DATA_SHAPE_LEN];      // Tensor memory size.
} aclprofTensor;

typedef enum {
    ACL_PROF_MESSAGE_TYPE_TENSOR_INFO = 0
} aclprofMessageType;
```

<br>

<a id="aclprofStepTag"></a>

## aclprofStepTag

```c
typedef enum{
    ACL_STEP_START = 0, // step  start
    ACL_STEP_END = 1    // step  end
} aclprofStepTag;
```

> **Note:**
> The same [aclprofStepInfo](25-03_Operation_APIs.md#aclprofStepInfo) object and the same tag can be set only once; otherwise, profiling parsing will fail.

<br>

<a id="aclRegisterCallbackType"></a>

## aclRegisterCallbackType

```c
typedef enum aclRegisterCallbackType {
    ACL_REG_TYPE_ACL_MODEL,           // Model management.
    ACL_REG_TYPE_ACL_OP_EXECUTOR,     // Single operator call.
    ACL_REG_TYPE_ACL_OP_CBLAS,        // CBLAS API in single operator call.
    ACL_REG_TYPE_ACL_OP_COMPILER,     // Single operator compilation.
    ACL_REG_TYPE_ACL_TDT_CHANNEL,     // Tensor data transmission.
    ACL_REG_TYPE_ACL_TDT_QUEUE,       // Shared queue management.
    ACL_REG_TYPE_ACL_DVPP,            // Media data processing.
    ACL_REG_TYPE_ACL_RETR,            // Feature vector retrieval.
    ACL_REG_TYPE_OTHER = 0xFFFF,      // Custom feature.
} aclRegisterCallbackType;
```

<br>

<a id="aclrtAtomicOperation"></a>

## aclrtAtomicOperation

```c
typedef enum aclrtAtomicOperation {
    ACL_RT_ATOMIC_OPERATION_INTEGER_ADD = 0,       // Atomic add operation for integer data, corresponding to the asc_atomic_add API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_INTEGER_MIN = 1,       // Atomic minimum operation for integer data, corresponding to the asc_atomic_min API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_INTEGER_MAX = 2,       // Atomic maximum operation for integer data, corresponding to the asc_atomic_max API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_INTEGER_INCREMENT = 3, // Atomic increment-by-1 operation, corresponding to the asc_atomic_inc API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_INTEGER_DECREMENT = 4, // Atomic decrement-by-1 operation, corresponding to the asc_atomic_dec API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_AND = 5,               // Atomic AND (&) operation, corresponding to the asc_atomic_and API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_OR = 6,                // Atomic OR (|) operation, corresponding to the asc_atomic_or API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_XOR = 7,               // Atomic XOR (^) operation, corresponding to the asc_atomic_xor API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_EXCHANGE = 8,          // Atomic assignment operation, corresponding to the asc_atomic_exch API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_CAS = 9,               // Atomic compare-and-swap operation, corresponding to the asc_atomic_cas API in Ascend C.
    ACL_RT_ATOMIC_OPERATION_FLOAT_ADD = 10,        // Atomic add operation for floating-point data, corresponding to the asc_atomic_add API in Ascend C.
    ACL_RT_ATOMIC_OPERATION_FLOAT_MIN = 11,        // Atomic minimum operation for floating-point data, corresponding to the asc_atomic_min API in Ascend C.
    ACL_RT_ATOMIC_OPERATION_FLOAT_MAX = 12,        // Atomic maximum operation for floating-point data, corresponding to the asc_atomic_max API in Ascend C.

    /* The options above are atomic operations based on Single Instruction Multiple Thread (SIMT) programming. */
    /* The options below are atomic operations based on Single Instruction Multiple Data (SIMD) programming. */

    ACL_RT_ATOMIC_OPERATION_DMA_ADD = 30,          // Atomic add operation, corresponding to the SetAtomicAdd API in Ascend C.         
    ACL_RT_ATOMIC_OPERATION_DMA_MIN = 31,          // Atomic minimum operation, corresponding to the SetAtomicMin API in Ascend C.
    ACL_RT_ATOMIC_OPERATION_DMA_MAX = 32,          // Atomic maximum operation, corresponding to the SetAtomicMax API in Ascend C.
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_ADD = 40,  // Atomic add operation, corresponding to the AtomicAdd API in Ascend C.
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_MIN = 41,  // Atomic minimum operation, corresponding to the AtomicMin API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_MAX = 42,  // Atomic maximum operation, corresponding to the AtomicMax API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_CAS = 43,  // Atomic compare-and-swap operation, corresponding to the AtomicCas API of Ascend C.
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_EXCH = 44, // Atomic assignment operation, corresponding to the AtomicExch API of Ascend C.
} aclrtAtomicOperation;
```

<br>

<a id="aclrtAtomicOperationCapability"></a>

## aclrtAtomicOperationCapability

```c
typedef enum aclrtAtomicOperationCapability {
    ACL_RT_ATOMIC_CAPABILITY_SIGNED = 1U << 0,       // Signed type.
    ACL_RT_ATOMIC_CAPABILITY_UNSIGNED = 1U << 1,     // Unsigned type.
    ACL_RT_ATOMIC_CAPABILITY_REDUCTION = 1U << 2,    // Reduction operation.
    ACL_RT_ATOMIC_CAPABILITY_SCALAR8 = 1U << 3,      // 8-bit (1-byte) scalar data.
    ACL_RT_ATOMIC_CAPABILITY_SCALAR16 = 1U << 4,     // 16-bit (2-byte) scalar data.
    ACL_RT_ATOMIC_CAPABILITY_SCALAR32 = 1U << 5,     // 32-bit (4-byte) scalar data.
    ACL_RT_ATOMIC_CAPABILITY_SCALAR64 = 1U << 6,     // 64-bit (8-byte) scalar data.
    ACL_RT_ATOMIC_CAPABILITY_SCALAR128 = 1U << 7,    // 128-bit (16-byte) scalar data.
    ACL_RT_ATOMIC_CAPABILITY_VECTOR32X4 = 1U << 8,   // Vector data operation on four 32-bit values, that is, atomically computing four consecutive 32-bit data at once.
} aclrtAtomicOperationCapability;
```

<br>

<a id="aclrtBinaryLoadOptionType"></a>

## aclrtBinaryLoadOptionType

```c
typedef enum aclrtBinaryLoadOptionType {
    ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD = 1,       // Specifies whether to load the operator to the device side after parsing the operator binary and registering the operator.
    ACL_RT_BINARY_LOAD_OPT_LAZY_MAGIC = 2,      // Deprecated. Use ACL_RT_BINARY_LOAD_OPT_MAGIC instead.
    ACL_RT_BINARY_LOAD_OPT_MAGIC = 2,           // Magic number that identifies the operator type.
    ACL_RT_BINARY_LOAD_OPT_CPU_KERNEL_MODE = 3, // AI CPU operator registration mode.
} aclrtBinaryLoadOptionType;
```

<br>

<a id="aclrtCmoType"></a>

## aclrtCmoType

```c
typedef enum aclrtCmoType {
    ACL_RT_CMO_TYPE_PREFETCH = 0,     // Prefetch memory from memory to the cache.
    ACL_RT_CMO_TYPE_WRITEBACK,        // Flush data from the cache to memory while retaining a copy in the cache.
    ACL_RT_CMO_TYPE_INVALID,          // Discard data in the cache.
    ACL_RT_CMO_TYPE_FLUSH,            // Flush data from the cache to memory without retaining a copy in the cache.
} aclrtCmoType;
```

<br>

<a id="aclrtCntNotifyRecordMode"></a>

## aclrtCntNotifyRecordMode

```c
typedef enum {
    ACL_RT_CNT_NOTIFY_RECORD_SET_VALUE_MODE = 0,      // Overwrite mode. CntNotify count value = value.
    ACL_RT_CNT_NOTIFY_RECORD_ADD_MODE = 1,            // Accumulation mode. CntNotify count value = Current value + value.
    ACL_RT_CNT_NOTIFY_RECORD_BIT_OR_MODE = 2,         // Bitwise OR mode. CntNotify count value = Current value | value.
    ACL_RT_CNT_NOTIFY_RECORD_BIT_AND_MODE = 4,        // Bitwise AND mode. CntNotify count value = Current value & value.
} aclrtCntNotifyRecordMode;
```

<br>

<a id="aclrtCntNotifyWaitMode"></a>

## aclrtCntNotifyWaitMode

```c
typedef enum {
    ACL_RT_CNT_NOTIFY_WAIT_LESS_MODE = 0,               // If the current count value of CntNotify < value, the Wait is released.
    ACL_RT_CNT_NOTIFY_WAIT_EQUAL_MODE = 1,              // If the current count value of CntNotify = value, the Wait is released.
    ACL_RT_CNT_NOTIFY_WAIT_BIGGER_MODE = 2,             // If the current count value of CntNotify > value, the Wait is released.
    ACL_RT_CNT_NOTIFY_WAIT_BIGGER_OR_EQUAL_MODE = 3,    // If the current count value of CntNotify >= value, the Wait is released.
    ACL_RT_CNT_NOTIFY_WAIT_EQUAL_WITH_BITMASK_MODE = 4, // If the current count value of CntNotify & value = value, the Wait is released.
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

### Definition

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
    ACL_DEV_ATTR_L2_CACHE_SIZE = 302,
    ACL_DEV_ATTR_SMP_ID = 401U,
    ACL_DEV_ATTR_PHY_CHIP_ID = 402U,
    ACL_DEV_ATTR_SUPER_POD_DEVICE_ID = 403U,
    ACL_DEV_ATTR_SUPER_POD_SERVER_ID = 404U,
    ACL_DEV_ATTR_SUPER_POD_ID = 405U, 
    ACL_DEV_ATTR_CUST_OP_PRIVILEGE = 406U,
    ACL_DEV_ATTR_MAINBOARD_ID = 407U,
    ACL_DEV_ATTR_HD_CONNECT_TYPE = 408U,
    ACL_DEV_ATTR_DEVICE_FORM_FACTOR = 409U,
    ACL_DEV_ATTR_SUPER_POD_CHASSIS_ID = 410U,
    ACL_DEV_ATTR_IS_VIRTUAL = 501U,

    ACL_DEV_ATTR_NPU_ARCH = 601U,
} aclrtDevAttr;
```

The enumeration item descriptions are as follows:

- ACL\_DEV\_ATTR\_AICPU\_CORE\_NUM

    Number of AI CPUs.

- ACL\_DEV\_ATTR\_AICORE\_CORE\_NUM

    Number of AI Cores.

- ACL\_DEV\_ATTR\_CUBE\_CORE\_NUM

    Number of Cube Cores.

- ACL\_DEV\_ATTR\_VECTOR\_CORE\_NUM

    Number of Vector Cores.

- ACL\_DEV\_ATTR\_WARP\_SIZE

    Number of threads in a warp. In the Single Instruction Multiple Thread (SIMT) programming model, a warp is a collection of threads that execute the same instruction.

    <!-- npu="950" id15 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id15 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_THREAD\_PER\_VECTOR\_CORE

    Maximum number of threads that can reside simultaneously on each **VECTOR\_CORE**.

    <!-- npu="950" id16 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id16 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_UBUF\_PER\_VECTOR\_CORE

    Maximum unified buffer size that can be used on each **VECTOR\_CORE**, in bytes.

    <!-- npu="950" id17 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id17 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_X

    Maximum value of Grid dimension X, used for the grid configuration of thread blocks in the SIMT programming model.

    <!-- npu="950" id18 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id18 -->

    For product models that do not support this option, 0 is returned by default.

    Note: Grid represents a grid of thread blocks, which consists of multiple thread blocks. Grid adopts a three-dimensional structure, where its dimensions X, Y, and Z respectively represent the size of thread blocks in different dimensions. A thread block also adopts a three-dimensional structure, where its dimensions X, Y, and Z respectively represent the number of threads in the three dimensions of the thread block.

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_Y

    Maximum value of Grid dimension Y, used for the grid configuration of thread blocks in the SIMT programming model.

    <!-- npu="950" id19 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id19 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_GRID\_DIM\_Z

    Maximum value of Grid dimension Z, used for the grid configuration of thread blocks in the SIMT programming model.

    <!-- npu="950" id20 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id20 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_PER\_GRID

    Maximum number of blocks in each Grid, used for the grid configuration of thread blocks in the SIMT programming model.

    <!-- npu="950" id21 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id21 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_THREADS\_PER\_BLOCK

    Maximum number of threads in each block, used for thread block configuration in the SIMT programming model.

    <!-- npu="950" id22 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id22 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_X

    Maximum value of Block dimension X, used for thread block configuration in the SIMT programming model.

    <!-- npu="950" id23 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id23 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_Y

    Maximum value of Block dimension Y, used for thread block configuration in the SIMT programming model.

    <!-- npu="950" id24 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id24 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_MAX\_BLOCK\_DIM\_Z

    Maximum value of Block dimension Z, used for thread block configuration in the SIMT programming model.

    <!-- npu="950" id25 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id25 -->

    For product models that do not support this option, 0 is returned by default.

- ACL\_DEV\_ATTR\_TOTAL\_GLOBAL\_MEM\_SIZE

    Total available memory on the device, in bytes.

- ACL\_DEV\_ATTR\_L2\_CACHE\_SIZE

    L2 cache size, in bytes.

- ACL\_DEV\_ATTR\_SMP\_ID

    Symmetric Multiprocessing (SMP) ID, used to identify whether devices run on the same operating system.

- ACL\_DEV\_ATTR\_PHY\_CHIP\_ID

    Physical chip ID.

- ACL\_DEV\_ATTR\_SUPER\_POD\_DEVICE\_ID

    Device ID in super node products.

- ACL\_DEV\_ATTR\_SUPER\_POD\_SERVER\_ID

    Server ID in super node products.

- ACL\_DEV\_ATTR\_SUPER\_POD\_ID

    Super node ID in the cluster.

- ACL\_DEV\_ATTR\_CUST\_OP\_PRIVILEGE

    Whether a custom operator can execute more system call permissions.

    The value can be:

    - **0**: The system call permissions of a custom operator are controlled (for example, write operations cannot be executed).
    - **1**: Custom operators can execute more system call permissions.

    <!-- npu="950" id26 -->
    Ascend 950PR&950DT products do not support this option.
    <!-- end id26 -->

- ACL\_DEV\_ATTR\_MAINBOARD\_ID

    Motherboard ID.

- ACL\_DEV\_ATTR\_HD\_CONNECT\_TYPE

    Interconnect protocol between the host and the device.

    The value can be:

    - **0**: interconnect transmission through PCIe.
    - **1**: interconnect transmission through Huawei Cache Coherence System (HCCS).
    - **2**: interconnect transmission through Unified Bus (UB).

    <!-- npu="950" id27 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id27 -->

    For product models that do not support this option, an error is returned.

- ACL\_DEV\_ATTR\_DEVICE\_FORM\_FACTOR

    Device form.

    The value can be:

    - **0**: PoD form (compute cabinet form).
    - **1**: A+K Server form (Ascend + Kunpeng architecture).
    - **2**: A+X Server form (Ascend + non-Kunpeng architecture), such as X86 architecture.
    - **3**: PCIe standard card form.

    <!-- npu="950" id61 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id61 -->

    For product models that do not support this option, an error is returned.

- ACL\_DEV\_ATTR\_SUPER\_POD\_CHASSIS\_ID

    Chassis ID in super node products.

    <!-- npu="950" id108 -->
    Only Ascend 950PR&950DT products support this option.
    <!-- end id108 -->

    For product models that do not support this option, an error is returned.

- ACL\_DEV\_ATTR\_IS\_VIRTUAL

    Whether the instance is an Ascend virtualization instance.

    - **0**: The instance is not an Ascend virtualization instance; it is a physical machine.
    - **1**: The instance is an Ascend virtualization instance, which may be a virtual machine or a container.

- ACL\_DEV\_ATTR\_NPU\_ARCH

    Architecture version of the NPU.

    The mapping between product models and NPU architecture versions is as follows:

    <!-- npu="950" id28 -->
    - Ascend 950PR&950DT products: 3510
    <!-- end id28 -->
    <!-- npu="A3" id29 -->
    - Atlas A3 products: 2201
    <!-- end id29 -->
    <!-- npu="910b" id30 -->
    - Atlas A2 products: 2201
    <!-- end id30 -->
    <!-- npu="310b" id31 -->
    - Atlas 200I/500 A2 inference products: 3002
    <!-- end id31 -->
    <!-- npu="310p" id32 -->
    - Atlas inference products: 2002
    <!-- end id32 -->
    <!-- npu="910" id33 -->
    - Atlas training products: 1001
    <!-- end id33 -->
    <!-- npu="9030" id35 -->
    - Kirin 9030: 3113
    <!-- end id35 -->
    <!-- npu="x90" id36 -->
    - Kirin X90: 3003
    <!-- end id36 -->
    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id4 -->

### Relationship Between the AI Core, Cube Core, and Vector Core

To facilitate understanding of the relationship between the AI Core, Cube Core, and Vector Core, the definition of Core is first clarified here. A Core is a compute core that has an independent Scalar compute unit. The Scalar compute unit typically handles features such as Single Instruction Multiple Data (SIMD) instruction issue for a compute core, so this Scalar compute unit is also commonly referred to as the scheduling unit within the core. The AI data processing core units differ across products and are currently classified into the following categories:

- When the AI data processing core unit is an AI Core:
    - Within an AI Core, Cube and Vector share one Scalar scheduling unit.
        
        <!-- npu="910" id37 -->
        This uses Atlas training products as an example.
        <!-- end id37 -->

        ![](figures/aicore_shares_one_scalar.png)

    - Within an AI Core, Cube and Vector each have their own Scalar scheduling unit, and are therefore also referred to as Cube Core and Vector Core. In this case, one Cube Core and a group of Vector Cores are defined as one AI Core, and the number of AI Cores is typically calculated based on the number of Cube Cores, for example, Atlas A2 products.

        <!-- npu="910b" id38 -->
        This uses Atlas A2 products as an example.
        <!-- end id38 -->

        ![](figures/aicore_contains_multi_scalars.png)

- When the AI data processing core units are an AI Core and a separate Vector Core: both the AI Core and the Vector Core have independent Scalar scheduling units.

    <!-- npu="310p" id39 -->
    This example uses Atlas inference products.
    <!-- end id39 -->

    ![](figures/aicore_and_vectorcore.png)

### Relationship Between the SuperPOD ID, SuperPOD Server ID, and SuperPOD Device ID

![](figures/podid_serverid_deviceid.png)

<br>

<a id="aclrtDevFeatureType"></a>

## aclrtDevFeatureType

```c
typedef enum { 
    ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV = 1, // Update the computation task of the AI Core operator.
    ACL_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV      = 21, // Send queue event messages across devices.
} aclrtDevFeatureType;
```

<br>

<a id="aclrtDeviceStatus"></a>

## aclrtDeviceStatus

```c
typedef enum aclrtDeviceStatus {
    ACL_RT_DEVICE_STATUS_NORMAL = 0,     // The device is normal and available.
    ACL_RT_DEVICE_STATUS_ABNORMAL,       // The device is abnormal.
    ACL_RT_DEVICE_STATUS_END = 0xFFFF,   // Reserved value.
} aclrtDeviceStatus;
```

<br>

<a id="aclrtDevResLimitType"></a>

## aclrtDevResLimitType

```c
typedef enum { 
    ACL_RT_DEV_RES_CUBE_CORE = 0,   // AI Core or Cube Core
    ACL_RT_DEV_RES_VECTOR_CORE,     // Vector Core
} aclrtDevResLimitType;
```

For the definition and detailed description of Core, see [aclrtDevAttr](#aclrtDevAttr).

<!-- npu="910,310p" id40 -->
- For the following products, **ACL\_RT\_DEV\_RES\_CUBE\_CORE** indicates the AI Core.

    <!-- npu="910" id41 -->
    Atlas training products
    <!-- end id41 -->

    <!-- npu="310p" id42 -->
    Atlas inference products
    <!-- end id42 -->
<!-- end id40 -->

<!-- npu="950,A3,910b,310b" id43 -->
- For the following products, **ACL\_RT\_DEV\_RES\_CUBE\_CORE** indicates the Cube Core.

    <!-- npu="950" id44 -->
    Ascend 950PR&950DT products
    <!-- end id44 -->

    <!-- npu="A3" id45 -->
    Atlas A3 products
    <!-- end id45 -->

    <!-- npu="910b" id46 -->
    Atlas A2 products
    <!-- end id46 -->

    <!-- npu="310b" id47 -->
    Atlas 200I/500 A2 inference products
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
    ACL_EVENT_RECORDED_STATUS_NOT_READY = 0,  // The event is not recorded to the stream, or the event recorded to the stream has not been executed or has failed to execute.
    ACL_EVENT_RECORDED_STATUS_COMPLETE = 1,   // The event recorded to the stream is executed successfully.
} aclrtEventRecordedStatus;
```

<br>

<a id="aclrtEventStatus"></a>

## aclrtEventStatus

```c
typedef enum aclrtEventStatus {
    ACL_EVENT_STATUS_COMPLETE  = 0, // Complete.
    ACL_EVENT_STATUS_NOT_READY = 1, // Not ready.
    ACL_EVENT_STATUS_RESERVED  = 2, // Reserved.
} aclrtEventStatus;
```

<br>

<a id="aclrtEventWaitStatus"></a>

## aclrtEventWaitStatus

```c
typedef enum aclrtEventWaitStatus {
    ACL_EVENT_WAIT_STATUS_COMPLETE  = 0,      // Complete.
    ACL_EVENT_WAIT_STATUS_NOT_READY = 1,      // Not ready.
    ACL_EVENT_WAIT_STATUS_RESERVED  = 0xFFFF, // Reserved.
} aclrtEventWaitStatus;
```

<br>

<a id="aclrtFloatOverflowMode"></a>

## aclrtFloatOverflowMode

```c
typedef enum aclrtFloatOverflowMode {
    ACL_RT_OVERFLOW_MODE_SATURATION = 0, // Saturation mode for overflow detection.
    ACL_RT_OVERFLOW_MODE_INFNAN,         // Inf/NaN mode for overflow detection, which is the default value.
    ACL_RT_OVERFLOW_MODE_UNDEF,
} aclrtFloatOverflowMode;
```

Compared with the Inf/NaN mode, in saturation mode, if the computation result is Inf, the final result is a maximum value; if the computation result is NaN, the final result is 0. If saturation mode is set, the computation precision may have errors. This mode is provided only for compatibility with earlier versions and will not evolve in the future.

<!-- npu="950,A3,910b" id48 -->
For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, the default value is the Inf/NaN mode. Among them, Ascend 950PR&950DT products support only the Inf/NaN mode.
<!-- end id48 -->

<!-- npu="910,310p,310b" id49 -->
For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, only the saturation mode can be set.
<!-- end id49 -->

<br>

<a id="aclrtFuncAttribute"></a>

## aclrtFuncAttribute

```c
typedef enum {
    ACL_FUNC_ATTR_KERNEL_TYPE = 1,     // Kernel type.
    ACL_FUNC_ATTR_KERNEL_RATIO = 2,    // Ratio of Cube Cores to Vector Cores required for kernel execution.
    ACL_FUNC_ATTR_KERNEL_SCHED_MODE = 3,    // Kernel scheduling mode.
} aclrtFuncAttribute;
```

- When the attribute is set to **ACL\_FUNC\_ATTR\_KERNEL\_TYPE**, see [aclrtKernelType](#aclrtKernelType) for the attribute value description.
<!-- npu="950,A3,910b,910,310p,310b" id50 -->
- When the attribute is set to **ACL\_FUNC\_ATTR\_KERNEL\_RATIO**, obtain the attribute value as follows:

    ```c
    uint16_t* ratioArr = reinterpret_cast<uint16_t*>(&attrValue);
    uint16_t aicratio = ratioArr[1];   // Cube Core ratio.
    uint16_t aivratio = ratioArr[0];   // Vector Core ratio.
    ```
 
    The support for this attribute varies by product model, as follows:

    <!-- npu="950" id51 -->
    - Ascend 950PR&950DT products: Not supported.
    <!-- end id51 -->
    <!-- npu="A3" id52 -->
    - Atlas A3 products: Supported
    <!-- end id52 -->
    <!-- npu="910b" id53 -->
    - Atlas A2 products: Supported
    <!-- end id53 -->
    <!-- npu="310b" id54 -->
    - Atlas 200I/500 A2 inference products: Not supported
    <!-- end id54 -->
    <!-- npu="310p" id55 -->
    - Atlas inference products: Supported
    <!-- end id55 -->
    <!-- npu="910" id56 -->
    - Atlas training products: Not supported
    <!-- end id56 -->
<!-- end id50 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id5 -->
- When the attribute is set to **ACL\_FUNC\_ATTR\_KERNEL\_SCHED\_MODE**, the values are as follows:

    - **0**: normal scheduling mode. The operator starts execution as soon as a core becomes idle. For example, when the value of **numBlocks** is 8, the operator kernel function will execute on 8 cores. In this case, if the normal scheduling mode is specified, the operator starts execution as soon as 1 core becomes idle.
    - **1**: batch scheduling mode. The operator starts execution only when all required cores are idle. For example, when the value of **numBlocks** is 8, the operator kernel function will execute on 8 cores. In this case, if the batch scheduling mode is specified, the operator starts execution only after all 8 cores become idle.

<br>

<a id="aclrtGroupAttr"></a>

## aclrtGroupAttr

```c
typedef enum aclrtGroupAttr
{
    ACL_GROUP_AICORE_INT,     // Number of AI Cores corresponding to the Group. The data type of the attribute value is integer.
    ACL_GROUP_AIV_INT,       // Number of Vector Cores corresponding to the group. The data type of the attribute value is integer.
    ACL_GROUP_AIC_INT,       // Number of AI CPU threads corresponding to the group. The data type of the attribute value is integer.
    ACL_GROUP_SDMANUM_INT,   // Number of channels for asynchronous memory copy. The data type of the attribute value is integer.
    ACL_GROUP_ASQNUM_INT,    // Number of streams that can be scheduled and executed simultaneously under the group, which is less than or equal to 32. Currently, a maximum of 32 streams can be scheduled simultaneously at the system level. The data type of the attribute value is integer.
    ACL_GROUP_GROUPID_INT    // ID of the group. The data type of the attribute value is integer.
} aclrtGroupAttr;
```

<br>

<a id="aclrtHacType"></a>

## aclrtHacType

```c
typedef enum {
    ACL_RT_HAC_TYPE_STARS = 0,    // System Task and Resource Scheduler
    ACL_RT_HAC_TYPE_AICPU,        // AI CPU
    ACL_RT_HAC_TYPE_AIC,          // AI Core or Cube Core
    ACL_RT_HAC_TYPE_AIV,          // Vector Core
    ACL_RT_HAC_TYPE_PCIEDMA,      // PCIe Direct Memory Access
    ACL_RT_HAC_TYPE_RDMA,         // Remote Direct Memory Access
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
    ACL_RT_HOST_MEM_MAP_NOT_SUPPORTED = 0,  // Not supported.
    ACL_RT_HOST_MEM_MAP_SUPPORTED           // Supported.
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

| Item | Description |
| --- | --- |
| ACL_HOST_REGISTER_MAPPED | Registers the host memory mapping as accessible to the device, including read and write. |
| ACL_HOST_REGISTER_IOMEMORY | Registers the I/O space (registers and cache) mapping of a third-party PCIe device on the host as accessible to the device, including read and write. This is a reserved option and is not supported currently. |
| ACL_HOST_REGISTER_READONLY | Registers the host memory mapping as read-only for the device. |

<br>

<a id="aclrtIpcMemAttrType"></a>

## aclrtIpcMemAttrType

```c
typedef enum {
    ACL_RT_IPC_MEM_ATTR_ACCESS_LINK,    // Communication method.
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
    ACL_KERNEL_TYPE_MIX = 3,       // The Cube Core and Vector Core simultaneously start on the AI Core.
    ACL_KERNEL_TYPE_AICPU = 100,   // AI CPU
} aclrtKernelType;
```

The AI data processing core units differ across products. For the definition and detailed description of the Core, see [aclrtDevAttr](#aclrtDevAttr).

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
    ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE = 1,        // Scheduling mode.
    ACL_RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE = 2, // Size of the UB buffer inside the VECTOR CORE required for SIMT operator execution.
    ACL_RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE = 3,       // Operator execution engine.
    ACL_RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET,       // numBlocks offset.
    ACL_RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH,   // Whether to prevent the hardware from prefetching the information of this task during task dispatch.
    ACL_RT_LAUNCH_KERNEL_ATTR_DATA_DUMP,             // Whether to enable dump.
    ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT,               // Timeout for the task scheduler to wait for task execution, in seconds.
    ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US = 8,        // Timeout for the task scheduler to wait for task execution, in microseconds.
    ACL_RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING = 9,  // Task-level profiling switch.
} aclrtLaunchKernelAttrId;
```

<br>

<a id="aclrtMallocAttrType"></a>

## aclrtMallocAttrType

```c
typedef enum {
    ACL_RT_MEM_ATTR_RSV = 0,    // Reserved value.
    ACL_RT_MEM_ATTR_MODULE_ID,  // Module ID.
    ACL_RT_MEM_ATTR_DEVICE_ID,  // Device ID.
    ACL_RT_MEM_ATTR_VA_FLAG,    // Whether to use the virtual address (VA) consistency feature when requesting host memory using the aclrtMallocHostWithCfg API.
} aclrtMallocAttrType;
```

<br>

<a id="aclrtMemAccessFlags"></a>

## aclrtMemAccessFlags

```c
typedef enum {
    ACL_RT_MEM_ACCESS_FLAGS_NONE = 0x0,      // The address range is inaccessible. 
    ACL_RT_MEM_ACCESS_FLAGS_READ = 0x1,      // The address range is readable.
    ACL_RT_MEM_ACCESS_FLAGS_READWRITE = 0x3, // The address range is readable and writable.
} aclrtMemAccessFlags;
```

<br>

<a id="aclrtMemAllocationType"></a>

## aclrtMemAllocationType

```c
typedef enum aclrtMemAllocationType {
    ACL_MEM_ALLOCATION_TYPE_PINNED = 0,     // Pinned memory.
} aclrtMemAllocationType;
```

<br>

<a id="aclrtMemAttr"></a>

## aclrtMemAttr

```c
typedef enum aclrtMemAttr {
    ACL_DDR_MEM,             // Huge page memory + normal memory.
    ACL_HBM_MEM,             // Huge page memory + normal memory.
    ACL_DDR_MEM_HUGE,        // Huge page memory.
    ACL_DDR_MEM_NORMAL,      // Normal memory.
    ACL_HBM_MEM_HUGE,        // Huge page memory. The memory request granularity is 2 MB. If the size is not a multiple of 2 MB, it is aligned upward to 2 MB.
    ACL_HBM_MEM_NORMAL,      // Normal memory.
    ACL_DDR_MEM_P2P_HUGE,    // Huge page memory used for data copy between devices.
    ACL_DDR_MEM_P2P_NORMAL,  // Normal memory used for data copy between devices.
    ACL_HBM_MEM_P2P_HUGE,    // Huge page memory used for data copy between devices. The memory request granularity is 2 MB. If the size is not a multiple of 2 MB, it is aligned upward to 2 MB.
    ACL_HBM_MEM_P2P_NORMAL,  // Normal memory used for data copy between devices.
    ACL_HBM_MEM_HUGE1G,      // Huge page memory with a memory request granularity of 1 GB. If the size is not a multiple of 1 GB, it is aligned upward to 1 GB.
    ACL_HBM_MEM_P2P_HUGE1G,  // Huge page memory used for data copy between devices, with a memory request granularity of 1 GB. If the size is not a multiple of 1 GB, it is aligned upward to 1 GB.

    /* The options above are compatible with earlier versions. The user must select the appropriate memory attribute option based on the hardware memory (DDR or HBM). */
    /* The options below are automatically selected by the API based on the underlying hardware memory (DDR or HBM). The user does not need to be aware of hardware details. These options are recommended. */

    ACL_MEM_NORMAL,          // Normal memory.
    ACL_MEM_HUGE,            // Huge page memory with a memory request granularity of 2 MB. If the size is not a multiple of 2 MB, it is aligned upward to 2 MB.
    ACL_MEM_HUGE1G,          // Huge page memory with a memory request granularity of 1 GB. If the size is not a multiple of 1 GB, it is aligned upward to 1 GB.
    ACL_MEM_P2P_NORMAL,      // Normal memory used for data copy between devices.
    ACL_MEM_P2P_HUGE,        // Huge page memory used for data copy between devices, with a memory request granularity of 2 MB. If the size is not a multiple of 2 MB, it is aligned upward to 2 MB.
    ACL_MEM_P2P_HUGE1G,      // Huge page memory used for data copy between devices, with a memory request granularity of 1 GB. If the size is not a multiple of 1 GB, it is aligned upward to 1 GB.
} aclrtMemAttr;
```

For scenarios where huge page memory is requested, when the memory request granularity is 2 MB, requesting 1 GB of huge page memory occupies 1024/2=512 page tables. When the memory request granularity is 1 GB, 1 GB of huge page memory occupies only 1 page table, which effectively reduces the number of page tables and expands the address range covered by the Translation Lookaside Buffer (TLB), thereby improving the performance of scattered access. The TLB is a hardware module in the AI processor used for high-speed caching, which stores the mapping from recently used virtual addresses to physical addresses.

<!-- npu="A3,910b" id59 -->
Only Atlas A3 products and Atlas A2 products support the HUGE1G-related options.
<!-- end id59 -->

<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id6 -->

<br>

<a id="aclrtMemcpyKind"></a>

## aclrtMemcpyKind

```c
typedef enum aclrtMemcpyKind {
    ACL_MEMCPY_HOST_TO_HOST,     // Memory copy within the host.
    ACL_MEMCPY_HOST_TO_DEVICE,   // Memory copy from the host to the device.
    ACL_MEMCPY_DEVICE_TO_HOST,   // Memory copy from the device to the host.
    ACL_MEMCPY_DEVICE_TO_DEVICE, // Memory copy within a device or between two devices.
    ACL_MEMCPY_DEFAULT,          // Copy direction determined by the system based on the source and destination memory addresses.
    ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE,   // Memory copy from the host to the device, but the host memory is temporarily stored in the cache managed by Runtime. After the memory copy API is successfully called, the host memory can be released. 
    ACL_MEMCPY_INNER_DEVICE_TO_DEVICE,  // Memory copy within a device. 
    ACL_MEMCPY_INTER_DEVICE_TO_DEVICE,  // Memory copy between two devices. 
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
    ACL_MEM_HANDLE_TYPE_NONE = 0,   // Generic handle with no type identifier.
    ACL_MEM_HANDLE_TYPE_POSIX = 2,  // POSIX-type handle, indicating that the memory can be exported through a POSIX file descriptor. It is recommended to set this attribute only in the POSIX system.
} aclrtMemHandleType;
```

<br>

<a id="aclrtMemLinkType"></a>

## aclrtMemLinkType

```c
typedef enum {
    ACL_RT_MEM_ACCESS_LINK_SIO = 0,
    ACL_RT_MEM_ACCESS_LINK_HCCS = 1,
    ACL_RT_MEM_ACCESS_UB_ONE_PORT_PATH = 2,
    ACL_RT_MEM_ACCESS_UB_MULTI_PORT_PATH = 3,
} aclrtMemLinkType;
```

The description of each enumeration item is as follows:

- `ACL_RT_MEM_ACCESS_LINK_SIO`: SIO channel, an on-chip connection method through which two DIEs are connected.
- `ACL_RT_MEM_ACCESS_LINK_HCCS`: HCCS channel. HCCS stands for Huawei Cache Coherence System, which is used for high-speed interconnection between the CPU and NPU.
- `ACL_RT_MEM_ACCESS_UB_ONE_PORT_PATH`: Unified Bus (UB) single-port path: Full Mesh (FM) connection, with no hierarchy and all point-to-point direct connections.
- `ACL_RT_MEM_ACCESS_UB_MULTI_PORT_PATH`: Unified Bus (UB) multi-port path: CLOS connection, with hierarchical structured interconnection.

<!-- npu="A3" id109 -->
For Atlas A3 products, only `ACL_RT_MEM_ACCESS_LINK_SIO` and `ACL_RT_MEM_ACCESS_LINK_HCCS` are supported.
<!-- end id109 -->
<!-- npu="950" id110 -->
For Ascend 950PR&950DT products, only `ACL_RT_MEM_ACCESS_UB_ONE_PORT_PATH` and `ACL_RT_MEM_ACCESS_UB_MULTI_PORT_PATH` are supported.
<!-- end id110 -->

<br>

<a id="aclrtMemLocationType"></a>

## aclrtMemLocationType

```c
typedef enum aclrtMemLocationType {
    ACL_MEM_LOCATION_TYPE_HOST = 0,      // Host memory requested through acl APIs (for example, aclrtMallocHost).
    ACL_MEM_LOCATION_TYPE_DEVICE,        // Device memory requested through acl APIs (for example, aclrtMalloc).
    ACL_MEM_LOCATION_TYPE_UNREGISTERED,  // Memory not requested through acl APIs.
    ACL_MEM_LOCATION_TYPE_MANAGED,       // Unified Virtual Memory (UVM).
    ACL_MEM_LOCATION_TYPE_HOST_NUMA =4,  // Host memory requested by NUMA ID through the aclrtMallocPhysical API.
} aclrtMemLocationType;
```

<!-- npu="910b" id103 -->
The **ACL_MEM_LOCATION_TYPE_MANAGED** option is currently supported only by Atlas A2 products.
<!-- end id103 -->

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

**Enumeration item descriptions are as follows:**

- ACL\_MEM\_MALLOC\_HUGE\_FIRST

    Requests huge page memory. The memory request granularity is 2 MB, and memory that is not a multiple of 2 MB is aligned upward to 2 MB. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

    When the requested memory is less than or equal to 1 MB, normal page memory is requested even if this memory request policy is used. When the requested memory is greater than 1 MB, huge page memory is requested preferentially; if huge page memory is insufficient, normal page memory is used.

- ACL\_MEM\_MALLOC\_HUGE\_ONLY

    Requests huge page memory. The memory request granularity is 2 MB, and memory that is not a multiple of 2 MB is aligned upward to 2 MB. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

    When this option is configured, only huge page memory is requested; if huge page memory is insufficient, an error is returned.

- ACL\_MEM\_MALLOC\_NORMAL\_ONLY

    Requests only normal pages. If normal page memory is insufficient, an error is returned. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

- ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P

    Requests huge page memory in the memory copy between two devices. The memory request granularity is 2 MB, and memory that is not a multiple of 2 MB is aligned upward to 2 MB. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

    When this option is configured, huge page memory is preferentially requested. If huge page memory is insufficient, normal page memory is used.

    <!-- npu="310b" id62 -->
    Atlas 200I/500 A2 inference products do not support this option.
    <!-- end id62 -->

    <!-- npu="310p" id63 -->
    For Atlas inference products, if collective communication services are involved, communication domain initialization must be performed before any other operation involving device memory request; otherwise, initialization may fail due to insufficient P2P memory.
    <!-- end id63 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id7 -->

- ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P

    Requests huge page memory in the memory copy between two devices. The memory request granularity is 2 MB, and memory that is not a multiple of 2 MB is aligned upward to 2 MB. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

    When this option is configured, only huge page memory is requested. If huge page memory is insufficient, normal page memory is used.

    <!-- npu="310b" id65 -->
    Atlas 200I/500 A2 inference products do not support this option.
    <!-- end id65 -->

    <!-- npu="310p" id66 -->
    For Atlas inference products, if collective communication services are involved, communication domain initialization must be performed before any other operation involving device memory request; otherwise, initialization may fail due to insufficient P2P memory.
    <!-- end id66 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id8 -->

- ACL\_MEM\_MALLOC\_NORMAL\_ONLY\_P2P

    Requests normal page memory in the memory copy between two devices. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

    <!-- npu="310b" id68 -->
    Atlas 200I/500 A2 inference products do not support this option.
    <!-- end id68 -->

    <!-- npu="310p" id69 -->
    For Atlas inference products, if collective communication services are involved, the communication domain initialization must be performed before any other operation involving device memory request; otherwise, initialization may fail due to insufficient P2P memory.
    <!-- end id69 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id9 -->

- ACL\_MEM\_MALLOC\_HUGE1G\_ONLY

    Requests huge page memory. The memory request granularity is 1 GB, and memory that is not a multiple of 1 GB is aligned upward to 1 GB. For example, when 1.9 GB is requested, 2 GB is actually requested according to the round-up principle. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

    When this option is configured, only 1 GB huge pages are requested. If the 1 GB huge page memory is insufficient, an error is returned. Because 1 GB huge page resources are limited, you can try using the **ACL\_MEM\_MALLOC\_HUGE\_FIRST** option to request huge page memory.

    Compared with the **ACL\_MEM\_MALLOC\_HUGE\_ONLY** option, the memory request granularity of **ACL\_MEM\_MALLOC\_HUGE\_ONLY** is 2 MB. If 1 GB of huge page memory is requested, 1024/2 = 512 page tables are occupied. However, the memory request granularity of **ACL\_MEM\_MALLOC\_HUGE1G\_ONLY** is 1 GB, and 1 GB of huge page memory occupies only one page table, which effectively reduces the number of page tables and expands the address range of the Translation Lookaside Buffer (TLB), thereby improving the performance of scattered access. The TLB is a hardware module in the AI processor used for high-speed caching, and it stores the mapping from recently used virtual addresses to physical addresses.

    <!-- npu="910,310p,310b" id71 -->
    Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products do not support this option.
    <!-- end id71 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id10 -->

- ACL\_MEM\_MALLOC\_HUGE1G\_ONLY\_P2P:

    Requests huge page memory in the memory copy between two devices. The memory request granularity is 1 GB, and memory that is not a multiple of 1 GB is aligned upward to 1 GB. For example, when 1.9 GB is requested, 2 GB is actually requested according to the round-up principle. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

    When this option is configured, only 1 GB huge pages are requested. If the 1 GB huge page memory is insufficient, an error is returned. Because 1 GB huge page resources are limited, you can try using the **ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P** option to request huge page memory.

    Compared with the **ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P** option, the memory request granularity of **ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P** is 2 MB. If 1 GB of huge page memory is to be requested, 1024/2 = 512 page tables are occupied. However, the memory request granularity of **ACL\_MEM\_MALLOC\_HUGE1G\_ONLY\_P2P** is 1 GB, and 1 GB of huge page memory occupies only one page table, which effectively reduces the number of page tables and effectively expands the address range of the Translation Lookaside Buffer (TLB) cache, thereby improving the performance of scattered access. The TLB is a hardware module in the AI processor used for high-speed caching, and it is used to store the mapping from recently used virtual addresses to physical addresses.

    <!-- npu="910,310p,310b" id73 -->
    Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products do not support this option.
    <!-- end id73 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id11 -->

- ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH

    Requests memory from low-bandwidth physical memory.

    <!-- npu="950,A3,910b,910,310p,310b" id75 -->
    Setting this option is invalid. The system selects the memory type based on the memory types supported by the hardware by default.
    <!-- end id75 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id12 -->

- ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH

    Requests memory from high-bandwidth physical memory.

    <!-- npu="950,A3,910b,910,310p,310b" id77 -->
    Setting this option is invalid. The system selects the memory type based on the memory types supported by the hardware by default.
    <!-- end id77 -->

    <!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id13 -->

- ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY

    Used to control the requested memory to be read-only in user mode; any modification to this memory in user mode will fail. In addition, the system internally selects whether to request memory from high-bandwidth or low-bandwidth physical memory based on hardware support.

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

The enumeration items are described as follows:

- **ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY**

    Sets the memory multi-copy attribute, commonly known as the **read mostly** attribute.

    If the **read mostly** attribute is set for a segment of UVM memory, then except for the object that first accesses this memory segment (note: here "object" refers to the host or device), every other object that accesses it creates a read-only memory copy. That is, one virtual address can have multiple read-only copies. On an object that has a read-only memory copy, the page table mapping from virtual memory to physical memory needs to be established only on the first access. When the memory is accessed again on an object that has a read-only memory copy, no page fault is triggered, thereby reducing the performance overhead caused by page faults.

    However, if a write operation is performed on memory with the **read mostly** attribute set, the copies on all objects other than the object where the write occurs become invalid and the **read mostly** attribute is canceled. A subsequent access triggers a page fault, and the system needs to re-establish the page table mapping, which affects performance. Therefore, it is recommended to set the **read mostly** attribute for UVM memory that is normally read-only and rarely written.

    If the **ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY** option is set, the **location** parameter is ignored, and a read-only copy is created on the host, which owns one copy of the data by default.

- **ACL\_MEM\_ADVISE\_UNSET\_READ\_MOSTLY**

    Cancels the **read mostly** attribute.

    After cancellation, this segment of UVM memory retains only one memory copy. Which object's memory copy is retained depends on the **location** parameter passed in. If **invalid** is passed, the memory copy on the host is retained. If there is no copy at the passed-in **location**, a copy is created. At the same time, except for the object whose memory copy is retained, the memory copies on all other objects become invalid, and the corresponding physical memory is released.

- **ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION**

    Sets the memory preferred location attribute, commonly referred to as the **preferred location** attribute, which indicates that the preferred location for accessing this memory segment is the host or the device.

    This attribute can be used together with the memory accessor attribute (that is, **ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY**). When the location is the same, it is used to allocate physical memory in advance and establish page table mappings, thereby avoiding the overhead of page faults when accessing memory at the preferred location.

    When setting the **preferred location** attribute, note whether the **read mostly** attribute is set:

    - When the **read mostly** attribute is not set, if the preferred location is set on the host, the API internally checks whether the current memory address already has a mapping on the device. If a mapping exists, it returns an error. If no mapping exists, the API internally checks whether the current memory address already has a mapping on the host. If a mapping exists, it returns directly; if no mapping exists, it requests physical memory, establishes a page table mapping with the **readwrite** attribute, and then returns.
    - When the **read mostly** attribute is not set, if the preferred location is set on a specified device, the API internally checks whether the current address has a mapping on the host or other devices. If a mapping exists, it returns an error. If no mapping exists, it requests physical memory on the specified device, establishes a page table mapping with the **readwrite** attribute, and then returns.
    - When the **read mostly** attribute is set, if the preferred location is set on the host, the API returns directly without any operation.
    - When the **read mostly** attribute is set, if the preferred location is set on a specified device, the API internally checks whether a copy already exists on the specified device. If a copy exists, it returns directly; if no copy exists, it establishes a read-only copy and then returns.

- **ACL\_MEM\_ADVISE\_UNSET\_PREFERRED\_LOCATION**

    Cancels the **preferred location** attribute setting.

- **ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY**

    Sets the remote mapping attribute, typically called the **accessed by** attribute.

    This attribute must be used together with the preferred location attribute (that is, **ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION**). When the location is the same, it is used to allocate physical memory in advance and establish page table mappings, thereby avoiding the overhead of page faults when accessing memory at the preferred location.

- **ACL\_MEM\_ADVISE\_UNSET\_ACCESSED\_BY**

    Cancels the **accessed by** attribute setting.

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

**Table 1**  Enumeration item description

| Item | Description |
| --- | --- |
| ACL_MEM_LOCATIONTYPE_INVALID | Invalid location. |
| ACL_MEM_LOCATIONTYPE_DEVICE | The location is on the device. |
| ACL_MEM_LOCATIONTYPE_HOST | The location is on the host. |
| ACL_MEM_LOCATIONTYPE_HOST_NUMA | The location is on a host NUMA node. When setting this location type, you must pass a valid NUMA ID. |
| ACL_MEM_LOCATIONTYPE_HOST_NUMA_CURRENT | The location is on the NUMA node associated with the current thread. When this location type is set, the ID passed in by the user is invalid; the API automatically obtains and uses the ID of the NUMA node where the current thread resides. |

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

The enumeration item descriptions are as follows:

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_READ\_MOSTLY**

    Queries whether the specified memory has the **read mostly** attribute set.

    For the case where the **ACL\_MEM\_ADVISE\_SET\_READ\_MOSTLY** or **ACL\_MEM\_ADVISE\_UNSET\_READ\_MOSTLY** policy attribute is set through the **aclrtMemManagedAdvise** API, the **read mostly** attribute value can be queried through the **ACL\_MEM\_RANGE\_ATTRIBUTE\_READ\_MOSTLY** option.

    Returns 1 if all memory pages within the specified memory range have the **read mostly** attribute set; otherwise, returns 0. Since the attribute value is an integer, **dataSize** must be set to **4**.

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION**

    Queries whether the specified memory has the **preferred location** attribute set.

    For the case where the **ACL\_MEM\_ADVISE\_SET\_PREFERRED\_LOCATION** or **ACL\_MEM\_ADVISE\_UNSET\_PREFERRED\_LOCATION** policy attribute is set through the **aclrtMemManagedAdvise** API, the **preferred location** attribute value can be queried through the **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION** option.

    The attribute values are described as follows:

    - If all memory pages within the specified memory range have a specific device or NUMA node set as the preferred location, the returned result is the ID of that device or NUMA node; otherwise, **-2** is returned.
    - If all memory pages within the specified memory range have the host set as the preferred location, the returned result is **-1**; otherwise, **-2** is returned.

    Because the attribute value is an integer, **dataSize** must be set to **4**.

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_ACCESSED\_BY**

    Queries whether the specified memory has the **accessed by** attribute set.

    For cases where the **ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY** or **ACL\_MEM\_ADVISE\_UNSET\_ACCESSED\_BY** policy attribute is set through the **aclrtMemManagedAdvise** API, the **accessed by** attribute value can be queried through the **ACL\_MEM\_RANGE\_ATTRIBUTE\_ACCESSED\_BY** option.

    The attribute value is a list of IDs of the host, device, or NUMA nodes for which the **ACL\_MEM\_ADVISE\_SET\_ACCESSED\_BY** attribute is set within the specified memory range. Note the following:

    - If the size of the **data** array requested by the user is larger than the number of the hosts, devices, or NUMA nodes for which the **accessed by** attribute is set, the excess portion returns **-2**.
    - If the size of the **data** array requested by the user is smaller than the number of the hosts, devices, or NUMA nodes for which the **accessed by** attribute is set, the size of the **data** array takes precedence, but there is no guarantee as to which node IDs are stored.

    Because the attribute value is an integer, **dataSize** must be set to a non-zero integer multiple of 4.

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION\_TYPE**

    Queries the type of the preferred location of the specified memory. Note that the actual location type of the memory pages to be queried may differ from the preferred location type.

    If all memory pages within the specified memory range have the host, the same device, or the same NUMA node set as their preferred location, **ACL\_MEM\_LOCATIONTYPE\_HOST**, **ACL\_MEM\_LOCATIONTYPE\_DEVICE**, or **ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA** is returned respectively; otherwise, **ACL\_MEM\_LOCATIONTYPE\_INVALID** is returned.

    **dataSize** must be sizeof\([aclrtMemManagedLocationType](#aclrtMemManagedLocationType)\), and **data** is parsed as the **aclrtMemManagedLocationType** type.

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_PREFERRED\_LOCATION\_ID**

    Queries the ID of the preferred location of the specified memory.

    If all memory pages within the specified memory range have the same device or the same NUMA node set as their preferred location, the device ID or NUMA node ID is returned respectively; otherwise, the ID is invalid.

    Because the attribute value is an integer, **dataSize** must be set to **4**.

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION** (reserved attribute)

    Queries the location to which the specified memory is last explicitly prefetched through the prefetch API. This return value only indicates the location where the application last requested to prefetch the memory range, and does not indicate whether the prefetch operation has completed.

    The attribute values are described as follows:

    - If the last prefetch location of all memory pages within the specified memory range is a device or NUMA node, the returned result is the ID of that device or NUMA node; otherwise, **-2** is returned.
    - If the last prefetch location of all memory pages within the specified memory range is the host, the returned result is **-1**; otherwise, **-2** is returned.

    Because the attribute value is an integer, **dataSize** must be set to **4**.

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION\_TYPE** (Reserved attribute)

    Queries the location type to which the specified memory is last explicitly prefetched through the memory prefetch API. This return value only indicates the location where the application last requested to prefetch the memory range, and does not indicate whether the prefetch operation has completed.

    If the last prefetch location of all memory pages within the specified memory range is the host, the same device, or the same NUMA node, **ACL\_MEM\_LOCATIONTYPE\_HOST**, **ACL\_MEM\_LOCATIONTYPE\_DEVICE**, or **ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA** is returned respectively; otherwise, **ACL\_MEM\_LOCATIONTYPE\_INVALID** is returned.

    **dataSize** must be sizeof\([aclrtMemManagedLocationType](#aclrtMemManagedLocationType)\), and **data** is parsed as the **aclrtMemManagedLocationType** type.

- **ACL\_MEM\_RANGE\_ATTRIBUTE\_LAST\_PREFETCH\_LOCATION\_ID** (Reserved attribute)

    Queries the ID of the location to which the specified memory is last explicitly prefetched through the prefetch API.

    If all memory pages within the specified memory range are last prefetched to the same device or the same NUMA node, the device ID or NUMA node ID is returned respectively; otherwise, the ID is invalid.

    Because the attribute value is an integer, **dataSize** must be set to **4**.

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

**Table 1**  Enumeration item description

| Item | Description |
| --- | --- |
| ACL_RT_MEM_POOL_REUSE_FOLLOW_EVENT_DEPENDENCIES | Switch for event-dependent memory reuse.<br>When executing tasks on a stream, the system searches for other streams associated with this stream through events, and reuses the memory that has been returned to the memory pool by tasks in these associated streams. This mechanism is suitable for scenarios where task synchronization between streams is implemented through events in user applications.<br>The attribute value type is uint32_t, and the values are as follows:<br><br>  - **1**: enable event-dependent memory reuse.<br>  - **0**: disable event-dependent memory reuse. |
| ACL_RT_MEM_POOL_REUSE_ALLOW_OPPORTUNISTIC | Switch for opportunistic memory reuse.<br>When executing tasks on a stream, the system searches for reusable memory in the memory pool, but does not guarantee that memory reuse will succeed. When memory reuse fails, the program reports an error and stops.<br>The attribute value type is uint32_t, and the values are as follows:<br><br>  - **1**: enable opportunistic memory reuse.<br>  - **0**: disable opportunistic memory reuse. |
| ACL_RT_MEM_POOL_REUSE_ALLOW_INTERNAL_DEPENDENCIES | Switch for implicit-dependency memory reuse.<br>When executing tasks on a stream, the system searches for reusable memory in the memory pool. If this memory is previously used by other streams but no task dependency exists between the related streams, the system automatically adds event synchronization wait logic between the related streams to ensure that the tasks in the previous stream have finished accessing the memory, thereby achieving safe memory reuse.<br>The attribute value type is uint32_t, and the values are as follows:<br><br>  - **1**: enable implicit-dependency memory reuse.<br>  - **0**: disable implicit-dependency memory reuse. |
| ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD | Threshold of the memory size to be retained in the memory pool when releasing idle physical memory, in bytes. The default value is **0**.<br>When the idle physical memory in the memory pool exceeds this threshold, the system attempts to release the idle memory at the next stream synchronization (for example, when calling the **aclrtSynchronizeStream** API).<br>The attribute value type is uint64_t. |
| ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_CURRENT | Total amount of memory currently requested in the memory pool. This attribute is read-only.<br>The attribute value type is uint64_t. |
| ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_HIGH | Historical peak of the total amount of memory currently requested in the memory pool.<br>The attribute value type is uint64_t.<br>The attribute can only be set to **0**. |
| ACL_RT_MEM_POOL_ATTR_USED_MEM_CURRENT | Total amount of memory actually in use in the memory pool. This attribute is read-only.<br>The attribute value type is uint64_t. |
| ACL_RT_MEM_POOL_ATTR_USED_MEM_HIGH | Historical peak of the total amount of memory actually in use in the memory pool.<br>The attribute value type is uint64_t.<br>The attribute can only be set to **0**. |

<br>

<a id="aclrtMemSharedHandleType"></a>

## aclrtMemSharedHandleType

```c
typedef enum aclrtMemSharedHandleType {
    ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT = 0x1,  
    ACL_MEM_SHARE_HANDLE_TYPE_FABRIC = 0x2,
} aclrtMemSharedHandleType;
```

**Table 1** Enumeration item description

| Item | Description |
| --- | --- |
| ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT | Shares memory across processes within an AI Server. This is the default value. |
| ACL_MEM_SHARE_HANDLE_TYPE_FABRIC | Shares memory across processes across AI Servers, including the scenario within a single AI Server. |

<!-- npu="A3" id79 -->
Only Atlas A3 products support the **ACL\_MEM\_SHARE\_HANDLE\_TYPE\_FABRIC** option.
<!-- end id79 -->
<!-- @ref: runtime/res/docs/zh/api_ref/25-02_Enumerations_res.md#id14 -->

<br>

<a id="aclrtRandomNumFuncType"></a>

## aclrtRandomNumFuncType

```c
typedef enum { 
    ACL_RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK = 0,   // Dropout bitmask.
    ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS,           // Uniform distribution.
    ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS,            // Normal distribution.
    ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS,  // Truncated normal distribution.
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
Atlas inference products support only the **SUM** operation.
<!-- end id80 -->

<!-- npu="910" id81 -->
Atlas training products support only the **SUM** operation.
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

**Table 1**  Enumeration item description

| Item | Description |
| --- | --- |
| ACL_DEVICE | The AI software stack runs on the control CPU of the device or in the board-side environment.<br>Ascend 950PR&950DT products do not support this option.<br>Atlas A3 products do not support this option.<br>Atlas A2 products do not support this option. |
| ACL_HOST | The AI software stack runs on the host CPU. |

<br>

<a id="aclrtSnapShotStage"></a>

## aclrtSnapShotStage

```c
typedef enum {
    ACL_RT_SNAPSHOT_LOCK_PRE = 0,    // Before locking.
    ACL_RT_SNAPSHOT_BACKUP_PRE,      // Before backup.
    ACL_RT_SNAPSHOT_BACKUP_POST,     // After backup.
    ACL_RT_SNAPSHOT_RESTORE_PRE,     // Before restore.
    ACL_RT_SNAPSHOT_RESTORE_POST,    // After restore.
    ACL_RT_SNAPSHOT_UNLOCK_POST,     // After unlocking.
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
    ACL_STREAM_LAUNCH_BLOCKING_MODE           = 6,
} aclrtStreamAttr;
```

| Item | Description |
| --- | --- |
| ACL_STREAM_ATTR_FAILURE_MODE | When a task on the stream fails, this attribute can be used to set the task scheduling mode of the stream to control whether to continue executing the next task after a task fails.<br>By default, the stream does not support setting the task scheduling mode.<br>Setting the task scheduling mode through this attribute has the same feature as the [aclrtSetStreamFailureMode](06_stream_management.md#aclrtSetStreamFailureMode) API. |
| ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK | When interfacing with an upper-layer training framework (for example, PyTorch), this attribute can be used to enable or disable the overflow detection switch for a specified stream. After it is disabled, whether a task overflows cannot be obtained through the overflow detection operator.<br>After the overflow detection switch is enabled or disabled, it takes effect only on subsequently dispatched tasks; already dispatched tasks remain unchanged.<br>Setting the overflow detection switch through this attribute has the same feature as the [aclrtSetStreamOverflowSwitch](06_stream_management.md#aclrtSetStreamOverflowSwitch) API. |
| ACL_STREAM_ATTR_USER_CUSTOM_TAG | Sets the overflow detection group tag on the stream to determine the detection granularity when an overflow occurs. If no group tag is set, the process granularity is used by default. If a group tag is set, only streams that have the same group tag as the stream where the overflow occurs are detected. |
| ACL_STREAM_ATTR_CACHE_OP_INFO | In the scenario of building a model running instance based on the capture method, this attribute is used to set the operator information cache switch of the stream to control whether operator information is attached when performance data is subsequently collected.<br>This attribute must be used together with other APIs. For details, see the API call process in [aclrtCacheLastTaskOpInfo](24_other_APIs.md#aclrtCacheLastTaskOpInfo).<br>When tasks are captured across streams, the operator information cache switch state of other streams associated with the main stream is consistent with that of the main stream. |
| ACL_STREAM_ATTR_PRIORITY | Dynamically sets or queries the stream priority based on this attribute value. |
| ACL_STREAM_LAUNCH_BLOCKING_MODE | Controls whether the following APIs run in synchronous or asynchronous mode on the specified stream:<br><br>  - aclrtLaunchKernel<br>  - aclrtLaunchKernelV2<br>  - aclrtLaunchKernelWithConfig<br>  - aclrtLaunchKernelWithHostArgs<br>  - aclrtLaunchKernelWithArgsArray<br>  - aclrtLaunchSIMTKernelWithArgsArray<br>  - aclrtLaunchSIMTKernelWithHostArgs<br>  - aclmdlRIExecuteAsync<br><br>Set it through the [aclrtSetStreamAttribute](06_stream_management.md#aclrtSetStreamAttribute) API and obtain it through the [aclrtGetStreamAttribute](06_stream_management.md#aclrtGetStreamAttribute) API. For the attribute value description, see **launchBlockingMode** in [aclrtStreamAttrValue](25-04_Structs.md#aclrtStreamAttrValue). |

<!-- npu="950,A3,910b" id84 -->
For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, setting the stream priority is supported.
For Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products, setting or obtaining the `ACL_STREAM_LAUNCH_BLOCKING_MODE` attribute is supported.
<!-- end id84 -->

<!-- npu="910,310p,310b" id82 -->
For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, setting the stream priority is not supported.
For Atlas 200I/500 A2 inference products, Atlas inference products, and Atlas training products, setting or obtaining the `ACL_STREAM_LAUNCH_BLOCKING_MODE` attribute is not supported.
<!-- end id82 -->

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

**Table 1**  Enumeration item description

| Item | Description |
| --- | --- |
| ACL_RT_STREAM_WORK_ADDR_PTR | Pointer to the working memory required by the model on a stream (temporary data stored on the device during model execution), managed by the user. This configuration is mainly used for the scenario where multiple models share working memory when executed serially on the same stream. In this case, memory must be allocated based on the largest working memory among the multiple models, and **aclmdlQuerySize** can be used in advance to query the working memory size required by each model.<br>If both **ACL_RT_STREAM_WORK_ADDR_PTR** and **ACL_MDL_WORK_ADDR_PTR** in **aclmdlExecConfigAttr** (which indicates the working memory of a model) are configured, **ACL_MDL_WORK_ADDR_PTR** in **aclmdlExecConfigAttr** takes precedence. |
| ACL_RT_STREAM_WORK_SIZE | Size of the working memory required by the model, in bytes. |
| ACL_RT_STREAM_FLAG | Reserved configuration. The default value is **0**. |
| ACL_RT_STREAM_PRIORITY | Priority of the stream. The smaller the number, the higher the priority. The value range is [0,7]. The default value is **0**. |

<br>

<a id="aclrtStreamStatus"></a>

## aclrtStreamStatus

```c
typedef enum aclrtStreamStatus {
    ACL_STREAM_STATUS_COMPLETE  = 0,      // All tasks on the stream are completed.
    ACL_STREAM_STATUS_NOT_READY = 1,      // At least one task on the stream is not completed.
    ACL_STREAM_STATUS_RESERVED  = 0xFFFF, // Reserved.
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

| Item | Description |
| --- | --- |
| ACL_RT_UPDATE_RANDOM_TASK | Random number generation task. |
| ACL_RT_UPDATE_AIC_AIV_TASK | Computation task executed on the Cube\Vector compute unit. |

<!-- npu="A3,910b" id85 -->
Atlas A3 products and Atlas A2 products support the random number generation task.
<!-- end id85 -->

<!-- npu="310p" id86 -->
Atlas inference products do not support the random number generation task.
<!-- end id86 -->

<br>

<a id="aclSysParamOpt"></a>

## aclSysParamOpt

```c
typedef enum { 
    ACL_OPT_DETERMINISTIC = 0,
    ACL_OPT_ENABLE_DEBUG_KERNEL = 1,
    ACL_OPT_STRONG_CONSISTENCY = 2,
    ACL_OPT_ENABLE_KERNEL_EARLY_START = 3
} aclSysParamOpt;
```

**Table 1**  Enumeration item description

| Item | Description |
| --- | --- |
| ACL_OPT_DETERMINISTIC | Whether to enable deterministic computation.<br><br>Value range [0, 4):<br>  - **0**: disable deterministic computation. This is the default value.<br>  - **1**: enable deterministic computation.<br>  - **2**: enable strong consistency computation. The computation result is deterministic and independent of the data location (equivalent to the deprecated **ACL_OPT_STRONG_CONSISTENCY**).<br>  - **3**: enable batch consistency computation. In machine learning or high-performance computing, when a sample is placed into a batch of any size or its order within the batch is adjusted, the final output computation result of that sample must remain bit-wise identical. In simple terms: "The computation result of a single sample has nothing to do with which group it belongs to (batch size) or its position in the group (batch index)."<br><br>When deterministic computation is enabled, the operator produces the same output across multiple executions under the same hardware and input. However, enabling deterministic computation often slows down operator execution.<br>By default, deterministic computation is disabled, and the operator may produce different results across multiple executions under the same hardware and input. This difference generally arises because asynchronous multi-threaded execution in the operator implementation causes the accumulation order of floating-point numbers to change.<br>It is generally recommended not to enable deterministic computation, because deterministic computation often slows down operator execution and thus affects performance. When the model produces different results across multiple executions, or during precision tuning, deterministic computation can be enabled to assist in model debugging and tuning. |
| ACL_OPT_ENABLE_DEBUG_KERNEL | Whether to enable out-of-bounds access detection for global memory during the operator execution phase.<br><br>  - **0**: disable out-of-bounds memory access detection. This is the default value.<br>  - **1**: enable out-of-bounds memory access detection.<br><br>Before compiling the operator, call the **aclSetCompileopt** API to set **ACL_OP_DEBUG_OPTION** to **oom**, and at the same time call the **aclrtCtxSetSysParamOpt** API (whose scope is the context) or the **aclrtSetSysParamOpt** API (whose scope is the process) to set **ACL_OPT_ENABLE_DEBUG_KERNEL** to **1**, thereby enabling out-of-bounds access detection for global memory. During operator execution, if an out-of-bounds memory access occurs when reading or writing data from global memory (for example, reading operator input data or writing operator output data), the error code "EZ9999" is returned, indicating an operator AI Core error. |
| ACL_OPT_STRONG_CONSISTENCY | Whether to enable strong consistency computation.<br>**0**: disable strong consistency computation. This is the default value.<br>**1**: enable strong consistency computation.<br>When strong consistency computation is enabled, the computation result is deterministic, and multiple executions produce the same output. In addition, the computation result is independent of the data location. For example, during cube multiplication, the accumulation order of different rows may differ, which may cause slight differences in the computation results of the same data in different rows. However, with strong consistency computation enabled, as long as the input is the same, the computation result remains consistent even in different rows.<br>By default, strong consistency computation is disabled, which may cause inconsistent computation results when the same data is located in different rows.<br>It is generally recommended not to enable strong consistency computation, because it slows down operator execution and affects performance. Strong consistency computation should be enabled only when it is necessary to strictly guarantee consistent computation results for the same data at different locations, or during precision tuning, to assist in model debugging and optimization.<br>Caution: This enumeration item will be deprecated in later versions. Use `ACL_OPT_DETERMINISTIC` instead.|
| ACL_OPT_ENABLE_KERNEL_EARLY_START | Reserved value. |

<br>

<a id="acltdtQueueAttrType"></a>

## acltdtQueueAttrType

```c
typedef enum {
    ACL_TDT_QUEUE_NAME_PTR = 0,  // Queue name.
    ACL_TDT_QUEUE_DEPTH_UINT32   // Queue depth.
} acltdtQueueAttrType;
```

<br>

<a id="acltdtQueueRouteParamType"></a>

## acltdtQueueRouteParamType

```c
typedef enum {
    ACL_TDT_QUEUE_ROUTE_SRC_UINT32 = 0,  // Source queue ID.
    ACL_TDT_QUEUE_ROUTE_DST_UINT32,      // Target queue ID.
    ACL_TDT_QUEUE_ROUTE_STATUS_INT32     // Route binding status. 0 indicates unbound, 1 indicates bound, and 2 indicates a binding exception.
} acltdtQueueRouteParamType;
```

<br>

<a id="acltdtQueueRouteQueryInfoParamType"></a>

## acltdtQueueRouteQueryInfoParamType

```c
typedef enum {
    ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM = 0,  // Queries the matching mode.
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32,  // Specifies the source queue ID to query.
    ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32   // Specifies the destination queue ID to query.
} acltdtQueueRouteQueryInfoParamType;
```

After the **ACL\_TDT\_QUEUE\_ROUTE\_QUERY\_MODE\_ENUM** type is selected, the parameter value comes from the enumerated values of [acltdtQueueRouteQueryMode](#acltdtQueueRouteQueryMode).

<br>

<a id="acltdtQueueRouteQueryMode"></a>

## acltdtQueueRouteQueryMode

```c
typedef enum {
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC = 0,         // Specifies matching query based only on the source queue ID.
    ACL_TDT_QUEUE_ROUTE_QUERY_DST = 1,         // Specifies matching query based only on the destination queue ID.
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST = 2,  // Specifies matching query based on both the source and destination queue IDs.
    ACL_TDT_QUEUE_ROUTE_QUERY_ABNORMAL = 100   // Specifies querying abnormal routes.
} acltdtQueueRouteQueryMode;
```

<br>

<a id="acltdtTensorType"></a>

## acltdtTensorType

```c
enum acltdtTensorType {
    ACL_TENSOR_DATA_UNDEFINED = -1,
    ACL_TENSOR_DATA_TENSOR,           // Normal tensor data identifier.
    ACL_TENSOR_DATA_END_OF_SEQUENCE,  // End data identifier.
    ACL_TENSOR_DATA_ABNORMAL,         // Abnormal data identifier.
    ACL_TENSOR_DATA_SLICE_TENSOR,     // Tensor data in the tensor slicing scenario.
    ACL_TENSOR_DATA_END_TENSOR        // Last tensor in the tensor slicing scenario.
};
```

<br>

<a id="aclrtDeviceLimit"></a>

## aclrtDeviceLimit

```c
typedef enum aclrtDeviceLimit {
    ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE = 0,
    ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE = 1,
    ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE = 2,
    ACL_RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE = 3,
    ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE = 4,
} aclrtDeviceLimit;
```

<!-- npu="950" id106 -->
For Ascend 950PR&950DT products, all the above options are supported. `ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE` and `ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE` cannot be set to **0** at the same time; otherwise, the API returns `ACL_ERROR_RT_PARAM_INVALID`.
<!-- end id106 -->

<!-- npu="A3,910b" id107 -->
For Atlas A3 products and Atlas A2 products, only SIMD-related options (for example, `ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE`) are supported, and SIMT-related options (for example, `ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE`) are not supported.
<!-- end id107 -->

The description of each enumeration item is as follows:

- `ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE`: sets the stack space size of each thread of a Single Instruction Multiple Thread (SIMT) operator, in bytes. The default value is 1152 bytes. When this option is set to `ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE`, the value must be an integer multiple of 128 bytes. If the value passed in is not an integer multiple of 128 bytes, the API rounds it up internally to ensure that it is an integer multiple of 128 bytes. The actual stack space size of each thread is (value rounded up to an integer multiple of 128 bytes × 32) bytes.

- `ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE`: Sets the divergence stack space size of a SIMT operator, in bytes. The default value is 1024 bytes. When this option is set to `ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE`, the value must be an integer multiple of 128 bytes. If the value passed in is not an integer multiple of 128 bytes, the API rounds it up internally to ensure that it is an integer multiple of 128 bytes.

- `ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE`: controls the stack space size allocated to each AI Core when a Single Instruction Multiple Data (SIMD) operator is executed in a process, in bytes. The default value is 32768 bytes (that is, 32 KB).

    <!-- npu="A3,910b" id104 -->
    For Atlas A3 products and Atlas A2 products, when this option is set to `ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE`, the value range is (32768, 196608] bytes, that is, (32, 192] KB.
    <!-- end id104 -->

    <!-- npu="950" id105 -->
    For Ascend 950PR&950DT products, when this option is set to `ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE`, the value range is (32768, 131072] bytes, that is, (32, 128] KB.
    <!-- end id105 -->

    When the value is greater than 32 KB, the API rounds it up internally to ensure that it is an integer multiple of 16 KB; when the value is less than or equal to 32 KB, it is processed as 32 KB by default.

- `ACL_RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE`: controls the space size, in bytes, that a SIMD operator can use for Printf printing on each Core. The default value is 32768 bytes (that is, 32 KB). When this option is set to `ACL_RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE`, the value must be an integer multiple of 8 bytes. If the passed value is not an integer multiple of 8 bytes, the API automatically rounds it up to ensure that it is an integer multiple of 8 bytes. The value range is [1024, 67108864] bytes, that is, [1 KB, 64 MB].

- `ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE`: controls the space size, in bytes, that a SIMT operator can use for Printf printing. The default value is 2097152 bytes (that is, 2 MB). When this option is set to `ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE`, the value must be an integer multiple of 8 bytes. If the passed value is not an integer multiple of 8 bytes, the API automatically rounds it up to ensure that it is an integer multiple of 8 bytes. The value range is [1048576, 67108864] bytes, that is, [1, 64] MB.
