# 19-02 msproftx Extension

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-26T12:35:39.148Z pushedAt=2026-10-28T10:17:21.765Z -->

This topic describes the msproftx extension APIs, which are used for custom performance markers (Stamp), range markers, and call stack markers.

- [`void *aclprofCreateStamp()`](#aclprofCreateStamp): Creates an event marker for msproftx.
- [`aclError aclprofSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen)`](#aclprofSetStampTraceMessage): Carries a string description for the msproftx event marker, which is displayed in the msprof\_tx summary data of the results parsed and exported by profiling.
- [`aclError aclprofMark(void *stamp)`](#aclprofMark): Marks an instantaneous event for msproftx.
- [`aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)`](#aclprofMarkEx): Performs stamping for aclprofMarkEx.
- [`aclError aclprofPush(void *stamp)`](#aclprofPush): Records the start time of the time span of an event occurrence for msproftx.
- [`aclError aclprofPop()`](#aclprofPop): Records the end time of the time span of an event occurrence for msproftx.
- [`aclError aclprofRangeStart(void *stamp, uint32_t *rangeId)`](#aclprofRangeStart): Records the start time of the time span of an event occurrence for msproftx.
- [`aclError aclprofRangeStop(uint32_t rangeId)`](#aclprofRangeStop): Records the end time of the time span of an event occurrence for msproftx.
- [`aclError aclprofRangePushEx(aclprofEventAttributes *attr)`](#aclprofRangePushEx): Reports tensor information in Torch scenarios for msproftx.
- [`aclError aclprofRangePop()`](#aclprofRangePop): Reports Tensor information in Torch scenarios for msproftx.
- [`void aclprofDestroyStamp(void *stamp)`](#aclprofDestroyStamp): Releases the event marker for msproftx.
- [`uint64_t aclprofStr2Id(const char *message)`](#aclprofStr2Id): Converts a string into a hash ID for msproftx.

## Extension API Usage Notes

- **API call requirements**: The msproftx-related APIs must be called between the [aclprofStart](19-01_data_profiling_apis.md#aclprofStart) API and the [aclprofStop](19-01_data_profiling_apis.md#aclprofStop) API. The APIs used in pairs are: [aclprofCreateStamp](#aclprofCreateStamp)/[aclprofDestroyStamp](#aclprofDestroyStamp), [aclprofPush](#aclprofPush)/[aclprofPop](#aclprofPop), and [aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop).
- **API call sequence**: **[aclprofStart](19-01_data_profiling_apis.md#aclprofStart) API** \(specifying Device 0 and Device 1\)--\> [aclprofCreateStamp](#aclprofCreateStamp) API --\> [aclprofSetStampTraceMessage](#aclprofSetStampTraceMessage) API --\> [aclprofMark](#aclprofMark) API --\>\ ([aclprofPush](#aclprofPush) API --\> [aclprofPop](#aclprofPop) API\) or \ ([aclprofRangeStart](#aclprofRangeStart) API --\> [aclprofRangeStop](#aclprofRangeStop) API\)--\> [aclprofDestroyStamp](#aclprofDestroyStamp) API --\> **[aclprofStop](19-01_data_profiling_apis.md#aclprofStop) API**\ (must be consistent with the [aclprofConfig](25-03_Operation_APIs.md#aclprofConfig) data of the [aclprofStart](19-01_data_profiling_apis.md#aclprofStart) API\).

---

<a class="method_anchor" id="aclprofCreateStamp"></a>

## aclprofCreateStamp

```c
void *aclprofCreateStamp()
```

### Applicable Products

<!-- npu="950" id953 -->
- Ascend 950PR&950DT products: Supported
<!-- end id953 -->
<!-- npu="A3" id954 -->
- Atlas A3 products: Supported
<!-- end id954 -->
<!-- npu="910b" id955 -->
- Atlas A2 products: Supported
<!-- end id955 -->
<!-- npu="310b" id956 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id956 -->
<!-- npu="310p" id957 -->
- Atlas inference products: Supported
<!-- end id957 -->
<!-- npu="910" id958 -->
- Atlas training products: Supported
<!-- end id958 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id1 -->

### Description

Creates an event marker for msproftx. When the [aclprofMark](#aclprofMark), [aclprofSetStampTraceMessage](#aclprofSetStampTraceMessage), [aclprofPush](#aclprofPush), and [aclprofRangeStart](#aclprofRangeStart) APIs are called subsequently, the pointer describing this event must be used as input to record the time span of the event occurrence.

### Return Values

- Returns a pointer of the **void** type, indicating success.
- Returns **nullptr**, indicating failure.

### Constraints

This API is used in pairs with the [aclprofDestroyStamp](#aclprofDestroyStamp) API, and the [aclprofStart](19-01_data_profiling_apis.md#aclprofStart) API must be called in advance.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofSetStampTraceMessage"></a>

## aclprofSetStampTraceMessage

```c
aclError aclprofSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen)
```

### Applicable Products

<!-- npu="950" id1023 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1023 -->
<!-- npu="A3" id1024 -->
- Atlas A3 products: Supported
<!-- end id1024 -->
<!-- npu="910b" id1025 -->
- Atlas A2 products: Supported
<!-- end id1025 -->
<!-- npu="310b" id1026 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1026 -->
<!-- npu="310p" id1027 -->
- Atlas inference products: Supported
<!-- end id1027 -->
<!-- npu="910" id1028 -->
- Atlas training products: Supported
<!-- end id1028 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id2 -->

### Description

Carries a string description for the msproftx event marker, which is displayed in the msprof\_tx summary data of the results parsed and exported by profiling.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stamp | Input | Stamp pointer, referring to the msproftx event marker.<br>Specify the pointer of the [aclprofCreateStamp](#aclprofCreateStamp) API. |
| msg | Input | Pointer to the stamp information string. |
| msgLen | Input | String length. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API is called between the [aclprofCreateStamp](#aclprofCreateStamp) API and the [aclprofDestroyStamp](#aclprofDestroyStamp) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofMark"></a>

## aclprofMark

```c
aclError aclprofMark(void *stamp)
```

### Applicable Products

<!-- npu="950" id2570 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2570 -->
<!-- npu="A3" id2571 -->
- Atlas A3 products: Supported
<!-- end id2571 -->
<!-- npu="910b" id2572 -->
- Atlas A2 products: Supported
<!-- end id2572 -->
<!-- npu="310b" id2573 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2573 -->
<!-- npu="310p" id2574 -->
- Atlas inference products: Supported
<!-- end id2574 -->
<!-- npu="910" id2575 -->
- Atlas training products: Supported
<!-- end id2575 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id3 -->
### Description

Marks an instantaneous event for msproftx.

After this API is called, profiling automatically adds the current timestamp to the stamp pointer and sets the event type to **Mark**, indicating the start of an msproftx collection.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stamp | Input | Stamp pointer, pointing to the msproftx event marker.<br>Specify the pointer of the [aclprofCreateStamp](#aclprofCreateStamp) API. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API is called between the [aclprofCreateStamp](#aclprofCreateStamp) API and the [aclprofDestroyStamp](#aclprofDestroyStamp) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofMarkEx"></a>

## aclprofMarkEx

```c
aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2934 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2934 -->
<!-- npu="A3" id2935 -->
- Atlas A3 products: Supported
<!-- end id2935 -->
<!-- npu="910b" id2936 -->
- Atlas A2 products: Supported
<!-- end id2936 -->
<!-- npu="310b" id2937 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2937 -->
<!-- npu="310p" id2938 -->
- Atlas inference products: Supported
<!-- end id2938 -->
<!-- npu="910" id2939 -->
- Atlas training products: Supported
<!-- end id2939 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id4 -->
### Description

Performs stamping for aclprofMarkEx.

This API is used to dispatch a stamp task to the configured stream to identify the relationship between host-side stamp tasks and device-side stamp tasks.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| msg | Input | Pointer to the stamp information string. |
| msgLen | Input | String length. A maximum of 127 characters is supported. |
| stream | Input | Stream. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

None
<br>
<br>
<br>

<a class="method_anchor" id="aclprofPush"></a>

## aclprofPush

```c
aclError aclprofPush(void *stamp)
```

### Applicable Products

<!-- npu="950" id1758 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1758 -->
<!-- npu="A3" id1759 -->
- Atlas A3 products: Supported
<!-- end id1759 -->
<!-- npu="910b" id1760 -->
- Atlas A2 products: Supported
<!-- end id1760 -->
<!-- npu="310b" id1761 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1761 -->
<!-- npu="310p" id1762 -->
- Atlas inference products: Supported
<!-- end id1762 -->
<!-- npu="910" id1763 -->
- Atlas training products: Supported
<!-- end id1763 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id5 -->

### Description

Records the start time of the time span of an event occurrence for msproftx.

After this API is called, profiling automatically records the start timestamp in the stamp pointer and sets the event type to **Push/Pop**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stamp | Input | Stamp pointer, pointing to the msproftx event marker.<br>Specify the pointer of the [aclprofCreateStamp](#aclprofCreateStamp) API. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API is used in pairs with the [aclprofPop](#aclprofPop) API to indicate the start and end of a time span.
- This API is called between the [aclprofCreateStamp](#aclprofCreateStamp) API and the [aclprofDestroyStamp](#aclprofDestroyStamp) API.
- This API cannot be called across threads. If cross-thread usage is required, use the [aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofPop"></a>

## aclprofPop

```c
aclError aclprofPop()
```

### Applicable Products

<!-- npu="950" id267 -->
- Ascend 950PR&950DT products: Supported
<!-- end id267 -->
<!-- npu="A3" id268 -->
- Atlas A3 products: Supported
<!-- end id268 -->
<!-- npu="910b" id269 -->
- Atlas A2 products: Supported
<!-- end id269 -->
<!-- npu="310b" id270 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id270 -->
<!-- npu="310p" id271 -->
- Atlas inference products: Supported
<!-- end id271 -->
<!-- npu="910" id272 -->
- Atlas training products: Supported
<!-- end id272 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id6 -->

### Description

Records the end time of the time span of an event occurrence for msproftx.

After this API is called, profiling automatically records the timestamp at which collection ends in the stamp pointer.

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API is used in pairs with [aclprofPush](#aclprofPush) to indicate the start and end of a time span.
- This API is called between the [aclprofCreateStamp](#aclprofCreateStamp) API and the [aclprofDestroyStamp](#aclprofDestroyStamp) API.
- This API cannot be called across threads. If cross-thread usage is required, use the [aclprofRangeStart](#aclprofRangeStart)/[aclprofRangeStop](#aclprofRangeStop) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofRangeStart"></a>

## aclprofRangeStart

```c
aclError aclprofRangeStart(void *stamp, uint32_t *rangeId)
```

### Applicable Products

<!-- npu="950" id2990 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2990 -->
<!-- npu="A3" id2991 -->
- Atlas A3 products: Supported
<!-- end id2991 -->
<!-- npu="910b" id2992 -->
- Atlas A2 products: Supported
<!-- end id2992 -->
<!-- npu="310b" id2993 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2993 -->
<!-- npu="310p" id2994 -->
- Atlas inference products: Supported
<!-- end id2994 -->
<!-- npu="910" id2995 -->
- Atlas training products: Supported
<!-- end id2995 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id7 -->
### Description

Records the start time of the time span of an event occurrence for msproftx.

After this API is called, profiling automatically records the timestamp at which collection starts in the stamp pointer, sets the event type to **Start/Stop**, generates a process-unique ID, and stores the stamp in a map maintained at process granularity.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stamp | Input | Stamp pointer, pointing to the msproftx event marker.<br>Specify the pointer of the [aclprofCreateStamp](#aclprofCreateStamp) API. |
| rangeId | Output | Unique identifier of the msproftx event marker, which is used to distinguish across threads. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API is used in pairs with the [aclprofRangeStop](#aclprofRangeStop) API to indicate the start and end of a time span.
- This API is called between the [aclprofCreateStamp](#aclprofCreateStamp) API and the [aclprofDestroyStamp](#aclprofDestroyStamp) API.
- This API can be called across threads.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofRangeStop"></a>

## aclprofRangeStop

```c
aclError aclprofRangeStop(uint32_t rangeId)
```

### Applicable Products

<!-- npu="950" id2556 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2556 -->
<!-- npu="A3" id2557 -->
- Atlas A3 products: Supported
<!-- end id2557 -->
<!-- npu="910b" id2558 -->
- Atlas A2 products: Supported
<!-- end id2558 -->
<!-- npu="310b" id2559 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2559 -->
<!-- npu="310p" id2560 -->
- Atlas inference products: Supported
<!-- end id2560 -->
<!-- npu="910" id2561 -->
- Atlas training products: Supported
<!-- end id2561 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id8 -->

### Description

Records the end time of the time span of an event occurrence for msproftx.

After this API is called, profiling automatically records the timestamp of the end of collection in the stamp pointer.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| rangeId | Input | Unique identifier of the msproftx event marker, which is used to distinguish across threads. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API is used in pairs with [aclprofRangeStart](#aclprofRangeStart) to indicate the start and end of a time span.
- This API is called between the [aclprofCreateStamp](#aclprofCreateStamp) API and the [aclprofDestroyStamp](#aclprofDestroyStamp) API.
- This API can be called across threads.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofRangePushEx"></a>

## aclprofRangePushEx

```c
aclError aclprofRangePushEx(aclprofEventAttributes *attr)
```

### Applicable Products

<!-- npu="950" id659 -->
- Ascend 950PR&950DT products: Supported
<!-- end id659 -->
<!-- npu="A3" id660 -->
- Atlas A3 products: Supported
<!-- end id660 -->
<!-- npu="910b" id661 -->
- Atlas A2 products: Supported
<!-- end id661 -->
<!-- npu="310b" id662 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id662 -->
<!-- npu="310p" id663 -->
- Atlas inference products: Supported
<!-- end id663 -->
<!-- npu="910" id664 -->
- Atlas training products: Supported
<!-- end id664 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id9 -->

### Description

In the aclrt and <<<>>> scenarios, the user calls **aclprofRangePushEx** before the operator loading API and then calls **aclprofRangePop** to complete the reporting of profiling data.

After this API is called, profiling caches the tensor information when it determines that the value of **messageType** is **MESSAGE\_TYPE\_TENSOR\_INFO**.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| attr | Input | Tensor information to be reported. For details about the structure, see [aclprofEventAttributes](25-02_Enumerations.md#aclprofEventAttributes). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API is used in pairs with [aclprofRangePop](#aclprofRangePop). You need to call **aclprofRangePushEx** first and then **aclprofRangePop**.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofRangePop"></a>

## aclprofRangePop

```c
aclError aclprofRangePop()
```

### Applicable Products

<!-- npu="950" id2157 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2157 -->
<!-- npu="A3" id2158 -->
- Atlas A3 products: Supported
<!-- end id2158 -->
<!-- npu="910b" id2159 -->
- Atlas A2 products: Supported
<!-- end id2159 -->
<!-- npu="310b" id2160 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2160 -->
<!-- npu="310p" id2161 -->
- Atlas inference products: Supported
<!-- end id2161 -->
<!-- npu="910" id2162 -->
- Atlas training products: Supported
<!-- end id2162 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id10 -->

### Description

In aclrt and <<<>>> scenarios, the user calls **aclprofRangePushEx** before the operator loading API and then calls **aclprofRangePop** to complete the reporting of profiling data.

After this API is called, profiling reports the cached tensor information.

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API is used in pairs with [aclprofRangePushEx](#aclprofRangePushEx). You need to call **aclprofRangePushEx** first and then **aclprofRangePop**.

<br>
<br>
<br>

<a class="method_anchor" id="aclprofDestroyStamp"></a>

## aclprofDestroyStamp

```c
void aclprofDestroyStamp(void *stamp)
```

### Applicable Products

<!-- npu="950" id1282 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1282 -->
<!-- npu="A3" id1283 -->
- Atlas A3 products: Supported
<!-- end id1283 -->
<!-- npu="910b" id1284 -->
- Atlas A2 products: Supported
<!-- end id1284 -->
<!-- npu="310b" id1285 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1285 -->
<!-- npu="310p" id1286 -->
- Atlas inference products: Supported
<!-- end id1286 -->
<!-- npu="910" id1287 -->
- Atlas training products: Supported
<!-- end id1287 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id11 -->

### Description

Destroys the event marker for msproftx.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stamp | Input | Stamp pointer, referring to the msproftx event marker.<br>Specify the pointer of the [aclprofCreateStamp](#aclprofCreateStamp) API. |

### Return Values

None

### Constraints

This API is used in pairs with the [aclprofCreateStamp](#aclprofCreateStamp) API, and must be called before the [aclprofStop](19-01_data_profiling_apis.md#aclprofStop) API.

<a class="method_anchor" id="aclprofStr2Id"></a>

## aclprofStr2Id

```c
uint64_t aclprofStr2Id(const char *message)
```

### Applicable Products

<!-- npu="950" id3452 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3452 -->
<!-- npu="A3" id3453 -->
- Atlas A3 products: Supported
<!-- end id3453 -->
<!-- npu="910b" id3454 -->
- Atlas A2 products: Supported
<!-- end id3454 -->
<!-- npu="310b" id3455 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3455 -->
<!-- npu="310p" id3456 -->
- Atlas inference products: Supported
<!-- end id3456 -->
<!-- npu="910" id3457 -->
- Atlas training products: Supported
<!-- end id3457 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-02_msproftx_extension_apis_res.md#id12 -->
### Description

Converts a string into a hash ID for msproftx.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| message | Input | Character information, for example, the operator name. |

### Return Values

Returns the hash ID. If the return value is the maximum value of the uint64\_t type, the operation fails; otherwise, the operation is successful.

### Constraints

This API is used in conjunction with [aclprofRangePushEx](19-02_msproftx_extension_apis.md#aclprofRangePushEx) and [aclprofRangePop](19-02_msproftx_extension_apis.md#aclprofRangePop), and must be called before the [aclprofRangePushEx](19-02_msproftx_extension_apis.md#aclprofRangePushEx) API.
