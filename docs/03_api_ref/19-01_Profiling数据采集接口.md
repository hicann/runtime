# 19-01 Profiling数据采集接口

本章节描述 Profiling 数据采集的核心接口，用于性能采集的初始化、配置、启停控制。

- [`aclError aclprofInit(const char *profilerResultPath, size_t length)`](#aclprofInit)：初始化Profiling，目前用于设置保存性能数据的文件的路径。
- [`aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)`](#aclprofSetConfig)：aclprofCreateConfig接口的扩展接口，用于设置性能数据采集参数。
- [`aclError aclprofStart(const aclprofConfig *profilerConfig)`](#aclprofStart)：下发Profiling请求，使能对应数据的采集。
- [`aclError aclprofStop(const aclprofConfig *profilerConfig)`](#aclprofStop)：停止Profiling数据采集。
- [`aclError aclprofFinalize()`](#aclprofFinalize)：结束Profiling。
- [`uint64_t aclprofStr2Id(const char *message)`](#aclprofStr2Id)：msproftx用于将字符串转化为哈希ID。

## 数据采集说明

### 总体约束

不能与[订阅算子信息](订阅算子信息.md)的接口交叉调用：[aclprofInit](#aclprofInit)接口和[aclprofFinalize](#aclprofFinalize)接口之间不能调用[aclprofModelSubscribe](19-03_订阅算子信息.md#aclprofModelSubscribe)接口、aclprofGet\*接口、[aclprofModelUnSubscribe](19-03_订阅算子信息.md#aclprofModelUnSubscribe)接口。

### 接口约束说明

-   **调用接口要求**：
    -   [aclprofInit](#aclprofInit)接口必须在aclInit接口之后、模型加载之前调用。

        如果已经通过[aclInit](02_初始化与去初始化.md#aclInit)接口配置了Profiling信息，则调用[aclprofInit](#aclprofInit)接口、[aclprofStart](#aclprofStart)接口、[aclprofStop](#aclprofStop)接口、[aclprofFinalize](#aclprofFinalize)时，会返回报错。

        如果没有调用[aclprofInit](#aclprofInit)接口，调用[aclprofStart](#aclprofStart)接口、[aclprofStop](#aclprofStop)接口、[aclprofFinalize](#aclprofFinalize)时，会返回报错。

    -   [aclprofStart](#aclprofStart)接口在模型执行之前调用，若在模型执行过程中调用[aclprofStart](#aclprofStart)接口，Profiling采集到的数据为调用[aclprofStart](#aclprofStart)接口之后的数据，可能导致数据不完整。

        调用[aclprofStart](#aclprofStart)接口时，可以指定从一个Device上采集性能数据，也可以指定从多个Device上采集性能数据。

        一个用户APP进程内，如果连续调用多次[aclprofStart](#aclprofStart)接口，指定重复的Profiling配置，或指定的Device重复，会返回报错。

    -   在用户APP的进程生命周期内，[aclprofInit](#aclprofInit)接口与[aclprofFinalize](#aclprofFinalize)接口配对使用，建议只调用一次，如该组合多次调用可以改变保存性能数据的文件的路径。
    -   [aclprofStart](#aclprofStart)接口与[aclprofStop](#aclprofStop)接口需配对使用。
    -   aclprofSetConfig接口必须在aclprofStart接口之前调用。一个APP进程内，可以根据需要选择一次或多次调用aclprofSetConfig接口。
    -   调用aclFinalize并接收到正常退出码后为执行完毕，其他情况为非正常。由于性能数据采集不支持多进程并发执行，为确保驱动关闭正常，需要在前一个性能数据采集用例完全执行完毕之后再执行下一轮采集。建议在aclFinalize接口返回值上加入异常处理操作，方便展示执行状态与问题定位。

-   **接口调用顺序**：
    -   **建议的接口调用顺序如下**，以“一个用户APP进程内采集多个模型推理时的性能数据”为例：

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclprofInit](#aclprofInit)接口--\>**[aclprofStart](#aclprofStart)接口**\(指定Device 0和Device 1\)--\>模型1加载--\>模型1执行--\>**[aclprofStop](#aclprofStop)接口**\(与[aclprofStart](#aclprofStart)接口的[aclprofConfig](24_数据类型及其操作接口.md#aclprofConfig)数据保持一致\)--\>**[aclprofStart](#aclprofStart)接口**\(指定Device 1和Device 2\)--\>模型2加载--\>模型2执行--\>**[aclprofStop](#aclprofStop)接口**\(与[aclprofStart](#aclprofStart)接口的[aclprofConfig](24_数据类型及其操作接口.md#aclprofConfig)数据保持一致\)--\>[aclprofFinalize](#aclprofFinalize)接口--\>执行其它任务--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

    -   **错误的接口调用顺序示例如下**，以“一个用户APP进程内，如果连续调用多次[aclprofStart](#aclprofStart)接口，指定的Device重复”为例：

        [aclInit](02_初始化与去初始化.md#aclInit)接口--\>[aclprofInit](#aclprofInit)接口--\>**[aclprofStart](#aclprofStart)接口**\(指定Device 0和**Device 1**\)--\>**[aclprofStart](#aclprofStart)接口**\(指定**Device 1**和Device 2\)--\>模型1加载--\>模型1执行--\>模型2加载--\>模型2执行--\>**[aclprofStop](#aclprofStop)接口**--\>**[aclprofStop](#aclprofStop)接口**--\>[aclprofFinalize](#aclprofFinalize)--\>执行其它任务--\>模型卸载--\>[aclFinalize](02_初始化与去初始化.md#aclFinalize)接口

---


<a id="aclprofInit"></a>

# aclprofInit

```c
aclError aclprofInit(const char *profilerResultPath, size_t length)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

初始化Profiling，目前用于设置保存性能数据的文件的路径。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| profilerResultPath | 输入 | 指定保存性能数据的文件的路径，支持配置为绝对路径或相对路径。 |
| length | 输入 | profilerResultPath的长度，单位为Byte，最大长度不超过4096字节。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

与[aclprofFinalize](#aclprofFinalize)接口配对使用，先调用aclprofInit接口再调用aclprofFinalize接口。


<br>
<br>
<br>



<a id="aclprofSetConfig"></a>

# aclprofSetConfig

```c
aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

aclprofCreateConfig接口的扩展接口，用于设置性能数据采集参数。

该接口支持多次调用，用户需要保证数据的一致性和准确性。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| configType | 输入 | 作为configType参数值。每个枚举表示不同采集配置，若要使用该接口下不同的选项采集多种性能数据，则需要多次调用该接口，详细请参见[aclprofConfigType](24_数据类型及其操作接口.md#aclprofConfigType)。 |
| config | 输入 | 指定配置项参数值。 |
| configLength | 输入 | config的长度，单位为Byte，最大长度不超过256字节。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

先调用aclprofSetConfig接口再调用[aclprofStart](#aclprofStart)接口，可根据需求选择调用该接口。


<br>
<br>
<br>



<a id="aclprofStart"></a>

# aclprofStart

```c
aclError aclprofStart(const aclprofConfig *profilerConfig)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

下发Profiling请求，使能对应数据的采集。

用户可根据需要，在模型执行过程中按需调用aclprofStart接口，Profiling采集到的数据为调用该接口之后的数据。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| profilerConfig | 输入 | 指定Profiling配置数据。类型定义请参见[aclprofConfig](24_数据类型及其操作接口.md#aclprofConfig)。<br>需提前调用[aclprofCreateConfig](24_数据类型及其操作接口.md#aclprofCreateConfig)接口创建aclprofConfig类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

与[aclprofStop](#aclprofStop)接口配对使用，先调用aclprofStart接口再调用aclprofStop接口。


<br>
<br>
<br>



<a id="aclprofStop"></a>

# aclprofStop

```c
aclError aclprofStop(const aclprofConfig *profilerConfig)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

停止Profiling数据采集。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| profilerConfig | 输入 | 指定停止Profiling数据采集的配置。类型定义请参见[aclprofConfig](24_数据类型及其操作接口.md#aclprofConfig)。<br>与[aclprofStart](#aclprofStart)接口中的[aclprofConfig](24_数据类型及其操作接口.md#aclprofConfig)类型数据保持一致。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

与[aclprofStart](#aclprofStart)接口配对使用，先调用aclprofStart接口再调用aclprofStop接口。


<br>
<br>
<br>



<a id="aclprofFinalize"></a>

# aclprofFinalize

```c
aclError aclprofFinalize()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

结束Profiling。

### 参数说明

无

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](24_数据类型及其操作接口.md#aclError)。

### 约束说明

与[aclprofInit](#aclprofInit)接口配对使用，先调用aclprofInit接口再调用aclprofFinalize接口。


<br>
<br>
<br>



<a id="aclprofStr2Id"></a>

# aclprofStr2Id

```c
uint64_t aclprofStr2Id(const char *message)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

msproftx用于将字符串转化为哈希ID。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| message | 输入 | 字符信息，例如算子名。 |

### 返回值说明

返回哈希ID，如果是uint64\_t类型的最大值则表示失败，其他表示成功。

### 约束说明

与[aclprofRangePushEx](19-02_msproftx扩展接口.md#aclprofRangePushEx)和[aclprofRangePop](19-02_msproftx扩展接口.md#aclprofRangePop)接口配合使用，在[aclprofRangePushEx](19-02_msproftx扩展接口.md#aclprofRangePushEx)接口调用之前调用。
