# 11-06 CMO Cache Operations

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:21:49.033Z pushedAt=2026-11-09T08:39:56.721Z nl=2 -->

This chapter describes the cache maintenance operations (CMO) APIs, which are used for cache refresh and invalidation operations.

- [`aclError aclrtCmoAsync(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)`](#aclrtCmoAsync): Performs cache memory operations on the device. This is an asynchronous API.
- [`aclError aclrtCmoAsyncWithBarrier(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId, aclrtStream stream)`](#aclrtCmoAsyncWithBarrier): Performs cache memory operations on the device and carries a `barrierId`, which indicates the barrier identifier of the cache memory operation. This is an asynchronous API.
- [`aclError aclrtCmoWaitBarrier(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)`](#aclrtCmoWaitBarrier): Waits for the Invalid memory operation task with the specified `barrierId` to complete. This is an asynchronous API.
- [`aclError aclrtCmoGetDescSize(size_t *size)`](#aclrtCmoGetDescSize): Obtains the memory size occupied by the cache memory descriptor on the current device.
- [`aclError aclrtCmoSetDesc(void *cmoDesc, void *src, size_t size)`](#aclrtCmoSetDesc): Sets the cache memory descriptor. After this API is called, the source memory address and memory size are recorded in the cache memory descriptor.
- [`aclError aclrtCmoAsyncWithDesc(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)`](#aclrtCmoAsyncWithDesc): Uses the memory descriptor (second-level pointer method) to operate on the cache memory on the device. This is an asynchronous API.

<a class="method_anchor" id="aclrtCmoAsync"></a>

## aclrtCmoAsync

```c
aclError aclrtCmoAsync(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3081 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3081 -->
<!-- npu="A3" id3082 -->
- Atlas A3 products: Supported
<!-- end id3082 -->
<!-- npu="910b" id3083 -->
- Atlas A2 products: Supported
<!-- end id3083 -->
<!-- npu="310b" id3084 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3084 -->
<!-- npu="310p" id3085 -->
- Atlas inference products: Not supported
<!-- end id3085 -->
<!-- npu="910" id3086 -->
- Atlas training products: Not supported
<!-- end id3086 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id1 -->

### Description

Performs cache memory operations on the device. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| src | Input | Device memory address to be operated on.<br>Only cache memory operations on the current device are supported. |
| size | Input | Size of the device memory to be operated on, in bytes. |
| cmoType | Input | Cache memory operation type. See [aclrtCmoType](25-02_Enumerations.md#aclrtCmoType) for the type definition.<br>Currently, only `ACL_RT_CMO_TYPE_PREFETCH` (memory prefetch) is supported. |
| stream | Input | Stream for executing the memory operation task. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCmoAsyncWithBarrier"></a>

## aclrtCmoAsyncWithBarrier

```c
aclError aclrtCmoAsyncWithBarrier(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3480 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3480 -->
<!-- npu="A3" id3481 -->
- Atlas A3 products: Not supported
<!-- end id3481 -->
<!-- npu="910b" id3482 -->
- Atlas A2 products: Not supported
<!-- end id3482 -->
<!-- npu="310b" id3483 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3483 -->
<!-- npu="310p" id3484 -->
- Atlas inference products: Not supported
<!-- end id3484 -->
<!-- npu="910" id3485 -->
- Atlas training products: Not supported
<!-- end id3485 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id2 -->

### Description

Performs cache memory operations on the device and carries a `barrierId`, which indicates the barrier identifier of the cache memory operation. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| src | Input | Device memory address to be operated on.<br>Only cache memory operations on the current device are supported. |
| size | Input | Size of the device memory to be operated on, in bytes. |
| cmoType | Input | Cache memory operation type. See [aclrtCmoType](25-02_Enumerations.md#aclrtCmoType) for the type definition. |
| barrierId | Input | Barrier identifier.<br>When `cmoType` is `ACL_RT_CMO_TYPE_INVALID`, `barrierId` takes effect and supports values greater than 0. It is used together with [aclrtCmoWaitBarrier](#aclrtCmoWaitBarrier) to wait for the completion of the Invalid memory operation task with the specified `barrierId`. When `cmoType` is any other value, `barrierId` is fixed to `0`. |
| stream | Input | Stream on which the memory operation task is executed. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>Only a stream bound to a model is supported here. To bind a model to a stream, call [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream). |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCmoWaitBarrier"></a>

## aclrtCmoWaitBarrier

```c
aclError aclrtCmoWaitBarrier(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)
```

### Applicable Products

<!-- npu="950" id1086 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1086 -->
<!-- npu="A3" id1087 -->
- Atlas A3 products: Not supported
<!-- end id1087 -->
<!-- npu="910b" id1088 -->
- Atlas A2 products: Not supported
<!-- end id1088 -->
<!-- npu="310b" id1089 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1089 -->
<!-- npu="310p" id1090 -->
- Atlas inference products: Not supported
<!-- end id1090 -->
<!-- npu="910" id1091 -->
- Atlas training products: Not supported
<!-- end id1091 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id3 -->

### Description

Waits for the Invalid memory operation task with the specified `barrierId` to complete. This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| taskInfo | Input | Task information of the cache memory operation. See [aclrtBarrierTaskInfo](25-04_Structs.md#aclrtBarrierTaskInfo) for the type definition.<br>The `cmoType` in the task information currently supports only `ACL_RT_CMO_TYPE_INVALID`. |
| stream | Input | Stream for executing the wait task. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition.<br>Only a stream bound to a model is supported here. To bind a model to a stream, call [aclmdlRIBindStream](15_model_running_instance_management.md#aclmdlRIBindStream). |
| flag | Input | Reserved parameter. Currently fixed to `0`. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCmoGetDescSize"></a>

## aclrtCmoGetDescSize

```c
aclError aclrtCmoGetDescSize(size_t *size)
```

### Applicable Products

<!-- npu="950" id2745 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2745 -->
<!-- npu="A3" id2746 -->
- Atlas A3 products: Supported
<!-- end id2746 -->
<!-- npu="910b" id2747 -->
- Atlas A2 products: Supported
<!-- end id2747 -->
<!-- npu="310b" id2748 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2748 -->
<!-- npu="310p" id2749 -->
- Atlas inference products: Not supported
<!-- end id2749 -->
<!-- npu="910" id2750 -->
- Atlas training products: Not supported
<!-- end id2750 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id4 -->

### Description

Obtains the memory size occupied by the cache memory descriptor on the current device.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| size | Output | Size of the cache memory descriptor, in bytes. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCmoSetDesc"></a>

## aclrtCmoSetDesc

```c
aclError aclrtCmoSetDesc(void *cmoDesc, void *src, size_t size)
```

### Applicable Products

<!-- npu="950" id925 -->
- Ascend 950PR&950DT products: Supported
<!-- end id925 -->
<!-- npu="A3" id926 -->
- Atlas A3 products: Supported
<!-- end id926 -->
<!-- npu="910b" id927 -->
- Atlas A2 products: Supported
<!-- end id927 -->
<!-- npu="310b" id928 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id928 -->
<!-- npu="310p" id929 -->
- Atlas inference products: Not supported
<!-- end id929 -->
<!-- npu="910" id930 -->
- Atlas training products: Not supported
<!-- end id930 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id5 -->

### Description

Sets the cache memory descriptor. After this API is called, the source memory address and memory size are recorded in the cache memory descriptor.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cmoDesc | Input | Pointer to the cache memory descriptor address.<br>Call aclrtCmoGetDescSize to obtain the memory size required by the cache memory descriptor, allocate device memory (for example, using aclrtMalloc), and then pass the device memory address as the input parameter here. |
| src | Input | Device memory address to be operated on.<br>Only cache memory operations on the current device are supported. |
| size | Input | Size of the device memory to be operated on, in bytes. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCmoAsyncWithDesc"></a>

## aclrtCmoAsyncWithDesc

```c
aclError aclrtCmoAsyncWithDesc(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)
```

### Applicable Products

<!-- npu="950" id2619 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2619 -->
<!-- npu="A3" id2620 -->
- Atlas A3 products: Supported
<!-- end id2620 -->
<!-- npu="910b" id2621 -->
- Atlas A2 products: Supported
<!-- end id2621 -->
<!-- npu="310b" id2622 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2622 -->
<!-- npu="310p" id2623 -->
- Atlas inference products: Not supported
<!-- end id2623 -->
<!-- npu="910" id2624 -->
- Atlas training products: Not supported
<!-- end id2624 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id6 -->

### Description

Performs cache memory operations on the device using a memory descriptor (second-level pointer). This is an asynchronous API.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| cmoDesc | Input | Pointer to the cache memory descriptor address, which is a device-side memory address.<br>Call aclrtCmoSetDesc to set the memory descriptor first, and then pass the address pointer of the memory descriptor as an input parameter to this API. |
| cmoType | Input | Cache memory operation type. See [aclrtCmoType](25-02_Enumerations.md#aclrtCmoType) for the type definition.<br>Currently, only `ACL_RT_CMO_TYPE_PREFETCH` (memory prefetch) is supported. |
| stream | Input | Stream for executing the memory operation task. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |
| reserve | Input | Reserved parameter. Currently, pass NULL. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).
