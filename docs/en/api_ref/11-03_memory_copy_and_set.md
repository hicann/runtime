# 11-03 Memory Copy and Configuration

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-23T11:24:49.306Z pushedAt=2026-10-26T06:01:38.908Z -->

This topic describes the APIs for memory copy and configuration between host and device and between devices.

- [`aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind)`](#aclrtMemcpy): Implements memory copy.
- [`aclError aclrtMemcpyAsync(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsync): Implements memory copy.
- [`aclError aclrtMemcpyAsyncWithCondition(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsyncWithCondition): Implements memory copy. (This API is deprecated. Use the **aclrtMemcpyAsync** API instead.)
- [`aclError aclrtMemcpyBatch(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex)`](#aclrtMemcpyBatch): Implements batch memory copy.
- [`aclError aclrtMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex, aclrtStream stream)`](#aclrtMemcpyBatchAsync): Implements batch memory copy.
- [`aclError aclrtMemcpyBatchV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs)`](#aclrtMemcpyBatchV2): Implements batch memory copy.
- [`aclError aclrtMemcpyBatchAsyncV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, aclrtStream stream)`](#aclrtMemcpyBatchAsyncV2): Implements batch memory copy.
- [`aclError aclrtMemcpy2d(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)`](#aclrtMemcpy2d): Implements synchronous memory copy, mainly used for copying cube data.
- [`aclError aclrtMemcpy2dAsync(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpy2dAsync): Implements asynchronous memory copy, mainly used for copying cube data. This is an asynchronous API.
- [`aclError aclrtGetMemcpyDescSize(aclrtMemcpyKind kind, size_t *descSize)`](#aclrtGetMemcpyDescSize): Obtains the memory size occupied by the memory copy descriptor on the current device.
- [`aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)`](#aclrtSetMemcpyDesc): Sets the memory copy descriptor. After this API is called, the source address, destination address, and memory copy length are recorded in the memory copy descriptor.
- [`aclError aclrtMemcpyAsyncWithDesc(void *desc, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsyncWithDesc): Uses the memory copy descriptor (second-level pointer mode) to perform memory copy. This is an asynchronous API.
- [`aclError aclrtMemcpyAsyncWithOffset(void **dst, size_t destMax, size_t dstDataOffset, const void **src, size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsyncWithOffset): Implements memory copy, applicable to scenarios where the base address is a second-level pointer and has an address offset. This is an asynchronous API.
- [`aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count)`](#aclrtMemset): Initializes memory and sets the content in memory as the specified value.
- [`aclError aclrtMemsetAsync(void *devPtr, size_t maxCount, int32_t value, size_t count, aclrtStream stream)`](#aclrtMemsetAsync): Initializes memory and sets the content in memory as the specified value. This is an asynchronous API.
- [`aclError aclrtMemsetD32(void *ptr, size_t memSize, uint32_t value, size_t N)`](#aclrtMemsetD32): Initializes memory and sets the content in memory as the specified 32-bit unsigned integer value, filled by element.
- [`aclError aclrtMemsetD32Async(void *ptr, size_t memSize, uint32_t value, size_t N, aclrtStream stream)`](#aclrtMemsetD32Async): Initializes memory and sets the content in memory as the specified 32-bit unsigned integer value. This is an asynchronous API.

<a class="method_anchor" id="aclrtMemcpy"></a>

## aclrtMemcpy

```c
aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id1331 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1331 -->
<!-- npu="A3" id1332 -->
- Atlas A3 products: Supported
<!-- end id1332 -->
<!-- npu="910b" id1333 -->
- Atlas A2 products: Supported
<!-- end id1333 -->
<!-- npu="310b" id1334 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1334 -->
<!-- npu="310p" id1335 -->
- Atlas inference products: Supported
<!-- end id1335 -->
<!-- npu="910" id1336 -->
- Atlas training products: Supported
<!-- end id1336 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id1 -->

### Description

Implements memory copy.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Pointer to the destination memory address. |
| destMax | Input | Maximum memory length of the destination address, in bytes. |
| src | Input | Pointer to the source memory address. |
| count | Input | Length of the memory copy, in bytes. |
| kind | Input | Type of the memory copy. This is a reserved parameter. The value configured in the enumeration is invalid. The system internally determines, based on the source memory address pointer and the destination memory address pointer, whether the data at the source address can be copied to the destination address. If it cannot, the system returns an error.<br>For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API performs memory copy immediately, and no implicit device synchronization or stream synchronization is performed inside the function.
<!-- npu="950,910b,910,310p" id1 -->
- To perform memory copy between two devices, first call the [aclrtDeviceCanAccessPeer](04_device_management.md#aclrtDeviceCanAccessPeer) API to query whether data exchange is supported between the two devices, call the [aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess) API to enable data exchange between the two devices, and then call this API to perform memory copy.

    **These constraints apply to the following models:**

    <!-- npu="950" id2 -->
    Ascend 950PR&950DT products
    <!-- end id2 -->

    <!-- npu="910b" id3 -->
    Atlas A2 products
    <!-- end id3 -->

    <!-- npu="310p" id4 -->
    Atlas inference products
    <!-- end id4 -->

    <!-- npu="910" id5 -->
    Atlas training products
    <!-- end id5 -->
<!-- end id1 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyAsync"></a>

## aclrtMemcpyAsync

```c
aclError aclrtMemcpyAsync(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2731 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2731 -->
<!-- npu="A3" id2732 -->
- Atlas A3 products: Supported
<!-- end id2732 -->
<!-- npu="910b" id2733 -->
- Atlas A2 products: Supported
<!-- end id2733 -->
<!-- npu="310b" id2734 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2734 -->
<!-- npu="310p" id2735 -->
- Atlas inference products: Supported
<!-- end id2735 -->
<!-- npu="910" id2736 -->
- Atlas training products: Supported
<!-- end id2736 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id2 -->

### Description

Implements memory copy.

The host memory in this API supports page-locked memory (such as the memory requested through the **aclrtMallocHost** API) and non-page-locked memory (memory requested through the **malloc** API). When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been dispatched, not that the task has been executed. After calling this API, you need to call a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed. When the host memory is non-page-locked memory, this API returns only after the memory copy task is completed.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Pointer to the destination memory address. |
| destMax | Input | Maximum memory length of the destination memory address, in bytes. |
| src | Input | Pointer to the source memory address. |
| count | Input | Length of the memory copy, in bytes. |
| kind | Input | Type of the memory copy. For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind). |
| stream | Input | Stream on which the memory copy task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="950,A3,910b,910,310p,310b" id6 -->
- In the Ascend EP form, this API does not support asynchronous memory copy within the host. If the value of **kind** passed is **ACL\_MEMCPY\_HOST\_TO\_HOST**, the API returns the error **ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT**.
<!-- end id6 -->
<!-- npu="310b" id7 -->
- In the Ascend RC form, when an application runs on the board, if the value of **kind** passed to this API is **ACL\_MEMCPY\_HOST\_TO\_DEVICE**, **ACL\_MEMCPY\_DEVICE\_TO\_HOST**, or **ACL\_MEMCPY\_HOST\_TO\_HOST**, the system internally uses **ACL\_MEMCPY\_DEVICE\_TO\_DEVICE** by default to perform memory copy within the device.
<!-- end id7 -->
<!-- npu="310p" id8 -->
- In the control CPU open form, when an application runs on the device, if the value of **kind** passed to this API is **ACL\_MEMCPY\_HOST\_TO\_DEVICE**, **ACL\_MEMCPY\_DEVICE\_TO\_HOST**, or **ACL\_MEMCPY\_HOST\_TO\_HOST**, the system internally uses **ACL\_MEMCPY\_DEVICE\_TO\_DEVICE** by default to perform memory copy within the device.
<!-- end id8 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id18 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyAsyncWithCondition"></a>

## aclrtMemcpyAsyncWithCondition (Deprecated)

```c
aclError aclrtMemcpyAsyncWithCondition(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)
```

**Caution: This API will be deprecated in later versions. Use the [aclrtMemcpyAsync](#aclrtMemcpyAsync) API instead.**

### Applicable Products

<!-- npu="950" id3494 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3494 -->
<!-- npu="A3" id3495 -->
- Atlas A3 products: Supported
<!-- end id3495 -->
<!-- npu="910b" id3496 -->
- Atlas A2 products: Supported
<!-- end id3496 -->
<!-- npu="310b" id3497 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3497 -->
<!-- npu="310p" id3498 -->
- Atlas inference products: Supported
<!-- end id3498 -->
<!-- npu="910" id3499 -->
- Atlas training products: Supported
<!-- end id3499 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id3 -->

### Description

Implements memory copy.

The host memory in this API supports page-locked memory (such as the memory requested through the **aclrtMallocHost** API) and non-page-locked memory (memory requested through the **malloc** API). When the host memory is non-page-locked, this API returns only after the memory copy task is complete. When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been dispatched, not that the task has been executed. After calling this API, call a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Pointer to the destination memory address. |
| destMax | Input | Maximum memory length of the destination memory address, in bytes. |
| src | Input | Pointer to the source memory address. |
| count | Input | Length of the memory copy, in bytes. |
| kind | Input | Type of the memory copy. For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind). |
| stream | Input | Stream on which the memory copy task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

<!-- npu="950,A3,910b,910,310p,310b" id9 -->
- In the Ascend EP form, this API does not support asynchronous memory copy within the host. If the value of **kind** passed is **ACL\_MEMCPY\_HOST\_TO\_HOST**, the API returns the error **ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT**.
<!-- end id9 -->
<!-- npu="310b" id10 -->
- In the Ascend RC form, when an application runs on the board, if the value of **kind** passed to this API is **ACL\_MEMCPY\_HOST\_TO\_DEVICE**, **ACL\_MEMCPY\_DEVICE\_TO\_HOST**, or **ACL\_MEMCPY\_HOST\_TO\_HOST**, the system internally uses **ACL\_MEMCPY\_DEVICE\_TO\_DEVICE** by default to perform memory copy within the device.
<!-- end id10 -->
<!-- npu="310p" id11 -->
- In the control CPU open form, when an application runs on the device, if the value of **kind** passed to this API is **ACL\_MEMCPY\_HOST\_TO\_DEVICE**, **ACL\_MEMCPY\_DEVICE\_TO\_HOST**, or **ACL\_MEMCPY\_HOST\_TO\_HOST**, the system internally uses **ACL\_MEMCPY\_DEVICE\_TO\_DEVICE** by default to perform memory copy within the device.
<!-- end id11 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id19 -->

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyBatch"></a>

## aclrtMemcpyBatch

```c
aclError aclrtMemcpyBatch(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex)
```

### Applicable Products

<!-- npu="950" id3382 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3382 -->
<!-- npu="A3" id3383 -->
- Atlas A3 products: Supported
<!-- end id3383 -->
<!-- npu="910b" id3384 -->
- Atlas A2 products: Supported
<!-- end id3384 -->
<!-- npu="310b" id3385 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3385 -->
<!-- npu="310p" id3386 -->
- Atlas inference products: Not supported
<!-- end id3386 -->
<!-- npu="910" id3387 -->
- Atlas training products: Not supported
<!-- end id3387 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id4 -->

### Description

Implements batch memory copy.

The host memory in this API supports page-locked memory (such as the memory requested through the **aclrtMallocHost** API) and non-page-locked memory (memory requested through the **malloc** API).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dsts | Input | Array of destination memory addresses. |
| destMaxs | Input | Array of maximum memory copy lengths, used to store the maximum length of each memory segment to be copied, in bytes. |
| srcs | Input | Array of source memory addresses. |
| sizes | Input | Array of memory copy lengths, used to store the size of each memory segment to be copied, in bytes. |
| numBatches | Input | Length of the **dsts**, **srcs**, and **sizes** arrays. |
| attrs | Input | Array of memory copy attributes. For details about the type definition, see [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr). |
| attrsIndexes | Input | Array of memory copy attribute indexes, used to specify the copy range to which each entry in the **attrs** array applies. The attributes specified in **attrs[k]** apply to the copy operations from **attrsIndexes[k]** to **attrsIndexes[k+1]** - 1, and the attributes in **attrs[numAttrs-1]** apply to the copy operations from **attrsIndexes[numAttrs-1]** to **numBatches** - 1. |
| numAttrs | Input | Length of the **attrs** and **attrsIndexes** arrays. |
| failIndex | Output | Index of the copy item where an error occurs (only memory attributes and copy directions are validated). If the error does not involve a specific copy operation, this value is **SIZE_MAX**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Memory copies within a batch are unordered and are not performed in the order of the elements in the array.
- The data specified in **srcs** is copied to the memory areas specified in **dsts**. The size of each copy operation is specified by **sizes**. The **dsts**, **srcs**, and **sizes** arrays must have the same length specified by **numBatches**.
- Each copy operation in the batch must be associated with the attribute set specified in the **attrs** array. Each entry in the **attrs** array can be applied to multiple copy operations, with the start copy index at which the corresponding attribute entry takes effect specified by the **attrsIndexes** array. The **attrs** and **attrsIndexes** arrays must have the same length specified by **numAttrs**. For example, if a batch contains 10 copy operations listed in **dsts**/**srcs**/**sizes**, where the first 6 use one set of attributes and the last 4 use another set of attributes, the value of **numAttrs** is **2**, the value of **attrsIndexes** is **\{0,6\}**, and **attrs** contains two sets of attributes. Note that the first entry of **attrsIndexes** must be 0, each entry must be greater than the previous entry, and the last entry must be less than **numBatches**. In addition, **numAttrs** must be less than or equal to **numBatches**.
- The direction of batch memory copy supports only one of host-to-device or device-to-host copy.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyBatchAsync"></a>

## aclrtMemcpyBatchAsync

```c
aclError aclrtMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2080 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2080 -->
<!-- npu="A3" id2081 -->
- Atlas A3 products: Supported
<!-- end id2081 -->
<!-- npu="910b" id2082 -->
- Atlas A2 products: Supported
<!-- end id2082 -->
<!-- npu="310b" id2083 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2083 -->
<!-- npu="310p" id2084 -->
- Atlas inference products: Not supported
<!-- end id2084 -->
<!-- npu="910" id2085 -->
- Atlas training products: Not supported
<!-- end id2085 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id5 -->

### Description

Implements batch memory copy.

The host memory in this API supports page-locked memory (such as the memory requested through the **aclrtMallocHost** API) and non-page-locked memory (memory requested through the **malloc** API). When the host memory is non-page-locked memory, this API returns only after the memory copy task is complete. When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been dispatched, not that the task has been executed. After calling this API, call a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed.

### Parameter

| Name | Input/Output | Description |
| --- | :---: | --- |
| dsts | Input | Array of destination memory addresses. |
| destMaxs | Input | Array of maximum memory copy lengths, used to store the maximum length of each memory segment to be copied, in bytes. |
| srcs | Input | Array of source memory addresses. |
| sizes | Input | Array of memory copy lengths, used to store the size of each memory segment to be copied, in bytes. |
| numBatches | Input | Length of the **dsts**, **srcs**, and **sizes** arrays. |
| attrs | Input | Array of memory copy attributes. For details about the type definition, see [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr). |
| attrsIndexes | Input | Array of memory copy attribute indexes, used to specify the copy range to which each entry in the **attrs** array applies. The attributes specified in **attrs[k]** apply to the copy operations from **attrsIndexes[k]** to **attrsIndexes[k+1]** - 1, and the attributes in **attrs[numAttrs-1]** apply to the copy operations from **attrsIndexes[numAttrs-1]** to **numBatches** - 1. |
| numAttrs | Input | Length of the **attrs** and **attrsIndexes** arrays. |
| failIndex | Output | Index of the copy item where an error occurs (only memory attributes and copy directions are validated). If the error does not involve a specific copy operation, this value is **SIZE_MAX**. |
| stream | Input | Stream on which the memory copy task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Memory copies within a batch are unordered and are not performed in the order of the elements in the array.
- The data specified in **srcs** is copied to the memory areas specified in **dsts**. The size of each copy operation is specified by **sizes**. The **dsts**, **srcs**, and **sizes** arrays must have the same length specified by **numBatches**.
- Each copy operation in the batch must be associated with the attribute set specified in the **attrs** array. Each entry in the **attrs** array can be applied to multiple copy operations, with the start copy index at which the corresponding attribute entry takes effect specified by the **attrsIndexes** array. The **attrs** and **attrsIndexes** arrays must have the same length specified by **numAttrs**. For example, if a batch contains 10 copy operations listed in **dsts**/**srcs**/**sizes**, where the first 6 use one set of attributes and the last 4 use another set of attributes, the value of **numAttrs** is **2**, the value of **attrsIndexes** is **\{0,6\}**, and **attrs** contains two sets of attributes. Note that the first entry of **attrsIndexes** must be 0, each entry must be greater than the previous entry, and the last entry must be less than **numBatches**. In addition, **numAttrs** must be less than or equal to **numBatches**.
- The direction of batch memory copy supports only one of host-to-device or device-to-host copy.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyBatchV2"></a>

## aclrtMemcpyBatchV2

```c
aclError aclrtMemcpyBatchV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs)
```

### Applicable Products

<!-- npu="950" id50 -->
- Ascend 950PR&950DT products: Supported
<!-- end id50 -->
<!-- npu="A3" id51 -->
- Atlas A3 products: Supported
<!-- end id51 -->
<!-- npu="910b" id52 -->
- Atlas A2 products: Supported
<!-- end id52 -->
<!-- npu="310b" id53 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id53 -->
<!-- npu="310p" id54 -->
- Atlas inference products: Not supported
<!-- end id54 -->
<!-- npu="910" id55 -->
- Atlas training products: Not supported
<!-- end id55 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id6 -->

### Description

Implements batch memory copy.

The host memory in this API supports page-locked memory (such as the memory requested through the **aclrtMallocHost** API) and non-page-locked memory (memory requested through the **malloc** API).

Compared with the [aclrtMemcpyBatch](#aclrtMemcpyBatch) API, this API no longer returns the index of the failed copy item through the **failIndex** parameter.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dsts | Input | Array of destination memory addresses. |
| destMaxs | Input | Array of maximum memory copy lengths, used to store the maximum length of each memory segment to be copied, in bytes. |
| srcs | Input | Array of source memory addresses. |
| sizes | Input | Array of memory copy lengths, used to store the size of each memory segment to be copied, in bytes. |
| numBatches | Input | Length of the **dsts**, **srcs**, and **sizes** arrays. |
| attrs | Input | Array of memory copy attributes. For details about the type definition, see [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr). |
| attrsIndexes | Input | Array of memory copy attribute indexes, used to specify the copy range to which each entry in the **attrs** array applies. The attributes specified in **attrs[k]** apply to the copy operations from **attrsIndexes[k]** to **attrsIndexes[k+1]** - 1, and the attributes in **attrs[numAttrs-1]** apply to the copy operations from **attrsIndexes[numAttrs-1]** to **numBatches** - 1. |
| numAttrs | Input | Length of the **attrs** and **attrsIndexes** arrays. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Memory copies within a batch are unordered and are not performed in the order of the elements in the array.
- The data specified in **srcs** is copied to the memory areas specified in **dsts**. The size of each copy operation is specified by **sizes**. The **dsts**, **srcs**, and **sizes** arrays must have the same length specified by **numBatches**.
- Each copy operation in the batch must be associated with an attribute set specified in the **attrs** array. Each entry in the **attrs** array can be applied to multiple copy operations, with the start copy index at which the corresponding attribute entry takes effect specified by the **attrsIndexes** array. The **attrs** and **attrsIndexes** arrays must have the same length specified by **numAttrs**. For example, if a batch contains 10 copy operations listed in **dsts**/**srcs**/**sizes**, where the first 6 use one set of attributes and the last 4 use another set of attributes, the value of **numAttrs** is **2**, the value of **attrsIndexes** is **\{0,6\}**, and **attrs** contains two sets of attributes. Note that the first entry of **attrsIndexes** must be 0, each entry must be greater than the previous entry, and the last entry must be less than **numBatches**. In addition, **numAttrs** must be less than or equal to **numBatches**.
- The direction of batch memory copy supports only one of host-to-device or device-to-host copy.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyBatchAsyncV2"></a>

## aclrtMemcpyBatchAsyncV2

```c
aclError aclrtMemcpyBatchAsyncV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3340 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3340 -->
<!-- npu="A3" id3341 -->
- Atlas A3 products: Supported
<!-- end id3341 -->
<!-- npu="910b" id3342 -->
- Atlas A2 products: Supported
<!-- end id3342 -->
<!-- npu="310b" id3343 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3343 -->
<!-- npu="310p" id3344 -->
- Atlas inference products: Not supported
<!-- end id3344 -->
<!-- npu="910" id3345 -->
- Atlas training products: Not supported
<!-- end id3345 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id7 -->

### Description

Implements batch memory copy.

The host memory in this API supports page-locked memory (such as the memory requested through the **aclrtMallocHost** API) and non-page-locked memory (memory requested through the **malloc** API). When the host memory is non-page-locked memory, this API returns only after the memory copy task is complete. When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been dispatched, not that the task has been executed. After calling this API, call a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed.

Compared with the [aclrtMemcpyBatchAsync](#aclrtMemcpyBatchAsync) API, this API no longer returns the index of the failed copy item through the **failIndex** parameter.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dsts | Input | Array of destination memory addresses. |
| destMaxs | Input | Array of maximum memory copy lengths, used to store the maximum length of each memory segment to be copied, in bytes. |
| srcs | Input | Array of source memory addresses. |
| sizes | Input | Array of memory copy lengths, used to store the size of each memory segment to be copied, in bytes. |
| numBatches | Input | Length of the **dsts**, **srcs**, and **sizes** arrays. |
| attrs | Input | Array of memory copy attributes. For details about the type definition, see [aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr). |
| attrsIndexes | Input | Array of memory copy attribute indexes, used to specify the copy range to which each entry in the **attrs** array applies. The attributes specified in **attrs[k]** apply to the copy operations from **attrsIndexes[k]** to **attrsIndexes[k+1]** - 1, and **attrs[numAttrs-1]** applies to the copy operations from **attrsIndexes[numAttrs-1]** to **numBatches** - 1. |
| numAttrs | Input | Length of the **attrs** and **attrsIndexes** arrays. |
| stream | Input | Stream on which the memory copy task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Memory copies within a batch are unordered and are not performed in the order of the elements in the array.
- The data specified in **srcs** is copied to the memory areas specified in **dsts**. The size of each copy operation is specified by **sizes**. The **dsts**, **srcs**, and **sizes** arrays must have the same length specified by **numBatches**.
- Each copy operation in the batch must be associated with an attribute set specified in the **attrs** array. Each entry in the **attrs** array can be applied to multiple copy operations, with the start copy index at which the corresponding attribute entry takes effect specified by the **attrsIndexes** array. The **attrs** and **attrsIndexes** arrays must have the same length specified by **numAttrs**. For example, if a batch contains 10 copy operations listed in **dsts**/**srcs**/**sizes**, where the first 6 use one set of attributes and the last 4 use another set of attributes, the value of **numAttrs** is **2**, the value of **attrsIndexes** is **\{0,6\}**, and **attrs** contains two sets of attributes. Note that the first entry of **attrsIndexes** must be 0, each entry must be greater than the previous entry, and the last entry must be less than **numBatches**. In addition, **numAttrs** must be less than or equal to **numBatches**.
- The direction of batch memory copy supports only one of host-to-device or device-to-host copy.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpy2d"></a>

## aclrtMemcpy2d

```c
aclError aclrtMemcpy2d(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id1779 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1779 -->
<!-- npu="A3" id1780 -->
- Atlas A3 products: Supported
<!-- end id1780 -->
<!-- npu="910b" id1781 -->
- Atlas A2 products: Supported
<!-- end id1781 -->
<!-- npu="310b" id1782 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1782 -->
<!-- npu="310p" id1783 -->
- Atlas inference products: Supported
<!-- end id1783 -->
<!-- npu="910" id1784 -->
- Atlas training products: Supported
<!-- end id1784 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id8 -->

### Description

Implements synchronous memory copy, mainly used for copying cube data.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Pointer to the destination memory address. |
| dpitch | Input | Address distance between two adjacent column vectors in the destination memory. |
| src | Input | Pointer to the source memory address. |
| spitch | Input | Address distance between two adjacent column vectors in the source memory. |
| width | Input | Width of the data to be copied. |
| height | Input | Height of the data to be copied. |
| kind | Input | Type of memory copy. For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind). |

### Return Value

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Currently, only memory copy of the **ACL\_MEMCPY\_HOST\_TO\_DEVICE** or **ACL\_MEMCPY\_DEVICE\_TO\_HOST** type is supported.
<!-- npu="310p" id12 -->
- For Atlas inference products, this API is not supported in the control CPU open form. In addition, the Atlas inference acceleration module products do not support this API.
<!-- end id12 -->
<!-- npu="310b" id13 -->
- For Atlas 200I/500 A2 inference products, this API is not supported in the Ascend RC form.
<!-- end id13 -->

### Reference Resources

The following figure shows the memory copy diagram of this API.

![](figures/memory_copy_diagram.png)

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpy2dAsync"></a>

## aclrtMemcpy2dAsync

```c
aclError aclrtMemcpy2dAsync(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id1583 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1583 -->
<!-- npu="A3" id1584 -->
- Atlas A3 products: Supported
<!-- end id1584 -->
<!-- npu="910b" id1585 -->
- Atlas A2 products: Supported
<!-- end id1585 -->
<!-- npu="310b" id1586 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1586 -->
<!-- npu="310p" id1587 -->
- Atlas inference products: Supported
<!-- end id1587 -->
<!-- npu="910" id1588 -->
- Atlas training products: Supported
<!-- end id1588 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id9 -->

### Description

Implements asynchronous memory copy, mainly used for copying cube data. This is an asynchronous API.

The host memory in this API supports page-locked memory (such as the memory requested through the **aclrtMallocHost** API) and non-page-locked memory (memory requested through the **malloc** API). When the host memory is non-page-locked memory, this API returns only after the memory copy task is completed. When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been dispatched, not that the task has been executed. After calling this API, call a synchronization wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has been executed.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Pointer to the destination memory address. |
| dpitch | Input | Address distance between two adjacent column vectors in the destination memory. |
| src | Input | Pointer to the source memory address. |
| spitch | Input | Address distance between two adjacent column vectors in the source memory. |
| width | Input | Width of the data to be copied.<br>The maximum value of **width** is **5000000**, and it must be less than or equal to the value of **dpitch** and **spitch**. |
| height | Input | Height of the data to be copied.<br>The maximum value of height is 5 x 1024 x 1024 = 5242880; otherwise, the API returns a failure. |
| kind | Input | Type of memory copy. For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind). |
| stream | Input | Stream on which the memory copy task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Value

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API supports only memory copy of the **ACL\_MEMCPY\_HOST\_TO\_DEVICE**, **ACL\_MEMCPY\_DEVICE\_TO\_HOST**, or **ACL\_MEMCPY\_DEVICE\_TO\_DEVICE** type, and the supported types vary by model. For unsupported memory copy types, the API returns **ACL\_ERROR\_INVALID\_PARAM**.
  
  <!-- npu="950,A3,910b" id14 -->
  Among them, the **ACL\_MEMCPY\_DEVICE\_TO\_DEVICE** type is supported only by Ascend 950PR&950DT products, Atlas A3 products, and Atlas A2 products.
  <!-- end id14 -->

<!-- npu="310p" id15 -->
- For Atlas inference products, this API cannot be called in the control CPU open form. In addition, Atlas inference acceleration module products do not support this API.
<!-- end id15 -->
<!-- npu="310b" id16 -->
- For Atlas 200I/500 A2 inference products, this API cannot be called in the Ascend RC form.
<!-- end id16 -->

### Reference Resources

The following figure shows the memory copy diagram of this API.

![](figures/memory_copy_diagram.png)

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetMemcpyDescSize"></a>

## aclrtGetMemcpyDescSize

```c
aclError aclrtGetMemcpyDescSize(aclrtMemcpyKind kind, size_t *descSize)
```

### Applicable Products

<!-- npu="950" id1814 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1814 -->
<!-- npu="A3" id1815 -->
- Atlas A3 products: Supported
<!-- end id1815 -->
<!-- npu="910b" id1816 -->
- Atlas A2 products: Supported
<!-- end id1816 -->
<!-- npu="310b" id1817 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1817 -->
<!-- npu="310p" id1818 -->
- Atlas inference products: Not supported
<!-- end id1818 -->
<!-- npu="910" id1819 -->
- Atlas training products: Not supported
<!-- end id1819 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id10 -->

### Description

Obtains the memory size occupied by the memory copy descriptor of the current device.

This API must be used together with other key APIs to implement memory copy. For details, see [aclrtMemcpyAsyncWithDesc](#aclrtMemcpyAsyncWithDesc).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| kind | Input | Type of memory copy. For the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind).<br>Currently, only **ACL_MEMCPY_INNER_DEVICE_TO_DEVICE** is supported, which indicates the memory copy within a device. |
| descSize | Output | Memory size, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetMemcpyDesc"></a>

## aclrtSetMemcpyDesc

```c
aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)
```

### Applicable Products

<!-- npu="950" id1128 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1128 -->
<!-- npu="A3" id1129 -->
- Atlas A3 products: Supported
<!-- end id1129 -->
<!-- npu="910b" id1130 -->
- Atlas A2 products: Supported
<!-- end id1130 -->
<!-- npu="310b" id1131 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1131 -->
<!-- npu="310p" id1132 -->
- Atlas inference products: Not supported
<!-- end id1132 -->
<!-- npu="910" id1133 -->
- Atlas training products: Not supported
<!-- end id1133 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id11 -->

### Description

Sets the memory copy descriptor. After this API is called, the source address, destination address, and memory copy length are recorded in the memory copy descriptor.

This API must be used together with other key APIs to implement memory copy. For details, see [aclrtMemcpyAsyncWithDesc](#aclrtMemcpyAsyncWithDesc).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| desc | Output | Pointer to the memory copy descriptor address.<br>Call [aclrtGetMemcpyDescSize](#aclrtGetMemcpyDescSize) first to obtain the memory size required by the memory descriptor, request the device memory (for example, using the **aclrtMalloc** API), and pass the device memory address as the input parameter here. |
| kind | Input | Type of memory copy. For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind).<br>Currently, only **ACL_MEMCPY_INNER_DEVICE_TO_DEVICE** is supported, which indicates the memory copy within a device. |
| srcAddr | Input | Pointer to the source memory address.<br>The memory is requested and managed by the user. |
| dstAddr | Input | Pointer to the destination memory address.<br>The memory is requested and managed by the user. |
| count | Input | Length of the memory copy, in bytes. |
| config | Input | Reserved parameter. Currently, it must be set to **NULL**. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyAsyncWithDesc"></a>

## aclrtMemcpyAsyncWithDesc

```c
aclError aclrtMemcpyAsyncWithDesc(void *desc, aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id3256 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3256 -->
<!-- npu="A3" id3257 -->
- Atlas A3 products: Supported
<!-- end id3257 -->
<!-- npu="910b" id3258 -->
- Atlas A2 products: Supported
<!-- end id3258 -->
<!-- npu="310b" id3259 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3259 -->
<!-- npu="310p" id3260 -->
- Atlas inference products: Not supported
<!-- end id3260 -->
<!-- npu="910" id3261 -->
- Atlas training products: Not supported
<!-- end id3261 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id12 -->

### Description

Performs memory copy by using a memory copy descriptor (second-level pointer method). This is an asynchronous API.

This API must be used together with the following key APIs to implement memory copy:

1. Call [aclrtGetMemcpyDescSize](#aclrtGetMemcpyDescSize) to obtain the memory size required by the memory descriptor.
2. Request the device memory to store the memory descriptor.
3. Request the source memory and destination memory to store the data before and after the copy, respectively.
4. Call [aclrtSetMemcpyDesc](#aclrtSetMemcpyDesc) to set the source memory address, destination memory address, and other information into the memory descriptor.
5. Call **aclrtMemcpyAsyncWithDesc** to implement memory copy.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| desc | Input | Address pointer of the memory copy descriptor, which is a device-side memory address.<br>Here, call [aclrtSetMemcpyDesc](#aclrtSetMemcpyDesc) to set the memory copy descriptor first, and then pass the address pointer of the memory copy descriptor as an input parameter to this API. |
| kind | Input | Type of memory copy. For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind).<br>Currently, only **ACL_MEMCPY_INNER_DEVICE_TO_DEVICE** is supported, indicating the memory copy within a device. |
| stream | Input | Stream on which the memory copy task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Value

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyAsyncWithOffset"></a>

## aclrtMemcpyAsyncWithOffset

```c
aclError aclrtMemcpyAsyncWithOffset(void **dst, size_t destMax, size_t dstDataOffset, const void **src, size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2983 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2983 -->
<!-- npu="A3" id2984 -->
- Atlas A3 products: Supported
<!-- end id2984 -->
<!-- npu="910b" id2985 -->
- Atlas A2 products: Supported
<!-- end id2985 -->
<!-- npu="310b" id2986 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2986 -->
<!-- npu="310p" id2987 -->
- Atlas inference products: Not supported
<!-- end id2987 -->
<!-- npu="910" id2988 -->
- Atlas training products: Supported
<!-- end id2988 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id13 -->

### Description

Implements memory copy, suitable for scenarios where the base address is a second-level pointer and has an address offset. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Pointer to the destination memory address. |
| destMax | Input | Maximum memory length of the destination memory address, in bytes. |
| dstDataOffset | Input | Destination memory address offset. |
| src | Input | Pointer to the source memory address. |
| count | Input | Length of the memory copy, in bytes. |
| srcDataOffset | Input | Source memory address offset. |
| kind | Input | Type of memory copy. For details about the type definition, see [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind).<br>Currently, **kind** supports only **ACL_MEMCPY_INNER_DEVICE_TO_DEVICE** (memory copy within a device). |
| stream | Input | Stream on which the memory copy task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemset"></a>

## aclrtMemset

```c
aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count)
```

### Applicable Products

<!-- npu="950" id1996 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1996 -->
<!-- npu="A3" id1997 -->
- Atlas A3 products: Supported
<!-- end id1997 -->
<!-- npu="910b" id1998 -->
- Atlas A2 products: Supported
<!-- end id1998 -->
<!-- npu="310b" id1999 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1999 -->
<!-- npu="310p" id2000 -->
- Atlas inference products: Supported
<!-- end id2000 -->
<!-- npu="910" id2001 -->
- Atlas training products: Supported
<!-- end id2001 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id14 -->

### Description

Initializes memory and sets the content in memory as the specified value.

The memory to be initialized can reside on the host side or the device side, which is determined by the system based on the address. If the host memory is not requested through an acl API (for example, **aclrtMallocHost**), undefined behavior will occur.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Input | Pointer to the memory start address. |
| maxCount | Input | Maximum memory length, in bytes. |
| value | Input | Value to set. |
| count | Input | Length of the memory to be set as the specified value, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API will immediately initialize the memory, and no implicit device synchronization or stream synchronization is performed inside the function.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemsetAsync"></a>

## aclrtMemsetAsync

```c
aclError aclrtMemsetAsync(void *devPtr, size_t maxCount, int32_t value, size_t count, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2059 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2059 -->
<!-- npu="A3" id2060 -->
- Atlas A3 products: Supported
<!-- end id2060 -->
<!-- npu="910b" id2061 -->
- Atlas A2 products: Supported
<!-- end id2061 -->
<!-- npu="310b" id2062 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2062 -->
<!-- npu="310p" id2063 -->
- Atlas inference products: Supported
<!-- end id2063 -->
<!-- npu="910" id2064 -->
- Atlas training products: Supported
<!-- end id2064 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id15 -->

### Description

Initializes memory and sets the content in memory as the specified value. This is an asynchronous API.

The memory to be initialized can reside on the host side or the device side, which is determined by the system based on the address. If the host memory is not requested through an acl API (for example, **aclrtMallocHost**), undefined behavior will occur.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| devPtr | Input | Pointer to the memory start address. |
| maxCount | Input | Maximum memory length, in bytes. |
| value | Input | Value to set. |
| count | Input | Length of the memory to be set as the specified value, in bytes. |
| stream | Input | Stream on which the memory initialization task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Value

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemsetD32"></a>

## aclrtMemsetD32

```c
aclError aclrtMemsetD32(void *ptr, size_t memSize, uint32_t value, size_t N)
```

### Applicable Products

<!-- npu="950" id2892 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2892 -->
<!-- npu="A3" id2893 -->
- Atlas A3 products: Supported
<!-- end id2893 -->
<!-- npu="910b" id2894 -->
- Atlas A2 products: Supported
<!-- end id2894 -->
<!-- npu="310b" id2895 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2895 -->
<!-- npu="310p" id2896 -->
- Atlas inference products: Not supported
<!-- end id2896 -->
<!-- npu="910" id2897 -->
- Atlas training products: Not supported
<!-- end id2897 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id16 -->

### Description

Initializes memory and sets the content in memory as the specified 32-bit unsigned integer value.

The difference from **aclrtMemset** is that this API fills memory in units of 32-bit unsigned integers, where **N** indicates the number of 32-bit unsigned integer values to be filled.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Pointer to the memory start address. The memory here supports only memory requested by **aclrtMallocHost** or **aclrtMalloc**. |
| memSize | Input | Maximum memory length, in bytes (must be greater than or equal to **N** x 4). |
| value | Input | 32-bit unsigned integer value to be filled. |
| N | Input | Number of 32-bit unsigned integer values to be filled. |

### Return Values

Returns **ACL_SUCCESS** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

This API will immediately initialize the memory, and no implicit device synchronization or stream synchronization is performed inside the function.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemsetD32Async"></a>

## aclrtMemsetD32Async

```c
aclError aclrtMemsetD32Async(void *ptr, size_t memSize, uint32_t value, size_t N, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2052 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2052 -->
<!-- npu="A3" id2053 -->
- Atlas A3 products: Supported
<!-- end id2053 -->
<!-- npu="910b" id2054 -->
- Atlas A2 products: Supported
<!-- end id2054 -->
<!-- npu="310b" id2055 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2055 -->
<!-- npu="310p" id2056 -->
- Atlas inference products: Not supported
<!-- end id2056 -->
<!-- npu="910" id2057 -->
- Atlas training products: Not supported
<!-- end id2057 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id17 -->

### Description

Initializes memory and sets the content in memory as the specified 32-bit unsigned integer value. This is an asynchronous API.

The difference from **aclrtMemset** is that this API fills memory in units of 32-bit unsigned integers, where **N** indicates the number of 32-bit unsigned integer values to be filled.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| ptr | Input | Pointer to the memory start address. The memory here supports only memory requested by **aclrtMallocHost** or **aclrtMalloc**. |
| memSize | Input | Maximum memory length, in bytes (must be greater than or equal to **N** x 4). |
| value | Input | 32-bit unsigned integer value to be filled. |
| N | Input | Number of 32-bit unsigned integer values to be filled. |
| stream | Input | Stream on which the memory initialization task is executed. For the details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **ACL_SUCCESS** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

The initialization task for the device memory is dispatched to the specified stream for execution. The caller must ensure that the stream is valid and has not been destroyed. If **nullptr** is passed to the stream parameter, the default stream is used.

The initialization task for the host memory is not dispatched to a stream for execution. Therefore, the behavior of this API is the same as that of **aclrtMemsetD32**.
