# 19-02 msproftx扩展接口

本章节描述 msproftx 扩展接口，用于自定义性能标记（Stamp）、范围标记及调用栈标记。

- [`void *aclprofCreateStamp()`](#aclprofCreateStamp)：创建msproftx事件标记。
- [`aclError aclprofSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen)`](#aclprofSetStampTraceMessage)：为msproftx事件标记携带字符串描述，在Profiling解析并导出结果中msprof\_tx summary数据展示。
- [`aclError aclprofMark(void *stamp)`](#aclprofMark)：msproftx标记瞬时事件。
- [`aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)`](#aclprofMarkEx)：aclprofMarkEx打点接口。
- [`aclError aclprofPush(void *stamp)`](#aclprofPush)：msproftx用于记录事件发生的时间跨度的开始时间。
- [`aclError aclprofPop()`](#aclprofPop)：msproftx用于记录事件发生的时间跨度的结束时间。
- [`aclError aclprofRangeStart(void *stamp, uint32_t *rangeId)`](#aclprofRangeStart)：msproftx用于记录事件发生的时间跨度的开始时间。
- [`aclError aclprofRangeStop(uint32_t rangeId)`](#aclprofRangeStop)：msproftx用于记录事件发生的时间跨度的结束时间。
- [`aclError aclprofRangePushEx(aclprofEventAttributes *attr)`](#aclprofRangePushEx)：在Torch场景下，msproftx上报Tensor信息。
- [`aclError aclprofRangePop()`](#aclprofRangePop)：在Torch场景下，msproftx上报Tensor信息。
- [`void aclprofDestroyStamp(void *stamp)`](#aclprofDestroyStamp)：释放msproftx事件标记。

## 扩展接口使用说明

-   **调用接口要求**：msproftx功能相关接口须在[aclprofStart](19-01_Profiling数据采集接口.md#aclprofStart)接口与[aclprofStop](19-01_Profiling数据采集接口.md#aclprofStop)接口之间调用。其中配对使用的接口有：[aclprofCreateStamp](#aclprofCreateStamp)/[aclprofDestroyStamp](#aclprofDestroyStamp)、[aclprofPush](#aclprofPush)/[aclprofPop](#aclprofPop)、[aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop)。
-   **接口调用顺序**：**[aclprofStart](19-01_Profiling数据采集接口.md#aclprofStart)接口**\(指定Device 0和Device 1\)--\>[aclprofCreateStamp](#aclprofCreateStamp)接口--\>[aclprofSetStampTraceMessage](#aclprofSetStampTraceMessage)接口--\>[aclprofMark](#aclprofMark)接口--\>\([aclprofPush](#aclprofPush)接口--\>[aclprofPop](#aclprofPop)接口\)或\([aclprofRangeStart](#aclprofRangeStart)接口--\>[aclprofRangeStop](#aclprofRangeStop)接口\)--\>[aclprofDestroyStamp](#aclprofDestroyStamp)接口--\>**[aclprofStop](19-01_Profiling数据采集接口.md#aclprofStop)接口**\(与[aclprofStart](19-01_Profiling数据采集接口.md#aclprofStart)接口的[aclprofConfig](25_数据类型及其操作接口.md#aclprofConfig)数据保持一致\)。

---


<a id="aclprofCreateStamp"></a>

# aclprofCreateStamp

```c
void *aclprofCreateStamp()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

创建msproftx事件标记。后续调用[aclprofMark](#aclprofMark)、[aclprofSetStampTraceMessage](#aclprofSetStampTraceMessage)、[aclprofPush](#aclprofPush)和[aclprofRangeStart](#aclprofRangeStart)接口时需要以描述该事件的指针作为输入，表示记录该事件发生的时间跨度。

### 返回值说明

-   返回void类型的指针，表示成功。
-   返回nullptr，表示失败。

### 约束说明

与[aclprofDestroyStamp](#aclprofDestroyStamp)接口配对使用，需提前调用[aclprofStart](19-01_Profiling数据采集接口.md#aclprofStart)接口。


<br>
<br>
<br>



<a id="aclprofSetStampTraceMessage"></a>

# aclprofSetStampTraceMessage

```c
aclError aclprofSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

为msproftx事件标记携带字符串描述，在Profiling解析并导出结果中msprof\_tx summary数据展示。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |
| msg | 输入 | Stamp信息字符串指针。 |
| msgLen | 输入 | 字符串长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。


<br>
<br>
<br>



<a id="aclprofMark"></a>

# aclprofMark

```c
aclError aclprofMark(void *stamp)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

msproftx标记瞬时事件。

调用此接口后，Profiling自动在Stamp指针中加上当前时间戳，将Event type设置为Mark，表示开始一次msproftx采集。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。


<br>
<br>
<br>



<a id="aclprofMarkEx"></a>

# aclprofMarkEx

```c
aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

aclprofMarkEx打点接口。

调用此接口向配置的Stream流上下发打点任务，用于标识Host侧打点与Device侧打点任务的关系。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| msg | 输入 | 打点信息字符串指针。类型定义请参见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。 |
| msgLen | 输入 | 字符串长度。最大支持127字符。 |
| stream | 输入 | 指定Stream。<br>取值详见[aclrtStream](25_数据类型及其操作接口.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。


<br>
<br>
<br>



<a id="aclprofPush"></a>

# aclprofPush

```c
aclError aclprofPush(void *stamp)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

msproftx用于记录事件发生的时间跨度的开始时间。

调用此接口后，Profiling自动在Stamp指针中记录开始的时间戳，将Event type设置为Push/Pop。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   与[aclprofPop](#aclprofPop)接口成对使用，表示时间跨度的开始和结束。
-   在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
-   不能跨线程调用，若需要跨线程可使用[aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop)接口。


<br>
<br>
<br>



<a id="aclprofPop"></a>

# aclprofPop

```c
aclError aclprofPop()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

msproftx用于记录事件发生的时间跨度的结束时间。

调用此接口后，Profiling自动在Stamp指针中记录采集结束的时间戳。

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   与[aclprofPush](#aclprofPush)接口成对使用，表示时间跨度的开始和结束。
-   在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
-   不能跨线程调用。若需要跨线程可使用[aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop)接口。


<br>
<br>
<br>



<a id="aclprofRangeStart"></a>

# aclprofRangeStart

```c
aclError aclprofRangeStart(void *stamp, uint32_t *rangeId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

msproftx用于记录事件发生的时间跨度的开始时间。

调用此接口后，Profiling自动在Stamp指针记录采集开始的时间戳，将Event type设置为Start/Stop，生成一个进程唯一的id，并将Stamp保存在以进程粒度维护的一个map中。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |
| rangeId | 输出 | msproftx事件标记的唯一标识。用于在跨线程时区分。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   与[aclprofRangeStop](#aclprofRangeStop)接口成对使用，表示时间跨度的开始和结束。
-   在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
-   可以跨线程调用。


<br>
<br>
<br>



<a id="aclprofRangeStop"></a>

# aclprofRangeStop

```c
aclError aclprofRangeStop(uint32_t rangeId)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

msproftx用于记录事件发生的时间跨度的结束时间。

调用此接口后，Profiling自动在Stamp指针中记录采集结束的时间戳。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| rangeId | 输出 | msproftx事件标记的唯一标识。用于在跨线程时区分。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

-   与[aclprofRangeStart](#aclprofRangeStart)接口成对使用，表示时间跨度的开始和结束。
-   在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
-   可以跨线程调用。


<br>
<br>
<br>



<a id="aclprofRangePushEx"></a>

# aclprofRangePushEx

```c
aclError aclprofRangePushEx(aclprofEventAttributes *attr)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在Torch场景下，msproftx上报Tensor信息。

调用此接口后，Profiling判断messageType为MESSAGE\_TYPE\_TENSOR\_INFO时，缓存Tensor信息。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| attr | 输入 | 需要上报的Tensor信息，结构体详见[aclprofEventAttributes](25_数据类型及其操作接口.md#aclprofEventAttributes)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

与[aclprofRangePop](#aclprofRangePop)接口配对使用，先调用aclprofRangePushEx接口再调用aclprofRangePop接口。


<br>
<br>
<br>



<a id="aclprofRangePop"></a>

# aclprofRangePop

```c
aclError aclprofRangePop()
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

在Torch场景下，msproftx上报Tensor信息。

调用此接口后，Profiling上报缓存的Tensor信息。

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25_数据类型及其操作接口.md#aclError)。

### 约束说明

与[aclprofRangePushEx](#aclprofRangePushEx)接口配对使用，先调用aclprofRangePushEx接口再调用aclprofRangePop接口。


<br>
<br>
<br>



<a id="aclprofDestroyStamp"></a>

# aclprofDestroyStamp

```c
void aclprofDestroyStamp(void *stamp)
```

### 产品支持情况


| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

释放msproftx事件标记。

### 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |

### 返回值说明

无

### 约束说明

与[aclprofCreateStamp](#aclprofCreateStamp)接口配对使用，在[aclprofStop](19-01_Profiling数据采集接口.md#aclprofStop)接口前调用。
