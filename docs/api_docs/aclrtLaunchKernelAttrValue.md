# aclrtLaunchKernelAttrValue

```
typedef union aclrtLaunchKernelAttrValue {
    uint8_t schemMode;
    uint32_t localMemorySize;
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
| schemMode | 调度模式。<br>取值如下：<br><br>  - 0：普通调度模式，有空闲的核，就启动算子执行。例如，当blockDim为8时，表示算子核函数将会在8个核上执行，这时如果指定普通调度模式，则表示只要有1个核空闲了，就启动算子执行。<br>  - 1：batch调度模式，必须所有所需的核都空闲了，才启动算子执行。例如，当blockDim为8时，表示算子核函数将会在8个核上执行，这时如果指定batch调度模式，则表示必须等8个核都空闲了，才启动算子执行。 |
| localMemorySize | 用于指定SIMT（Single Instruction Multiple Thread）算子执行时需要的VECTOR CORE内部UB buffer的大小，单位Byte。<br>当前不支持该参数，配置该参数不生效。 |
| engineType | 算子执行引擎。取值请参见[aclrtEngineType](aclrtEngineType.md)。<br>以下产品型号配置该参数不生效：<br><br>  - Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>  - Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| blockDimOffset | blockDim偏移量。<br><br>  - 如果blockDim ≤ AI Core核数，则无需使用Vector Core上计算，可将engineType配置为ACL_RT_ENGINE_TYPE_AIC（表示在AI Core上计算），则此处的blockDimOffset配置为0。<br>  - 如果blockDim > AI Core核数，则需：在一个Stream上下发任务，将engineType配置为ACL_RT_ENGINE_TYPE_AIC（表示在AI Core上计算），此处的blockDimOffset配置为0。在另一个Stream上下发任务，将engineType配置为ACL_RT_ENGINE_TYPE_AIV（表示在Vector Core上计算），此处的blockDimOffset配置为aicoreblockdim，aicoreblockdim的计算公式如下：blockDim ≤ AI Core核数+Vector Core核数时，aicoreblockdim = AI Core核数否则，aicoreblockdim = 向上取整 ( blockDim * ( AI Core核数 ) / ( AI Core核数 + Vector Core核数 ))<br>  - 在一个Stream上下发任务，将engineType配置为ACL_RT_ENGINE_TYPE_AIC（表示在AI Core上计算），此处的blockDimOffset配置为0。<br>  - 在另一个Stream上下发任务，将engineType配置为ACL_RT_ENGINE_TYPE_AIV（表示在Vector Core上计算），此处的blockDimOffset配置为aicoreblockdim，aicoreblockdim的计算公式如下：blockDim ≤ AI Core核数+Vector Core核数时，aicoreblockdim = AI Core核数否则，aicoreblockdim = 向上取整 ( blockDim * ( AI Core核数 ) / ( AI Core核数 + Vector Core核数 ))<br>  - blockDim ≤ AI Core核数+Vector Core核数时，aicoreblockdim = AI Core核数<br>  - 否则，aicoreblockdim = 向上取整 ( blockDim * ( AI Core核数 ) / ( AI Core核数 + Vector Core核数 ))<br><br>以下产品型号不支持该参数：<br><br>  - Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>  - Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| isBlockTaskPrefetch | 任务下发时，是否阻止硬件预取本任务的信息。<br>取值如下：<br><br>  - 0：不阻止<br>  - 1：阻止 |
| isDataDump | 是否开启Dump。<br>取值如下：<br><br>  - 0：不开启<br>  - 1：开启 |
| timeout | 任务调度器等待任务执行的超时时间。仅适用于执行AI CPU或AI Core算子的场景。<br>取值如下：<br><br>  - 0：表示永久等待；<br>  - >0：配置具体的超时时间，单位是秒。 |
| timeoutUs | 任务调度器等待任务执行的超时时间，单位微秒。<br>若aclrtTimeoutUs结构体中，timeoutLow和timeoutHigh均被配置为0，则表示永久等待。<br>对于同一个Launch Kernel任务，不能同时配置timeoutUs和timeout参数，否则返回报错。 |
| rsv | 预留参数。当前固定配置为0。 |

