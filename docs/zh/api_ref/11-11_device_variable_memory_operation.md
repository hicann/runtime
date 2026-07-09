# 11-11 Device变量内存操作

本章节描述Device变量内存操作相关接口，用户可以访问和操作Device变量。

- [`aclError aclrtGetSymbolAddress(const void *symbol, void **devPtr)`](#aclrtGetSymbolAddress)：获取Device变量的地址。
- [`aclError aclrtGetSymbolSize(const void *symbol, size_t *size)`](#aclrtGetSymbolSize)：获取Device变量占用的内存大小。
- [`aclError aclrtMemcpyFromSymbol(void *dst, size_t dstMax, const void *symbol, size_t count, size_t offset, aclrtMemcpyKind kind)`](#aclrtMemcpyFromSymbol)：实现Device变量的数据到Host的同步内存复制。
- [`aclError aclrtMemcpyFromSymbolAsync(void *dst, size_t dstMax, const void *symbol, size_t count, size_t offset, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyFromSymbolAsync)：实现Device变量的数据到Host的异步内存复制。
- [`aclError aclrtMemcpyToSymbol(const void *symbol, const void *src, size_t count, size_t offset, aclrtMemcpyKind kind)`](#aclrtMemcpyToSymbol)：实现Host数据到Device变量的同步内存复制。
- [`aclError aclrtMemcpyToSymbolAsync(const void *symbol, const void *src, size_t count, size_t offset, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyToSymbolAsync)：实现Host数据到Device变量的异步内存复制。

<a id="aclrtGetSymbolAddress"></a>

## aclrtGetSymbolAddress

```c
aclError aclrtGetSymbolAddress(const void *symbol, void **devPtr)
```

### 产品支持情况

<!-- npu="950" id1618 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1618 -->
<!-- npu="A3" id1619 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1619 -->
<!-- npu="910b" id1620 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1620 -->
<!-- npu="310b" id1621 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1621 -->
<!-- npu="310p" id1622 -->
- Atlas 推理系列产品：支持
<!-- end id1622 -->
<!-- npu="910" id1623 -->
- Atlas 训练系列产品：不支持
<!-- end id1623 -->
<!-- npu="IPV350" id1624 -->
- IPV350：不支持
<!-- end id1624 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id1 -->

### 功能说明

获取Device变量的地址。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量的地址。此处传入`__gm__`声明的变量名取地址。 |
| devPtr | 输出 | Device变量的内存地址指针。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口仅适用于Ascend C语言开发自定义算子并基于毕昇编译器进行Host和Device代码混合编译的场景。
- Device变量地址仅在当前Device有效，切换Device后需重新获取地址。
- 仅支持AI Core算子中的Device变量，具体约束如下：
    - 支持在main函数所在文件中定义的Device变量（如 `__gm__ float convWeights`）。
    - 支持通过extern关键字跨文件引用Device变量。例如，在文件A中定义`__gm__ float convWeights`，文件B中可通过`extern __gm__ float convWeights`声明并引用该变量。需要满足编译要求：使用毕昇编译器的-dc模式，将多个源文件编译为单个算子二进制文件。
    - 支持基础数据类型、函数指针、结构体及数组，不支持class类型。注意：函数指针只支持指向纯Scalar的函数，不能有效区分Cube和Vector的函数逻辑。

<br>
<br>
<br>

<a id="aclrtGetSymbolSize"></a>

## aclrtGetSymbolSize

```c
aclError aclrtGetSymbolSize(const void *symbol, size_t *size)
```

### 产品支持情况

<!-- npu="950" id218 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id218 -->
<!-- npu="A3" id219 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id219 -->
<!-- npu="910b" id220 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id220 -->
<!-- npu="310b" id221 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id221 -->
<!-- npu="310p" id222 -->
- Atlas 推理系列产品：支持
<!-- end id222 -->
<!-- npu="910" id223 -->
- Atlas 训练系列产品：不支持
<!-- end id223 -->
<!-- npu="IPV350" id224 -->
- IPV350：不支持
<!-- end id224 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id2 -->

### 功能说明

获取Device变量占用的内存大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量的地址。此处传入`__gm__`声明的变量名取地址。 |
| size | 输出 | Device变量的大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。

<br>
<br>
<br>

<a id="aclrtMemcpyFromSymbol"></a>

## aclrtMemcpyFromSymbol

```c
aclError aclrtMemcpyFromSymbol(void *dst, size_t dstMax, const void *symbol,
                               size_t count, size_t offset, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id1247 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1247 -->
<!-- npu="A3" id1248 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1248 -->
<!-- npu="910b" id1249 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1249 -->
<!-- npu="310b" id1250 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1250 -->
<!-- npu="310p" id1251 -->
- Atlas 推理系列产品：支持
<!-- end id1251 -->
<!-- npu="910" id1252 -->
- Atlas 训练系列产品：不支持
<!-- end id1252 -->
<!-- npu="IPV350" id1253 -->
- IPV350：不支持
<!-- end id1253 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id3 -->

### 功能说明

实现Device变量的数据到Host的同步内存复制。用于读取Device变量的数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| dstMax | 输入 | 目标内存最大长度，单位Byte。需满足 dstMax ≥ count。 |
| symbol | 输入 | Device变量的地址。此处传入`__gm__`声明的变量名取地址。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_DEVICE_TO_HOST和ACL_MEMCPY_DEFAULT。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。

<br>
<br>
<br>

<a id="aclrtMemcpyFromSymbolAsync"></a>

## aclrtMemcpyFromSymbolAsync

```c
aclError aclrtMemcpyFromSymbolAsync(void *dst, size_t dstMax, const void *symbol,
                                    size_t count, size_t offset, aclrtMemcpyKind kind,
                                    aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2486 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2486 -->
<!-- npu="A3" id2487 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2487 -->
<!-- npu="910b" id2488 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2488 -->
<!-- npu="310b" id2489 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2489 -->
<!-- npu="310p" id2490 -->
- Atlas 推理系列产品：支持
<!-- end id2490 -->
<!-- npu="910" id2491 -->
- Atlas 训练系列产品：不支持
<!-- end id2491 -->
<!-- npu="IPV350" id2492 -->
- IPV350：不支持
<!-- end id2492 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id4 -->

### 功能说明

实现Device变量的数据到Host的异步内存复制。用于读取Device变量的数据。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| dstMax | 输入 | 目标内存最大长度，单位Byte。需满足 dstMax ≥ count。 |
| symbol | 输入 | Device变量的地址。此处传入`__gm__`声明的变量名取地址。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_DEVICE_TO_HOST和ACL_MEMCPY_DEFAULT。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。
- 本接口为异步接口，调用后需同步等待拷贝完成。

<br>
<br>
<br>

<a id="aclrtMemcpyToSymbol"></a>

## aclrtMemcpyToSymbol

```c
aclError aclrtMemcpyToSymbol(const void *symbol, const void *src,
                             size_t count, size_t offset, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id3144 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3144 -->
<!-- npu="A3" id3145 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3145 -->
<!-- npu="910b" id3146 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3146 -->
<!-- npu="310b" id3147 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3147 -->
<!-- npu="310p" id3148 -->
- Atlas 推理系列产品：支持
<!-- end id3148 -->
<!-- npu="910" id3149 -->
- Atlas 训练系列产品：不支持
<!-- end id3149 -->
<!-- npu="IPV350" id3150 -->
- IPV350：不支持
<!-- end id3150 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id5 -->

### 功能说明

实现Host数据到Device变量的同步内存复制。用于向Device变量写入数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量的地址。此处传入`__gm__`声明的变量名取地址。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_HOST_TO_DEVICE和ACL_MEMCPY_DEFAULT。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。

<br>
<br>
<br>

<a id="aclrtMemcpyToSymbolAsync"></a>

## aclrtMemcpyToSymbolAsync

```c
aclError aclrtMemcpyToSymbolAsync(const void *symbol, const void *src,
                                  size_t count, size_t offset, aclrtMemcpyKind kind,
                                  aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id1513 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1513 -->
<!-- npu="A3" id1514 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1514 -->
<!-- npu="910b" id1515 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1515 -->
<!-- npu="310b" id1516 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1516 -->
<!-- npu="310p" id1517 -->
- Atlas 推理系列产品：支持
<!-- end id1517 -->
<!-- npu="910" id1518 -->
- Atlas 训练系列产品：不支持
<!-- end id1518 -->
<!-- npu="IPV350" id1519 -->
- IPV350：不支持
<!-- end id1519 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-11_device_variable_memory_operation_res.md#id6 -->

### 功能说明

实现Host数据到Device变量的异步内存复制。用于向Device变量写入数据。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| symbol | 输入 | Device变量的地址。此处传入`__gm__`声明的变量名取地址。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| offset | 输入 | Device变量地址偏移，单位Byte。需满足 offset + count ≤ Device变量大小，Device变量大小可通过 [aclrtGetSymbolSize](#aclrtGetSymbolSize)接口查询获取。 |
| kind | 输入 | 拷贝类型，类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。本接口仅支持ACL_MEMCPY_HOST_TO_DEVICE和ACL_MEMCPY_DEFAULT。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 同[aclrtGetSymbolAddress](#aclrtGetSymbolAddress)接口约束说明。
- 本接口为异步接口，调用后需同步等待拷贝完成。
