# 9. CntNotify Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:17:48.377Z pushedAt=2026-11-09T08:17:01.537Z nl=2 -->

This chapter describes the CntNotify (count notify) management APIs of CANN Runtime, which are used to create, record, wait for, and destroy CntNotify.

- [`aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag)`](#aclrtCntNotifyCreate): Creates a CntNotify.
- [`aclError aclrtCntNotifyRecord(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo *info)`](#aclrtCntNotifyRecord): Records a CntNotify on the specified stream. This is an asynchronous API.
- [`aclError aclrtCntNotifyWaitWithTimeout(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo *info)`](#aclrtCntNotifyWaitWithTimeout): Blocks a specified stream until the specified CntNotify completes. This is an asynchronous API.
- [`aclError aclrtCntNotifyReset(aclrtCntNotify cntNotify, aclrtStream stream)`](#aclrtCntNotifyReset): Resets a CntNotify and sets its count value to 0. This is an asynchronous API.
- [`aclError aclrtCntNotifyGetId(aclrtCntNotify cntNotify, uint32_t *notifyId)`](#aclrtCntNotifyGetId): Obtains the ID of a CntNotify.
- [`aclError aclrtCntNotifyDestroy(aclrtCntNotify cntNotify)`](#aclrtCntNotifyDestroy): Destroys a CntNotify.

<a class="method_anchor" id="aclrtCntNotifyCreate"></a>

## aclrtCntNotifyCreate

```c
aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag)
```

### Applicable Products

<!-- npu="950" id1961 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1961 -->
<!-- npu="A3" id1962 -->
- Atlas A3 products: Not supported
<!-- end id1962 -->
<!-- npu="910b" id1963 -->
- Atlas A2 products: Not supported
<!-- end id1963 -->
<!-- npu="310b" id1964 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1964 -->
<!-- npu="310p" id1965 -->
- Atlas inference products: Not supported
<!-- end id1965 -->
<!-- npu="910" id1966 -->
- Atlas training products: Not supported
<!-- end id1966 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id1 -->

### Description

Creates a CntNotify.

CntNotify is also commonly used for status/action communication notifications between devices. However, CntNotify uses a count value to synchronize tasks. Unlike Notify, whose count value supports only a value of 1, CntNotify supports a count value in the range of \[1\–maximum uint32\_t].

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cntNotify | Output | Pointer to the CntNotify. See [aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify) for the type definition. |
| flag | Input | Reserved parameter, currently fixed to 0. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCntNotifyRecord"></a>

## aclrtCntNotifyRecord

```c
aclError aclrtCntNotifyRecord(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo *info)
```

### Applicable Products

<!-- npu="950" id3123 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3123 -->
<!-- npu="A3" id3124 -->
- Atlas A3 products: Not supported
<!-- end id3124 -->
<!-- npu="910b" id3125 -->
- Atlas A2 products: Not supported
<!-- end id3125 -->
<!-- npu="310b" id3126 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3126 -->
<!-- npu="310p" id3127 -->
- Atlas inference products: Not supported
<!-- end id3127 -->
<!-- npu="910" id3128 -->
- Atlas training products: Not supported
<!-- end id3128 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id2 -->

### Description

Records a CntNotify on the specified stream. This is an asynchronous API.

When used together with aclrtCntNotifyWaitWithTimeout, aclrtCntNotifyRecord is mainly used for synchronous wait across multiple streams.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cntNotify | Input | CntNotify to be recorded. See [aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify) for the type definition. |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>If using the default stream, set this to NULL.<br>In a multi-stream synchronous wait scenario, for example, when Stream2 waits for Stream1, set this to Stream1. |
| info | Input | Controls the behavior of Record. See [aclrtCntNotifyRecordInfo](25-04_Structs.md#aclrtCntNotifyRecordInfo) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCntNotifyWaitWithTimeout"></a>

## aclrtCntNotifyWaitWithTimeout

```c
aclError aclrtCntNotifyWaitWithTimeout(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo *info)
```

### Applicable Products

<!-- npu="950" id2199 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2199 -->
<!-- npu="A3" id2200 -->
- Atlas A3 products: Not supported
<!-- end id2200 -->
<!-- npu="910b" id2201 -->
- Atlas A2 products: Not supported
<!-- end id2201 -->
<!-- npu="310b" id2202 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2202 -->
<!-- npu="310p" id2203 -->
- Atlas inference products: Not supported
<!-- end id2203 -->
<!-- npu="910" id2204 -->
- Atlas training products: Not supported
<!-- end id2204 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id3 -->

### Description

Blocks the specified stream until the specified CntNotify completes. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cntNotify | Input | CntNotify to wait for. See [aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify) for the type definition. |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>If using the default stream, set this to NULL.<br>In a multi-stream synchronous wait scenario, for example, when Stream2 waits for Stream1, set this to Stream2. |
| info | Input | Controls the behavior of Wait. See [aclrtCntNotifyWaitInfo](25-04_Structs.md#aclrtCntNotifyWaitInfo) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCntNotifyReset"></a>

## aclrtCntNotifyReset

```c
aclError aclrtCntNotifyReset(aclrtCntNotify cntNotify, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2045 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2045 -->
<!-- npu="A3" id2046 -->
- Atlas A3 products: Not supported
<!-- end id2046 -->
<!-- npu="910b" id2047 -->
- Atlas A2 products: Not supported
<!-- end id2047 -->
<!-- npu="310b" id2048 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2048 -->
<!-- npu="310p" id2049 -->
- Atlas inference products: Not supported
<!-- end id2049 -->
<!-- npu="910" id2050 -->
- Atlas training products: Not supported
<!-- end id2050 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id4 -->

### Description

Resets a CntNotify and sets its count value to 0. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cntNotify | Input | CntNotify to be reset. See [aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify) for the type definition. |
| stream | Input | Specified stream. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>If using the default stream, set this to NULL.<br>In the scenario of synchronous wait across multiple streams, for example, when Stream2 waits for Stream1, set this to Stream2. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCntNotifyGetId"></a>

## aclrtCntNotifyGetId

```c
aclError aclrtCntNotifyGetId(aclrtCntNotify cntNotify, uint32_t *notifyId)
```

### Applicable Products

<!-- npu="950" id358 -->
- Ascend 950PR&950DT products: Supported
<!-- end id358 -->
<!-- npu="A3" id359 -->
- Atlas A3 products: Not supported
<!-- end id359 -->
<!-- npu="910b" id360 -->
- Atlas A2 products: Not supported
<!-- end id360 -->
<!-- npu="310b" id361 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id361 -->
<!-- npu="310p" id362 -->
- Atlas inference products: Not supported
<!-- end id362 -->
<!-- npu="910" id363 -->
- Atlas training products: Not supported
<!-- end id363 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id5 -->

### Description

Obtains the ID of a CntNotify.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cntNotify | Input | CntNotify to be obtained. See [aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify) for the type definition. |
| notifyId | Output | CntNotify ID. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCntNotifyDestroy"></a>

## aclrtCntNotifyDestroy

```c
aclError aclrtCntNotifyDestroy(aclrtCntNotify cntNotify)
```

### Applicable Products

<!-- npu="950" id1058 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1058 -->
<!-- npu="A3" id1059 -->
- Atlas A3 products: Not supported
<!-- end id1059 -->
<!-- npu="910b" id1060 -->
- Atlas A2 products: Not supported
<!-- end id1060 -->
<!-- npu="310b" id1061 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1061 -->
<!-- npu="310p" id1062 -->
- Atlas inference products: Not supported
<!-- end id1062 -->
<!-- npu="910" id1063 -->
- Atlas training products: Not supported
<!-- end id1063 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id6 -->

### Description

Destroys a CntNotify.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cntNotify | Input | CntNotify to be destroyed. See [aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).
