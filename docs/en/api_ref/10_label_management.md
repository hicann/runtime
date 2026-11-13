# 10. Label Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-23T11:56:15.686Z pushedAt=2026-10-26T02:15:00.762Z -->

This topic describes the label management APIs of CANN Runtime, which are used to create, set, and destroy labels as well as control conditional branches.

- [`aclError aclrtCreateLabel(aclrtLabel *label)`](#aclrtCreateLabel): Creates a label. Up to 65,535 labels can be created for each process.
- [`aclError aclrtSetLabel(aclrtLabel label, aclrtStream stream)`](#aclrtSetLabel): Sets a label on a stream.
- [`aclError aclrtDestroyLabel(aclrtLabel label)`](#aclrtDestroyLabel): Destroys a label.
- [`aclError aclrtCreateLabelList(aclrtLabel *labels, size_t num, aclrtLabelList *labelList)`](#aclrtCreateLabelList): Creates a label list.
- [`aclError aclrtDestroyLabelList(aclrtLabelList labelList)`](#aclrtDestroyLabelList): Destroys a label list.
- [`aclError aclrtSwitchLabelByIndex(void *ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream)`](#aclrtSwitchLabelByIndex): Switches to the corresponding label position based on the label index, executes the tasks on the stream where the label resides, and stops the tasks on the current stream. This is an asynchronous API.

<a class="method_anchor" id="aclrtCreateLabel"></a>

## aclrtCreateLabel

```c
aclError aclrtCreateLabel(aclrtLabel *label)
```

### Applicable Products

<!-- npu="950" id484 -->
- Ascend 950PR&950DT products: Supported
<!-- end id484 -->
<!-- npu="A3" id485 -->
- Atlas A3 products: Supported
<!-- end id485 -->
<!-- npu="910b" id486 -->
- Atlas A2 products: Supported
<!-- end id486 -->
<!-- npu="310b" id487 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id487 -->
<!-- npu="310p" id488 -->
- Atlas inference products: Supported
<!-- end id488 -->
<!-- npu="910" id489 -->
- Atlas training products: Supported
<!-- end id489 -->
<!-- @ref: runtime/res/docs/zh/api_ref/10_label_management_res.md#id1 -->

### Description

Creates a label. Up to 65,535 labels can be created for each process.

After creating a label with this API, use it together with the [aclrtCreateLabelList](#aclrtCreateLabelList) API (create a label list), the [aclrtSetLabel](#aclrtSetLabel) API (set a label on a stream), and the [aclrtSwitchLabelByIndex](#aclrtSwitchLabelByIndex) API (switch to a specified stream) in sequence to implement switching between streams.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| label | Output | Pointer to the label. For details about the type definition, see [aclrtLabel](25-05_Typedefs.md#aclrtLabel). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetLabel"></a>

## aclrtSetLabel

```c
aclError aclrtSetLabel(aclrtLabel label, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id386 -->
- Ascend 950PR&950DT products: Supported
<!-- end id386 -->
<!-- npu="A3" id387 -->
- Atlas A3 products: Supported
<!-- end id387 -->
<!-- npu="910b" id388 -->
- Atlas A2 products: Supported
<!-- end id388 -->
<!-- npu="310b" id389 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id389 -->
<!-- npu="310p" id390 -->
- Atlas inference products: Supported
<!-- end id390 -->
<!-- npu="910" id391 -->
- Atlas training products: Supported
<!-- end id391 -->
<!-- @ref: runtime/res/docs/zh/api_ref/10_label_management_res.md#id2 -->

### Description

Sets a label on a stream.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| label | Input | Label. For details about the type definition, see [aclrtLabel](25-05_Typedefs.md#aclrtLabel).<br>The label created by the **aclrtCreateLabel** API is used as the input here. |
| stream | Input | Stream on which the label is to be set. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>Only streams bound to a model running instance through the [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream) API are supported here. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyLabel"></a>

## aclrtDestroyLabel

```c
aclError aclrtDestroyLabel(aclrtLabel label)
```

### Applicable Products

<!-- npu="950" id2185 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2185 -->
<!-- npu="A3" id2186 -->
- Atlas A3 products: Supported
<!-- end id2186 -->
<!-- npu="910b" id2187 -->
- Atlas A2 products: Supported
<!-- end id2187 -->
<!-- npu="310b" id2188 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2188 -->
<!-- npu="310p" id2189 -->
- Atlas inference products: Supported
<!-- end id2189 -->
<!-- npu="910" id2190 -->
- Atlas training products: Supported
<!-- end id2190 -->
<!-- @ref: runtime/res/docs/zh/api_ref/10_label_management_res.md#id3 -->

### Description

Destroys a label.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| label | Input | Label created through the [aclrtCreateLabel](#aclrtCreateLabel) interface. For details about the type definition, see [aclrtLabel](25-05_Typedefs.md#aclrtLabel). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCreateLabelList"></a>

## aclrtCreateLabelList

```c
aclError aclrtCreateLabelList(aclrtLabel *labels, size_t num, aclrtLabelList *labelList)
```

### Applicable Products

<!-- npu="950" id1611 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1611 -->
<!-- npu="A3" id1612 -->
- Atlas A3 products: Supported
<!-- end id1612 -->
<!-- npu="910b" id1613 -->
- Atlas A2 products: Supported
<!-- end id1613 -->
<!-- npu="310b" id1614 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1614 -->
<!-- npu="310p" id1615 -->
- Atlas inference products: Supported
<!-- end id1615 -->
<!-- npu="910" id1616 -->
- Atlas training products: Supported
<!-- end id1616 -->
<!-- @ref: runtime/res/docs/zh/api_ref/10_label_management_res.md#id4 -->

### Description

Creates a label list.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| labels | Input | Label array. For details about the type definition, see [aclrtLabel](25-05_Typedefs.md#aclrtLabel).<br>The labels in the array must be created through the [aclrtCreateLabel](#aclrtCreateLabel) API. |
| num | Input | Length of the label array. The value range is (0, 65535]. |
| labelList | Output | Label list. For details about the type definition, see [aclrtLabelList](25-05_Typedefs.md#aclrtLabelList). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtDestroyLabelList"></a>

## aclrtDestroyLabelList

```c
aclError aclrtDestroyLabelList(aclrtLabelList labelList)
```

### Applicable Products

<!-- npu="950" id1093 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1093 -->
<!-- npu="A3" id1094 -->
- Atlas A3 products: Supported
<!-- end id1094 -->
<!-- npu="910b" id1095 -->
- Atlas A2 products: Supported
<!-- end id1095 -->
<!-- npu="310b" id1096 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1096 -->
<!-- npu="310p" id1097 -->
- Atlas inference products: Supported
<!-- end id1097 -->
<!-- npu="910" id1098 -->
- Atlas training products: Supported
<!-- end id1098 -->
<!-- @ref: runtime/res/docs/zh/api_ref/10_label_management_res.md#id5 -->

### Description

Destroys a label list.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| labelList | Input | Label list created through the API. For details about the type definition, see [aclrtLabelList](25-05_Typedefs.md#aclrtLabelList). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSwitchLabelByIndex"></a>

## aclrtSwitchLabelByIndex

```c
aclError aclrtSwitchLabelByIndex(void *ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id1233 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1233 -->
<!-- npu="A3" id1234 -->
- Atlas A3 products: Supported
<!-- end id1234 -->
<!-- npu="910b" id1235 -->
- Atlas A2 products: Supported
<!-- end id1235 -->
<!-- npu="310b" id1236 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1236 -->
<!-- npu="310p" id1237 -->
- Atlas inference products: Supported
<!-- end id1237 -->
<!-- npu="910" id1238 -->
- Atlas training products: Supported
<!-- end id1238 -->
<!-- @ref: runtime/res/docs/zh/api_ref/10_label_management_res.md#id6 -->

### Description

Switches to the corresponding label position based on the label index, executes the tasks on the stream where the label resides, and stops the tasks on the current stream. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **ptr** | Input | Label index.<br>Device memory address that stores the target label index value. The index value is of the uint32 data type and 4 bytes in length, and the index value starts from 0.<br>When the target label index is greater than the maximum index value of the **labelList** array, it switches to the largest label. |
| **maxValue** | Input | Number of labels in the label list. |
| **labelList** | Input | Label list. For details about the type definition, see [aclrtLabelList](25-05_Typedefs.md#aclrtLabelList).<br>The label list created by the [aclrtCreateLabelList](#aclrtCreateLabelList) API is used as the input here. |
| **stream** | Input | Stream that executes the switching task. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
