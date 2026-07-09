# 3. 运行时配置

本章节描述 CANN Runtime 的运行时配置接口，用于设置和查询系统参数、设备资源限制及 Stream 资源限制。

- [`aclError aclrtSetSysParamOpt(aclSysParamOpt opt, int64_t value)`](#aclrtSetSysParamOpt)：设置当前进程中的运行时参数值。
- [`aclError aclrtGetSysParamOpt(aclSysParamOpt opt, int64_t *value)`](#aclrtGetSysParamOpt)：获取当前进程中的运行时参数值。
- [`aclError aclrtGetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t* value)`](#aclrtGetDeviceResLimit)：获取当前进程的Device资源限制。
- [`aclError aclrtSetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)`](#aclrtSetDeviceResLimit)：设置当前进程的Device资源限制。
- [`aclError aclrtResetDeviceResLimit(int32_t deviceId)`](#aclrtResetDeviceResLimit)：调用[aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit)接口设置Device资源限制后，可调用本接口重置当前进程的Device资源限制，恢复默认配置，此时可通过[aclrtGetDeviceResLimit](#aclrtGetDeviceResLimit)接口查询默认的资源限制。
- [`aclError aclrtGetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value)`](#aclrtGetStreamResLimit)：获取指定Stream的Device资源限制。
- [`aclError aclrtSetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)`](#aclrtSetStreamResLimit)：设置指定Stream的Device资源限制。
- [`aclError aclrtResetStreamResLimit(aclrtStream stream)`](#aclrtResetStreamResLimit)：调用[aclrtSetStreamResLimit](#aclrtSetStreamResLimit)接口设置指定Stream的Device资源限制后，可调用本接口重置指定Stream的Device资源限制，恢复默认配置，此时可通过[aclrtGetStreamResLimit](#aclrtGetStreamResLimit)接口查询默认的资源限制。
- [`aclError aclrtUseStreamResInCurrentThread([aclrtStream](25-05_Typedefs.md#aclrtStream) stream)`](#aclrtUseStreamResInCurrentThread)：在当前线程中使用指定Stream上的Device资源限制。如果多次调用本接口设置Stream，将以最后一次设置为准。
- [`aclError aclrtUnuseStreamResInCurrentThread(aclrtStream stream)`](#aclrtUnuseStreamResInCurrentThread)：在当前线程中取消使用指定Stream上的Device资源限制。
- [`aclError aclrtGetResInCurrentThread(aclrtDevResLimitType type, uint32_t *value)`](#aclrtGetResInCurrentThread)：获取当前线程可使用的Device资源。

<a id="aclrtSetSysParamOpt"></a>

## aclrtSetSysParamOpt

```c
aclError aclrtSetSysParamOpt(aclSysParamOpt opt, int64_t value)
```

### 产品支持情况

<!-- npu="950" id8 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id8 -->
<!-- npu="A3" id9 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id9 -->
<!-- npu="910b" id10 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id10 -->
<!-- npu="310b" id11 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id11 -->
<!-- npu="310p" id12 -->
- Atlas 推理系列产品：支持
<!-- end id12 -->
<!-- npu="910" id13 -->
- Atlas 训练系列产品：支持
<!-- end id13 -->
<!-- npu="IPV350" id14 -->
- IPV350：不支持
<!-- end id14 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id1 -->

### 功能说明

设置当前进程中的运行时参数值。调用本接口设置运行时参数值后，若需获取参数值，需调用[aclrtGetSysParamOpt](#aclrtGetSysParamOpt)接口。

本接口与[aclrtCtxSetSysParamOpt](05_context_management.md#aclrtCtxSetSysParamOpt)接口的差别是，本接口作用域是进程，aclrtCtxSetSysParamOpt接口作用域是Context。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opt | 输入 | 运行时参数，请参见[aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt)。 |
| value | 输入 | 运行时参数值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetSysParamOpt"></a>

## aclrtGetSysParamOpt

```c
aclError aclrtGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
```

### 产品支持情况

<!-- npu="950" id2752 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2752 -->
<!-- npu="A3" id2753 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2753 -->
<!-- npu="910b" id2754 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2754 -->
<!-- npu="310b" id2755 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2755 -->
<!-- npu="310p" id2756 -->
- Atlas 推理系列产品：支持
<!-- end id2756 -->
<!-- npu="910" id2757 -->
- Atlas 训练系列产品：支持
<!-- end id2757 -->
<!-- npu="IPV350" id2758 -->
- IPV350：不支持
<!-- end id2758 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id2 -->

### 功能说明

获取当前进程中的运行时参数值。

如果不调用[aclrtSetSysParamOpt](#aclrtSetSysParamOpt)接口设置运行时参数的值，直接调用本接口可获取各参数的默认值0，表示不开启确定性计算或内存访问越界检测；调用[aclrtSetSysParamOpt](#aclrtSetSysParamOpt)接口设置运行时参数值后，若需获取参数值，需调用[aclrtGetSysParamOpt](#aclrtGetSysParamOpt)接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| opt | 输入 | 运行时参数，请参见[aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt)。 |
| value | 输出 | 运行时参数值。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetDeviceResLimit"></a>

## aclrtGetDeviceResLimit

```c
aclError aclrtGetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t* value)
```

### 产品支持情况

<!-- npu="950" id3305 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3305 -->
<!-- npu="A3" id3306 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3306 -->
<!-- npu="910b" id3307 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3307 -->
<!-- npu="310b" id3308 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3308 -->
<!-- npu="310p" id3309 -->
- Atlas 推理系列产品：支持
<!-- end id3309 -->
<!-- npu="910" id3310 -->
- Atlas 训练系列产品：支持
<!-- end id3310 -->
<!-- npu="IPV350" id3311 -->
- IPV350：不支持
<!-- end id3311 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id3 -->

### 功能说明

获取当前进程的Device资源限制。

若没有调用[aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit)接口设置当前进程的Device资源限制，则调用本接口获取到的是AI处理器硬件默认的资源限制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| type | 输入 | 资源类型，请参见[aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType)。 |
| value | 输出 | 资源限制的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetDeviceResLimit"></a>

## aclrtSetDeviceResLimit

```c
aclError aclrtSetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)
```

### 产品支持情况

<!-- npu="950" id232 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id232 -->
<!-- npu="A3" id233 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id233 -->
<!-- npu="910b" id234 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id234 -->
<!-- npu="310b" id235 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id235 -->
<!-- npu="310p" id236 -->
- Atlas 推理系列产品：支持
<!-- end id236 -->
<!-- npu="910" id237 -->
- Atlas 训练系列产品：支持
<!-- end id237 -->
<!-- npu="IPV350" id238 -->
- IPV350：不支持
<!-- end id238 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id4 -->

### 功能说明

设置当前进程的Device资源限制。

本接口应在调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口之后且在执行算子之前使用。如果对同一Device进行多次设置，将以最后一次设置为准。

除了进程级别的Device资源限制，当前还支持设置Stream级别的Device资源限制，可通过[aclrtSetStreamResLimit](#aclrtSetStreamResLimit)、[aclrtUseStreamResInCurrentThread](#aclrtUseStreamResInCurrentThread)接口配合使用实现。

Device资源限制的优先级为：Stream级别的Device资源限制 \> 进程级别的Device资源限制 \>  AI处理器硬件的资源限制

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| type | 输入 | 资源类型，请参见[aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType)。 |
| value | 输入 | 资源限制的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

本接口的设置仅对后续下发的任务有效。例如在调用[aclmdlRICaptureBegin](15_model_running_instance__management.md#aclmdlRICaptureBegin)、[aclmdlRICaptureEnd](15_model_running_instance__management.md#aclmdlRICaptureEnd)等接口捕获Stream任务到模型中、再执行模型推理的场景下，则需要在捕获之前调用本接口设置Device资源。

<br>
<br>
<br>

<a id="aclrtResetDeviceResLimit"></a>

## aclrtResetDeviceResLimit

```c
aclError aclrtResetDeviceResLimit(int32_t deviceId)
```

### 产品支持情况

<!-- npu="950" id281 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id281 -->
<!-- npu="A3" id282 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id282 -->
<!-- npu="910b" id283 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id283 -->
<!-- npu="310b" id284 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id284 -->
<!-- npu="310p" id285 -->
- Atlas 推理系列产品：支持
<!-- end id285 -->
<!-- npu="910" id286 -->
- Atlas 训练系列产品：支持
<!-- end id286 -->
<!-- npu="IPV350" id287 -->
- IPV350：不支持
<!-- end id287 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id5 -->

### 功能说明

调用[aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit)接口设置Device资源限制后，可调用本接口重置当前进程的Device资源限制，恢复默认配置，此时可通过[aclrtGetDeviceResLimit](#aclrtGetDeviceResLimit)接口查询默认的资源限制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetStreamResLimit"></a>

## aclrtGetStreamResLimit

```c
aclError aclrtGetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value)
```

### 产品支持情况

<!-- npu="950" id3060 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3060 -->
<!-- npu="A3" id3061 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3061 -->
<!-- npu="910b" id3062 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3062 -->
<!-- npu="310b" id3063 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3063 -->
<!-- npu="310p" id3064 -->
- Atlas 推理系列产品：支持
<!-- end id3064 -->
<!-- npu="910" id3065 -->
- Atlas 训练系列产品：支持
<!-- end id3065 -->
<!-- npu="IPV350" id3066 -->
- IPV350：不支持
<!-- end id3066 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id6 -->

### 功能说明

获取指定Stream的Device资源限制。

若没有调用[aclrtSetStreamResLimit](#aclrtSetStreamResLimit)接口设置Device资源限制，则调用本接口获取到的Device资源限制优先级为：当前进程的Device资源限制（调用[aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit)接口设置） \>  AI处理器硬件默认的资源限制

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>若传入NULL，则表示默认Stream。 |
| type | 输入 | 资源类型，请参见[aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType)。 |
| value | 输出 | 资源限制的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetStreamResLimit"></a>

## aclrtSetStreamResLimit

```c
aclError aclrtSetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)
```

### 产品支持情况

<!-- npu="950" id3074 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3074 -->
<!-- npu="A3" id3075 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3075 -->
<!-- npu="910b" id3076 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3076 -->
<!-- npu="310b" id3077 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3077 -->
<!-- npu="310p" id3078 -->
- Atlas 推理系列产品：支持
<!-- end id3078 -->
<!-- npu="910" id3079 -->
- Atlas 训练系列产品：支持
<!-- end id3079 -->
<!-- npu="IPV350" id3080 -->
- IPV350：不支持
<!-- end id3080 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id7 -->

### 功能说明

设置指定Stream的Device资源限制。

本接口应在调用[aclrtSetDevice](04_device_management.md#aclrtSetDevice)接口之后且在执行算子之前使用。如果对同一Stream进行多次设置，将以最后一次设置为准。

调用本接口设置指定Stream的Device资源限制后，需配合调用[aclrtUseStreamResInCurrentThread](#aclrtUseStreamResInCurrentThread)接口，设置在当前线程中使用指定Stream上的Device资源限制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>若传入NULL，则表示默认Stream。 |
| type | 输入 | 资源类型，请参见[aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType)。 |
| value | 输入 | 资源限制的大小。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtResetStreamResLimit"></a>

## aclrtResetStreamResLimit

```c
aclError aclrtResetStreamResLimit(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id1674 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1674 -->
<!-- npu="A3" id1675 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1675 -->
<!-- npu="910b" id1676 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1676 -->
<!-- npu="310b" id1677 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1677 -->
<!-- npu="310p" id1678 -->
- Atlas 推理系列产品：支持
<!-- end id1678 -->
<!-- npu="910" id1679 -->
- Atlas 训练系列产品：支持
<!-- end id1679 -->
<!-- npu="IPV350" id1680 -->
- IPV350：不支持
<!-- end id1680 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id8 -->

### 功能说明

调用[aclrtSetStreamResLimit](#aclrtSetStreamResLimit)接口设置指定Stream的Device资源限制后，可调用本接口重置指定Stream的Device资源限制，恢复默认配置，此时可通过[aclrtGetStreamResLimit](#aclrtGetStreamResLimit)接口查询默认的资源限制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>若传入NULL，则表示默认Stream。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtUseStreamResInCurrentThread"></a>

## aclrtUseStreamResInCurrentThread

```c
aclError aclrtUseStreamResInCurrentThread([aclrtStream](25-05_Typedefs.md#aclrtStream) stream)
```

### 产品支持情况

<!-- npu="950" id1226 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1226 -->
<!-- npu="A3" id1227 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1227 -->
<!-- npu="910b" id1228 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1228 -->
<!-- npu="310b" id1229 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1229 -->
<!-- npu="310p" id1230 -->
- Atlas 推理系列产品：支持
<!-- end id1230 -->
<!-- npu="910" id1231 -->
- Atlas 训练系列产品：支持
<!-- end id1231 -->
<!-- npu="IPV350" id1232 -->
- IPV350：不支持
<!-- end id1232 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id9 -->

### 功能说明

在当前线程中使用指定Stream上的Device资源限制。如果多次调用本接口设置Stream，将以最后一次设置为准。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>需先调用[aclrtSetStreamResLimit](#aclrtSetStreamResLimit)接口设置该Stream上的Device资源限制。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtUnuseStreamResInCurrentThread"></a>

## aclrtUnuseStreamResInCurrentThread

```c
aclError aclrtUnuseStreamResInCurrentThread(aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id400 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id400 -->
<!-- npu="A3" id401 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id401 -->
<!-- npu="910b" id402 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id402 -->
<!-- npu="310b" id403 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id403 -->
<!-- npu="310p" id404 -->
- Atlas 推理系列产品：支持
<!-- end id404 -->
<!-- npu="910" id405 -->
- Atlas 训练系列产品：支持
<!-- end id405 -->
<!-- npu="IPV350" id406 -->
- IPV350：不支持
<!-- end id406 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id10 -->

### 功能说明

在当前线程中取消使用指定Stream上的Device资源限制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtGetResInCurrentThread"></a>

## aclrtGetResInCurrentThread

```c
aclError aclrtGetResInCurrentThread(aclrtDevResLimitType type, uint32_t *value)
```

### 产品支持情况

<!-- npu="950" id2913 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2913 -->
<!-- npu="A3" id2914 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2914 -->
<!-- npu="910b" id2915 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2915 -->
<!-- npu="310b" id2916 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2916 -->
<!-- npu="310p" id2917 -->
- Atlas 推理系列产品：支持
<!-- end id2917 -->
<!-- npu="910" id2918 -->
- Atlas 训练系列产品：支持
<!-- end id2918 -->
<!-- npu="IPV350" id2919 -->
- IPV350：不支持
<!-- end id2919 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id11 -->

### 功能说明

获取当前线程可使用的Device资源。

获取时，按照如下优先级返回value：Stream级别的Device资源限制（调用[aclrtSetStreamResLimit](#aclrtSetStreamResLimit)接口设置） \> 当前进程的Device资源限制（调用[aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit)接口设置） \>  AI处理器硬件默认的资源限制

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| type | 输入 | 资源类型，请参见[aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType)。 |
| value | 输出 | 资源数量。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
