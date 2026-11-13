# 11-09 Stream Memory Operations

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-10-23T11:20:31.410Z pushedAt=2026-10-26T09:02:15.101Z -->

This topic describes the memory value write and wait APIs, which are used to asynchronously write to or wait for memory values on a stream.

- [`aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWrite): Writes data to the specified memory. This is an asynchronous API.
- [`aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWait): Waits until the data in the specified memory meets certain conditions and then releases the block. This is an asynchronous API.

<a class="method_anchor" id="aclrtValueWrite"></a>

## aclrtValueWrite

```c
aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2234 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2234 -->
<!-- npu="A3" id2235 -->
- Atlas A3 products: Supported
<!-- end id2235 -->
<!-- npu="910b" id2236 -->
- Atlas A2 products: Supported
<!-- end id2236 -->
<!-- npu="310b" id2237 -->
- Atlas 200I/500 A2 inference products: Not Supported
<!-- end id2237 -->
<!-- npu="310p" id2238 -->
- Atlas inference products: Not Supported
<!-- end id2238 -->
<!-- npu="910" id2239 -->
- Atlas training products: Not Supported
<!-- end id2239 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-09_stream_memory_operation_res.md#id1 -->

### Description

Writes data to the specified memory. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| devAddr | Input | Device-side memory address.<br>The user must request device memory in advance (for example, by calling the **aclrtMalloc** API). **devAddr** must be 8-byte aligned, and the effective memory bit width is 64 bits. |
| value | Input | Data to be written to the memory. |
| flag | Input | Reserved parameter, which is currently fixed to **0**. |
| stream | Input | Stream on which the data write task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>Passing **NULL** is supported here, indicating that the default stream is used. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).

<br>
<br>
<br>

<a class="method_anchor" id="aclrtValueWait"></a>

## aclrtValueWait

```c
aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id883 -->
- Ascend 950PR&950DT products: Supported
<!-- end id883 -->
<!-- npu="A3" id884 -->
- Atlas A3 products: Supported
<!-- end id884 -->
<!-- npu="910b" id885 -->
- Atlas A2 products: Supported
<!-- end id885 -->
<!-- npu="310b" id886 -->
- Atlas 200I/500 A2 inference products: Not Supported
<!-- end id886 -->
<!-- npu="310p" id887 -->
- Atlas inference products: Not Supported
<!-- end id887 -->
<!-- npu="910" id888 -->
- Atlas training products: Not Supported
<!-- end id888 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-09_stream_memory_operation_res.md#id2 -->

### Description

Waits until the data in the specified memory meets certain conditions and then releases the block. This is an asynchronous API.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| **devAddr** | Input | Device-side memory address.<br>The effective memory bit width of **devAddr** is 64 bits. |
| **value** | Input | Value to be compared with the data in the memory. |
| **flag** | Input | Comparison method. The block is released after the condition is met. The values are as follows:<br>ACL_STREAM_WAIT_VALUE_GEQ = 0x00000000U;  // Wait until (int64_t)(\*devAddr - value) >= 0 <br>ACL_STREAM_WAIT_VALUE_EQ = 0x00000001U;  // Wait until \*devAddr == value <br>ACL_STREAM_WAIT_VALUE_AND = 0x00000002U;  // Wait until (\*devAddr & value) != 0 <br>ACL_STREAM_WAIT_VALUE_NOR = 0x00000003U;  // Wait until ~(\*devAddr \| value) != 0 |
| **stream** | Input | Stream on which the wait task is executed. For details about the type definition, see [aclrtStream](25-05_Typedefs.md#aclrtStream).<br>Passing **NULL** is supported here, indicating that the default stream is used. |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
