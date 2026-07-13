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
- [`uint64_t aclprofStr2Id(const char *message)`](#aclprofStr2Id)：msproftx用于将字符串转化为哈希ID。

## 扩展接口使用说明

- **调用接口要求**：msproftx功能相关接口须在[aclprofStart](19-01_data_profiling_apis.md#aclprofStart)接口与[aclprofStop](19-01_data_profiling_apis.md#aclprofStop)接口之间调用。其中配对使用的接口有：[aclprofCreateStamp](#aclprofCreateStamp)/[aclprofDestroyStamp](#aclprofDestroyStamp)、[aclprofPush](#aclprofPush)/[aclprofPop](#aclprofPop)、[aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop)。
- **接口调用顺序**：**[aclprofStart](19-01_data_profiling_apis.md#aclprofStart)接口**\(指定Device 0和Device 1\)--\>[aclprofCreateStamp](#aclprofCreateStamp)接口--\>[aclprofSetStampTraceMessage](#aclprofSetStampTraceMessage)接口--\>[aclprofMark](#aclprofMark)接口--\>\([aclprofPush](#aclprofPush)接口--\>[aclprofPop](#aclprofPop)接口\)或\([aclprofRangeStart](#aclprofRangeStart)接口--\>[aclprofRangeStop](#aclprofRangeStop)接口\)--\>[aclprofDestroyStamp](#aclprofDestroyStamp)接口--\>**[aclprofStop](19-01_data_profiling_apis.md#aclprofStop)接口**\(与[aclprofStart](19-01_data_profiling_apis.md#aclprofStart)接口的[aclprofConfig](25-03_Operation_APIs.md#aclprofConfig)数据保持一致\)。

---

<a id="aclprofCreateStamp"></a>

## aclprofCreateStamp

```c
void *aclprofCreateStamp()
```

### 产品支持情况

<!-- npu="950" id953 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id953 -->
<!-- npu="A3" id954 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id954 -->
<!-- npu="910b" id955 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id955 -->
<!-- npu="310b" id956 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id956 -->
<!-- npu="310p" id957 -->
- Atlas 推理系列产品：支持
<!-- end id957 -->
<!-- npu="910" id958 -->
- Atlas 训练系列产品：支持
<!-- end id958 -->
<!-- npu="IPV350" id959 -->
- IPV350：不支持
<!-- end id959 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id1 -->

### 功能说明

创建msproftx事件标记。后续调用[aclprofMark](#aclprofMark)、[aclprofSetStampTraceMessage](#aclprofSetStampTraceMessage)、[aclprofPush](#aclprofPush)和[aclprofRangeStart](#aclprofRangeStart)接口时需要以描述该事件的指针作为输入，表示记录该事件发生的时间跨度。

### 返回值说明

- 返回void类型的指针，表示成功。
- 返回nullptr，表示失败。

### 约束说明

与[aclprofDestroyStamp](#aclprofDestroyStamp)接口配对使用，需提前调用[aclprofStart](19-01_data_profiling_apis.md#aclprofStart)接口。

<br>
<br>
<br>

<a id="aclprofSetStampTraceMessage"></a>

## aclprofSetStampTraceMessage

```c
aclError aclprofSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen)
```

### 产品支持情况

<!-- npu="950" id1023 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1023 -->
<!-- npu="A3" id1024 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1024 -->
<!-- npu="910b" id1025 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1025 -->
<!-- npu="310b" id1026 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1026 -->
<!-- npu="310p" id1027 -->
- Atlas 推理系列产品：支持
<!-- end id1027 -->
<!-- npu="910" id1028 -->
- Atlas 训练系列产品：支持
<!-- end id1028 -->
<!-- npu="IPV350" id1029 -->
- IPV350：不支持
<!-- end id1029 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id2 -->

### 功能说明

为msproftx事件标记携带字符串描述，在Profiling解析并导出结果中msprof\_tx summary数据展示。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |
| msg | 输入 | Stamp信息字符串指针。 |
| msgLen | 输入 | 字符串长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。

<br>
<br>
<br>

<a id="aclprofMark"></a>

## aclprofMark

```c
aclError aclprofMark(void *stamp)
```

### 产品支持情况

<!-- npu="950" id2570 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2570 -->
<!-- npu="A3" id2571 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2571 -->
<!-- npu="910b" id2572 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2572 -->
<!-- npu="310b" id2573 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2573 -->
<!-- npu="310p" id2574 -->
- Atlas 推理系列产品：支持
<!-- end id2574 -->
<!-- npu="910" id2575 -->
- Atlas 训练系列产品：支持
<!-- end id2575 -->
<!-- npu="IPV350" id2576 -->
- IPV350：不支持
<!-- end id2576 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id3 -->
### 功能说明

msproftx标记瞬时事件。

调用此接口后，Profiling自动在Stamp指针中加上当前时间戳，将Event type设置为Mark，表示开始一次msproftx采集。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。

<br>
<br>
<br>

<a id="aclprofMarkEx"></a>

## aclprofMarkEx

```c
aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2934 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2934 -->
<!-- npu="A3" id2935 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2935 -->
<!-- npu="910b" id2936 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2936 -->
<!-- npu="310b" id2937 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2937 -->
<!-- npu="310p" id2938 -->
- Atlas 推理系列产品：支持
<!-- end id2938 -->
<!-- npu="910" id2939 -->
- Atlas 训练系列产品：支持
<!-- end id2939 -->
<!-- npu="IPV350" id2940 -->
- IPV350：不支持
<!-- end id2940 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id4 -->
### 功能说明

aclprofMarkEx打点接口。

调用此接口向配置的Stream流上下发打点任务，用于标识Host侧打点与Device侧打点任务的关系。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| msg | 输入 | 打点信息字符串指针。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| msgLen | 输入 | 字符串长度。最大支持127字符。 |
| stream | 输入 | 指定Stream。<br>取值详见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclprofPush"></a>

## aclprofPush

```c
aclError aclprofPush(void *stamp)
```

### 产品支持情况

<!-- npu="950" id1758 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1758 -->
<!-- npu="A3" id1759 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1759 -->
<!-- npu="910b" id1760 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1760 -->
<!-- npu="310b" id1761 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1761 -->
<!-- npu="310p" id1762 -->
- Atlas 推理系列产品：支持
<!-- end id1762 -->
<!-- npu="910" id1763 -->
- Atlas 训练系列产品：支持
<!-- end id1763 -->
<!-- npu="IPV350" id1764 -->
- IPV350：不支持
<!-- end id1764 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id5 -->

### 功能说明

msproftx用于记录事件发生的时间跨度的开始时间。

调用此接口后，Profiling自动在Stamp指针中记录开始的时间戳，将Event type设置为Push/Pop。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 与[aclprofPop](#aclprofPop)接口成对使用，表示时间跨度的开始和结束。
- 在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
- 不能跨线程调用，若需要跨线程可使用[aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop)接口。

<br>
<br>
<br>

<a id="aclprofPop"></a>

## aclprofPop

```c
aclError aclprofPop()
```

### 产品支持情况

<!-- npu="950" id267 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id267 -->
<!-- npu="A3" id268 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id268 -->
<!-- npu="910b" id269 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id269 -->
<!-- npu="310b" id270 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id270 -->
<!-- npu="310p" id271 -->
- Atlas 推理系列产品：支持
<!-- end id271 -->
<!-- npu="910" id272 -->
- Atlas 训练系列产品：支持
<!-- end id272 -->
<!-- npu="IPV350" id273 -->
- IPV350：不支持
<!-- end id273 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id6 -->

### 功能说明

msproftx用于记录事件发生的时间跨度的结束时间。

调用此接口后，Profiling自动在Stamp指针中记录采集结束的时间戳。

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 与[aclprofPush](#aclprofPush)接口成对使用，表示时间跨度的开始和结束。
- 在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
- 不能跨线程调用。若需要跨线程可使用[aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop)接口。

<br>
<br>
<br>

<a id="aclprofRangeStart"></a>

## aclprofRangeStart

```c
aclError aclprofRangeStart(void *stamp, uint32_t *rangeId)
```

### 产品支持情况

<!-- npu="950" id2990 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2990 -->
<!-- npu="A3" id2991 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2991 -->
<!-- npu="910b" id2992 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2992 -->
<!-- npu="310b" id2993 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2993 -->
<!-- npu="310p" id2994 -->
- Atlas 推理系列产品：支持
<!-- end id2994 -->
<!-- npu="910" id2995 -->
- Atlas 训练系列产品：支持
<!-- end id2995 -->
<!-- npu="IPV350" id2996 -->
- IPV350：不支持
<!-- end id2996 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id7 -->
### 功能说明

msproftx用于记录事件发生的时间跨度的开始时间。

调用此接口后，Profiling自动在Stamp指针记录采集开始的时间戳，将Event type设置为Start/Stop，生成一个进程唯一的id，并将Stamp保存在以进程粒度维护的一个map中。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |
| rangeId | 输出 | msproftx事件标记的唯一标识。用于在跨线程时区分。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 与[aclprofRangeStop](#aclprofRangeStop)接口成对使用，表示时间跨度的开始和结束。
- 在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
- 可以跨线程调用。

<br>
<br>
<br>

<a id="aclprofRangeStop"></a>

## aclprofRangeStop

```c
aclError aclprofRangeStop(uint32_t rangeId)
```

### 产品支持情况

<!-- npu="950" id2556 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2556 -->
<!-- npu="A3" id2557 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2557 -->
<!-- npu="910b" id2558 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2558 -->
<!-- npu="310b" id2559 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2559 -->
<!-- npu="310p" id2560 -->
- Atlas 推理系列产品：支持
<!-- end id2560 -->
<!-- npu="910" id2561 -->
- Atlas 训练系列产品：支持
<!-- end id2561 -->
<!-- npu="IPV350" id2562 -->
- IPV350：不支持
<!-- end id2562 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id8 -->

### 功能说明

msproftx用于记录事件发生的时间跨度的结束时间。

调用此接口后，Profiling自动在Stamp指针中记录采集结束的时间戳。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| rangeId | 输入 | msproftx事件标记的唯一标识。用于在跨线程时区分。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 与[aclprofRangeStart](#aclprofRangeStart)接口成对使用，表示时间跨度的开始和结束。
- 在[aclprofCreateStamp](#aclprofCreateStamp)接口和[aclprofDestroyStamp](#aclprofDestroyStamp)接口之间调用。
- 可以跨线程调用。

<br>
<br>
<br>

<a id="aclprofRangePushEx"></a>

## aclprofRangePushEx

```c
aclError aclprofRangePushEx(aclprofEventAttributes *attr)
```

### 产品支持情况

<!-- npu="950" id659 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id659 -->
<!-- npu="A3" id660 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id660 -->
<!-- npu="910b" id661 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id661 -->
<!-- npu="310b" id662 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id662 -->
<!-- npu="310p" id663 -->
- Atlas 推理系列产品：支持
<!-- end id663 -->
<!-- npu="910" id664 -->
- Atlas 训练系列产品：支持
<!-- end id664 -->
<!-- npu="IPV350" id665 -->
- IPV350：不支持
<!-- end id665 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id9 -->

### 功能说明

在Torch场景下，msproftx上报Tensor信息。

调用此接口后，Profiling判断messageType为MESSAGE\_TYPE\_TENSOR\_INFO时，缓存Tensor信息。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| attr | 输入 | 需要上报的Tensor信息，结构体详见[aclprofEventAttributes](25-02_Enumerations.md#aclprofEventAttributes)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

与[aclprofRangePop](#aclprofRangePop)接口配对使用，先调用aclprofRangePushEx接口再调用aclprofRangePop接口。

<br>
<br>
<br>

<a id="aclprofRangePop"></a>

## aclprofRangePop

```c
aclError aclprofRangePop()
```

### 产品支持情况

<!-- npu="950" id2157 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2157 -->
<!-- npu="A3" id2158 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2158 -->
<!-- npu="910b" id2159 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2159 -->
<!-- npu="310b" id2160 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2160 -->
<!-- npu="310p" id2161 -->
- Atlas 推理系列产品：支持
<!-- end id2161 -->
<!-- npu="910" id2162 -->
- Atlas 训练系列产品：支持
<!-- end id2162 -->
<!-- npu="IPV350" id2163 -->
- IPV350：不支持
<!-- end id2163 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id10 -->

### 功能说明

在Torch场景下，msproftx上报Tensor信息。

调用此接口后，Profiling上报缓存的Tensor信息。

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

与[aclprofRangePushEx](#aclprofRangePushEx)接口配对使用，先调用aclprofRangePushEx接口再调用aclprofRangePop接口。

<br>
<br>
<br>

<a id="aclprofDestroyStamp"></a>

## aclprofDestroyStamp

```c
void aclprofDestroyStamp(void *stamp)
```

### 产品支持情况

<!-- npu="950" id1282 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1282 -->
<!-- npu="A3" id1283 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1283 -->
<!-- npu="910b" id1284 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1284 -->
<!-- npu="310b" id1285 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1285 -->
<!-- npu="310p" id1286 -->
- Atlas 推理系列产品：支持
<!-- end id1286 -->
<!-- npu="910" id1287 -->
- Atlas 训练系列产品：支持
<!-- end id1287 -->
<!-- npu="IPV350" id1288 -->
- IPV350：不支持
<!-- end id1288 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id11 -->

### 功能说明

释放msproftx事件标记。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](#aclprofCreateStamp)接口的指针。 |

### 返回值说明

无

### 约束说明

与[aclprofCreateStamp](#aclprofCreateStamp)接口配对使用，在[aclprofStop](19-01_data_profiling_apis.md#aclprofStop)接口前调用。

<a id="aclprofStr2Id"></a>

## aclprofStr2Id

```c
uint64_t aclprofStr2Id(const char *message)
```

### 产品支持情况

<!-- npu="950" id3452 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3452 -->
<!-- npu="A3" id3453 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3453 -->
<!-- npu="910b" id3454 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3454 -->
<!-- npu="310b" id3455 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3455 -->
<!-- npu="310p" id3456 -->
- Atlas 推理系列产品：支持
<!-- end id3456 -->
<!-- npu="910" id3457 -->
- Atlas 训练系列产品：支持
<!-- end id3457 -->
<!-- npu="IPV350" id3458 -->
- IPV350：不支持
<!-- end id3458 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id12 -->
### 功能说明

msproftx用于将字符串转化为哈希ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| message | 输入 | 字符信息，例如算子名。 |

### 返回值说明

返回哈希ID，如果是uint64\_t类型的最大值则表示失败，其他表示成功。

### 约束说明

与[aclprofRangePushEx](19-02_msproftx_extension_apis.md#aclprofRangePushEx)和[aclprofRangePop](19-02_msproftx_extension_apis.md#aclprofRangePop)接口配合使用，在[aclprofRangePushEx](19-02_msproftx_extension_apis.md#aclprofRangePushEx)接口调用之前调用。
