# 17-03 Shared Buffer Management

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-26T12:35:53.636Z pushedAt=2026-10-28T08:50:03.475Z -->

This topic describes the shared buffer management APIs, which are used for buffer allocation, release, data operations, and buffer chain management.

- [`aclError acltdtAllocBuf(size_t size, uint32_t type, acltdtBuf *buf)`](#acltdtAllocBuf): Requests shared buffer memory.
- [`aclError acltdtFreeBuf(acltdtBuf buf)`](#acltdtFreeBuf): Releases the buffer memory requested through the [acltdtAllocBuf](#acltdtAllocBuf) API.
- [`aclError acltdtGetBufData(const acltdtBuf buf, void **dataPtr, size_t *size)`](#acltdtGetBufData): Obtains the data area pointer and data area length of the shared buffer. The user can use this pointer to fill in data.
- [`aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr, size_t size, size_t offset)`](#acltdtSetBufUserData): Sets the data in the private data area of the shared buffer by copying from user memory to the specified offset position in the private data area of the shared memory, which is used to configure control information for context passing.
- [`aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr, size_t size, size_t offset)`](#acltdtGetBufUserData): Obtains the data in the private data area of the shared buffer and copies it to the memory area requested by the user after offsetting.
- [`aclError acltdtSetBufDataLen(acltdtBuf buf, size_t len)`](#acltdtSetBufDataLen): Sets the length of the valid data in the shared buffer.
- [`aclError acltdtGetBufDataLen(acltdtBuf buf, size_t *len)`](#acltdtGetBufDataLen): Obtains the length of the valid data in the shared buffer.
- [`aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *newBuf)`](#acltdtCopyBufRef): Performs a reference copy on the shared buffer data area, creating and returning a new buffer management structure that points to the same data area.
- [`aclError acltdtAppendBufChain(acltdtBuf headBuf, acltdtBuf buf)`](#acltdtAppendBufChain): Adds a shared buffer to the shared buffer chain.
- [`aclError acltdtGetBufChainNum(acltdtBuf headBuf, uint32_t *num)`](#acltdtGetBufChainNum): Obtains the number of shared buffers in the shared buffer chain.
- [`aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)`](#acltdtGetBufFromChain): Obtains the Mbuf at the specified index in the Mbuf chain.

<a class="method_anchor" id="acltdtAllocBuf"></a>

## acltdtAllocBuf

```c
aclError acltdtAllocBuf(size_t size, uint32_t type, acltdtBuf *buf)
```

### Applicable Products

<!-- npu="950" id2423 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2423 -->
<!-- npu="A3" id2424 -->
- Atlas A3 products: Not supported
<!-- end id2424 -->
<!-- npu="910b" id2425 -->
- Atlas A2 products: Not supported
<!-- end id2425 -->
<!-- npu="310b" id2426 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2426 -->
<!-- npu="310p" id2427 -->
- Atlas inference products: Not supported
<!-- end id2427 -->
<!-- npu="910" id2428 -->
- Atlas training products: Not supported
<!-- end id2428 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id1 -->

### Description

Requests shared buffer memory.

After memory is requested using the **acltdtAllocBuf** API, the length of the data area is the size specified by the **size** parameter. Before the user fills in valid data, the initial valid data length of this memory is 0. After the user fills valid data into the memory, the valid data length can be set through the [acltdtSetBufDataLen](#acltdtSetBufDataLen) API.

Memory requested using the **acltdtAllocBuf** API must be released through the [acltdtFreeBuf](#acltdtFreeBuf) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| size | Input | Memory size of the data area, in bytes, which cannot exceed 4 GB. |
| type | Input | Shared buffer memory type. The value options are as follows:<br>typedef enum {<br>   ACL_TDT_NORMAL_MEM = 0,<br>   ACL_TDT_DVPP_MEM<br>} acltdtAllocBufType;<br>Currently, only **ACL_TDT_NORMAL_MEM** is supported. |
| buf | Output | Request success, which outputs the shared buffer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id1 -->
### Constraints

For Atlas 200I/500 A2 inference products, this API can be used only in the Ascend RC form.
<!-- end id1 -->

<br>
<br>
<br>

<a class="method_anchor" id="acltdtFreeBuf"></a>

## acltdtFreeBuf

```c
aclError acltdtFreeBuf(acltdtBuf buf)
```

### Applicable Products

<!-- npu="950" id3228 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3228 -->
<!-- npu="A3" id3229 -->
- Atlas A3 products: Not supported
<!-- end id3229 -->
<!-- npu="910b" id3230 -->
- Atlas A2 products: Not supported
<!-- end id3230 -->
<!-- npu="310b" id3231 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3231 -->
<!-- npu="310p" id3232 -->
- Atlas inference products: Not supported
<!-- end id3232 -->
<!-- npu="910" id3233 -->
- Atlas training products: Not supported
<!-- end id3233 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id2 -->

### Description

Releases the buffer memory requested through the [acltdtAllocBuf](#acltdtAllocBuf) API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Buffer memory to be released. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtGetBufData"></a>

## acltdtGetBufData

```c
aclError acltdtGetBufData(const acltdtBuf buf, void **dataPtr, size_t *size)
```

### Applicable Products

<!-- npu="950" id1289 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id1289 -->
<!-- npu="A3" id1290 -->
- Atlas A3 products: Not supported
<!-- end id1290 -->
<!-- npu="910b" id1291 -->
- Atlas A2 products: Not supported
<!-- end id1291 -->
<!-- npu="310b" id1292 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id1292 -->
<!-- npu="310p" id1293 -->
- Atlas inference products: Not supported
<!-- end id1293 -->
<!-- npu="910" id1294 -->
- Atlas training products: Not supported
<!-- end id1294 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id3 -->

### Description

Obtains the data area pointer and data area length of a shared buffer. The user can use this pointer to fill in data.

API calling sequence: After a shared buffer is requested by calling [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef), the user calls [acltdtGetBufData](#acltdtGetBufData) to obtain the memory pointer and length of the shared buffer, then fills valid data into the memory, and finally calls [acltdtSetBufDataLen](#acltdtSetBufDataLen) to set the valid data length in the shared buffer. The length must be less than the size obtained by [acltdtGetBufData](#acltdtGetBufData).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer pointer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>It must be obtained by calling [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef). |
| dataPtr | Output | Data area pointer (device-side address). |
| size | Output | Data area length, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtSetBufUserData"></a>

## acltdtSetBufUserData

```c
aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr, size_t size, size_t offset)
```

### Applicable Products

<!-- npu="950" id638 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id638 -->
<!-- npu="A3" id639 -->
- Atlas A3 products: Not supported
<!-- end id639 -->
<!-- npu="910b" id640 -->
- Atlas A2 products: Not supported
<!-- end id640 -->
<!-- npu="310b" id641 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id641 -->
<!-- npu="310p" id642 -->
- Atlas inference products: Not supported
<!-- end id642 -->
<!-- npu="910" id643 -->
- Atlas training products: Not supported
<!-- end id643 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id4 -->

### Description

Sets the data in the private data area of the shared buffer by copying from user memory to the specified offset position in the private data area of the shared memory, which is used to configure control information for context passing. The current default private data area size is 96 bytes. **offset** + **size** must be less than or equal to 96 bytes; otherwise, an error is returned.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| buf | Output | Shared buffer pointer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |
| dataPtr | Input | Memory address pointer that stores user data. |
| size | Input | User data length, in bytes.<br>The data length is less than or equal to 96 bytes. |
| offset | Input | Address offset, in bytes.<br>The offset is less than or equal to 96 bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtGetBufUserData"></a>

## acltdtGetBufUserData

```c
aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr, size_t size, size_t offset)
```

### Applicable Products

<!-- npu="950" id78 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id78 -->
<!-- npu="A3" id79 -->
- Atlas A3 products: Not supported
<!-- end id79 -->
<!-- npu="910b" id80 -->
- Atlas A2 products: Not supported
<!-- end id80 -->
<!-- npu="310b" id81 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id81 -->
<!-- npu="310p" id82 -->
- Atlas inference products: Not supported
<!-- end id82 -->
<!-- npu="910" id83 -->
- Atlas training products: Not supported
<!-- end id83 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id5 -->

### Description

Obtains the data in the private data area of the shared buffer and copies it to the memory area requested by the user after offsetting. The current default private data area size is 96 bytes, and **offset** + **size** must be less than or equal to 96 bytes; otherwise, an error is returned.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer pointer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>It must be obtained through the [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef) API. |
| dataPtr | Input&Output | Memory address pointer for storing user data. |
| size | Input | User data length, in bytes.<br>The data length is less than or equal to 96 bytes. |
| offset | Input | Address offset, in bytes.<br>The offset is less than or equal to 96 bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtSetBufDataLen"></a>

## acltdtSetBufDataLen

```c
aclError acltdtSetBufDataLen(acltdtBuf buf, size_t len)
```

### Applicable Products

<!-- npu="950" id3375 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3375 -->
<!-- npu="A3" id3376 -->
- Atlas A3 products: Not supported
<!-- end id3376 -->
<!-- npu="910b" id3377 -->
- Atlas A2 products: Not supported
<!-- end id3377 -->
<!-- npu="310b" id3378 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3378 -->
<!-- npu="310p" id3379 -->
- Atlas inference products: Not supported
<!-- end id3379 -->
<!-- npu="910" id3380 -->
- Atlas training products: Not supported
<!-- end id3380 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id6 -->

### Description

Sets the length of the valid data in a shared buffer.

API calling sequence: After a shared buffer is requested by calling [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef), the user calls [acltdtGetBufData](#acltdtGetBufData) to obtain the memory pointer and length of the shared buffer, fills valid data into the memory, and then calls **acltdtSetBufDataLen** to set the length of the valid data in the shared buffer. The length must be less than the size obtained by [acltdtGetBufData](#acltdtGetBufData).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer pointer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>It must be obtained through [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef). |
| len | Input | Length of the valid data, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtGetBufDataLen"></a>

## acltdtGetBufDataLen

```c
aclError acltdtGetBufDataLen(acltdtBuf buf, size_t *len)
```

### Applicable Products

<!-- npu="950" id3473 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id3473 -->
<!-- npu="A3" id3474 -->
- Atlas A3 products: Not supported
<!-- end id3474 -->
<!-- npu="910b" id3475 -->
- Atlas A2 products: Not supported
<!-- end id3475 -->
<!-- npu="310b" id3476 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id3476 -->
<!-- npu="310p" id3477 -->
- Atlas inference products: Not supported
<!-- end id3477 -->
<!-- npu="910" id3478 -->
- Atlas training products: Not supported
<!-- end id3478 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id7 -->

### Description

Obtains the length of valid data in a shared buffer.

After the length of valid data in a shared buffer is set through [acltdtSetBufDataLen](#acltdtSetBufDataLen), this API can be called to obtain the length of valid data. Otherwise, the length obtained through this API is 0.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer pointer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>It must be obtained through [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef). |
| len | Output | Length of valid data, in bytes. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtCopyBufRef"></a>

## acltdtCopyBufRef

```c
aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *newBuf)
```

### Applicable Products

<!-- npu="950" id176 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id176 -->
<!-- npu="A3" id177 -->
- Atlas A3 products: Not supported
<!-- end id177 -->
<!-- npu="910b" id178 -->
- Atlas A2 products: Not supported
<!-- end id178 -->
<!-- npu="310b" id179 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id179 -->
<!-- npu="310p" id180 -->
- Atlas inference products: Not supported
<!-- end id180 -->
<!-- npu="910" id181 -->
- Atlas training products: Not supported
<!-- end id181 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id8 -->

### Description

Performs a reference copy on the shared buffer data area, creating and returning a new buffer management structure that points to the same data area.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>It must be obtained by calling [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef). |
| newBuf | Output | New shared buffer that points to the same data area. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<!-- npu="310b" id2 -->
### Constraints

For Atlas 200I/500 A2 inference products, this API can be used only in the Ascend RC form.
<!-- end id2 -->

<br>
<br>
<br>

<a class="method_anchor" id="acltdtAppendBufChain"></a>

## acltdtAppendBufChain

```c
aclError acltdtAppendBufChain(acltdtBuf headBuf, acltdtBuf buf)
```

### Applicable Products

<!-- npu="950" id967 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id967 -->
<!-- npu="A3" id968 -->
- Atlas A3 products: Not supported
<!-- end id968 -->
<!-- npu="910b" id969 -->
- Atlas A2 products: Not supported
<!-- end id969 -->
<!-- npu="310b" id970 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id970 -->
<!-- npu="310p" id971 -->
- Atlas inference products: Not supported
<!-- end id971 -->
<!-- npu="910" id972 -->
- Atlas training products: Not supported
<!-- end id972 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id9 -->

### Description

Adds a shared buffer to the shared buffer chain. A shared buffer chain supports a maximum of 128 shared buffers. A shared buffer can be obtained by calling [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef).

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| headBuf | Input | First shared buffer at the head of the shared buffer chain. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |
| buf | Input | Shared buffer to be added. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtGetBufChainNum"></a>

## acltdtGetBufChainNum

```c
aclError acltdtGetBufChainNum(acltdtBuf headBuf, uint32_t *num)
```

### Applicable Products

<!-- npu="950" id491 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id491 -->
<!-- npu="A3" id492 -->
- Atlas A3 products: Not supported
<!-- end id492 -->
<!-- npu="910b" id493 -->
- Atlas A2 products: Not supported
<!-- end id493 -->
<!-- npu="310b" id494 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id494 -->
<!-- npu="310p" id495 -->
- Atlas inference products: Not supported
<!-- end id495 -->
<!-- npu="910" id496 -->
- Atlas training products: Not supported
<!-- end id496 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id10 -->

### Description

Obtains the number of shared buffers in a shared buffer chain.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| headBuf | Input | First shared buffer at the head of the shared buffer chain. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>It must be obtained through the [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef) API. |
| num | Output | Number of shared buffers in the shared buffer chain. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="acltdtGetBufFromChain"></a>

## acltdtGetBufFromChain

```c
aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)
```

### Applicable Products

<!-- npu="950" id2290 -->
- Ascend 950PR&950DT products: Not supported
<!-- end id2290 -->
<!-- npu="A3" id2291 -->
- Atlas A3 products: Not supported
<!-- end id2291 -->
<!-- npu="910b" id2292 -->
- Atlas A2 products: Not supported
<!-- end id2292 -->
<!-- npu="310b" id2293 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2293 -->
<!-- npu="310p" id2294 -->
- Atlas inference products: Not supported
<!-- end id2294 -->
<!-- npu="910" id2295 -->
- Atlas training products: Not supported
<!-- end id2295 -->
<!-- @ref: runtime/res/docs/zh/api_ref/17-03_shared_buffer_management_res.md#id11 -->

### Description

Obtains the Mbuf at the specified index in the Mbuf chain.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| headBuf | Input | First shared buffer at the head of the shared buffer chain. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf).<br>It must be obtained through the [acltdtAllocBuf](#acltdtAllocBuf) or [acltdtCopyBufRef](#acltdtCopyBufRef) API. |
| index | Input | Sequence number of the shared buffer in the shared buffer chain (counting starts from 0). |
| buf | Output | Shared buffer at the specified index. For details about the type definition, see [acltdtBuf](25-05_Typedefs.md#acltdtBuf). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
