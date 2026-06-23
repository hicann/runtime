# Operations

包含 create、set、get、destroy 等操作接口的数据类型。

<br>

- [aclDataBuffer](#aclDataBuffer)
    - [aclCreateDataBuffer](#aclCreateDataBuffer)
    - [aclDestroyDataBuffer](#aclDestroyDataBuffer)
    - [aclGetDataBufferAddr](#aclGetDataBufferAddr)
    - [aclGetDataBufferSize（废弃）](#aclGetDataBufferSize（废弃）)
    - [aclGetDataBufferSizeV2](#aclGetDataBufferSizeV2)
    - [aclUpdateDataBuffer](#aclUpdateDataBuffer)
- [aclprofConfig](#aclprofConfig)
    - [aclprofCreateConfig](#aclprofCreateConfig)
    - [aclprofDestroyConfig](#aclprofDestroyConfig)
- [aclprofStepInfo](#aclprofStepInfo)
    - [aclprofCreateStepInfo](#aclprofCreateStepInfo)
    - [aclprofDestroyStepInfo](#aclprofDestroyStepInfo)
- [aclprofSubscribeConfig](#aclprofSubscribeConfig)
    - [aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig)
    - [aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig)
- [aclrtAllocatorDesc](#aclrtAllocatorDesc)
    - [aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)
    - [aclrtAllocatorDestroyDesc](#aclrtAllocatorDestroyDesc)
    - [aclrtAllocatorSetObjToDesc](#aclrtAllocatorSetObjToDesc)
    - [aclrtAllocatorSetAllocFuncToDesc](#aclrtAllocatorSetAllocFuncToDesc)
    - [aclrtAllocatorSetAllocAdviseFuncToDesc](#aclrtAllocatorSetAllocAdviseFuncToDesc)
    - [aclrtAllocatorSetFreeFuncToDesc](#aclrtAllocatorSetFreeFuncToDesc)
    - [aclrtAllocatorSetGetAddrFromBlockFuncToDesc](#aclrtAllocatorSetGetAddrFromBlockFuncToDesc)
- [aclrtStreamConfigHandle](#aclrtStreamConfigHandle)
    - [aclrtCreateStreamConfigHandle](#aclrtCreateStreamConfigHandle)
    - [aclrtDestroyStreamConfigHandle](#aclrtDestroyStreamConfigHandle)
- [acltdtDataItem](#acltdtDataItem)
    - [acltdtCreateDataItem](#acltdtCreateDataItem)
    - [acltdtDestroyDataItem](#acltdtDestroyDataItem)
    - [acltdtGetTensorTypeFromItem](#acltdtGetTensorTypeFromItem)
    - [acltdtGetDataTypeFromItem](#acltdtGetDataTypeFromItem)
    - [acltdtGetDataAddrFromItem](#acltdtGetDataAddrFromItem)
    - [acltdtGetDataSizeFromItem](#acltdtGetDataSizeFromItem)
    - [acltdtGetDimNumFromItem](#acltdtGetDimNumFromItem)
    - [acltdtGetDimsFromItem](#acltdtGetDimsFromItem)
- [acltdtDataset](#acltdtDataset)
    - [acltdtCreateDataset](#acltdtCreateDataset)
    - [acltdtDestroyDataset](#acltdtDestroyDataset)
    - [acltdtGetDataItem](#acltdtGetDataItem)
    - [acltdtAddDataItem](#acltdtAddDataItem)
    - [acltdtGetDatasetSize](#acltdtGetDatasetSize)
    - [acltdtGetDatasetName](#acltdtGetDatasetName)
- [acltdtQueueAttr](#acltdtQueueAttr)
    - [acltdtCreateQueueAttr](#acltdtCreateQueueAttr)
    - [acltdtDestroyQueueAttr](#acltdtDestroyQueueAttr)
    - [acltdtSetQueueAttr](#acltdtSetQueueAttr)
    - [acltdtGetQueueAttr](#acltdtGetQueueAttr)
- [acltdtQueueRoute](#acltdtQueueRoute)
    - [acltdtCreateQueueRoute](#acltdtCreateQueueRoute)
    - [acltdtDestroyQueueRoute](#acltdtDestroyQueueRoute)
    - [acltdtGetQueueRouteParam](#acltdtGetQueueRouteParam)
- [acltdtQueueRouteList](#acltdtQueueRouteList)
    - [acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)
    - [acltdtDestroyQueueRouteList](#acltdtDestroyQueueRouteList)
    - [acltdtAddQueueRoute](#acltdtAddQueueRoute)
    - [acltdtGetQueueRoute](#acltdtGetQueueRoute)
    - [acltdtGetQueueRouteNum](#acltdtGetQueueRouteNum)
- [acltdtQueueRouteQueryInfo](#acltdtQueueRouteQueryInfo)
    - [acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo)
    - [acltdtDestroyQueueRouteQueryInfo](#acltdtDestroyQueueRouteQueryInfo)
    - [acltdtSetQueueRouteQueryInfo](#acltdtSetQueueRouteQueryInfo)

<br>

<a id="aclDataBuffer"></a>

## aclDataBuffer

-   **[aclCreateDataBuffer](#aclCreateDataBuffer)**  

-   **[aclDestroyDataBuffer](#aclDestroyDataBuffer)**  

-   **[aclGetDataBufferAddr](#aclGetDataBufferAddr)**  

-   **[aclGetDataBufferSize（废弃）](#aclGetDataBufferSize（废弃）)**  

-   **[aclGetDataBufferSizeV2](#aclGetDataBufferSizeV2)**  

-   **[aclUpdateDataBuffer](#aclUpdateDataBuffer)**  

<br>

<a id="aclCreateDataBuffer"></a>

## aclCreateDataBuffer

```c
aclDataBuffer *aclCreateDataBuffer(void *data, size_t size)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建aclDataBuffer类型的数据，该数据类型用于描述内存地址、大小等内存信息。

如需销毁aclDataBuffer类型的数据，请参见[aclDestroyDataBuffer](#aclDestroyDataBuffer)。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| data | 输入 | 存放数据内存地址的指针。data参数支持传入nullptr，表示创建一个空的数据类型，此时size参数值必须设置为0。<br>该内存需由用户自行管理，调用[aclrtMalloc](11-01_设备内存分配与释放.md#aclrtMalloc)接口/[aclrtFree](11-01_设备内存分配与释放.md#aclrtFree)接口申请/释放内存，或调用[aclrtMallocHost](11-02_主机内存管理.md#aclrtMallocHost)接口/[aclrtFreeHost](11-02_主机内存管理.md#aclrtFreeHost)接口申请/释放内存。 |
| size | 输入 | 内存大小，单位Byte。<br>如果用户需要使用空tensor，则在申请内存时，内存大小最小为1Byte，以保障后续业务正常运行。 |

### 返回值说明

返回aclDataBuffer类型的指针。

<br>

<a id="aclDestroyDataBuffer"></a>

## aclDestroyDataBuffer

```c
aclError aclDestroyDataBuffer(const aclDataBuffer *dataBuffer)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[aclCreateDataBuffer](#aclCreateDataBuffer)接口创建的aclDataBuffer类型的数据。

此处仅销毁aclDataBuffer类型的数据，调用[aclCreateDataBuffer](#aclCreateDataBuffer)接口创建aclDataBuffer类型数据时传入的data的内存需由用户自行释放。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataBuffer | 输入 | 待销毁的aclDataBuffer类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclGetDataBufferAddr"></a>

## aclGetDataBufferAddr

```c
void *aclGetDataBufferAddr(const aclDataBuffer *dataBuffer)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取aclDataBuffer类型中的数据的内存地址。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataBuffer | 输入 | aclDataBuffer类型的指针。<br>需提前调用[aclCreateDataBuffer](#aclCreateDataBuffer)接口创建aclDataBuffer类型的数据。 |

### 返回值说明

返回aclDataBuffer类型中的数据的内存地址。

<br>

<a id="aclGetDataBufferSize（废弃）"></a>

## aclGetDataBufferSize（废弃）

```c
uint32 aclGetDataBufferSize(const aclDataBuffer *dataBuffer)
```

**须知：此接口后续版本会废弃，请使用[aclGetDataBufferSizeV2](#aclGetDataBufferSizeV2)接口。**

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取aclDataBuffer类型中数据的内存大小，单位Byte。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataBuffer | 输入 | aclDataBuffer类型的指针。<br>需提前调用[aclCreateDataBuffer](#aclCreateDataBuffer)接口创建aclDataBuffer类型的数据。 |

### 返回值说明

aclDataBuffer类型中数据的内存大小。

<br>

<a id="aclGetDataBufferSizeV2"></a>

## aclGetDataBufferSizeV2

```c
size_t aclGetDataBufferSizeV2(const aclDataBuffer *dataBuffer)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取aclDataBuffer类型中数据的内存大小，单位Byte。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataBuffer | 输入 | aclDataBuffer类型的指针。<br>需提前调用[aclCreateDataBuffer](#aclCreateDataBuffer)接口创建aclDataBuffer类型的数据。 |

### 返回值说明

aclDataBuffer类型中数据的内存大小。

<br>

<a id="aclUpdateDataBuffer"></a>

## aclUpdateDataBuffer

```c
aclError aclUpdateDataBuffer(aclDataBuffer *dataBuffer, void *data, size_t size)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

更新aclDataBuffer中数据的内存及大小。

更新aclDataBuffer后，之前aclDataBuffer中存放数据的内存如果不使用，需及时释放，否则可能会导致内存泄漏。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataBuffer | 输入 | aclDataBuffer类型的指针。<br>需提前调用[aclCreateDataBuffer](#aclCreateDataBuffer)接口创建aclDataBuffer类型的数据。<br>该内存需由用户自行管理，调用[aclrtMalloc](11-01_设备内存分配与释放.md#aclrtMalloc)接口/[aclrtFree](11-01_设备内存分配与释放.md#aclrtFree)接口申请/释放内存，或调用[aclrtMallocHost](11-02_主机内存管理.md#aclrtMallocHost)接口/[aclrtFreeHost](11-02_主机内存管理.md#aclrtFreeHost)接口申请/释放内存。 |
| data | 输入 | 存放数据内存地址的指针。 |
| size | 输入 | 内存大小，单位Byte。<br>如果用户需要使用空tensor，则在申请内存时，内存大小最小为1Byte，以保障后续业务正常运行。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclprofConfig"></a>

## aclprofConfig

-   **[aclprofCreateConfig](#aclprofCreateConfig)**  

-   **[aclprofDestroyConfig](#aclprofDestroyConfig)**  

<br>

<a id="aclprofCreateConfig"></a>

## aclprofCreateConfig

```c
aclprofConfig *aclprofCreateConfig(uint32_t *deviceIdList, uint32_t deviceNums, aclprofAicoreMetrics aicoreMetrics, const aclprofAicoreEvents *aicoreEvents, uint64_t dataTypeConfig)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建aclprofConfig类型的数据，表示创建Profiling配置数据。

aclProfConfig类型数据可以只创建一次、多处使用，用户需要保证数据的一致性和准确性。

如需销毁aclprofConfig类型的数据，请参见[aclprofDestroyConfig](#aclprofDestroyConfig)。

### 约束说明

-   使用aclprofDestroyConfig接口销毁aclprofConfig类型的数据，如不销毁会导致内存未被释放。

-   与[aclprofDestroyConfig](#aclprofDestroyConfig)接口配对使用，先调用aclprofCreateConfig接口再调用aclprofDestroyConfig接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceIdList | 输入 | Device ID列表。须根据实际环境的Device ID配置。<br>类型定义请参见[aclprofConfig](#aclprofConfig)和[aclprofAicoreMetrics](25-02_Enumerations.md#aclprofAicoreMetrics)。 |
| deviceNums | 输入 | Device的个数。需由用户保证deviceIdList中的Device个数与deviceNums参数值一致，否则可能会导致后续业务异常。 |
| aicoreMetrics | 输入 | 表示AI Core性能指标采集项。请参见[aclprofAicoreMetrics](25-02_Enumerations.md#aclprofAicoreMetrics)。 |
| aicoreEvents | 输入 | 表示AI Core事件，目前配置为NULL。 |
| dataTypeConfig | 输入 | 用户选择如下多个宏进行逻辑或（例如：ACL_PROF_ACL_API \| ACL_PROF_AICORE_METRICS），作为dataTypeConfig参数值。每个宏表示某一类性能数据，详细说明如下：<br><br>  - ACL_PROF_ACL_API：表示采集接口的性能数据，包括Host与Device之间、Device间的同步异步内存复制时延等。<br>  - ACL_PROF_TASK_TIME：采集算子下发耗时、算子执行耗时数据以及算子基本信息数据，提供更全面的性能分析数据。<br>  - ACL_PROF_TASK_TIME_L0：采集算子下发耗时、算子执行耗时数据。与ACL_PROF_TASK_TIME和ACL_PROF_TASK_TIME_L2相比，由于不采集算子基本信息数据，采集时性能开销较小，可更精准统计相关耗时数据。<br>  - ACL_PROF_TASK_TIME_L2：采集算子下发耗时、算子执行耗时数据、算子基本信息数据（包括attr），提供更全面的性能分析数据。<br>  - ACL_PROF_GE_API_L0：采集动态Shape算子在Host调度主要阶段的耗时数据，可更精准统计相关耗时数据。<br>  - ACL_PROF_GE_API_L1：采集动态Shape算子在Host调度阶段更细粒度的耗时数据，提供更全面的性能分析数据。<br>  - ACL_PROF_OP_ATTR：控制采集算子的属性信息，当前仅支持aclnn算子。<br>  - ACL_PROF_AICORE_METRICS：表示采集AI Core性能指标数据，逻辑或时必须包括该宏，aicoreMetrics入参处配置的性能指标采集项才有效。<br>  - ACL_PROF_TASK_MEMORY：控制CANN算子的内存占用情况采集开关，用于优化内存使用。单算子场景下，按照GE组件维度和算子维度采集算子内存大小及生命周期信息（单算子API执行方式不采集GE组件内存）；静态图和静态子图场景下，在算子编译阶段按照算子维度采集算子内存大小及生命周期信息。<br>  - ACL_PROF_AICPU：表示采集AI CPU任务的开始、结束数据。<br>  - ACL_PROF_L2CACHE：表示采集L2 Cache数据和TLB页表缓存命中率。<br>  - ACL_PROF_HCCL_TRACE：控制通信数据采集开关。<br>  - ACL_PROF_MSPROFTX：获取用户和上层框架程序输出的性能数据。可在采集进程内（aclprofStart接口、aclprofStop接口之间）调用msproftx扩展接口或mstx接口开启记录应用程序执行期间特定事件发生的时间跨度，并写入性能数据文件，再使用msprof工具解析该文件，并导出展示性能分析数据。<br>  - ACL_PROF_TRAINING_TRACE：控制迭代轨迹数据采集开关。<br>  - ACL_PROF_RUNTIME_API：控制runtime api性能数据采集开关。<br>  - ACL_PROF_API_STATS：控制acl api的统计开关，打开此开关后，profiling会启用在线分析模式，统计acl api的性能数据。该模式下，其他开关无效。|

### 返回值说明

-   返回aclprofConfig类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="aclprofDestroyConfig"></a>

## aclprofDestroyConfig

```c
aclError aclprofDestroyConfig(const aclprofConfig *profilerConfig)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[aclprofCreateConfig](#aclprofCreateConfig)接口创建的aclprofConfig类型的数据。

### 约束说明

-   与[aclprofCreateConfig](#aclprofCreateConfig)接口配对使用，先调用aclprofCreateConfig接口再调用aclprofDestroyConfig接口。
-   同一aclprofConfig指针重复调用aclprofDestroyConfig接口，会出现重复释放内存的报错。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| profilerConfig | 输入 | 待销毁的aclprofConfig类型的指针。类型定义请参见[aclprofConfig](#aclprofConfig)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclprofStepInfo"></a>

## aclprofStepInfo

-   **[aclprofCreateStepInfo](#aclprofCreateStepInfo)**  

-   **[aclprofDestroyStepInfo](#aclprofDestroyStepInfo)**  

<br>

<a id="aclprofCreateStepInfo"></a>

## aclprofCreateStepInfo

```c
aclprofStepInfo* aclprofCreateStepInfo()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建aclprofStepInfo对象，用于描述迭代信息。

### 约束说明

-   使用aclprofDestroyStepInfo接口销毁aclprofStepInfo类型的数据，如不销毁会导致内存未被释放。
-   与[aclprofDestroyStepInfo](#aclprofDestroyStepInfo)接口配对使用，先调用aclprofCreateStepInfo接口再调用aclprofDestroyStepInfo接口。

### 返回值

-   返回aclprofStepInfo类型的指针，表示成功。
-   返回nullptr，表示失败。

> **说明：**
>同一个aclprofStepInfo对象、同一个tag只能设置一次，否则Profiling解析会出错。

<br>

<a id="aclprofDestroyStepInfo"></a>

## aclprofDestroyStepInfo

```c
void aclprofDestroyStepInfo(aclprofStepInfo* stepinfo)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[aclprofCreateStepInfo](#aclprofCreateStepInfo)接口创建的aclprofStepInfo类型的数据。

### 约束说明

-   与[aclprofCreateStepInfo](#aclprofCreateStepInfo)接口配对使用，先调用aclprofCreateStepInfo接口再调用aclprofDestroyStepInfo接口。
-   同一aclprofStepInfo数据重复调用aclprofDestroyStepInfo接口，会出现重复释放内存的报错。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stepinfo | 输入 | 指定迭代信息。需提前调用[aclprofCreateStepInfo](#aclprofCreateStepInfo)接口创建[aclprofStepInfo](#aclprofStepInfo)类型的数据。 |

<br>

<a id="aclprofSubscribeConfig"></a>

## aclprofSubscribeConfig

-   **[aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig)**  

-   **[aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig)**  

<br>

<a id="aclprofCreateSubscribeConfig"></a>

## aclprofCreateSubscribeConfig

```c
aclprofSubscribeConfig *aclprofCreateSubscribeConfig(int8_t timeInfoSwitch, aclprofAicoreMetrics aicoreMetrics, void *fd)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建aclprofSubscribeConfig类型的数据，表示创建订阅配置信息。

如需销毁aclprofSubscribeConfig类型的数据，请参见[aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig)。

### 约束说明

-   使用aclprofDestroySubscribeConfig接口销毁aclprofSubscribeConfig类型的数据，如不销毁会导致内存未被释放。

-   与[aclprofDestroySubscribeConfig](#aclprofDestroySubscribeConfig)接口配对使用，先调用aclprofCreateSubscribeConfig接口再调用aclprofDestroySubscribeConfig接口。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| timeInfoSwitch | 输入 | 是否采集网络模型中算子的性能数据：<br><br>  - 1：采集<br>  - 0：不采集<br><br>类型定义请参见[aclprofSubscribeConfig](#aclprofSubscribeConfig)和[aclprofAicoreMetrics](25-02_Enumerations.md#aclprofAicoreMetrics)。 |
| aicoreMetrics | 输入 | 表示AI Core性能指标采集项。<br> 说明： 订阅接口目前仅提供算子耗时统计的功能，暂时不支持AicoreMetrics采集功能。<br>取值详见[aclprofAicoreMetrics](25-02_Enumerations.md#aclprofAicoreMetrics)。 |
| fd | 输入 | 用户创建的管道写指针。<br>用户在调用aclprofModelUnSubscribe接口后，系统内部会在数据发送结束后，关闭该模型的管道写指针。 |

### 返回值说明

-   返回aclprofSubscribeConfig类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="aclprofDestroySubscribeConfig"></a>

## aclprofDestroySubscribeConfig

```c
aclError aclprofDestroySubscribeConfig(const aclprofSubscribeConfig *profSubscribeConfig)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig)接口创建的aclprofSubscribeConfig类型的数据。

### 约束说明

-   与[aclprofCreateSubscribeConfig](#aclprofCreateSubscribeConfig)接口配对使用，先调用aclprofCreateSubscribeConfig接口再调用aclprofDestroySubscribeConfig接口。
-   同一aclprofSubscribeConfig指针重复调用aclprofDestroySubscribeConfig接口，会出现重复释放内存的报错。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| profSubscribeConfig | 输入 | 待销毁的aclprofSubscribeConfig类型的指针。类型定义请参见[aclprofSubscribeConfig](#aclprofSubscribeConfig)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclrtAllocatorDesc"></a>

## aclrtAllocatorDesc

-   **[aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)**  

-   **[aclrtAllocatorDestroyDesc](#aclrtAllocatorDestroyDesc)**  

-   **[aclrtAllocatorSetObjToDesc](#aclrtAllocatorSetObjToDesc)**  

-   **[aclrtAllocatorSetAllocFuncToDesc](#aclrtAllocatorSetAllocFuncToDesc)**  

-   **[aclrtAllocatorSetAllocAdviseFuncToDesc](#aclrtAllocatorSetAllocAdviseFuncToDesc)**  

-   **[aclrtAllocatorSetFreeFuncToDesc](#aclrtAllocatorSetFreeFuncToDesc)**  

-   **[aclrtAllocatorSetGetAddrFromBlockFuncToDesc](#aclrtAllocatorSetGetAddrFromBlockFuncToDesc)**  

<br>

<a id="aclrtAllocatorCreateDesc"></a>

## aclrtAllocatorCreateDesc

```c
aclrtAllocatorDesc aclrtAllocatorCreateDesc()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建aclrtAllocatorDesc类型的数据，表示Allocator描述信息，主要用于注册回调函数。

### 返回值说明

-   返回aclrtAllocatorDesc类型的指针，表示成功。
-   返回NULL，表示失败。

<br>

<a id="aclrtAllocatorDestroyDesc"></a>

## aclrtAllocatorDestroyDesc

```c
aclError aclrtAllocatorDestroyDesc(aclrtAllocatorDesc allocatorDesc)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过aclrtAllocatorCreateDesc接口创建的aclrtAllocatorDesc类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| allocatorDesc | 输入 | 待销毁的aclrtAllocatorDesc类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclrtAllocatorSetObjToDesc"></a>

## aclrtAllocatorSetObjToDesc

```c
aclError aclrtAllocatorSetObjToDesc(aclrtAllocatorDesc allocatorDesc,  aclrtAllocator allocator)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

使用用户提供的Allocator场景下，向Allocator描述信息中设置Allocator对象。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| allocatorDesc | 输入 | Allocator描述符指针。<br>需提前调用[aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)接口设置Allocator描述信息。<br>取值详见[aclrtAllocatorDesc](#aclrtAllocatorDesc)。 |
| allocator | 输入 | 用户提供的Allocator对象指针。类型定义请参见[aclrtAllocator](25-05_Typedefs.md#aclrtAllocator)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败。

<br>

<a id="aclrtAllocatorSetAllocFuncToDesc"></a>

## aclrtAllocatorSetAllocFuncToDesc

```c
aclError aclrtAllocatorSetAllocFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocFunc func)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

使用用户提供的Allocator场景下，设置“申请内存block”的回调函数。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| allocatorDesc | 输入 | Allocator描述符指针。<br>需提前调用[aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)接口设置Allocator描述信息。<br>取值详见[aclrtAllocatorDesc](#aclrtAllocatorDesc)。 |
| func | 输入 | 申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclrtAllocatorSetAllocAdviseFuncToDesc"></a>

## aclrtAllocatorSetAllocAdviseFuncToDesc

```c
aclError aclrtAllocatorSetAllocAdviseFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocAdviseFunc func)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

使用用户提供的Allocator场景下，设置"根据建议地址申请内存block"的回调函数，一般用于内存复用场景。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| allocatorDesc | 输入 | Allocator描述符指针。<br>需提前调用[aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)接口设置Allocator描述信息。<br>取值详见[aclrtAllocatorDesc](#aclrtAllocatorDesc)。 |
| func | 输入 | 根据建议地址申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocAdviseFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, size_t size, [aclrtAllocatorAddr](25-05_Typedefs.md#aclrtAllocatorAddr) addr); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclrtAllocatorSetFreeFuncToDesc"></a>

## aclrtAllocatorSetFreeFuncToDesc

```c
aclError aclrtAllocatorSetFreeFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorFreeFunc func)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

使用用户提供的Allocator场景下，设置“释放内存block”的回调函数。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| allocatorDesc | 输入 | Allocator描述符指针。<br>需提前调用[aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)接口设置Allocator描述信息。<br>取值详见[aclrtAllocatorDesc](#aclrtAllocatorDesc)。 |
| func | 输入 | 释放内存block的回调函数。<br>回调函数定义如下：<br>typedef void (*aclrtAllocatorFreeFunc)([aclrtAllocator](25-05_Typedefs.md#aclrtAllocator) allocator, [aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclrtAllocatorSetGetAddrFromBlockFuncToDesc"></a>

## aclrtAllocatorSetGetAddrFromBlockFuncToDesc

```c
aclError aclrtAllocatorSetGetAddrFromBlockFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorGetAddrFromBlockFunc func)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

使用用户提供的Allocator场景下，设置“根据申请来的block获取device内存地址”的回调函数。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| allocatorDesc | 输入 | Allocator描述符指针。<br>需提前调用[aclrtAllocatorCreateDesc](#aclrtAllocatorCreateDesc)接口设置Allocator描述信息。<br>取值详见[aclrtAllocatorDesc](#aclrtAllocatorDesc)。 |
| func | 输入 | 根据申请来的block获取device内存地址的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorGetAddrFromBlockFunc)([aclrtAllocatorBlock](25-05_Typedefs.md#aclrtAllocatorBlock) block); |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="aclrtStreamConfigHandle"></a>

## aclrtStreamConfigHandle

-   **[aclrtCreateStreamConfigHandle](#aclrtCreateStreamConfigHandle)**  

-   **[aclrtDestroyStreamConfigHandle](#aclrtDestroyStreamConfigHandle)**  

<br>

<a id="aclrtCreateStreamConfigHandle"></a>

## aclrtCreateStreamConfigHandle

```c
aclrtStreamConfigHandle *aclrtCreateStreamConfigHandle(void)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | x |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

### 功能说明

创建aclrtStreamConfigHandle类型的数据，表示一个Stream的配置对象。

如需销毁aclrtStreamConfigHandle类型的数据，请参见[aclrtDestroyStreamConfigHandle](#aclrtDestroyStreamConfigHandle)。

### 参数说明

无

### 返回值说明

-   返回aclrtStreamConfigHandle类型的指针，表示成功。
-   返回NULL，表示失败。

<br>

<a id="aclrtDestroyStreamConfigHandle"></a>

## aclrtDestroyStreamConfigHandle

```c
aclError aclrtDestroyStreamConfigHandle(aclrtStreamConfigHandle *handle)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | x |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

### 功能说明

销毁通过[aclrtCreateStreamConfigHandle](#aclrtCreateStreamConfigHandle)接口创建的aclrtStreamConfigHandle类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| handle | 输入 | 待销毁的aclrtStreamConfigHandle类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtDataItem"></a>

## acltdtDataItem

-   **[acltdtCreateDataItem](#acltdtCreateDataItem)**  

-   **[acltdtDestroyDataItem](#acltdtDestroyDataItem)**  

-   **[acltdtGetTensorTypeFromItem](#acltdtGetTensorTypeFromItem)**  

-   **[acltdtGetDataTypeFromItem](#acltdtGetDataTypeFromItem)**  

-   **[acltdtGetDataAddrFromItem](#acltdtGetDataAddrFromItem)**  

-   **[acltdtGetDataSizeFromItem](#acltdtGetDataSizeFromItem)**  

-   **[acltdtGetDimNumFromItem](#acltdtGetDimNumFromItem)**  

-   **[acltdtGetDimsFromItem](#acltdtGetDimsFromItem)**  

<br>

<a id="acltdtCreateDataItem"></a>

## acltdtCreateDataItem

```c
acltdtDataItem *acltdtCreateDataItem(acltdtTensorType tdtType,
const int64_t *dims,
size_t dimNum,
aclDataType dataType,
void *data,
size_t size)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建acltdtDataItem类型的数据，代表一个业务上的Tensor。

如需销毁acltdtDataItem类型的数据，请参见[acltdtDestroyDataItem](#acltdtDestroyDataItem)。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| tdtType | 输入 | tensor类型。类型定义请参见[acltdtTensorType](25-02_Enumerations.md#acltdtTensorType)。 |
| dims | 输入 | tensor的Shape。 |
| dimNum | 输入 | tensor的Shape中的维度个数。 |
| dataType | 输入 | 正常数据里的数据类型。类型定义请参见[aclDataType](25-02_Enumerations.md#aclDataType)。 |
| data | 输入 | 数据地址指针。 |
| size | 输入 | 数据长度。 |

### 返回值说明

-   返回acltdtDataItem类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="acltdtDestroyDataItem"></a>

## acltdtDestroyDataItem

```c
aclError acltdtDestroyDataItem(acltdtDataItem *dataItem)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建的acltdtDataItem类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | 待销毁的acltdtDataItem类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtGetTensorTypeFromItem"></a>

## acltdtGetTensorTypeFromItem

```c
acltdtTensorType acltdtGetTensorTypeFromItem(const acltdtDataItem *dataItem)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

收到dataItem数据之后，从数据描述里首先check这个数据是个正常数据，还是一个end数据，还是一个异常数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |

### 返回值说明

请参见[acltdtTensorType](25-02_Enumerations.md#acltdtTensorType)。

<br>

<a id="acltdtGetDataTypeFromItem"></a>

## acltdtGetDataTypeFromItem

```c
aclDataType acltdtGetDataTypeFromItem(const acltdtDataItem *dataItem)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取正常数据的数据类型。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |

### 返回值说明

获取到的数据类型，类型定义请参见[aclDataType](25-02_Enumerations.md#aclDataType)。

<br>

<a id="acltdtGetDataAddrFromItem"></a>

## acltdtGetDataAddrFromItem

```c
void *acltdtGetDataAddrFromItem(const acltdtDataItem *dataItem)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

得到正常数据的数据地址。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |

### 返回值说明

返回正常数据的数据地址。

<br>

<a id="acltdtGetDataSizeFromItem"></a>

## acltdtGetDataSizeFromItem

```c
size_t acltdtGetDataSizeFromItem(const acltdtDataItem *dataItem)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

得到正常数据的数据长度。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |

### 返回值说明

获取到的数据长度。

<br>

<a id="acltdtGetDimNumFromItem"></a>

## acltdtGetDimNumFromItem

```c
size_t acltdtGetDimNumFromItem(const acltdtDataItem *dataItem)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

得到正常tensor数据的数据Shape中的维度个数。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |

### 返回值说明

获取到的维度个数。

<br>

<a id="acltdtGetDimsFromItem"></a>

## acltdtGetDimsFromItem

```c
aclError acltdtGetDimsFromItem(const acltdtDataItem *dataItem, int64_t *dims, size_t dimNum)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

得到正常tensor数据的数据Shape。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataItem | 输入 | acltdtDataItem类型的指针。<br>需提前调用[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |
| dims | 输入&输出 | 维度信息数组。 |
| dimNum | 输入 | 维度个数。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtDataset"></a>

## acltdtDataset

-   **[acltdtCreateDataset](#acltdtCreateDataset)**  

-   **[acltdtDestroyDataset](#acltdtDestroyDataset)**  

-   **[acltdtGetDataItem](#acltdtGetDataItem)**  

-   **[acltdtAddDataItem](#acltdtAddDataItem)**  

-   **[acltdtGetDatasetSize](#acltdtGetDatasetSize)**  

-   **[acltdtGetDatasetName](#acltdtGetDatasetName)**  

<br>

<a id="acltdtCreateDataset"></a>

## acltdtCreateDataset

```c
acltdtDataset *acltdtCreateDataset()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建acltdtDataset类型的数据，对等一个Vector<tensor\>。

如需销毁acltdtDataset类型的数据，请参见[acltdtDestroyDataset](#acltdtDestroyDataset)。

### 参数说明

无

### 返回值说明

-   返回acltdtDataset类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="acltdtDestroyDataset"></a>

## acltdtDestroyDataset

```c
aclError acltdtDestroyDataset(acltdtDataset *dataset)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[acltdtCreateDataset](#acltdtCreateDataset)接口创建的acltdtDataset类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataset | 输入 | 待销毁的acltdtDataset类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtGetDataItem"></a>

## acltdtGetDataItem

```c
acltdtDataItem *acltdtGetDataItem(const acltdtDataset *dataset, size_t index)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取acltdtDataset中的第n个acltdtDataItem。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataset | 输入 | acltdtDataset类型的指针。<br>需提前调用[acltdtCreateDataset](#acltdtCreateDataset)接口创建acltdtDataset类型的数据，再调用[acltdtAddDataItem](#acltdtAddDataItem)接口添加acltdtDataItem。 |
| index | 输入 | 表明获取的是第几个acltdtDataItem。 |

### 返回值说明

-   获取成功，返回acltdtDataItem的地址。
-   获取失败返回空地址。

<br>

<a id="acltdtAddDataItem"></a>

## acltdtAddDataItem

```c
aclError acltdtAddDataItem(acltdtDataset *dataset, acltdtDataItem *dataItem)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

向acltdtDataset中增加acltdtDataItem。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataset | 输出 | 待增加acltdtDataItem的acltdtDataset地址指针。<br>需提前调用[acltdtCreateDataset](#acltdtCreateDataset)接口创建acltdtDataset类型的数据。 |
| dataItem | 输入 | 待增加的acltdtDataItem地址指针。<br>需提前调用[acltdtCreateDataItem](#acltdtCreateDataItem)接口创建acltdtDataItem类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtGetDatasetSize"></a>

## acltdtGetDatasetSize

```c
size_t acltdtGetDatasetSize(const acltdtDataset *dataset)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取acltdtDataset中acltdtDataItem的个数。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataset | 输入 | acltdtDataset类型的指针。<br>需提前调用[acltdtCreateDataset](#acltdtCreateDataset)接口创建acltdtDataset类型的数据。 |

### 返回值说明

acltdtDataItem的个数。

<br>

<a id="acltdtGetDatasetName"></a>

## acltdtGetDatasetName

```c
const char *acltdtGetDatasetName(const acltdtDataset *dataset)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取标识acltdtDataset（对等一个Vector<tensor\>）的描述符。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dataset | 输入 | acltdtDataset类型的指针。<br>需提前调用[acltdtCreateDataset](#acltdtCreateDataset)接口创建acltdtDataset类型的数据。 |

### 返回值说明

标识acltdtDataset（对等一个Vector<tensor\>）的描述符的指针。

<br>

<a id="acltdtQueueAttr"></a>

## acltdtQueueAttr

-   **[acltdtCreateQueueAttr](#acltdtCreateQueueAttr)**  

-   **[acltdtDestroyQueueAttr](#acltdtDestroyQueueAttr)**  

-   **[acltdtSetQueueAttr](#acltdtSetQueueAttr)**  

-   **[acltdtGetQueueAttr](#acltdtGetQueueAttr)**  

<br>

<a id="acltdtCreateQueueAttr"></a>

## acltdtCreateQueueAttr

```c
acltdtQueueAttr *acltdtCreateQueueAttr()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建acltdtQueueAttr类型的数据，表示队列属性配置信息。

### 参数说明

无

### 返回值说明

-   返回acltdtQueueAttr类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="acltdtDestroyQueueAttr"></a>

## acltdtDestroyQueueAttr

```c
aclError acltdtDestroyQueueAttr(const acltdtQueueAttr *attr)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过acltdtCreateQueueAttr接口创建的acltdtQueueAttr类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| attr | 输入 | 待销毁的acltdtQueueAttr类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtSetQueueAttr"></a>

## acltdtSetQueueAttr

```c
aclError acltdtSetQueueAttr(acltdtQueueAttr *attr, acltdtQueueAttrType type, size_t len, const void *param)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置队列属性值。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| attr | 输入&输出 | 队列属性配置信息的指针。<br>需提前调用[acltdtCreateQueueAttr](#acltdtCreateQueueAttr)接口创建acltdtQueueAttr类型的数据。 |
| type | 输入 | 属性类型。类型定义请参见[acltdtQueueAttrType](25-02_Enumerations.md#acltdtQueueAttrType)。 |
| len | 输入 | 属性值的字节数。<br><br>  - type取值的枚举名以_UINT64结尾时，此处配置为8；<br>  - type取值的枚举名以_UINT32结尾时，此处配置为4；<br>  - type取值的枚举名以_PTR结尾时，若操作系统是32位，则此处配置为4；若操作系统是64位，则配置为8。 |
| param | 输入 | 指向属性值的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtGetQueueAttr"></a>

## acltdtGetQueueAttr

```c
aclError acltdtGetQueueAttr(const acltdtQueueAttr *attr, acltdtQueueAttrType type, size_t len, size_t *paramRetSize, void *param)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取队列属性值。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| attr | 输入 | 队列属性配置信息的指针。<br>需提前调用[acltdtCreateQueueAttr](#acltdtCreateQueueAttr)接口创建acltdtQueueAttr类型的数据。 |
| type | 输入 | 属性类型。类型定义请参见[acltdtQueueAttrType](25-02_Enumerations.md#acltdtQueueAttrType). |
| len | 输入 | 属性值的字节数。<br><br>  - type取值的枚举名以_UINT64结尾时，此处配置为8；<br>  - type取值的枚举名以_UINT32结尾时，此处配置为4；<br>  - type取值的枚举名以_PTR结尾时，若操作系统是32位，则此处配置为4；若操作系统是64位，则配置为8。 |
| paramRetSize | 输出 | 实际返回的属性值字节数的指针。 |
| param | 输出 | 指向属性值的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtQueueRoute"></a>

## acltdtQueueRoute

-   **[acltdtCreateQueueRoute](#acltdtCreateQueueRoute)**  

-   **[acltdtDestroyQueueRoute](#acltdtDestroyQueueRoute)**  

-   **[acltdtGetQueueRouteParam](#acltdtGetQueueRouteParam)**  

<br>

<a id="acltdtCreateQueueRoute"></a>

## acltdtCreateQueueRoute

```c
acltdtQueueRoute* acltdtCreateQueueRoute(uint32_t srcId, uint32_t dstId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建acltdtQueueRoute类型的数据，表示创建队列路由配置。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| srcId | 输入 | 源队列ID。 |
| dstId | 输入 | 目的队列ID。 |

### 返回值说明

-   返回acltdtQueueRoute类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="acltdtDestroyQueueRoute"></a>

## acltdtDestroyQueueRoute

```c
aclError acltdtDestroyQueueRoute(const acltdtQueueRoute *route)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[acltdtCreateQueueRoute](#acltdtCreateQueueRoute)接口创建的acltdtQueueRoute类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| route | 输入 | 待销毁的acltdtQueueRoute类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtGetQueueRouteParam"></a>

## acltdtGetQueueRouteParam

```c
aclError acltdtGetQueueRouteParam(const acltdtQueueRoute *route, acltdtQueueRouteParamType type, size_t len, size_t *paramRetSize, void *param)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

获取队列路由配置的相关信息，例如源队列ID、目标队列ID等。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| route | 输入 | 队列路由配置信息的指针。<br>需提前调用[acltdtCreateQueueRoute](#acltdtCreateQueueRoute)接口创建acltdtQueueRoute类型的数据。 |
| type | 输入 | 路由参数类型。类型定义请参见[acltdtQueueRouteParamType](25-02_Enumerations.md#acltdtQueueRouteParamType)。 |
| len | 输入 | 参数值的字节数。<br>type取值的枚举名以_UINT32或_INT32结尾，此处固定配置为4。 |
| paramRetSize | 输出 | 实际返回的参数值字节数的指针。 |
| param | 输出 | 指向参数值的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtQueueRouteList"></a>

## acltdtQueueRouteList

-   **[acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)**  

-   **[acltdtDestroyQueueRouteList](#acltdtDestroyQueueRouteList)**  

-   **[acltdtAddQueueRoute](#acltdtAddQueueRoute)**  

-   **[acltdtGetQueueRoute](#acltdtGetQueueRoute)**  

-   **[acltdtGetQueueRouteNum](#acltdtGetQueueRouteNum)**  

<br>

<a id="acltdtCreateQueueRouteList"></a>

## acltdtCreateQueueRouteList

```c
acltdtQueueRouteList* acltdtCreateQueueRouteList()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建acltdtQueueRouteList类型的数据，表示队列路由配置数组。

### 参数说明

无

### 返回值说明

-   返回acltdtQueueRouteList类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="acltdtDestroyQueueRouteList"></a>

## acltdtDestroyQueueRouteList

```c
aclError acltdtDestroyQueueRouteList(const acltdtQueueRouteList *routeList)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)接口创建的acltdtQueueRouteList类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| routeList | 输入 | 待销毁的acltdtQueueRouteList类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtAddQueueRoute"></a>

## acltdtAddQueueRoute

```c
aclError acltdtAddQueueRoute(acltdtQueueRouteList *routeList, const acltdtQueueRoute *route)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

向队列路由配置数组中添加队列路由配置信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| routeList | 输入&输出 | 队列路由配置数组。<br>需提前调用[acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)接口创建acltdtQueueRouteList类型的数据。 |
| route | 输入 | 需添加的队列路由配置信息的指针。<br>需提前调用[acltdtCreateQueueRoute](#acltdtCreateQueueRoute)接口创建acltdtQueueRoute类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtGetQueueRoute"></a>

## acltdtGetQueueRoute

```c
aclError acltdtGetQueueRoute(const acltdtQueueRouteList *routeList, size_t index, acltdtQueueRoute *route)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

从队列路由配置数组中获取指定的队列路由配置信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| routeList | 输入 | 队列路由配置数组。<br>需提前调用[acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)接口创建acltdtQueueRouteList类型的数据。 |
| index | 输入 | 指定获取哪一个队列路由配置信息，index编号从0开始。 |
| route | 输入&输出 | 需添加的队列路由配置信息的指针。类型定义请参见[acltdtQueueRoute](#acltdtQueueRoute)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtGetQueueRouteNum"></a>

## acltdtGetQueueRouteNum

```c
size_t acltdtGetQueueRouteNum(const acltdtQueueRouteList *routeList)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

从队列路由配置数组中获取路由数量。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| routeList | 输入 | 队列路由配置数组。<br>需提前调用[acltdtCreateQueueRouteList](#acltdtCreateQueueRouteList)接口创建acltdtQueueRouteList类型的数据。 |

### 返回值说明

返回路由数量。

<br>

<a id="acltdtQueueRouteQueryInfo"></a>

## acltdtQueueRouteQueryInfo

-   **[acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo)**  

-   **[acltdtDestroyQueueRouteQueryInfo](#acltdtDestroyQueueRouteQueryInfo)**  

-   **[acltdtSetQueueRouteQueryInfo](#acltdtSetQueueRouteQueryInfo)**  

<br>

<a id="acltdtCreateQueueRouteQueryInfo"></a>

## acltdtCreateQueueRouteQueryInfo

```c
acltdtQueueRouteQueryInfo* acltdtCreateQueueRouteQueryInfo()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建acltdtQueueRouteQueryInfo类型的数据，表示队列路由关系查询条件。

### 参数说明

无

### 返回值说明

-   返回acltdtQueueRouteQueryInfo类型的指针，表示成功。
-   返回nullptr，表示失败。

<br>

<a id="acltdtDestroyQueueRouteQueryInfo"></a>

## acltdtDestroyQueueRouteQueryInfo

```c
aclError acltdtDestroyQueueRouteQueryInfo(const acltdtQueueRouteQueryInfo *info)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

销毁通过[acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo)接口创建的acltdtQueueRouteQueryInfo类型的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| info | 输入 | 待销毁的acltdtQueueRouteQueryInfo类型的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>

<a id="acltdtSetQueueRouteQueryInfo"></a>

## acltdtSetQueueRouteQueryInfo

```c
aclError acltdtSetQueueRouteQueryInfo(acltdtQueueRouteQueryInfo *param, acltdtQueueRouteQueryInfoParamType type, size_t len, const void *value)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

设置路由关系查询条件。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| param | 输入&输出 | 队列路由关系查询条件的指针。<br>需提前调用[acltdtCreateQueueRouteQueryInfo](#acltdtCreateQueueRouteQueryInfo)创建acltdtQueueRouteQueryInfo类型的数据。 |
| type | 输入 | 参数类型。类型定义请参见[acltdtQueueRouteQueryInfoParamType](25-02_Enumerations.md#acltdtQueueRouteQueryInfoParamType)。 |
| len | 输入 | 参数值的字节数。<br><br>  - type取值的枚举名以_UINT64结尾时，此处配置为8；<br>  - type取值的枚举名以_UINT32结尾时，此处配置为4；<br>  - type取值的枚举名以_PTR结尾时，若操作系统是32位，则此处配置为4；若操作系统是64位，则配置为8。 |
| value | 输入 | 参数值的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
