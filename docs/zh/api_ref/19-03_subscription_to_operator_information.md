# 19-03 订阅算子信息

本章节描述算子信息订阅接口，用于订阅模型中算子的执行信息（类型、名称、耗时等）。

- [`aclError aclprofModelSubscribe(uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)`](#aclprofModelSubscribe)：网络场景下，订阅算子的基本信息，包括算子名称、算子类型、算子执行耗时等。
- [`aclError aclprofModelUnSubscribe(uint32_t modelId)`](#aclprofModelUnSubscribe)：网络场景下，取消订阅算子的基本信息，包括算子名称、算子类型、算子执行耗时等。
- [`aclError aclprofGetOpDescSize(size_t *opDescSize)`](#aclprofGetOpDescSize)：获取单个算子数据结构的大小，单位为Byte。当前版本中约定每个算子数据结构的大小是一样的。
- [`aclError aclprofGetOpNum(const void *opInfo, size_t opInfoLen, uint32_t *opNumber)`](#aclprofGetOpNum)：获取指定内存中算子的数量。
- [`aclError aclprofGetOpTypeLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opTypeLen)`](#aclprofGetOpTypeLen)：获取算子类型的字符串长度，用于内存申请。
- [`aclError aclprofGetOpType(const void *opInfo, size_t opInfoLen, uint32_t index, char *opType, size_t opTypeLen)`](#aclprofGetOpType)：获取指定算子的算子类型名称。
- [`aclError aclprofGetOpNameLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opNameLen)`](#aclprofGetOpNameLen)：获取算子名称的字符串长度，用于内存申请。
- [`aclError aclprofGetOpName(const void *opInfo, size_t opInfoLen, uint32_t index, char *opName, size_t opNameLen)`](#aclprofGetOpName)：获取指定算子的算子名称。
- [`uint64_t aclprofGetOpStart(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpStart)：获取算子执行的开始时间，单位为ns。
- [`uint64_t aclprofGetOpEnd(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpEnd)：获取算子执行的结束时间，单位为ns。
- [`uint64_t aclprofGetOpDuration(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpDuration)：获取算子执行的耗时时间，单位为ns。
- [`size_t aclprofGetModelId(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetModelId)：获取指定算子所在模型的ID。
- [`aclprofSubscribeOpFlag aclprofGetOpFlag(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpFlag)：获取指定算子的订阅类型标记。
- [`const char *aclprofGetOpAttriValue(const void *opInfo, size_t opInfoLen, uint32_t index, aclprofSubscribeOpAttri attri)`](#aclprofGetOpAttriValue)：获取指定算子的属性值。

## 订阅接口使用说明

### 总体约束

不能与[Profiling数据采集接口](19-01_data_profiling_apis.md)的接口交叉调用：[aclprofModelSubscribe](#aclprofModelSubscribe)接口和[aclprofModelUnSubscribe](#aclprofModelUnSubscribe)接口之间不能调用[aclprofInit](19-01_data_profiling_apis.md#aclprofInit)接口、[aclprofStart](19-01_data_profiling_apis.md#aclprofStart)接口、[aclprofStop](19-01_data_profiling_apis.md#aclprofStop)接口和[aclprofFinalize](19-01_data_profiling_apis.md#aclprofFinalize)接口。

### 接口约束说明

- **接口调用要求**：
    - [aclprofModelSubscribe](#aclprofModelSubscribe)接口在模型执行之前调用，若在模型执行过程中调用[aclprofModelSubscribe](#aclprofModelSubscribe)接口，Profiling采集到的数据为调用[aclprofModelSubscribe](#aclprofModelSubscribe)接口之后的数据，可能导致数据不完整。
    - [aclprofModelSubscribe](#aclprofModelSubscribe)接口需与[aclprofModelUnSubscribe](#aclprofModelUnSubscribe)接口配对使用，不能在调用[aclprofModelUnSubscribe](#aclprofModelUnSubscribe)接口前，多次调用

        [aclprofModelSubscribe](#aclprofModelSubscribe)接口重复订阅相同的模型。

    - 不能调用[aclprofModelSubscribe](#aclprofModelSubscribe)接口订阅不存在的模型ID。
    - 不能调用[aclprofModelUnSubscribe](#aclprofModelUnSubscribe)接口取消订阅不存在的模型ID或未订阅过的模型ID。
    - 如果在同一个Device上加载了多个模型，只能对多个模型下发同样的订阅配置。

- **接口调用顺序**：
    - **建议的接口调用顺序如下**：

        模型加载--\>[aclprofModelSubscribe](#aclprofModelSubscribe)接口--\>[aclprofGetOpDescSize](#aclprofGetOpDescSize)接口--\>[aclprofGetOpNum](#aclprofGetOpNum)接口--\>[aclprofGetOpType](#aclprofGetOpType)/[aclprofGetOpName](#aclprofGetOpName)/[aclprofGetOpStart](#aclprofGetOpStart)/[aclprofGetOpEnd](#aclprofGetOpEnd)/[aclprofGetOpDuration](#aclprofGetOpDuration)/[aclprofGetModelId](#aclprofGetModelId)接口--\>[aclprofModelUnSubscribe](#aclprofModelUnSubscribe)接口

    - **错误的接口调用顺序示例如下**，以重复定义同一个模型为例：

        模型1加载--\>[aclprofModelSubscribe](#aclprofModelSubscribe)接口\(指定模型1\)--\>[aclprofModelSubscribe](#aclprofModelSubscribe)接口\(指定模型1\)--\>[aclprofModelUnSubscribe](#aclprofModelUnSubscribe)接口

---

<a id="aclprofModelSubscribe"></a>

## aclprofModelSubscribe

```c
aclError aclprofModelSubscribe(uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)
```

### 产品支持情况

<!-- npu="950" id1352 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1352 -->
<!-- npu="A3" id1353 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1353 -->
<!-- npu="910b" id1354 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1354 -->
<!-- npu="310b" id1355 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1355 -->
<!-- npu="310p" id1356 -->
- Atlas 推理系列产品：支持
<!-- end id1356 -->
<!-- npu="910" id1357 -->
- Atlas 训练系列产品：支持
<!-- end id1357 -->
<!-- npu="IPV350" id1358 -->
- IPV350：不支持
<!-- end id1358 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id1 -->
### 功能说明

网络场景下，订阅算子的基本信息，包括算子名称、算子类型、算子执行耗时等。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelId | 输入 | 待订阅的网络模型的ID。<br>调用aclmdlLoadFromFile接口/aclmdlLoadFromMem接口/aclmdlLoadFromFileWithMem接口/aclmdlLoadFromMemWithMem接口加载模型成功后，会返回模型ID。<br>类型定义请参见[aclprofSubscribeConfig](25-03_Operation_APIs.md#aclprofSubscribeConfig)。 |
| profSubscribeConfig | 输入 | 待订阅的配置信息。<br>需提前调用[aclprofCreateSubscribeConfig](25-03_Operation_APIs.md#aclprofCreateSubscribeConfig)接口创建aclprofSubscribeConfig类型的数据。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

与[aclprofModelUnSubscribe](#aclprofModelUnSubscribe)接口配对使用。

<br>
<br>
<br>

<a id="aclprofModelUnSubscribe"></a>

## aclprofModelUnSubscribe

```c
aclError aclprofModelUnSubscribe(uint32_t modelId)
```

### 产品支持情况

<!-- npu="950" id2920 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2920 -->
<!-- npu="A3" id2921 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2921 -->
<!-- npu="910b" id2922 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2922 -->
<!-- npu="310b" id2923 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2923 -->
<!-- npu="310p" id2924 -->
- Atlas 推理系列产品：支持
<!-- end id2924 -->
<!-- npu="910" id2925 -->
- Atlas 训练系列产品：支持
<!-- end id2925 -->
<!-- npu="IPV350" id2926 -->
- IPV350：不支持
<!-- end id2926 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id2 -->

### 功能说明

网络场景下，取消订阅算子的基本信息，包括算子名称、算子类型、算子执行耗时等。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| modelId | 输入 | 已订阅的模型的ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

与[aclprofModelSubscribe](#aclprofModelSubscribe)接口配对使用。

<br>
<br>
<br>

<a id="aclprofGetOpDescSize"></a>

## aclprofGetOpDescSize

```c
aclError aclprofGetOpDescSize(size_t *opDescSize)
```

### 产品支持情况

<!-- npu="950" id2647 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2647 -->
<!-- npu="A3" id2648 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2648 -->
<!-- npu="910b" id2649 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2649 -->
<!-- npu="310b" id2650 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2650 -->
<!-- npu="310p" id2651 -->
- Atlas 推理系列产品：支持
<!-- end id2651 -->
<!-- npu="910" id2652 -->
- Atlas 训练系列产品：支持
<!-- end id2652 -->
<!-- npu="IPV350" id2653 -->
- IPV350：不支持
<!-- end id2653 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id3 -->
### 功能说明

获取单个算子数据结构的大小，单位为Byte。当前版本中约定每个算子数据结构的大小是一样的。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opDescSize | 输出 | 算子数据结构的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclprofGetOpNum"></a>

## aclprofGetOpNum

```c
aclError aclprofGetOpNum(const void *opInfo, size_t opInfoLen, uint32_t *opNumber)
```

### 产品支持情况

<!-- npu="950" id1394 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1394 -->
<!-- npu="A3" id1395 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1395 -->
<!-- npu="910b" id1396 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1396 -->
<!-- npu="310b" id1397 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1397 -->
<!-- npu="310p" id1398 -->
- Atlas 推理系列产品：支持
<!-- end id1398 -->
<!-- npu="910" id1399 -->
- Atlas 训练系列产品：支持
<!-- end id1399 -->
<!-- npu="IPV350" id1400 -->
- IPV350：不支持
<!-- end id1400 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id4 -->

### 功能说明

获取指定内存中算子的数量。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 指定算子信息的内存地址。<br>调用[aclprofGetOpDescSize](#aclprofGetOpDescSize)接口获取到单个算子数据结构的大小后，用户需按照“单个算子数据结构的大小*整数系数”得到的数值申请内存，用于存放Profiling采集到的算子信息数据，作为本接口的输入。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| opNumber | 输出 | 算子的数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclprofGetOpTypeLen"></a>

## aclprofGetOpTypeLen

```c
aclError aclprofGetOpTypeLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opTypeLen)
```

### 产品支持情况

<!-- npu="950" id897 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id897 -->
<!-- npu="A3" id898 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id898 -->
<!-- npu="910b" id899 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id899 -->
<!-- npu="310b" id900 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id900 -->
<!-- npu="310p" id901 -->
- Atlas 推理系列产品：支持
<!-- end id901 -->
<!-- npu="910" id902 -->
- Atlas 训练系列产品：支持
<!-- end id902 -->
<!-- npu="IPV350" id903 -->
- IPV350：不支持
<!-- end id903 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id5 -->

### 功能说明

获取算子类型的字符串长度，用于内存申请。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子的算子类型名称。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |
| opTypeLen | 输出 | opType的长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclprofGetOpType"></a>

## aclprofGetOpType

```c
aclError aclprofGetOpType(const void *opInfo, size_t opInfoLen, uint32_t index, char *opType, size_t opTypeLen)
```

### 产品支持情况

<!-- npu="950" id2661 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2661 -->
<!-- npu="A3" id2662 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2662 -->
<!-- npu="910b" id2663 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2663 -->
<!-- npu="310b" id2664 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2664 -->
<!-- npu="310p" id2665 -->
- Atlas 推理系列产品：支持
<!-- end id2665 -->
<!-- npu="910" id2666 -->
- Atlas 训练系列产品：支持
<!-- end id2666 -->
<!-- npu="IPV350" id2667 -->
- IPV350：不支持
<!-- end id2667 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id6 -->
### 功能说明

获取指定算子的算子类型名称。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子的算子类型名称。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |
| opType | 输出 | 算子类型名称。 |
| opTypeLen | 输入 | opType的实际内存申请长度。取值范围建议不小于aclprofGetOpTypeLen，否则内容会有截断。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclprofGetOpNameLen"></a>

## aclprofGetOpNameLen

```c
aclError aclprofGetOpNameLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opNameLen)
```

### 产品支持情况

<!-- npu="950" id1520 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1520 -->
<!-- npu="A3" id1521 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1521 -->
<!-- npu="910b" id1522 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1522 -->
<!-- npu="310b" id1523 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1523 -->
<!-- npu="310p" id1524 -->
- Atlas 推理系列产品：支持
<!-- end id1524 -->
<!-- npu="910" id1525 -->
- Atlas 训练系列产品：支持
<!-- end id1525 -->
<!-- npu="IPV350" id1526 -->
- IPV350：不支持
<!-- end id1526 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id7 -->
### 功能说明

获取算子名称的字符串长度，用于内存申请。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子的算子名称长度。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |
| opNameLen | 输出 | opName的实际内存申请长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclprofGetOpName"></a>

## aclprofGetOpName

```c
aclError aclprofGetOpName(const void *opInfo, size_t opInfoLen, uint32_t index, char *opName, size_t opNameLen)
```

### 产品支持情况

<!-- npu="950" id2066 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2066 -->
<!-- npu="A3" id2067 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2067 -->
<!-- npu="910b" id2068 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2068 -->
<!-- npu="310b" id2069 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2069 -->
<!-- npu="310p" id2070 -->
- Atlas 推理系列产品：支持
<!-- end id2070 -->
<!-- npu="910" id2071 -->
- Atlas 训练系列产品：支持
<!-- end id2071 -->
<!-- npu="IPV350" id2072 -->
- IPV350：不支持
<!-- end id2072 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id8 -->

### 功能说明

获取指定算子的算子名称。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子的算子名称。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |
| opName | 输出 | 算子名称。 |
| opNameLen | 输入 | opName的实际内存申请长度。取值范围建议不小于aclprofGetOpNameLen，否则内容会有截断。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclprofGetOpStart"></a>

## aclprofGetOpStart

```c
uint64_t aclprofGetOpStart(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### 产品支持情况

<!-- npu="950" id1548 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1548 -->
<!-- npu="A3" id1549 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1549 -->
<!-- npu="910b" id1550 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1550 -->
<!-- npu="310b" id1551 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1551 -->
<!-- npu="310p" id1552 -->
- Atlas 推理系列产品：支持
<!-- end id1552 -->
<!-- npu="910" id1553 -->
- Atlas 训练系列产品：支持
<!-- end id1553 -->
<!-- npu="IPV350" id1554 -->
- IPV350：不支持
<!-- end id1554 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id9 -->

### 功能说明

获取算子执行的开始时间，单位为ns。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子执行的开始时间。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |

### 返回值说明

算子执行的开始时间。

<br>
<br>
<br>

<a id="aclprofGetOpEnd"></a>

## aclprofGetOpEnd

```c
uint64_t aclprofGetOpEnd(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### 产品支持情况

<!-- npu="950" id3368 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3368 -->
<!-- npu="A3" id3369 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3369 -->
<!-- npu="910b" id3370 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3370 -->
<!-- npu="310b" id3371 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3371 -->
<!-- npu="310p" id3372 -->
- Atlas 推理系列产品：支持
<!-- end id3372 -->
<!-- npu="910" id3373 -->
- Atlas 训练系列产品：支持
<!-- end id3373 -->
<!-- npu="IPV350" id3374 -->
- IPV350：不支持
<!-- end id3374 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id10 -->
### 功能说明

获取算子执行的结束时间，单位为ns。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子执行的结束时间。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |

### 返回值说明

算子执行结束时间。

<br>
<br>
<br>

<a id="aclprofGetOpDuration"></a>

## aclprofGetOpDuration

```c
uint64_t aclprofGetOpDuration(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### 产品支持情况

<!-- npu="950" id1240 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1240 -->
<!-- npu="A3" id1241 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1241 -->
<!-- npu="910b" id1242 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1242 -->
<!-- npu="310b" id1243 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1243 -->
<!-- npu="310p" id1244 -->
- Atlas 推理系列产品：支持
<!-- end id1244 -->
<!-- npu="910" id1245 -->
- Atlas 训练系列产品：支持
<!-- end id1245 -->
<!-- npu="IPV350" id1246 -->
- IPV350：不支持
<!-- end id1246 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id11 -->

### 功能说明

获取算子执行的耗时时间，单位为ns。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子执行的耗时时间。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |

### 返回值说明

算子执行的耗时时间。

<br>
<br>
<br>

<a id="aclprofGetModelId"></a>

## aclprofGetModelId

```c
size_t aclprofGetModelId(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### 产品支持情况

<!-- npu="950" id3109 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3109 -->
<!-- npu="A3" id3110 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3110 -->
<!-- npu="910b" id3111 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3111 -->
<!-- npu="310b" id3112 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3112 -->
<!-- npu="310p" id3113 -->
- Atlas 推理系列产品：支持
<!-- end id3113 -->
<!-- npu="910" id3114 -->
- Atlas 训练系列产品：支持
<!-- end id3114 -->
<!-- npu="IPV350" id3115 -->
- IPV350：不支持
<!-- end id3115 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id12 -->

### 功能说明

获取指定算子所在模型的ID。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子所在模型的ID。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |

### 返回值说明

模型的ID。

<br>
<br>
<br>

<a id="aclprofGetOpFlag"></a>

## aclprofGetOpFlag

```c
aclprofSubscribeOpFlag aclprofGetOpFlag(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### 产品支持情况

<!-- npu="950" id2240 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2240 -->
<!-- npu="A3" id2241 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2241 -->
<!-- npu="910b" id2242 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2242 -->
<!-- npu="310b" id2243 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2243 -->
<!-- npu="310p" id2244 -->
- Atlas 推理系列产品：支持
<!-- end id2244 -->
<!-- npu="910" id2245 -->
- Atlas 训练系列产品：支持
<!-- end id2245 -->
<!-- npu="IPV350" id2246 -->
- IPV350：不支持
<!-- end id2246 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id13 -->

### 功能说明

获取指定算子的订阅类型标记。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子的订阅类型标记。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |

### 返回值说明

返回aclprofSubscribeOpFlag枚举类型。

```c
typedef enum {
    ACL_SUBSCRIBLE_OP = 0,                // 算子
    ACL_SUBSCRIBLE_SUBGRAPH = 1,          // 子图
    ACL_SUBSCRIBLE_OP_THREAD = 2,         // 算子thread
    ACL_SUBSCRIBLE_NONE = 0xFF,
} aclprofSubscribeOpFlag;
```

<br>
<br>
<br>

<a id="aclprofGetOpAttriValue"></a>

## aclprofGetOpAttriValue

```c
const char *aclprofGetOpAttriValue(const void *opInfo, size_t opInfoLen, uint32_t index, aclprofSubscribeOpAttri attri)
```

### 产品支持情况

<!-- npu="950" id4240 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id4240 -->
<!-- npu="A3" id4241 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id4241 -->
<!-- npu="910b" id4242 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id4242 -->
<!-- npu="310b" id4243 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id4243 -->
<!-- npu="310p" id4244 -->
- Atlas 推理系列产品：支持
<!-- end id4244 -->
<!-- npu="910" id4245 -->
- Atlas 训练系列产品：支持
<!-- end id4245 -->
<!-- npu="IPV350" id4246 -->
- IPV350：不支持
<!-- end id4246 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id14 -->

### 功能说明

获取指定算子的属性值。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子的属性值。<br>用户调用[aclprofGetOpNum](#aclprofGetOpNum)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |
| attri | 输入 | 指定获取的算子属性。类型为aclprofSubscribeOpAttri。<br>支持的取值如下：<br>- ACL_SUBSCRIBE_ATTRI_THREADID(0)：获取线程ID属性。<br>- ACL_SUBSCRIBE_ATTRI_NONE：无效属性标记，不用于获取有效属性值。 |

### 返回值说明

返回指定算子属性值的字符串指针。

返回NULL表示获取失败，例如attri传入无效值或当前属性不支持获取。
