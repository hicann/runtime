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

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

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
    -  支持在main函数所在文件中定义的Device变量（如 `__gm__ float convWeights`）。
    -  支持通过extern关键字跨文件引用Device变量。例如，在文件A中定义`__gm__ float convWeights`，文件B中可通过`extern __gm__ float convWeights`声明并引用该变量。需要满足编译要求：使用毕昇编译器的-dc模式，将多个源文件编译为单个算子二进制文件。
    -  支持基础数据类型、函数指针、结构体及数组，不支持class类型。注意：函数指针只支持指向纯Scalar的函数，不能有效区分Cube和Vector的函数逻辑。

<br>
<br>
<br>

<a id="aclrtGetSymbolSize"></a>

## aclrtGetSymbolSize

```c
aclError aclrtGetSymbolSize(const void *symbol, size_t *size)
```

### 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

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

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

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

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

实现Device变量的数据到Host的异步内存复制。用于读取Device变量的数据。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_Stream管理.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

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

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

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

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

### 功能说明

实现Host数据到Device变量的异步内存复制。用于向Device变量写入数据。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_Stream管理.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

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