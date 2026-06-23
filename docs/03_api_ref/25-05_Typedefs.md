# Typedefs

typedef 类型数据。

<br>

- [aclFloat16](#aclFloat16)
- [aclmdlRI](#aclmdlRI)
- [aclmdlRICondHandle](#aclmdlRICondHandle)
- [aclmdlRITask](#aclmdlRITask)
- [aclrtAllocator](#aclrtAllocator)
- [aclrtAllocatorAddr](#aclrtAllocatorAddr)
- [aclrtAllocatorBlock](#aclrtAllocatorBlock)
- [aclrtArgsHandle](#aclrtArgsHandle)
- [aclrtBinaryLoadOptionValue](#aclrtBinaryLoadOptionValue)
- [aclrtBinHandle](#aclrtBinHandle)
- [aclrtCntNotify](#aclrtCntNotify)
- [aclrtContext](#aclrtContext)
- [aclrtDrvMemHandle](#aclrtDrvMemHandle)
- [aclrtEvent](#aclrtEvent)
- [aclrtFuncHandle](#aclrtFuncHandle)
- [aclrtLabel](#aclrtLabel)
- [aclrtLabelList](#aclrtLabelList)
- [aclrtLaunchKernelAttrValue](#aclrtLaunchKernelAttrValue)
- [aclrtMallocAttrValue](#aclrtMallocAttrValue)
- [aclrtMbuf](#aclrtMbuf)
- [aclrtMemPool](#aclrtMemPool)
- [aclrtNotify](#aclrtNotify)
- [aclrtParamHandle](#aclrtParamHandle)
- [aclrtStream](#aclrtStream)
- [aclrtStreamAttrValue](#aclrtStreamAttrValue)
- [aclrtTaskGrp](#aclrtTaskGrp)
- [aclrtUpdateTaskAttrVal](#aclrtUpdateTaskAttrVal)
- [acltdtBuf](#acltdtBuf)

<br>

<a id="aclFloat16"></a>

## aclFloat16

该数据类型仅用于数据传递，不能用于加减乘除等运算。

```
typedef uint16_t aclFloat16;
```

<br>

<a id="aclmdlRI"></a>

## aclmdlRI

```
typedef void *aclmdlRI;
```

<br>

<a id="aclmdlRICondHandle"></a>

## aclmdlRICondHandle

```
typedef void* aclmdlRICondHandle;
```

<br>

<a id="aclmdlRITask"></a>

## aclmdlRITask

```
typedef void *aclmdlRITask;
```

<br>

<a id="aclrtAllocator"></a>

## aclrtAllocator

```
typedef void *aclrtAllocator;
```

<br>

<a id="aclrtAllocatorAddr"></a>

## aclrtAllocatorAddr

```
typedef void *aclrtAllocatorAddr;
```

<br>

<a id="aclrtAllocatorBlock"></a>

## aclrtAllocatorBlock

```
typedef void *aclrtAllocatorBlock;
```

<br>

<a id="aclrtArgsHandle"></a>

## aclrtArgsHandle

```
typedef void* aclrtArgsHandle;
```

<br>

<a id="aclrtBinaryLoadOptionValue"></a>

## aclrtBinaryLoadOptionValue

```
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
| cpuKernelMode | AI CPU算子注册模式。<br>取值如下：<br><br>  - 0：调用[aclrtBinaryLoadFromFile](14_Kernel加载与执行.md#aclrtBinaryLoadFromFile)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，AI CPU算子库文件（.so）已经在调用[aclrtSetDevice](04_Device管理.md#aclrtSetDevice)接口时被加载到Device。适用于加载CANN内置算子。<br>  - 1：调用[aclrtBinaryLoadFromFile](14_Kernel加载与执行.md#aclrtBinaryLoadFromFile)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，[aclrtBinaryLoadFromFile](14_Kernel加载与执行.md#aclrtBinaryLoadFromFile)接口会查找算子信息库文件同名的AI CPU算子库文件（.so）。适用于加载用户自定义算子。<br>  - 2：调用[aclrtBinaryLoadFromData](14_Kernel加载与执行.md#aclrtBinaryLoadFromData)接口加载算子，并配合使用[aclrtRegisterCpuFunc](14_Kernel加载与执行.md#aclrtRegisterCpuFunc)接口注册AI CPU算子信息。适用于没有算子信息库文件，也没有算子库文件的场景。 |
| rsv | 预留值。 |

<br>

<a id="aclrtBinHandle"></a>

## aclrtBinHandle

```
typedef void* aclrtBinHandle;
```

<br>

<a id="aclrtCntNotify"></a>

## aclrtCntNotify

```
typedef void *aclrtCntNotify;
```

<br>

<a id="aclrtContext"></a>

## aclrtContext

```
typedef void *aclrtContext;
```

<br>

<a id="aclrtDrvMemHandle"></a>

## aclrtDrvMemHandle

```
typedef void* aclrtDrvMemHandle;
```

<br>

<a id="aclrtEvent"></a>

## aclrtEvent

```
typedef void *aclrtEvent;
```

<br>

<a id="aclrtFuncHandle"></a>

## aclrtFuncHandle

```
typedef void* aclrtFuncHandle;
```

<br>

<a id="aclrtLabel"></a>

## aclrtLabel

```
typedef void *aclrtLabel; 
```

<br>

<a id="aclrtLabelList"></a>

## aclrtLabelList

```
typedef void *aclrtLabelList;
```

<br>

<a id="aclrtLaunchKernelAttrValue"></a>

## aclrtLaunchKernelAttrValue

```
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


| 成员名称 | 描述 |
| --- | --- |
| schemMode | 调度模式。<br>取值如下：<br><br>  - 0：普通调度模式，有空闲的核，就启动算子执行。例如，当numBlocks为8时，表示算子核函数将会在8个核上执行，这时如果指定普通调度模式，则表示只要有1个核空闲了，就启动算子执行。<br>  - 1：batch调度模式，必须所有所需的核都空闲了，才启动算子执行。例如，当numBlocks为8时，表示算子核函数将会在8个核上执行，这时如果指定batch调度模式，则表示必须等8个核都空闲了，才启动算子执行。 |
| dynUBufSize | 用于指定SIMT（Single Instruction Multiple Thread）算子执行时需要的VECTOR CORE内部UB buffer的大小，单位Byte。可通过[aclrtFunctionGetAvailDynUbufPerBlock](14_Kernel加载与执行.md#aclrtFunctionGetAvailDynUbufPerBlock)接口，在Kernel Launch前查询该参数可指定的最大值。<br>仅Ascend 950PR/Ascend 950DT支持该参数。其它产品型号当前不支持该参数，配置该参数不生效。 |
| engineType | 算子执行引擎。类型定义请参见[aclrtEngineType](25-02_Enumerations.md#aclrtEngineType)。<br>配置该参数不生效。 |
| blockDimOffset | numBlocks偏移量。<br><br>  配置该参数不生效。 |
| isBlockTaskPrefetch | 任务下发时，是否阻止硬件预取本任务的信息。<br>取值如下：<br><br>  - 0：不阻止<br>  - 1：阻止 |
| isDataDump | 是否开启Dump。<br>取值如下：<br><br>  - 0：不开启<br>  - 1：开启 |
| timeout | 任务调度器等待任务执行的超时时间。仅适用于执行AI CPU或AI Core算子的场景。<br>取值如下：<br><br>  - 0：表示永久等待；<br>  - >0：配置具体的超时时间，单位是秒。 |
| timeoutUs | 任务调度器等待任务执行的超时时间，单位微秒。类型定义请参见[aclrtTimeoutUs](25-04_Structs.md#aclrtTimeoutUs)。<br>若aclrtTimeoutUs结构体中，timeoutLow和timeoutHigh均被配置为0，则表示永久等待。<br>对于同一个Launch Kernel任务，不能同时配置timeoutUs和timeout参数，否则返回报错。 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtMallocAttrValue"></a>

## aclrtMallocAttrValue

```
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
| vaFlag | 使用aclrtMallocHostWithCfg接口申请Host内存时，是否使用VA（virtual address）一致性功能：<br><br>  - 0：不使用（默认值）。<br>  - 1：使用，申请的Host内存通过[aclrtHostRegister](11-02_主机内存管理.md#aclrtHostRegister)接口注册后，返回的devPtr与ptr（表示Host内存地址）一致，Host和Device可以使用相同的VA访问。<br><br>仅部分产品型号支持使用VA一致性功能，不支持的型号使用该功能将返回报错。支持的产品型号如下：<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| rsv | 预留参数。当前固定配置为0。 |

<br>

<a id="aclrtMbuf"></a>

## aclrtMbuf

```
typedef void *aclrtMbuf;
```

<br>

<a id="aclrtMemPool"></a>

## aclrtMemPool

```
typedef void *aclrtMemPool;
```

<br>

<a id="aclrtNotify"></a>

## aclrtNotify

```
typedef void *aclrtNotify;
```

<br>

<a id="aclrtParamHandle"></a>

## aclrtParamHandle

```
typedef void* aclrtParamHandle;
```

<br>

<a id="aclrtStream"></a>

## aclrtStream

```
typedef void *aclrtStream;
```

<br>

<a id="aclrtStreamAttrValue"></a>

## aclrtStreamAttrValue

```
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

<a id="aclrtTaskGrp"></a>

## aclrtTaskGrp

```
typedef void *aclrtTaskGrp;
```

<br>

<a id="aclrtUpdateTaskAttrVal"></a>

## aclrtUpdateTaskAttrVal

```
typedef union { 
    aclrtRandomTaskUpdateAttr randomTaskAttr; 
    aclrtAicAivTaskUpdateAttr aicAivTaskAttr; 
} aclrtUpdateTaskAttrVal;
```


| 成员名称 | 说明 |
| --- | --- |
| randomTaskAttr | 随机数生成任务。类型定义请参见[aclrtRandomTaskUpdateAttr](25-04_Structs.md#aclrtRandomTaskUpdateAttr)。<br>不同型号对该任务支持的情况不同：<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品支持随机数生成任务<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品支持随机数生成任务 |
| aicAivTaskAttr | 在Cube\Vector计算单元上执行的计算任务。类型定义请参见[aclrtAicAivTaskUpdateAttr](25-04_Structs.md#aclrtAicAivTaskUpdateAttr)。 |

<br>

<a id="acltdtBuf"></a>

## acltdtBuf

```
typedef void *acltdtBuf;
```
