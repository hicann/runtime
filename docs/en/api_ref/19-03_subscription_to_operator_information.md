# 19-03 Operator Information Subscription

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:33:03.035Z pushedAt=2026-11-09T10:34:58.424Z nl=2 -->

This section describes the APIs for subscribing to operator execution information in a model, including operator type, name, and execution time.

- [`aclError aclprofModelSubscribe(uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)`](#aclprofModelSubscribe): Subscribes to basic operator information, including operator name, operator type, and operator execution time, in a network.
- [`aclError aclprofModelUnSubscribe(uint32_t modelId)`](#aclprofModelUnSubscribe): Unsubscribes from basic operator information, including operator name, operator type, and operator execution time, in a network.
- [`aclError aclprofGetOpDescSize(size_t *opDescSize)`](#aclprofGetOpDescSize): Gets the size of a single operator data structure, in bytes. In the current version, each operator data structure has the same size.
- [`aclError aclprofGetOpNum(const void *opInfo, size_t opInfoLen, uint32_t *opNumber)`](#aclprofGetOpNum): Gets the number of operators in a specified memory region.
- [`aclError aclprofGetOpTypeLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opTypeLen)`](#aclprofGetOpTypeLen): Gets the string length of an operator type for memory allocation.
- [`aclError aclprofGetOpType(const void *opInfo, size_t opInfoLen, uint32_t index, char *opType, size_t opTypeLen)`](#aclprofGetOpType): Gets the operator type name of a specified operator.
- [`aclError aclprofGetOpNameLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opNameLen)`](#aclprofGetOpNameLen): Gets the string length of an operator name for memory allocation.
- [`aclError aclprofGetOpName(const void *opInfo, size_t opInfoLen, uint32_t index, char *opName, size_t opNameLen)`](#aclprofGetOpName): Gets the name of a specified operator.
- [`uint64_t aclprofGetOpStart(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpStart): Gets the start time of operator execution, in µs.
- [`uint64_t aclprofGetOpEnd(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpEnd): Gets the end time of operator execution, in µs.
- [`uint64_t aclprofGetOpDuration(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpDuration): Gets the execution time of an operator, in µs.
- [`size_t aclprofGetModelId(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetModelId): Gets the model ID of a specified operator.
- [`aclprofSubscribeOpFlag aclprofGetOpFlag(const void *opInfo, size_t opInfoLen, uint32_t index)`](#aclprofGetOpFlag): Gets the subscription type flag of a specified operator.
- [`const char *aclprofGetOpAttriValue(const void *opInfo, size_t opInfoLen, uint32_t index, aclprofSubscribeOpAttri attri)`](#aclprofGetOpAttriValue): Gets the attribute value of a specified operator.

## Notes

### General Constraints

Do not call these APIs together with [profiling APIs](19-01_data_profiling_apis.md). Between [aclprofModelSubscribe](#aclprofModelSubscribe) and [aclprofModelUnSubscribe](#aclprofModelUnSubscribe), you must not call the following APIs: [aclprofInit](19-01_data_profiling_apis.md#aclprofInit), [aclprofStart](19-01_data_profiling_apis.md#aclprofStart), [aclprofStop](19-01_data_profiling_apis.md#aclprofStop), and[aclprofFinalize](19-01_data_profiling_apis.md#aclprofFinalize).

### API Constraints

- **Call Requirements**:
    - Call [aclprofModelSubscribe](#aclprofModelSubscribe) before model execution. If you call [aclprofModelSubscribe](#aclprofModelSubscribe) during model execution, profiling only collects data after the call. This may lead to incomplete data.
    - The [aclprofModelSubscribe](#aclprofModelSubscribe) API must be paired with the [aclprofModelUnSubscribe](#aclprofModelUnSubscribe) API. Do not call the

        [aclprofModelSubscribe](#aclprofModelSubscribe) API multiple times to repeatedly subscribe to the same model before calling the [aclprofModelUnSubscribe](#aclprofModelUnSubscribe) API.

    - Do not subscribe to a model ID that does not exist.
    - Do not unsubscribe from a model ID that does not exist or was never subscribed to.
    - If multiple models are loaded on the same device, you must use the same subscription configuration for all models.

- **API Call Order**:
    - **Recommended order**:

        Load model → [aclprofModelSubscribe](#aclprofModelSubscribe) → [aclprofGetOpDescSize](#aclprofGetOpDescSize) → [aclprofGetOpNum](#aclprofGetOpNum) → [aclprofGetOpType](#aclprofGetOpType) / [aclprofGetOpName](#aclprofGetOpName) / [aclprofGetOpStart](#aclprofGetOpStart) / [aclprofGetOpEnd](#aclprofGetOpEnd) / [aclprofGetOpDuration](#aclprofGetOpDuration) / [aclprofGetModelId](#aclprofGetModelId) → [aclprofModelUnSubscribe](#aclprofModelUnSubscribe)

    - **Incorrect order example** (subscribing to the same model twice):

        Load model 1 → [aclprofModelSubscribe](#aclprofModelSubscribe) (model 1) → [aclprofModelSubscribe](#aclprofModelSubscribe) (model 1) → [aclprofModelUnSubscribe](#aclprofModelUnSubscribe)

---

<a class="method_anchor" id="aclprofModelSubscribe"></a>

## aclprofModelSubscribe

```c
aclError aclprofModelSubscribe(uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)
```

### Applicable Products

<!-- npu="950" id1352 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1352 -->
<!-- npu="A3" id1353 -->
- Atlas A3 products: Supported
<!-- end id1353 -->
<!-- npu="910b" id1354 -->
- Atlas A2 products: Supported
<!-- end id1354 -->
<!-- npu="310b" id1355 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1355 -->
<!-- npu="310p" id1356 -->
- Atlas inference products: Supported
<!-- end id1356 -->
<!-- npu="910" id1357 -->
- Atlas training products: Supported
<!-- end id1357 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id1 -->
### Function

Subscribes to basic operator information, including operator name, operator type, and operator execution time, in a network.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelId | Input | ID of the model to subscribe to.<br>After loading a model by calling aclmdlLoadFromFile, aclmdlLoadFromMem, aclmdlLoadFromFileWithMem, or aclmdlLoadFromMemWithMem, the model ID is returned.|
| profSubscribeConfig | Input | Subscription configuration.<br>Create the aclprofSubscribeConfig data first by calling [aclprofCreateSubscribeConfig](25-03_Operation_APIs.md#aclprofCreateSubscribeConfig). |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API must be paired with [aclprofModelUnSubscribe](#aclprofModelUnSubscribe).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofModelUnSubscribe"></a>

## aclprofModelUnSubscribe

```c
aclError aclprofModelUnSubscribe(uint32_t modelId)
```

### Applicable Products

<!-- npu="950" id2920 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2920 -->
<!-- npu="A3" id2921 -->
- Atlas A3 products: Supported
<!-- end id2921 -->
<!-- npu="910b" id2922 -->
- Atlas A2 products: Supported
<!-- end id2922 -->
<!-- npu="310b" id2923 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2923 -->
<!-- npu="310p" id2924 -->
- Atlas inference products: Supported
<!-- end id2924 -->
<!-- npu="910" id2925 -->
- Atlas training products: Supported
<!-- end id2925 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id2 -->

### Function

Unsubscribes from basic operator information, including operator name, operator type, and operator execution time, in a network.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| modelId | Input | ID of the subscribed model. |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API must be paired with [aclprofModelSubscribe](#aclprofModelSubscribe).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpDescSize"></a>

## aclprofGetOpDescSize

```c
aclError aclprofGetOpDescSize(size_t *opDescSize)
```

### Applicable Products

<!-- npu="950" id2647 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2647 -->
<!-- npu="A3" id2648 -->
- Atlas A3 products: Supported
<!-- end id2648 -->
<!-- npu="910b" id2649 -->
- Atlas A2 products: Supported
<!-- end id2649 -->
<!-- npu="310b" id2650 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2650 -->
<!-- npu="310p" id2651 -->
- Atlas inference products: Supported
<!-- end id2651 -->
<!-- npu="910" id2652 -->
- Atlas training products: Supported
<!-- end id2652 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id3 -->
### Function

Gets the size of a single operator data structure, in bytes. In the current version, each operator data structure has the same size.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opDescSize | Output | Size of the operator data structure. |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpNum"></a>

## aclprofGetOpNum

```c
aclError aclprofGetOpNum(const void *opInfo, size_t opInfoLen, uint32_t *opNumber)
```

### Applicable Products

<!-- npu="950" id1394 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1394 -->
<!-- npu="A3" id1395 -->
- Atlas A3 products: Supported
<!-- end id1395 -->
<!-- npu="910b" id1396 -->
- Atlas A2 products: Supported
<!-- end id1396 -->
<!-- npu="310b" id1397 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1397 -->
<!-- npu="310p" id1398 -->
- Atlas inference products: Supported
<!-- end id1398 -->
<!-- npu="910" id1399 -->
- Atlas training products: Supported
<!-- end id1399 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id4 -->

### Function

Gets the number of operators in a specified memory region.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Memory address of the operator information.<br>After calling [aclprofGetOpDescSize](#aclprofGetOpDescSize) to get the size of a single operator data structure, allocate memory to store the profiling operator information data by multiplying single operator data structure size by integer coefficient. This serves as the input for this API. |
| opInfoLen | Input | Length of the operator information. |
| opNumber | Output | Number of operators. |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpTypeLen"></a>

## aclprofGetOpTypeLen

```c
aclError aclprofGetOpTypeLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opTypeLen)
```

### Applicable Products

<!-- npu="950" id897 -->
- Ascend 950PR&950DT products: Supported
<!-- end id897 -->
<!-- npu="A3" id898 -->
- Atlas A3 products: Supported
<!-- end id898 -->
<!-- npu="910b" id899 -->
- Atlas A2 products: Supported
<!-- end id899 -->
<!-- npu="310b" id900 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id900 -->
<!-- npu="310p" id901 -->
- Atlas inference products: Supported
<!-- end id901 -->
<!-- npu="910" id902 -->
- Atlas training products: Supported
<!-- end id902 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id5 -->

### Function

Gets the string length of an operator type for memory allocation.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's type name to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |
| opTypeLen | Output | Length of opType. |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpType"></a>

## aclprofGetOpType

```c
aclError aclprofGetOpType(const void *opInfo, size_t opInfoLen, uint32_t index, char *opType, size_t opTypeLen)
```

### Applicable Products

<!-- npu="950" id2661 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2661 -->
<!-- npu="A3" id2662 -->
- Atlas A3 products: Supported
<!-- end id2662 -->
<!-- npu="910b" id2663 -->
- Atlas A2 products: Supported
<!-- end id2663 -->
<!-- npu="310b" id2664 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2664 -->
<!-- npu="310p" id2665 -->
- Atlas inference products: Supported
<!-- end id2665 -->
<!-- npu="910" id2666 -->
- Atlas training products: Supported
<!-- end id2666 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id6 -->
### Function

Gets the operator type name of a specified operator.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's type name to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |
| opType | Output | Operator type name. |
| opTypeLen | Input | Actual memory allocation length for opType. You are advised to set this value to at least the value returned by aclprofGetOpTypeLen, or the content may be truncated. |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpNameLen"></a>

## aclprofGetOpNameLen

```c
aclError aclprofGetOpNameLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opNameLen)
```

### Applicable Products

<!-- npu="950" id1520 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1520 -->
<!-- npu="A3" id1521 -->
- Atlas A3 products: Supported
<!-- end id1521 -->
<!-- npu="910b" id1522 -->
- Atlas A2 products: Supported
<!-- end id1522 -->
<!-- npu="310b" id1523 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1523 -->
<!-- npu="310p" id1524 -->
- Atlas inference products: Supported
<!-- end id1524 -->
<!-- npu="910" id1525 -->
- Atlas training products: Supported
<!-- end id1525 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id7 -->
### Function

Gets the string length of an operator name for memory allocation.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's name length to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |
| opNameLen | Output | The actual memory allocation length for opName. |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpName"></a>

## aclprofGetOpName

```c
aclError aclprofGetOpName(const void *opInfo, size_t opInfoLen, uint32_t index, char *opName, size_t opNameLen)
```

### Applicable Products

<!-- npu="950" id2066 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2066 -->
<!-- npu="A3" id2067 -->
- Atlas A3 products: Supported
<!-- end id2067 -->
<!-- npu="910b" id2068 -->
- Atlas A2 products: Supported
<!-- end id2068 -->
<!-- npu="310b" id2069 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2069 -->
<!-- npu="310p" id2070 -->
- Atlas inference products: Supported
<!-- end id2070 -->
<!-- npu="910" id2071 -->
- Atlas training products: Supported
<!-- end id2071 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id8 -->

### Function

Gets the operator name of a specified operator.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's name to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |
| opName | Output | The operator name. |
| opNameLen | Input | Actual memory allocation length for opName. You are advised to set this value to at least the value returned by aclprofGetOpNameLen, or the content may be truncated. |

### Return Value

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpStart"></a>

## aclprofGetOpStart

```c
uint64_t aclprofGetOpStart(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### Applicable Products

<!-- npu="950" id1548 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1548 -->
<!-- npu="A3" id1549 -->
- Atlas A3 products: Supported
<!-- end id1549 -->
<!-- npu="910b" id1550 -->
- Atlas A2 products: Supported
<!-- end id1550 -->
<!-- npu="310b" id1551 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1551 -->
<!-- npu="310p" id1552 -->
- Atlas inference products: Supported
<!-- end id1552 -->
<!-- npu="910" id1553 -->
- Atlas training products: Supported
<!-- end id1553 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id9 -->

### Function

Gets the start time of operator execution, in µs.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's start time to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |

### Return Value

The start time of operator execution.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpEnd"></a>

## aclprofGetOpEnd

```c
uint64_t aclprofGetOpEnd(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### Applicable Products

<!-- npu="950" id3368 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3368 -->
<!-- npu="A3" id3369 -->
- Atlas A3 products: Supported
<!-- end id3369 -->
<!-- npu="910b" id3370 -->
- Atlas A2 products: Supported
<!-- end id3370 -->
<!-- npu="310b" id3371 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3371 -->
<!-- npu="310p" id3372 -->
- Atlas inference products: Supported
<!-- end id3372 -->
<!-- npu="910" id3373 -->
- Atlas training products: Supported
<!-- end id3373 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id10 -->
### Function

Gets the end time of operator execution, in µs.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's end time to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |

### Return Value

The end time of operator execution.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpDuration"></a>

## aclprofGetOpDuration

```c
uint64_t aclprofGetOpDuration(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### Applicable Products

<!-- npu="950" id1240 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1240 -->
<!-- npu="A3" id1241 -->
- Atlas A3 products: Supported
<!-- end id1241 -->
<!-- npu="910b" id1242 -->
- Atlas A2 products: Supported
<!-- end id1242 -->
<!-- npu="310b" id1243 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1243 -->
<!-- npu="310p" id1244 -->
- Atlas inference products: Supported
<!-- end id1244 -->
<!-- npu="910" id1245 -->
- Atlas training products: Supported
<!-- end id1245 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id11 -->

### Function

Gets the execution time of an operator, in µs.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's execution time to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |

### Return Value

The execution time of the operator.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetModelId"></a>

## aclprofGetModelId

```c
size_t aclprofGetModelId(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### Applicable Products

<!-- npu="950" id3109 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3109 -->
<!-- npu="A3" id3110 -->
- Atlas A3 products: Supported
<!-- end id3110 -->
<!-- npu="910b" id3111 -->
- Atlas A2 products: Supported
<!-- end id3111 -->
<!-- npu="310b" id3112 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3112 -->
<!-- npu="310p" id3113 -->
- Atlas inference products: Supported
<!-- end id3113 -->
<!-- npu="910" id3114 -->
- Atlas training products: Supported
<!-- end id3114 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id12 -->

### Function

Gets the model ID of a specified operator.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's model ID to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |

### Return Value

The model ID.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpFlag"></a>

## aclprofGetOpFlag

```c
aclprofSubscribeOpFlag aclprofGetOpFlag(const void *opInfo, size_t opInfoLen, uint32_t index)
```

### Applicable Products

<!-- npu="950" id2240 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2240 -->
<!-- npu="A3" id2241 -->
- Atlas A3 products: Supported
<!-- end id2241 -->
<!-- npu="910b" id2242 -->
- Atlas A2 products: Supported
<!-- end id2242 -->
<!-- npu="310b" id2243 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2243 -->
<!-- npu="310p" id2244 -->
- Atlas inference products: Supported
<!-- end id2244 -->
<!-- npu="910" id2245 -->
- Atlas training products: Supported
<!-- end id2245 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id13 -->

### Function

Gets the subscription type flag of a specified operator.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's subscription type flag to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |

### Return Value

Returns an aclprofSubscribeOpFlag enum type.

```c
typedef enum {
    ACL_SUBSCRIBE_OP = 0,                // Operator
    ACL_SUBSCRIBE_SUBGRAPH = 1,          // Subgraph
    ACL_SUBSCRIBE_OP_THREAD = 2,         // Operator thread
    ACL_SUBSCRIBE_NONE = 0xFF,
} aclprofSubscribeOpFlag;
```

<br>
<br>
<br>

<a class="method_anchor" id="aclprofGetOpAttriValue"></a>

## aclprofGetOpAttriValue

```c
const char *aclprofGetOpAttriValue(const void *opInfo, size_t opInfoLen, uint32_t index, aclprofSubscribeOpAttri attri)
```

### Applicable Products

<!-- npu="950" id4240 -->
- Ascend 950PR&950DT products: Supported
<!-- end id4240 -->
<!-- npu="A3" id4241 -->
- Atlas A3 products: Supported
<!-- end id4241 -->
<!-- npu="910b" id4242 -->
- Atlas A2 products: Supported
<!-- end id4242 -->
<!-- npu="310b" id4243 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id4243 -->
<!-- npu="310p" id4244 -->
- Atlas inference products: Supported
<!-- end id4244 -->
<!-- npu="910" id4245 -->
- Atlas training products: Supported
<!-- end id4245 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-03_subscription_to_operator_information_res.md#id14 -->

### Function

Gets the attribute value of a specified operator.

You are advised to create a new thread and call this API in that thread. Otherwise, calls to this API may block the scheduling of other tasks in the main thread.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| opInfo | Input | Address that contains operator information. |
| opInfoLen | Input | Length of the operator information. |
| index | Input | Specifies which operator's attribute value to get.<br>After calling [aclprofGetOpNum](#aclprofGetOpNum) to get the operator count, the index range is [0, (Operator count − 1)]. |
| attri | Input | Specifies the operator attribute to get. The type is aclprofSubscribeOpAttri.<br>Options:<br>- ACL_SUBSCRIBE_ATTRI_THREADID(0): Gets the thread ID attribute.<br>- ACL_SUBSCRIBE_ATTRI_NONE: Invalid attribute flag, not used for getting valid attribute values. |

### Return Value

Returns a string pointer to the specified operator attribute value.

Returns NULL if getting the attribute fails, for example, when `attri` is set to an invalid value or the attribute does not support retrieval.
