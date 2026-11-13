# 19-01 Profiling APIs

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:32:02.562Z pushedAt=2026-11-09T10:32:12.609Z nl=2 -->

This section describes the core profiling APIs that initialize, configure, and start/stop profiling.

- [`aclError aclprofInit(const char *profilerResultPath, size_t length)`](#aclprofInit): Initializes profiling and sets the path to the file that stores profile data.
- [`aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)`](#aclprofSetConfig): Sets profile data collection parameters. An extension of the aclprofCreateConfig API.
- [`aclError aclprofStart(const aclprofConfig *profilerConfig)`](#aclprofStart): Sends a profiling request and enables data collection.
- [`aclError aclprofStop(const aclprofConfig *profilerConfig)`](#aclprofStop): Stops profiling.
- [`aclError aclprofFinalize()`](#aclprofFinalize): Finalizes profiling.

## Notes

### General Constraints

Do not call these APIs together with the [Operator Information Subscription](19-03_subscription_to_operator_information.md) APIs. Between [aclprofInit](#aclprofInit) and [aclprofFinalize](#aclprofFinalize), you must not call [aclprofModelSubscribe](19-03_subscription_to_operator_information.md#aclprofModelSubscribe), aclprofGet\* APIs, and [aclprofModelUnSubscribe](19-03_subscription_to_operator_information.md#aclprofModelUnSubscribe).

### API Constraints

- **Call Requirements**:
    - Call [aclprofInit](#aclprofInit) after aclInit and before model loading.

        If profiling is already set through [aclInit](02_initialization_and_deinitialization.md#aclInit), calling [aclprofInit](#aclprofInit), [aclprofStart](#aclprofStart), [aclprofStop](#aclprofStop), or [aclprofFinalize](#aclprofFinalize) returns an error.

        If you do not call [aclprofInit](#aclprofInit) first, calling [aclprofStart](#aclprofStart), [aclprofStop](#aclprofStop), or [aclprofFinalize](#aclprofFinalize) returns an error.

    - Call [aclprofStart](#aclprofStart) before model execution. If you call [aclprofStart](#aclprofStart) during model execution, profiling only collects data after the call. This may lead to incomplete data.

        When calling [aclprofStart](#aclprofStart), you can collect profile data from one device or multiple devices.

        In one user app process, if you call [aclprofStart](#aclprofStart) multiple times with duplicate profiling configurations or on duplicate devices, the API returns an error.

    - In the user app process lifecycle, [aclprofInit](#aclprofInit) and [aclprofFinalize](#aclprofFinalize) are paired. You are advised to call them only once. Calling them multiple times can change the path to the profile data file.
    - [aclprofStart](#aclprofStart) and [aclprofStop](#aclprofStop) must be used in pairs.
    - Call aclprofSetConfig before aclprofStart. In one app process, you can call aclprofSetConfig once or multiple times as needed.
    - After calling aclFinalize, a normal exit code means execution is complete. Any other code means abnormal exit. Profiling does not support multiple concurrent processes. To ensure the driver shuts down properly, wait for the current profiling task to finish before starting the next one. You are advised to add error handling on the return value of aclFinalize for easier debugging.

- **Call Order**:
    - **Recommended order** (example: collecting profile data from multiple models during inference in one user app process):

        [aclInit](02_initialization_and_deinitialization.md#aclInit) → [aclprofInit](#aclprofInit) → **[aclprofStart](#aclprofStart)** (specifying Device 0 and Device 1) → Load model 1 → Run model 1 → **[aclprofStop](#aclprofStop)** (use the same [aclprofConfig](25-03_Operation_APIs.md#aclprofConfig) as [aclprofStart](#aclprofStart)) → **[aclprofStart](#aclprofStart)** (specifying Device 1 and Device 2) → Load model 2 → Run model 2 → **[aclprofStop](#aclprofStop)** (use the same [aclprofConfig](25-03_Operation_APIs.md#aclprofConfig) as [aclprofStart](#aclprofStart)) → [aclprofFinalize](#aclprofFinalize) → Run other tasks → Unload model → [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)

    - **Incorrect order example** (calling [aclprofStart](#aclprofStart) multiple times on duplicate devices in one user app process):

        [aclInit](02_initialization_and_deinitialization.md#aclInit) → [aclprofInit](#aclprofInit) → **[aclprofStart](#aclprofStart)** (specifying Device 0 and **Device 1**) → **[aclprofStart](#aclprofStart)** (specifying **Device 1** and Device 2) → Load model 1 → Run model 1 → Load model 2 → Run model 2 → **[aclprofStop](#aclprofStop)** → **[aclprofStop](#aclprofStop)** → [aclprofFinalize](#aclprofFinalize) → Run other tasks → Unload model → [aclFinalize](02_initialization_and_deinitialization.md#aclFinalize)

---

<a class="method_anchor" id="aclprofInit"></a>

## aclprofInit

```c
aclError aclprofInit(const char *profilerResultPath, size_t length)
```

### Applicable Products

<!-- npu="950" id645 -->
- Ascend 950PR&950DT products: Supported
<!-- end id645 -->
<!-- npu="A3" id646 -->
- Atlas A3 products: Supported
<!-- end id646 -->
<!-- npu="910b" id647 -->
- Atlas A2 products: Supported
<!-- end id647 -->
<!-- npu="310b" id648 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id648 -->
<!-- npu="310p" id649 -->
- Atlas inference products: Supported
<!-- end id649 -->
<!-- npu="910" id650 -->
- Atlas training products: Supported
<!-- end id650 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-01_data_profiling_apis_res.md#id1 -->
### Function

Initializes profiling and sets the path to the file that stores profile data.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| profilerResultPath | Input | Path to the profile data file. Supports both absolute and relative paths. |
| length | Input | Length of profilerResultPath, in bytes. Max: 4096. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API must be paired with [aclprofFinalize](#aclprofFinalize). Call aclprofInit before aclprofFinalize.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofSetConfig"></a>

## aclprofSetConfig

```c
aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
```

### Applicable Products

<!-- npu="950" id36 -->
- Ascend 950PR&950DT products: Supported
<!-- end id36 -->
<!-- npu="A3" id37 -->
- Atlas A3 products: Supported
<!-- end id37 -->
<!-- npu="910b" id38 -->
- Atlas A2 products: Supported
<!-- end id38 -->
<!-- npu="310b" id39 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id39 -->
<!-- npu="310p" id40 -->
- Atlas inference products: Supported
<!-- end id40 -->
<!-- npu="910" id41 -->
- Atlas training products: Supported
<!-- end id41 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-01_data_profiling_apis_res.md#id2 -->
### Function

Sets profiling parameters. An extension of the aclprofCreateConfig API.

You can call this API multiple times. Make sure the data remains consistent and accurate.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| configType | Input | Type of profiling parameters. Each enum value represents a different collection configuration. To collect different types of profile data with this API, call it multiple times. See [aclprofConfigType](25-02_Enumerations.md#aclprofConfigType) for details. |
| config | Input | Parameter values for the configuration. |
| configLength | Input | Length of config in bytes. Max: 256. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

Call aclprofSetConfig before [aclprofStart](#aclprofStart). Calling this API is optional.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofStart"></a>

## aclprofStart

```c
aclError aclprofStart(const aclprofConfig *profilerConfig)
```

### Applicable Products

<!-- npu="950" id3172 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3172 -->
<!-- npu="A3" id3173 -->
- Atlas A3 products: Supported
<!-- end id3173 -->
<!-- npu="910b" id3174 -->
- Atlas A2 products: Supported
<!-- end id3174 -->
<!-- npu="310b" id3175 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3175 -->
<!-- npu="310p" id3176 -->
- Atlas inference products: Supported
<!-- end id3176 -->
<!-- npu="910" id3177 -->
- Atlas training products: Supported
<!-- end id3177 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-01_data_profiling_apis_res.md#id3 -->

### Function

Sends a profiling request and enables data collection.

You can call aclprofStart during model execution as needed. Profiling only collects data after the call.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| profilerConfig | Input | Profiling configuration. See [aclprofConfig](25-03_Operation_APIs.md#aclprofConfig) for the type definition.<br>Create the aclprofConfig data first by calling [aclprofCreateConfig](25-03_Operation_APIs.md#aclprofCreateConfig). |

### Return Values

0: success; others: failure. See [aclError](25-01_aclError.md#aclError).

### Constraints

This API must be paired with [aclprofStop](#aclprofStop). Call aclprofStart before aclprofStop.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofStop"></a>

## aclprofStop

```c
aclError aclprofStop(const aclprofConfig *profilerConfig)
```

### Applicable Products

<!-- npu="950" id2479 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2479 -->
<!-- npu="A3" id2480 -->
- Atlas A3 products: Supported
<!-- end id2480 -->
<!-- npu="910b" id2481 -->
- Atlas A2 products: Supported
<!-- end id2481 -->
<!-- npu="310b" id2482 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2482 -->
<!-- npu="310p" id2483 -->
- Atlas inference products: Supported
<!-- end id2483 -->
<!-- npu="910" id2484 -->
- Atlas training products: Supported
<!-- end id2484 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-01_data_profiling_apis_res.md#id4 -->

### Function

Stops profiling.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| profilerConfig | Input | Configuration to stop profiling. See [aclprofConfig](25-03_Operation_APIs.md#aclprofConfig) for the type definition.<br>Must match the [aclprofConfig](25-03_Operation_APIs.md#aclprofConfig) data used in [aclprofStart](#aclprofStart). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API must be paired with [aclprofStart](#aclprofStart). Call aclprofStart before aclprofStop.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofFinalize"></a>

## aclprofFinalize

```c
aclError aclprofFinalize()
```

### Applicable Products

<!-- npu="950" id1408 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1408 -->
<!-- npu="A3" id1409 -->
- Atlas A3 products: Supported
<!-- end id1409 -->
<!-- npu="910b" id1410 -->
- Atlas A2 products: Supported
<!-- end id1410 -->
<!-- npu="310b" id1411 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1411 -->
<!-- npu="310p" id1412 -->
- Atlas inference products: Supported
<!-- end id1412 -->
<!-- npu="910" id1413 -->
- Atlas training products: Supported
<!-- end id1413 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-01_data_profiling_apis_res.md#id5 -->

### Function

Finalizes profiling.

### Parameters

None.

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API must be paired with [aclprofInit](#aclprofInit). Call aclprofInit before aclprofFinalize.
