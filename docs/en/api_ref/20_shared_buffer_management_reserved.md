# 20. Shared Buffer Management (Reserved, Not Supported in This Version)

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:33:42.853Z pushedAt=2026-11-09T10:37:28.801Z nl=2 -->

This section describes the reserved shared buffer management APIs (not supported in the current version).

- [`aclError aclrtAllocBuf(aclrtMbuf *buf, size_t size)`](#aclrtAllocBuf): Allocates a shared buffer of the specified size.
- [`aclError aclrtFreeBuf(aclrtMbuf buf)`](#aclrtFreeBuf): Releases a shared buffer allocated by calling [aclrtAllocBuf](#aclrtAllocBuf).
- [`aclError aclrtGetBufData(const aclrtMbuf buf, void **dataPtr, size_t *size)`](#aclrtGetBufData): Gets the pointer to and length of the data area of a shared buffer. You can use this pointer to fill in data.
- [`aclError aclrtSetBufUserData(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset)`](#aclrtSetBufUserData): Sets the private data area data of a shared buffer. The data is copied from user memory to the specified offset in the private data area of the shared buffer, which is used to set control information passed as context.
- [`aclError aclrtGetBufUserData(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)`](#aclrtGetBufUserData): Gets the private data area data of a shared buffer. After an offset is applied, the data is copied to the memory area allocated by the user.
- [`aclError aclrtGetBufDataLen(aclrtMbuf buf, size_t *len)`](#aclrtGetBufDataLen): Gets the length of valid data in a shared buffer.
- [`aclError aclrtSetBufDataLen(aclrtMbuf buf, size_t len)`](#aclrtSetBufDataLen): Sets the length of valid data in a shared buffer.
- [`aclError aclrtCopyBufRef(const aclrtMbuf buf, aclrtMbuf *newBuf)`](#aclrtCopyBufRef): Performs a reference copy of the data area of a shared buffer, creating and returning a new mbuf management structure pointing to the same data area.
- [`aclError aclrtAppendBufChain(aclrtMbuf headBuf, aclrtMbuf buf)`](#aclrtAppendBufChain): Appends a shared buffer to the mbuf chain.
- [`aclError aclrtGetBufFromChain(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf)`](#aclrtGetBufFromChain): Obtains the index-th shared buffer from the mbuf chain.
- [`aclError aclrtGetBufChainNum(aclrtMbuf headBuf, uint32_t *num)`](#aclrtGetBufChainNum): Obtains the number of shared buffers in the mbuf chain.

<a class="method_anchor" id="aclrtAllocBuf"></a>

## aclrtAllocBuf

```c
aclError aclrtAllocBuf(aclrtMbuf *buf, size_t size)
```

### Function

Allocates a shared buffer of a specified size.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Output | Allocated shared buffer. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf). |
| size | Input | Memory size of the data area, in bytes. The value cannot exceed 4 GB. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtFreeBuf"></a>

## aclrtFreeBuf

```c
aclError aclrtFreeBuf(aclrtMbuf buf)
```

### Function

Releases the shared buffer allocated by calling [aclrtAllocBuf](#aclrtAllocBuf).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer to release. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetBufData"></a>

## aclrtGetBufData

```c
aclError aclrtGetBufData(const aclrtMbuf buf, void **dataPtr, size_t *size)
```

### Function

Obtains the pointer and length of the data area of a shared buffer. You can use this pointer to fill in data.

API calling sequence: After a shared buffer is requested by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef), the user needs to call [aclrtGetBufData](#aclrtGetBufData) to obtain the memory pointer and length of the shared buffer, then fill valid data into the memory, and finally call [aclrtSetBufDataLen](#aclrtSetBufDataLen) to set the valid data length in the shared buffer. The length must be less than the size obtained by [aclrtGetBufData](#aclrtGetBufData).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf).<br>Must be allocated by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef). |
| dataPtr | Output | Pointer to the data area (device-side address). |
| size | Output | Length of the data area, in bytes. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetBufUserData"></a>

## aclrtSetBufUserData

```c
aclError aclrtSetBufUserData(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset)
```

### Function

Sets the data in the private data area of a shared buffer. The data is copied from user memory to the specified offset in the private data area of the shared buffer to set control information passed as context. The default size of the private data area is 96 bytes. The value of `offset` plus `size` must be less than or equal to 96 bytes; otherwise, an error is returned.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer. For details about the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf).<br>It must be obtained by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef). |
| dataPtr | Input | Pointer to the memory address that stores the user data. |
| size | Input | Length of the user data. The unit is byte.<br>The data length must be less than or equal to 96 bytes. |
| offset | Input | Address offset. The unit is byte.<br>The offset must be less than or equal to 96 bytes. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetBufUserData"></a>

## aclrtGetBufUserData

```c
aclError aclrtGetBufUserData(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)
```

### Function

Gets the data in the private data area of a shared buffer, and copies the data to the user-allocated memory area after applying a specified offset. The default size of the private data area is 96 bytes. The value of `offset` plus `size` must be less than or equal to 96 bytes; otherwise, an error is returned.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf).<br>Must be allocated by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef). |
| dataPtr | Output | Pointer to the memory address for storing user data. |
| size | Input | Length of user data. The unit is byte.<br>The data length is less than or equal to 96 bytes. |
| offset | Input | Address offset. The unit is byte.<br>The offset is less than or equal to 96 bytes. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetBufDataLen"></a>

## aclrtGetBufDataLen

```c
aclError aclrtGetBufDataLen(aclrtMbuf buf, size_t *len)
```

### Function

Gets the length of valid data in a shared buffer.

After setting the length of valid data in a shared buffer by calling [aclrtSetBufDataLen](#aclrtSetBufDataLen), call this API to obtain the length of valid data. Otherwise, the length obtained using this API is 0.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer. For details about the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf).<br>Must be allocated by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef). |
| len | Output | Length of valid data. The unit is byte. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtSetBufDataLen"></a>

## aclrtSetBufDataLen

```c
aclError aclrtSetBufDataLen(aclrtMbuf buf, size_t len)
```

### Function

Sets the length of the valid data in a shared buffer.

API call order: After a shared buffer is obtained by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef), call [aclrtGetBufData](#aclrtGetBufData) to obtain the memory pointer and length of the shared buffer, fill the memory with valid data, and then call [aclrtSetBufDataLen](#aclrtSetBufDataLen) to set the length of the valid data in the shared buffer. The length must be less than the size returned by [aclrtGetBufData](#aclrtGetBufData).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf).<br>Must be allocated by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef). |
| len | Input | Length of the valid data. The unit is byte. |

### Return Values

Returns 0 on success, or a non-zero value on failure. See also [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtCopyBufRef"></a>

## aclrtCopyBufRef

```c
aclError aclrtCopyBufRef(const aclrtMbuf buf, aclrtMbuf *newBuf)
```

### Function

Copies a reference to the data area of a shared buffer, and creates and returns a new mbuf management structure pointing to the same data area.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| buf | Input | Shared buffer. See [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf) for the type definition.<br>Can be allocated by calling [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef). |
| newBuf | Output | Returns a new shared buffer pointing to the same data area. See [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf) for the type definition. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtAppendBufChain"></a>

## aclrtAppendBufChain

```c
aclError aclrtAppendBufChain(aclrtMbuf headBuf, aclrtMbuf buf)
```

### Function

Appends a shared buffer to an mbuf chain. A shared buffer chain supports a maximum of 128 shared buffers. Shared buffers can be allocated by calling  [aclrtAllocBuf](#aclrtAllocBuf) or [aclrtCopyBufRef](#aclrtCopyBufRef).

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| headBuf | Input | First shared buffer in the mbuf chain. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf). |
| buf | Input | Shared buffer to append. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetBufFromChain"></a>

## aclrtGetBufFromChain

```c
aclError aclrtGetBufFromChain(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf)
```

### Function

Gets the index-th shared buffer from an mbuf chain.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| headBuf | Input | First shared buffer in the mbuf chain. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf). |
| index | Input | Index in the mbuf chain (starting from 0). |
| buf | Output | Index-th shared buffer. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf). |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetBufChainNum"></a>

## aclrtGetBufChainNum

```c
aclError aclrtGetBufChainNum(aclrtMbuf headBuf, uint32_t *num)
```

### Function

Obtains the number of shared buffers in an mbuf chain.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| headBuf | Input | First shared buffer in an mbuf chain. For the type definition, see [aclrtMbuf](25-05_Typedefs.md#aclrtMbuf). |
| num | Output | Number of shared buffers. |

### Return Values

0: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).
