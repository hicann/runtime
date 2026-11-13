# 11-11 Device Variable Memory Operations

<!-- md-trans-meta sourceCommit=31ae292a88c1a38674abaa350b60eba724bab178 translatedAt=2026-11-06T11:23:49.344Z pushedAt=2026-11-09T08:54:08.445Z nl=2 -->

This chapter describes the APIs related to device variable memory operations, allowing you to access and operate device variables.

- [`aclError aclrtGetSymbolAddress(const void *symbol, void **devPtr)`](#aclrtGetSymbolAddress): Obtains the address of a device variable.
- [`aclError aclrtGetSymbolSize(const void *symbol, size_t *size)`](#aclrtGetSymbolSize): Obtains the memory size occupied by a device variable.
- [`aclError aclrtMemcpyFromSymbol(void *dst, size_t dstMax, const void *symbol, size_t count, size_t offset, aclrtMemcpyKind kind)`](#aclrtMemcpyFromSymbol): Implements synchronous memory copy from a device variable to the host.
- [`aclError aclrtMemcpyFromSymbolAsync(void *dst, size_t dstMax, const void *symbol, size_t count, size_t offset, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyFromSymbolAsync): Implements asynchronous memory copy from a device variable to the host.
- [`aclError aclrtMemcpyToSymbol(const void *symbol, const void *src, size_t count, size_t offset, aclrtMemcpyKind kind)`](#aclrtMemcpyToSymbol): Implements synchronous memory copy from the host to a device variable.
- [`aclError aclrtMemcpyToSymbolAsync(const void *symbol, const void *src, size_t count, size_t offset, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyToSymbolAsync): Implements asynchronous memory copy from the host to a device variable.

<a class="method_anchor" id="aclrtGetSymbolAddress"></a>

## aclrtGetSymbolAddress

```c
aclError aclrtGetSymbolAddress(const void *symbol, void **devPtr)
```

### Applicable Products

<!-- npu="950" id1618 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1618 -->
<!-- npu="A3" id1619 -->
- Atlas A3 products: Supported
<!-- end id1619 -->
<!-- npu="910b" id1620 -->
- Atlas A2 products: Supported
<!-- end id1620 -->
<!-- npu="310b" id1621 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1621 -->
<!-- npu="310p" id1622 -->
- Atlas inference products: Supported
<!-- end id1622 -->
<!-- npu="910" id1623 -->
- Atlas training products: Not supported
<!-- end id1623 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id1 -->

### Description

Obtains the address of a device variable.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Address of the device variable. Pass the address of a variable declared with `__gm__`. |
| devPtr | Output | Memory address pointer of the device variable. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- This API applies only to the scenario where you develop custom operators in Ascend C and use the BiSheng compiler for mixed host and device code compilation.
- The device variable address is valid only on the current device. After switching the device, you must re-obtain the address.
- Only device variables in AI Core operators are supported, with the following constraints:
    - Device variables defined in the file where the main function resides are supported (for example, `__gm__ float convWeights`).
    - Cross-file references to device variables through the `extern` keyword are supported. For example, if `__gm__ float convWeights` is defined in file A, file B can declare and reference the variable through `extern __gm__ float convWeights`. The compilation requirement must be satisfied: use the -dc mode of the BiSheng compiler to compile multiple source files into a single operator binary file.
    - Basic data types, function pointers, structures, and arrays are supported. The class type is not supported. Note that function pointers support only functions pointing to pure Scalar, and cannot effectively distinguish between Cube and Vector function logic.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtGetSymbolSize"></a>

## aclrtGetSymbolSize

```c
aclError aclrtGetSymbolSize(const void *symbol, size_t *size)
```

### Applicable Products

<!-- npu="950" id218 -->
- Ascend 950PR&950DT products: Supported
<!-- end id218 -->
<!-- npu="A3" id219 -->
- Atlas A3 products: Supported
<!-- end id219 -->
<!-- npu="910b" id220 -->
- Atlas A2 products: Supported
<!-- end id220 -->
<!-- npu="310b" id221 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id221 -->
<!-- npu="310p" id222 -->
- Atlas inference products: Supported
<!-- end id222 -->
<!-- npu="910" id223 -->
- Atlas training products: Not supported
<!-- end id223 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id2 -->

### Description

Obtains the memory size occupied by a device variable.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Address of the device variable. Pass the address of the variable declared with `__gm__`. |
| size | Output | Size of the device variable, in bytes. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyFromSymbol"></a>

## aclrtMemcpyFromSymbol

```c
aclError aclrtMemcpyFromSymbol(void *dst, size_t dstMax, const void *symbol,
                               size_t count, size_t offset, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id1247 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1247 -->
<!-- npu="A3" id1248 -->
- Atlas A3 products: Supported
<!-- end id1248 -->
<!-- npu="910b" id1249 -->
- Atlas A2 products: Supported
<!-- end id1249 -->
<!-- npu="310b" id1250 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1250 -->
<!-- npu="310p" id1251 -->
- Atlas inference products: Supported
<!-- end id1251 -->
<!-- npu="910" id1252 -->
- Atlas training products: Not supported
<!-- end id1252 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id3 -->

### Description

Implements synchronous memory copy of data from a device variable to the host. It is used to read the data of a device variable.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Destination memory address pointer. |
| dstMax | Input | Maximum length of the destination memory, in bytes. Must satisfy dstMax ≥ count. |
| symbol | Input | Address of the device variable. Pass the address of the variable declared with `__gm__`. |
| count | Input | Length of the memory copy, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| offset | Input | Device variable address offset, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API only supports `ACL_MEMCPY_DEVICE_TO_HOST` and `ACL_MEMCPY_DEFAULT`. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyFromSymbolAsync"></a>

## aclrtMemcpyFromSymbolAsync

```c
aclError aclrtMemcpyFromSymbolAsync(void *dst, size_t dstMax, const void *symbol,
                                    size_t count, size_t offset, aclrtMemcpyKind kind,
                                    aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2486 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2486 -->
<!-- npu="A3" id2487 -->
- Atlas A3 products: Supported
<!-- end id2487 -->
<!-- npu="910b" id2488 -->
- Atlas A2 products: Supported
<!-- end id2488 -->
<!-- npu="310b" id2489 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id2489 -->
<!-- npu="310p" id2490 -->
- Atlas inference products: Supported
<!-- end id2490 -->
<!-- npu="910" id2491 -->
- Atlas training products: Not supported
<!-- end id2491 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id4 -->

### Description

Implements asynchronous memory copy of data from a device variable to the host. It is used to read the data of a device variable.

The host memory in this API supports page-locked memory (for example, memory allocated via the aclrtMallocHost API) and non-page-locked memory (memory allocated via the malloc API). When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has completed. When the host memory is non-page-locked memory, this API returns only after the memory copy task completes.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| dst | Input | Destination memory address pointer. |
| dstMax | Input | Maximum length of the destination memory, in bytes. Must satisfy dstMax ≥ Count. |
| symbol | Input | Address of the device variable. Pass the address of the variable declared with `__gm__`. |
| count | Input | Length of the memory copy, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| offset | Input | Device variable address offset, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API only supports `ACL_MEMCPY_DEVICE_TO_HOST` and `ACL_MEMCPY_DEFAULT`. |
| stream | Input | Stream that executes the memory copy task. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.
- This API is asynchronous. After calling it, you must synchronously wait for the copy to complete.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyToSymbol"></a>

## aclrtMemcpyToSymbol

```c
aclError aclrtMemcpyToSymbol(const void *symbol, const void *src,
                             size_t count, size_t offset, aclrtMemcpyKind kind)
```

### Applicable Products

<!-- npu="950" id3144 -->
- Ascend 950PR&950DT products: Supported
<!-- end id3144 -->
<!-- npu="A3" id3145 -->
- Atlas A3 products: Supported
<!-- end id3145 -->
<!-- npu="910b" id3146 -->
- Atlas A2 products: Supported
<!-- end id3146 -->
<!-- npu="310b" id3147 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id3147 -->
<!-- npu="310p" id3148 -->
- Atlas inference products: Supported
<!-- end id3148 -->
<!-- npu="910" id3149 -->
- Atlas training products: Not supported
<!-- end id3149 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id5 -->

### Description

Implements synchronous memory copy from host data to a device variable. It is used to write data to a device variable.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Address of the device variable. Pass the address of the variable declared with `__gm__`. |
| src | Input | Source memory address pointer. |
| count | Input | Length of the memory copy, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API call. |
| offset | Input | Device variable address offset, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API call. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API only supports `ACL_MEMCPY_HOST_TO_DEVICE` and `ACL_MEMCPY_DEFAULT`. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.

<br>
<br>
<br>

<a class="method_anchor" id="aclrtMemcpyToSymbolAsync"></a>

## aclrtMemcpyToSymbolAsync

```c
aclError aclrtMemcpyToSymbolAsync(const void *symbol, const void *src,
                                  size_t count, size_t offset, aclrtMemcpyKind kind,
                                  aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id1513 -->
- Ascend 950PR&950DT products: Supported
<!-- end id1513 -->
<!-- npu="A3" id1514 -->
- Atlas A3 products: Supported
<!-- end id1514 -->
<!-- npu="910b" id1515 -->
- Atlas A2 products: Supported
<!-- end id1515 -->
<!-- npu="310b" id1516 -->
- Atlas 200I/500 A2 inference products: Not supported
<!-- end id1516 -->
<!-- npu="310p" id1517 -->
- Atlas inference products: Supported
<!-- end id1517 -->
<!-- npu="910" id1518 -->
- Atlas training products: Not supported
<!-- end id1518 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id6 -->

### Description

Implements asynchronous memory copy of data from the host to a device variable. It is used to write data to a device variable.

The host memory in this API supports page-locked memory (for example, memory allocated via the aclrtMallocHost API) and non-page-locked memory (memory allocated via the malloc API). When the host memory is page-locked memory, this API is an asynchronous API. A successful call only indicates that the task has been delivered, not that the task has been executed. After calling this API, call a synchronous wait API (for example, [aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)) to ensure that the memory copy task has completed. When the host memory is non-page-locked memory, this API returns only after the memory copy task completes.

### Parameters

| Parameter | Input/Output | Description |
| --- | :---: | --- |
| symbol | Input | Address of the device variable. Pass the address of the variable declared with `__gm__`. |
| src | Input | Source memory address pointer. |
| count | Input | Length of the memory copy, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| offset | Input | Device variable address offset, in bytes. Must satisfy Offset + Count ≤ Device variable size. The device variable size can be obtained via the [aclrtGetSymbolSize](#aclrtGetSymbolSize) API. |
| kind | Input | Copy type. See [aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind) for the type definition. This API only supports `ACL_MEMCPY_HOST_TO_DEVICE` and `ACL_MEMCPY_DEFAULT`. |
| stream | Input | Stream that executes the memory copy task. See [aclrtStream](25-05_Typedefs.md#aclrtStream) for the type definition. |

### Return Values

`0`: success; others: failure. For details, see [aclError](25-01_aclError.md#aclError).

### Constraints

- Same as the constraints of the [aclrtGetSymbolAddress](#aclrtGetSymbolAddress) API.
- This API is asynchronous. After calling it, you must synchronously wait for the copy to complete.
