# aclrtLaunchKernelAttrValue

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
| dynUBufSize | 用于指定SIMT（Single Instruction Multiple Thread）算子执行时需要的VECTOR CORE内部UB buffer的大小，单位Byte。<br>仅Ascend 950PR/Ascend950DT支持该参数。其它产品型号当前不支持该参数，配置该参数不生效。 |
| engineType | 算子执行引擎。类型定义请参见[aclrtEngineType](aclrtEngineType.md)。<br>当前不支持配置该参数，配置不生效。 |
| blockDimOffset | numBlocks偏移量。<br>当前不支持配置该参数，配置不生效。 |
| isBlockTaskPrefetch | 任务下发时，是否阻止硬件预取本任务的信息。<br>取值如下：<br><br>  - 0：不阻止<br>  - 1：阻止 |
| isDataDump | 是否开启Dump。<br>取值如下：<br><br>  - 0：不开启<br>  - 1：开启 |
| timeout | 任务调度器等待任务执行的超时时间。仅适用于执行AI CPU或AI Core算子的场景。<br>取值如下：<br><br>  - 0：表示永久等待；<br>  - >0：配置具体的超时时间，单位是秒。 |
| timeoutUs | 任务调度器等待任务执行的超时时间，单位微秒。类型定义请参见[aclrtTimeoutUs](aclrtTimeoutUs.md)。<br>若aclrtTimeoutUs结构体中，timeoutLow和timeoutHigh均被配置为0，则表示永久等待。<br>对于同一个Launch Kernel任务，不能同时配置timeoutUs和timeout参数，否则返回报错。 |
| rsv | 预留参数。当前固定配置为0。 |

