# 3. Runtime Configuration

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-23T11:21:47.021Z pushedAt=2026-10-26T02:08:08.073Z -->

This topic describes the runtime configuration APIs of CANN Runtime, which are used to set and query system parameters, device resource limits, and stream resource limits.

- [`aclError aclrtSetSysParamOpt(aclSysParamOpt opt, int64_t value)`](#aclrtSetSysParamOpt): Sets the runtime parameter in the current process.
- [`aclError aclrtGetSysParamOpt(aclSysParamOpt opt, int64_t *value)`](#aclrtGetSysParamOpt): Obtains the runtime parameter value in the current process.
- [`aclError aclrtGetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t* value)`](#aclrtGetDeviceResLimit): Obtains the device resource limit of the current process.
- [`aclError aclrtSetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)`](#aclrtSetDeviceResLimit): Sets the device resource limit of the current process.
- [`aclError aclrtResetDeviceResLimit(int32_t deviceId)`](#aclrtResetDeviceResLimit): Resets the device resource limit of the current process to restore the default configuration after the device resource limit is set by calling [aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit). At this time, the default resource limit can be queried through [aclrtGetDeviceResLimit](#aclrtGetDeviceResLimit).
- [`aclError aclrtGetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value)`](#aclrtGetStreamResLimit): Obtains the device resource limit of the specified stream.
- [`aclError aclrtSetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)`](#aclrtSetStreamResLimit): Sets the device resource limit of the specified stream.
- [`aclError aclrtResetStreamResLimit(aclrtStream stream)`](#aclrtResetStreamResLimit): Resets the device resource limit of the specified stream to restore the default configuration after the device resource limit of the specified stream is set by calling [aclrtSetStreamResLimit](#aclrtSetStreamResLimit). At this time, the default resource limit can be queried through [aclrtGetStreamResLimit](#aclrtGetStreamResLimit).
- [`aclError aclrtUseStreamResInCurrentThread(aclrtStream stream)`](#aclrtUseStreamResInCurrentThread): Uses the device resource limit on the specified stream in the current thread. If this API is called multiple times to set the stream, the last setting takes effect.
- [`aclError aclrtUnuseStreamResInCurrentThread(aclrtStream stream)`](#aclrtUnuseStreamResInCurrentThread): Cancels the use of the device resource limit on the specified stream in the current thread.
- [`aclError aclrtGetResInCurrentThread(aclrtDevResLimitType type, uint32_t *value)`](#aclrtGetResInCurrentThread): Obtains the device resources available in the current thread.

<a class="method_anchor" id="aclrtSetSysParamOpt"></a>

## aclrtSetSysParamOpt

```c
aclError aclrtSetSysParamOpt(aclSysParamOpt opt, int64_t value)
```

### Applicable Products

<!-- npu="950" id8 -->
- Ascend 950PR&950DT products: Supported
<!-- end id8 -->
<!-- npu="A3" id9 -->
- Atlas A3 products: Supported
<!-- end id9 -->
<!-- npu="910b" id10 -->
- Atlas A2 products: Supported
<!-- end id10 -->
<!-- npu="310b" id11 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id11 -->
<!-- npu="310p" id12 -->
- Atlas inference products: Supported
<!-- end id12 -->
<!-- npu="910" id13 -->
- Atlas training products: Supported
<!-- end id13 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id1 -->

### Description

Sets the runtime parameter in the current process. After calling this API to set the runtime parameter, if you need to obtain the parameter value, call the [aclrtGetSysParamOpt](#aclrtGetSysParamOpt) API.

The difference between this API and the [aclrtCtxSetSysParamOpt](05_context_management.md#aclrtCtxSetSysParamOpt) API is that the scope of this API is the process, while the scope of the **aclrtCtxSetSysParamOpt** API is the context.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| opt | Input | Runtime parameter. For details, see [aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt). |
| value | Input | Runtime parameter value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetSysParamOpt"></a>

## aclrtGetSysParamOpt

```c
aclError aclrtGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
```

### Applicable Products

<!-- npu="950" id2752 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2752 -->
<!-- npu="A3" id2753 -->
- Atlas A3 products: Supported
<!-- end id2753 -->
<!-- npu="910b" id2754 -->
- Atlas A2 products: Supported
<!-- end id2754 -->
<!-- npu="310b" id2755 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2755 -->
<!-- npu="310p" id2756 -->
- Atlas inference products: Supported
<!-- end id2756 -->
<!-- npu="910" id2757 -->
- Atlas training products: Supported
<!-- end id2757 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id2 -->

### Description

Obtains the runtime parameter value in the current process.

If the [aclrtSetSysParamOpt](#aclrtSetSysParamOpt) API is not called to set the runtime parameter, calling this API directly returns the default value **0** for each parameter, indicating that deterministic computation or memory access out-of-bounds detection is not enabled. After the runtime parameter is set by calling the [aclrtSetSysParamOpt](#aclrtSetSysParamOpt) API, call the [aclrtGetSysParamOpt](#aclrtGetSysParamOpt) API to obtain the parameter value.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| opt | Input | Runtime parameter. For details, see [aclSysParamOpt](25-02_Enumerations.md#aclSysParamOpt). |
| value | Output | Runtime parameter value. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetDeviceResLimit"></a>

## aclrtGetDeviceResLimit

```c
aclError aclrtGetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t* value)
```

### Applicable Products

<!-- npu="950" id3305 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3305 -->
<!-- npu="A3" id3306 -->
- Atlas A3 products: Supported
<!-- end id3306 -->
<!-- npu="910b" id3307 -->
- Atlas A2 products: Supported
<!-- end id3307 -->
<!-- npu="310b" id3308 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3308 -->
<!-- npu="310p" id3309 -->
- Atlas inference products: Supported
<!-- end id3309 -->
<!-- npu="910" id3310 -->
- Atlas training products: Supported
<!-- end id3310 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id3 -->

### Description

Obtains the device resource limit of the current process.

If [aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit) is not called to set the device resource limit of the current process, this API returns the default resource limit of the AI processor hardware.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After the user calls [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (Number of available devices - 1)]. |
| type | Input | Resource type. For details, see [aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType). |
| value | Output | Size of the resource limit. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetDeviceResLimit"></a>

## aclrtSetDeviceResLimit

```c
aclError aclrtSetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)
```

### Applicable Products

<!-- npu="950" id232 -->
- Ascend 950PR&950DT products: Supported
<!-- end id232 -->
<!-- npu="A3" id233 -->
- Atlas A3 products: Supported
<!-- end id233 -->
<!-- npu="910b" id234 -->
- Atlas A2 products: Supported
<!-- end id234 -->
<!-- npu="310b" id235 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id235 -->
<!-- npu="310p" id236 -->
- Atlas inference products: Supported
<!-- end id236 -->
<!-- npu="910" id237 -->
- Atlas training products: Supported
<!-- end id237 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id4 -->

### Description

Sets the device resource limit of the current process.

This API should be used after calling [aclrtSetDevice](04_device_management.md#aclrtSetDevice) and before executing operators. If the resource limit is set for the same device multiple times, the last setting takes effect.

In addition to the process-level device resource limit, the stream-level device resource limit is also supported. It can be implemented by using [aclrtSetStreamResLimit](#aclrtSetStreamResLimit) and [aclrtUseStreamResInCurrentThread](#aclrtUseStreamResInCurrentThread) together.

The priority of the device resource limits is as follows: stream-level device resource limit \> process-level device resource limit \> AI processor hardware resource limit

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After the user calls [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (Number of available devices - 1)]. |
| type | Input | Resource type. For details, see [aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType). |
| value | Input | Size of the resource limit. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The setting by this API takes effect only on tasks dispatched subsequently. For example, in the scenario where APIs such as [aclmdlRICaptureBegin](15_model_running_instance_management.md#aclmdlRICaptureBegin) and [aclmdlRICaptureEnd](15_model_running_instance_management.md#aclmdlRICaptureEnd) are called to capture stream tasks into a model and then model inference is executed, call this API to set the device resource limit before the capture.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtResetDeviceResLimit"></a>

## aclrtResetDeviceResLimit

```c
aclError aclrtResetDeviceResLimit(int32_t deviceId)
```

### Applicable Products

<!-- npu="950" id281 -->
- Ascend 950PR&950DT products: Supported
<!-- end id281 -->
<!-- npu="A3" id282 -->
- Atlas A3 products: Supported
<!-- end id282 -->
<!-- npu="910b" id283 -->
- Atlas A2 products: Supported
<!-- end id283 -->
<!-- npu="310b" id284 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id284 -->
<!-- npu="310p" id285 -->
- Atlas inference products: Supported
<!-- end id285 -->
<!-- npu="910" id286 -->
- Atlas training products: Supported
<!-- end id286 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id5 -->

### Description

Resets the device resource limit of the current process to restore the default configuration after the device resource limit is set by calling [aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit). At this time, you can query the default resource limit through [aclrtGetDeviceResLimit](#aclrtGetDeviceResLimit).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| deviceId | Input | Device ID.<br>After the user calls [aclrtGetDeviceCount](04_device_management.md#aclrtGetDeviceCount) to obtain the number of available devices, the value range of this device ID is [0, (Number of available devices - 1)]. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetStreamResLimit"></a>

## aclrtGetStreamResLimit

```c
aclError aclrtGetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value)
```

### Applicable Products

<!-- npu="950" id3060 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3060 -->
<!-- npu="A3" id3061 -->
- Atlas A3 products: Supported
<!-- end id3061 -->
<!-- npu="910b" id3062 -->
- Atlas A2 products: Supported
<!-- end id3062 -->
<!-- npu="310b" id3063 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3063 -->
<!-- npu="310p" id3064 -->
- Atlas inference products: Supported
<!-- end id3064 -->
<!-- npu="910" id3065 -->
- Atlas training products: Supported
<!-- end id3065 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id6 -->

### Description

Obtains the device resource limit of a specified stream.

If the [aclrtSetStreamResLimit](#aclrtSetStreamResLimit) API is not called to set the device resource limit, the priority of the device resource limit obtained by calling this API is as follows: the device resource limit of the current process (set by calling the [aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit) API) \>  the default resource limit of the AI processor hardware.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>If **NULL** is passed in, the default stream is used. |
| type | Input | Resource type. For details, see [aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType). |
| value | Output | Size of the resource limit. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetStreamResLimit"></a>

## aclrtSetStreamResLimit

```c
aclError aclrtSetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)
```

### Applicable Products

<!-- npu="950" id3074 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3074 -->
<!-- npu="A3" id3075 -->
- Atlas A3 products: Supported
<!-- end id3075 -->
<!-- npu="910b" id3076 -->
- Atlas A2 products: Supported
<!-- end id3076 -->
<!-- npu="310b" id3077 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3077 -->
<!-- npu="310p" id3078 -->
- Atlas inference products: Supported
<!-- end id3078 -->
<!-- npu="910" id3079 -->
- Atlas training products: Supported
<!-- end id3079 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id7 -->

### Description

Sets the device resource limit of the specified stream.

This API should be used after calling [aclrtSetDevice](04_device_management.md#aclrtSetDevice) and before executing operators. If the resource limit is set for the same stream multiple times, the last setting takes effect.

After calling this API to set the device resource limit of the specified stream, call [aclrtUseStreamResInCurrentThread](#aclrtUseStreamResInCurrentThread) to set the device resource limit of the specified stream to be used in the current thread.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>If **NULL** is passed in, the default stream is used. |
| type | Input | Resource type. For details, see [aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType). |
| value | Input | Size of the resource limit. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtResetStreamResLimit"></a>

## aclrtResetStreamResLimit

```c
aclError aclrtResetStreamResLimit(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id1674 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1674 -->
<!-- npu="A3" id1675 -->
- Atlas A3 products: Supported
<!-- end id1675 -->
<!-- npu="910b" id1676 -->
- Atlas A2 products: Supported
<!-- end id1676 -->
<!-- npu="310b" id1677 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1677 -->
<!-- npu="310p" id1678 -->
- Atlas inference products: Supported
<!-- end id1678 -->
<!-- npu="910" id1679 -->
- Atlas training products: Supported
<!-- end id1679 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id8 -->

### Description

Resets the device resource limit of the specified stream to restore the default configuration after the [aclrtSetStreamResLimit](#aclrtSetStreamResLimit) API is called to set the device resource limit of the specified stream. At this time, the default resource limit can be queried through the [aclrtGetStreamResLimit](#aclrtGetStreamResLimit) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>If **NULL** is passed in, the default stream is used. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtUseStreamResInCurrentThread"></a>

## aclrtUseStreamResInCurrentThread

```c
aclError aclrtUseStreamResInCurrentThread([aclrtStream](25-05_Typedefs.md#aclrtStream) stream)
```

### Applicable Products

<!-- npu="950" id1226 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1226 -->
<!-- npu="A3" id1227 -->
- Atlas A3 products: Supported
<!-- end id1227 -->
<!-- npu="910b" id1228 -->
- Atlas A2 products: Supported
<!-- end id1228 -->
<!-- npu="310b" id1229 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1229 -->
<!-- npu="310p" id1230 -->
- Atlas inference products: Supported
<!-- end id1230 -->
<!-- npu="910" id1231 -->
- Atlas training products: Supported
<!-- end id1231 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id9 -->

### Description

Uses the device resource limit on the specified stream in the current thread. If this API is called multiple times to set the stream, the last setting takes effect.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>You must first call [aclrtSetStreamResLimit](#aclrtSetStreamResLimit) to set the device resource limit on the stream. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtUnuseStreamResInCurrentThread"></a>

## aclrtUnuseStreamResInCurrentThread

```c
aclError aclrtUnuseStreamResInCurrentThread(aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id400 -->
- Ascend 950PR&950DT products: Supported
<!-- end id400 -->
<!-- npu="A3" id401 -->
- Atlas A3 products: Supported
<!-- end id401 -->
<!-- npu="910b" id402 -->
- Atlas A2 products: Supported
<!-- end id402 -->
<!-- npu="310b" id403 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id403 -->
<!-- npu="310p" id404 -->
- Atlas inference products: Supported
<!-- end id404 -->
<!-- npu="910" id405 -->
- Atlas training products: Supported
<!-- end id405 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id10 -->

### Description

Cancels the use of the device resource limit on the specified stream in the current thread.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetResInCurrentThread"></a>

## aclrtGetResInCurrentThread

```c
aclError aclrtGetResInCurrentThread(aclrtDevResLimitType type, uint32_t *value)
```

### Applicable Products

<!-- npu="950" id2913 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2913 -->
<!-- npu="A3" id2914 -->
- Atlas A3 products: Supported
<!-- end id2914 -->
<!-- npu="910b" id2915 -->
- Atlas A2 products: Supported
<!-- end id2915 -->
<!-- npu="310b" id2916 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2916 -->
<!-- npu="310p" id2917 -->
- Atlas inference products: Supported
<!-- end id2917 -->
<!-- npu="910" id2918 -->
- Atlas training products: Supported
<!-- end id2918 -->
<!-- @ref: runtime/res/docs/zh/api_ref/03_runtime_configuration_res.md#id11 -->

### Description

Obtains the device resources available in the current thread.

When the device resources are obtained, the value is returned according to the following priority: stream-level device resource limit (set by calling the [aclrtSetStreamResLimit](#aclrtSetStreamResLimit) API) \> the device resource limit of the current process (set by calling the [aclrtSetDeviceResLimit](#aclrtSetDeviceResLimit) API) \> the default resource limit of the AI processor hardware.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| type | Input | Resource type. For details, see [aclrtDevResLimitType](25-02_Enumerations.md#aclrtDevResLimitType). |
| value | Output | Resource quantity. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
