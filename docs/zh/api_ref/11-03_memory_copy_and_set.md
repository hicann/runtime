# 11-03 内存拷贝与设置

本章节描述 Host-Device 间及 Device-Device 间的内存拷贝与内存设置接口。

- [`aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind)`](#aclrtMemcpy)：实现内存复制。
- [`aclError aclrtMemcpyAsync(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsync)：实现内存复制。
- [`aclError aclrtMemcpyAsyncWithCondition(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsyncWithCondition_deprecated)：实现内存复制。（废弃接口，请使用aclrtMemcpyAsync接口）
- [`aclError aclrtMemcpyBatch(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex)`](#aclrtMemcpyBatch)：实现批量内存复制。
- [`aclError aclrtMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex, aclrtStream stream)`](#aclrtMemcpyBatchAsync)：实现批量内存复制。
- [`aclError aclrtMemcpyBatchV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs)`](#aclrtMemcpyBatchV2)：实现批量内存复制。
- [`aclError aclrtMemcpyBatchAsyncV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, aclrtStream stream)`](#aclrtMemcpyBatchAsyncV2)：实现批量内存复制。
- [`aclError aclrtMemcpy2d(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)`](#aclrtMemcpy2d)：实现同步内存复制，主要用于矩阵数据的复制。
- [`aclError aclrtMemcpy2dAsync(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpy2dAsync)：实现异步内存复制，主要用于矩阵数据的复制。异步接口。
- [`aclError aclrtGetMemcpyDescSize(aclrtMemcpyKind kind, size_t *descSize)`](#aclrtGetMemcpyDescSize)：获取当前Device的内存复制描述符占用的内存大小。
- [`aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)`](#aclrtSetMemcpyDesc)：设置内存复制描述符，此接口调用完成后，会将源地址，目的地址、内存复制长度记录到内存复制描述符中。
- [`aclError aclrtMemcpyAsyncWithDesc(void *desc, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsyncWithDesc)：使用内存复制描述符（二级指针方式）进行内存复制。异步接口。
- [`aclError aclrtMemcpyAsyncWithOffset(void **dst, size_t destMax, size_t dstDataOffset, const void **src, size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream)`](#aclrtMemcpyAsyncWithOffset)：实现内存复制，适用于基地址是二级指针、有地址偏移的场景。异步接口。
- [`aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count)`](#aclrtMemset)：初始化内存，将内存中的内容设置为指定的值。
- [`aclError aclrtMemsetAsync(void *devPtr, size_t maxCount, int32_t value, size_t count, aclrtStream stream)`](#aclrtMemsetAsync)：初始化内存，将内存中的内容设置为指定的值。异步接口。
- [`aclError aclrtMemsetD32(void *ptr, size_t memSize, uint32_t value, size_t N)`](#aclrtMemsetD32)：初始化内存，将内存中的内容设置为指定的32位无符号整数值，按元素填充。
- [`aclError aclrtMemsetD32Async(void *ptr, size_t memSize, uint32_t value, size_t N, aclrtStream stream)`](#aclrtMemsetD32Async)：初始化内存，将内存中的内容设置为指定的32位无符号整数值。异步接口。

<a id="aclrtMemcpy"></a>

## aclrtMemcpy

```c
aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id1331 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1331 -->
<!-- npu="A3" id1332 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1332 -->
<!-- npu="910b" id1333 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1333 -->
<!-- npu="310b" id1334 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1334 -->
<!-- npu="310p" id1335 -->
- Atlas 推理系列产品：支持
<!-- end id1335 -->
<!-- npu="910" id1336 -->
- Atlas 训练系列产品：支持
<!-- end id1336 -->
<!-- npu="IPV350" id1337 -->
- IPV350：支持
<!-- end id1337 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id1 -->

### 功能说明

实现内存复制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| kind | 输入 | 内存复制的类型，预留参数，配置枚举值中的值无效，系统内部会根据源内存地址指针、目的内存地址指针判断是否可以将源地址的数据复制到目的地址，如果不可以，则系统会返回报错。<br>类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口会立刻进行内存复制，函数内部不会进行隐式的device同步或流同步。
<!-- npu="950,910b,910,310p" id1 -->
- 如果执行两个Device间的内存复制，需先调用[aclrtDeviceCanAccessPeer](04_device_management.md#aclrtDeviceCanAccessPeer)接口查询两个Device间是否支持数据交互、调用[aclrtDeviceEnablePeerAccess](04_device_management.md#aclrtDeviceEnablePeerAccess)接口开启两个Device间的数据交互功能，再调用本接口进行内存复制。

    **该约束适用以下型号：**

    <!-- npu="950" id2 -->
    Ascend 950PR/Ascend 950DT
    <!-- end id2 -->

    <!-- npu="910b" id3 -->
    Atlas A2 训练系列产品/Atlas A2 推理系列产品
    <!-- end id3 -->

    <!-- npu="310p" id4 -->
    Atlas 推理系列产品
    <!-- end id4 -->

    <!-- npu="910" id5 -->
    Atlas 训练系列产品
    <!-- end id5 -->
<!-- end id1 -->

<br>
<br>
<br>

<a id="aclrtMemcpyAsync"></a>

## aclrtMemcpyAsync

```c
aclError aclrtMemcpyAsync(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2731 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2731 -->
<!-- npu="A3" id2732 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2732 -->
<!-- npu="910b" id2733 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2733 -->
<!-- npu="310b" id2734 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2734 -->
<!-- npu="310p" id2735 -->
- Atlas 推理系列产品：支持
<!-- end id2735 -->
<!-- npu="910" id2736 -->
- Atlas 训练系列产品：支持
<!-- end id2736 -->
<!-- npu="IPV350" id2737 -->
- IPV350：不支持
<!-- end id2737 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id2 -->

### 功能说明

实现内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成；当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="950,A3,910b,910,310p,310b" id6 -->
- Ascend EP形态下，本接口不支持异步Host内的内存复制功能，若传入的kind为ACL\_MEMCPY\_HOST\_TO\_HOST时，接口返回报错ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT。
<!-- end id6 -->
<!-- npu="310b" id7 -->
- Ascend RC形态下，在板端运行应用时，若调用本接口传入的kind为ACL\_MEMCPY\_HOST\_TO\_DEVICE或ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_HOST\_TO\_HOST，系统内部将默认使用ACL\_MEMCPY\_DEVICE\_TO\_DEVICE执行Device内的内存复制。
<!-- end id7 -->
<!-- npu="310p" id8 -->
- Control CPU开放形态下，在Device上运行应用时，若调用本接口传入的kind为ACL\_MEMCPY\_HOST\_TO\_DEVICE或ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_HOST\_TO\_HOST，系统内部将默认使用ACL\_MEMCPY\_DEVICE\_TO\_DEVICE执行Device内的内存复制。
<!-- end id8 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id18 -->

<br>
<br>
<br>

<a id="aclrtMemcpyAsyncWithCondition_deprecated"></a>

## aclrtMemcpyAsyncWithCondition（废弃）

```c
aclError aclrtMemcpyAsyncWithCondition(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)
```

**须知：此接口后续版本会废弃，请使用[aclrtMemcpyAsync](#aclrtMemcpyAsync)接口。**

### 产品支持情况

<!-- npu="950" id3494 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3494 -->
<!-- npu="A3" id3495 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3495 -->
<!-- npu="910b" id3496 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3496 -->
<!-- npu="310b" id3497 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3497 -->
<!-- npu="310p" id3498 -->
- Atlas 推理系列产品：支持
<!-- end id3498 -->
<!-- npu="910" id3499 -->
- Atlas 训练系列产品：支持
<!-- end id3499 -->
<!-- npu="IPV350" id3500 -->
- IPV350：支持
<!-- end id3500 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id3 -->

### 功能说明

实现内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

<!-- npu="950,A3,910b,910,310p,310b" id9 -->
- Ascend EP形态下，本接口不支持异步Host内的内存复制功能，若传入的kind为ACL\_MEMCPY\_HOST\_TO\_HOST时，接口返回报错ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT。
<!-- end id9 -->
<!-- npu="310b" id10 -->
- Ascend RC形态下，在板端运行应用时，若调用本接口传入的kind为ACL\_MEMCPY\_HOST\_TO\_DEVICE或ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_HOST\_TO\_HOST，系统内部将默认使用ACL\_MEMCPY\_DEVICE\_TO\_DEVICE执行Device内的内存复制。
<!-- end id10 -->
<!-- npu="310p" id11 -->
- Control CPU开放形态下，在Device上运行应用时，若调用本接口传入的kind为ACL\_MEMCPY\_HOST\_TO\_DEVICE或ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_HOST\_TO\_HOST，系统内部将默认使用ACL\_MEMCPY\_DEVICE\_TO\_DEVICE执行Device内的内存复制。
<!-- end id11 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id19 -->

<br>
<br>
<br>

<a id="aclrtMemcpyBatch"></a>

## aclrtMemcpyBatch

```c
aclError aclrtMemcpyBatch(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id3382 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3382 -->
<!-- npu="A3" id3383 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3383 -->
<!-- npu="910b" id3384 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3384 -->
<!-- npu="310b" id3385 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3385 -->
<!-- npu="310p" id3386 -->
- Atlas 推理系列产品：不支持
<!-- end id3386 -->
<!-- npu="910" id3387 -->
- Atlas 训练系列产品：不支持
<!-- end id3387 -->
<!-- npu="IPV350" id3388 -->
- IPV350：不支持
<!-- end id3388 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id4 -->

### 功能说明

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMaxs | 输入 | 内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。 |
| numBatches | 输入 | dsts、srcs和sizes数组的长度。 |
| attrs | 输入 | 内存复制属性数组。类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作。 |
| numAttrs | 输入 | attrs和attrsIndexes数组的长度。 |
| failIndex | 输出 | 用于发生错误时指示出错的复制项下标（仅支持对内存属性和复制方向的校验）。若错误不涉及特定复制操作，该值将为SIZE_MAX。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 批次内的内存拷贝是无序的，不会按照数组中元素的顺序拷贝。
- 将srcs中指定的数据复制到dsts中指定的内存区域，每个复制操作的大小由sizes指定，dsts、srcs、sizes这三个数组必须具有numBatches指定的相同长度。
- 批处理中的每个复制操作必须与attrs数组中指定的属性集相关联，attrs数组中的每个条目可应用于多个复制操作，具体通过attrsIndexes数组指定对应属性条目生效的起始复制索引。attrs和attrsIndexes这两个数组必须具有numAttrs指定的相同长度。例如：若批处理包含dsts/srcs/sizes列出的10个复制操作，其中前6个使用一组属性，后4个使用另一组属性，则numAttrs为2，attrsIndexes为\{0,6\}，attrs包含两组属性。注意，attrsIndexes的首个条目必须为0，且每个条目必须大于前一个条目，最后一个条目应小于numBatches。此外numAttrs必须小于等于numBatches。
- 批量内存复制的方向仅支持“从Host到Device”或者“从Device到Host”中的一种。

<br>
<br>
<br>

<a id="aclrtMemcpyBatchAsync"></a>

## aclrtMemcpyBatchAsync

```c
aclError aclrtMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex, aclrtStream stream)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id2080 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2080 -->
<!-- npu="A3" id2081 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2081 -->
<!-- npu="910b" id2082 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2082 -->
<!-- npu="310b" id2083 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2083 -->
<!-- npu="310p" id2084 -->
- Atlas 推理系列产品：不支持
<!-- end id2084 -->
<!-- npu="910" id2085 -->
- Atlas 训练系列产品：不支持
<!-- end id2085 -->
<!-- npu="IPV350" id2086 -->
- IPV350：不支持
<!-- end id2086 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id5 -->

### 功能说明

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMaxs | 输入 | 内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。 |
| numBatches | 输入 | dsts、srcs和sizes数组的长度。 |
| attrs | 输入 | 内存复制属性数组。类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作。 |
| numAttrs | 输入 | attrs和attrsIndexes数组的长度。 |
| failIndex | 输出 | 用于发生错误时指示出错的复制项下标（仅支持对内存属性和复制方向的校验）。若错误不涉及特定复制操作，该值将为SIZE_MAX。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 批次内的内存拷贝是无序的，不会按照数组中元素的顺序拷贝。
- 将srcs中指定的数据复制到dsts中指定的内存区域，每个复制操作的大小由sizes指定，dsts、srcs、sizes这三个数组必须具有numBatches指定的相同长度。
- 批处理中的每个复制操作必须与attrs数组中指定的属性集相关联，attrs数组中的每个条目可应用于多个复制操作，具体通过attrsIndexes数组指定对应属性条目生效的起始复制索引。attrs和attrsIndexes这两个数组必须具有numAttrs指定的相同长度。例如：若批处理包含dsts/srcs/sizes列出的10个复制操作，其中前6个使用一组属性，后4个使用另一组属性，则numAttrs为2，attrsIndexes为\{0,6\}，attrs包含两组属性。注意，attrsIndexes的首个条目必须为0，且每个条目必须大于前一个条目，最后一个条目应小于numBatches。此外numAttrs必须小于等于numBatches。
- 批量内存复制的方向仅支持“从Host到Device”或者“从Device到Host”中的一种。

<br>
<br>
<br>

<a id="aclrtMemcpyBatchV2"></a>

## aclrtMemcpyBatchV2

```c
aclError aclrtMemcpyBatchV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id50 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id50 -->
<!-- npu="A3" id51 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id51 -->
<!-- npu="910b" id52 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id52 -->
<!-- npu="310b" id53 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id53 -->
<!-- npu="310p" id54 -->
- Atlas 推理系列产品：不支持
<!-- end id54 -->
<!-- npu="910" id55 -->
- Atlas 训练系列产品：不支持
<!-- end id55 -->
<!-- npu="IPV350" id56 -->
- IPV350：不支持
<!-- end id56 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id6 -->

### 功能说明

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。

与[aclrtMemcpyBatch](#aclrtMemcpyBatch)接口相比，本接口不再通过failIndex参数返回失败的复制项下标。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMaxs | 输入 | 内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。 |
| numBatches | 输入 | dsts、srcs和sizes数组的长度。 |
| attrs | 输入 | 内存复制属性数组。类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作。 |
| numAttrs | 输入 | attrs和attrsIndexes数组的长度。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 批次内的内存拷贝是无序的，不会按照数组中元素的顺序拷贝。
- 将srcs中指定的数据复制到dsts中指定的内存区域，每个复制操作的大小由sizes指定，dsts、srcs、sizes这三个数组必须具有numBatches指定的相同长度。
- 批处理中的每个复制操作必须与attrs数组中指定的属性集相关联，attrs数组中的每个条目可应用于多个复制操作，具体通过attrsIndexes数组指定对应属性条目生效的起始复制索引。attrs和attrsIndexes这两个数组必须具有numAttrs指定的相同长度。例如：若批处理包含dsts/srcs/sizes列出的10个复制操作，其中前6个使用一组属性，后4个使用另一组属性，则numAttrs为2，attrsIndexes为\{0,6\}，attrs包含两组属性。注意，attrsIndexes的首个条目必须为0，且每个条目必须大于前一个条目，最后一个条目应小于numBatches。此外numAttrs必须小于等于numBatches。
- 批量内存复制的方向仅支持“从Host到Device”或者“从Device到Host”中的一种。

<br>
<br>
<br>

<a id="aclrtMemcpyBatchAsyncV2"></a>

## aclrtMemcpyBatchAsyncV2

```c
aclError aclrtMemcpyBatchAsyncV2(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, aclrtStream stream)
```

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于生产环境中。**

### 产品支持情况

<!-- npu="950" id3340 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3340 -->
<!-- npu="A3" id3341 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3341 -->
<!-- npu="910b" id3342 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3342 -->
<!-- npu="310b" id3343 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3343 -->
<!-- npu="310p" id3344 -->
- Atlas 推理系列产品：不支持
<!-- end id3344 -->
<!-- npu="910" id3345 -->
- Atlas 训练系列产品：不支持
<!-- end id3345 -->
<!-- npu="IPV350" id3346 -->
- IPV350：不支持
<!-- end id3346 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id7 -->

### 功能说明

实现批量内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成。

与[aclrtMemcpyBatchAsync](#aclrtMemcpyBatchAsync)接口相比，本接口不再通过failIndex参数返回失败的复制项下标。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dsts | 输入 | 目的内存地址数组。 |
| destMaxs | 输入 | 内存复制最大长度数组，用于存放每一段要复制的内存的最大长度，单位Byte。 |
| srcs | 输入 | 源内存地址数组。 |
| sizes | 输入 | 内存复制长度数组，用于存放每一段要复制的内存大小，单位Byte。 |
| numBatches | 输入 | dsts、srcs和sizes数组的长度。 |
| attrs | 输入 | 内存复制属性数组。类型定义请参见[aclrtMemcpyBatchAttr](25-04_Structs.md#aclrtMemcpyBatchAttr)。 |
| attrsIndexes | 输入 | 内存复制属性索引数组，用于指定attrs数组中每个条目适用的复制范围。attrs[k]中指定的属性将应用于从attrsIndexes[k]到attrsIndexes[k+1] - 1的复制操作，同时attrs[numAttrs-1]将应用于从attrsIndexes[numAttrs-1]到numBatches - 1的复制操作。 |
| numAttrs | 输入 | attrs和attrsIndexes数组的长度。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 批次内的内存拷贝是无序的，不会按照数组中元素的顺序拷贝。
- 将srcs中指定的数据复制到dsts中指定的内存区域，每个复制操作的大小由sizes指定，dsts、srcs、sizes这三个数组必须具有numBatches指定的相同长度。
- 批处理中的每个复制操作必须与attrs数组中指定的属性集相关联，attrs数组中的每个条目可应用于多个复制操作，具体通过attrsIndexes数组指定对应属性条目生效的起始复制索引。attrs和attrsIndexes这两个数组必须具有numAttrs指定的相同长度。例如：若批处理包含dsts/srcs/sizes列出的10个复制操作，其中前6个使用一组属性，后4个使用另一组属性，则numAttrs为2，attrsIndexes为\{0,6\}，attrs包含两组属性。注意，attrsIndexes的首个条目必须为0，且每个条目必须大于前一个条目，最后一个条目应小于numBatches。此外numAttrs必须小于等于numBatches。
- 批量内存复制的方向仅支持“从Host到Device”或者“从Device到Host”中的一种。

<br>
<br>
<br>

<a id="aclrtMemcpy2d"></a>

## aclrtMemcpy2d

```c
aclError aclrtMemcpy2d(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)
```

### 产品支持情况

<!-- npu="950" id1779 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1779 -->
<!-- npu="A3" id1780 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1780 -->
<!-- npu="910b" id1781 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1781 -->
<!-- npu="310b" id1782 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1782 -->
<!-- npu="310p" id1783 -->
- Atlas 推理系列产品：支持
<!-- end id1783 -->
<!-- npu="910" id1784 -->
- Atlas 训练系列产品：支持
<!-- end id1784 -->
<!-- npu="IPV350" id1785 -->
- IPV350：不支持
<!-- end id1785 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id8 -->

### 功能说明

实现同步内存复制，主要用于矩阵数据的复制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| dpitch | 输入 | 目的内存中相邻两列向量的地址距离。 |
| src | 输入 | 源内存地址指针。 |
| spitch | 输入 | 源内存中相邻两列向量的地址距离。 |
| width | 输入 | 待复制的数据宽度。 |
| height | 输入 | 待复制的数据高度。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 当前仅支持ACL\_MEMCPY\_HOST\_TO\_DEVICE类型和ACL\_MEMCPY\_DEVICE\_TO\_HOST类型的内存复制。
<!-- npu="310p" id12 -->
- 对于Atlas 推理系列产品，Control CPU开放形态下，不支持调用本接口。另外，Atlas 推理系列加速模块产品也不支持本接口。
<!-- end id12 -->
<!-- npu="310b" id13 -->
- 对于Atlas 200I/500 A2 推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id13 -->

### 参考资源

本接口的内存复制示意图：

![](figures/memory_copy_diagram.png)

<br>
<br>
<br>

<a id="aclrtMemcpy2dAsync"></a>

## aclrtMemcpy2dAsync

```c
aclError aclrtMemcpy2dAsync(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id1583 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1583 -->
<!-- npu="A3" id1584 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1584 -->
<!-- npu="910b" id1585 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1585 -->
<!-- npu="310b" id1586 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1586 -->
<!-- npu="310p" id1587 -->
- Atlas 推理系列产品：支持
<!-- end id1587 -->
<!-- npu="910" id1588 -->
- Atlas 训练系列产品：支持
<!-- end id1588 -->
<!-- npu="IPV350" id1589 -->
- IPV350：不支持
<!-- end id1589 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id9 -->

### 功能说明

实现异步内存复制，主要用于矩阵数据的复制。异步接口。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)）确保内存复制的任务已执行完成。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| dpitch | 输入 | 目的内存中相邻两列向量的地址距离。 |
| src | 输入 | 源内存地址指针。 |
| spitch | 输入 | 源内存中相邻两列向量的地址距离。 |
| width | 输入 | 待复制的数据宽度。<br>width最大设置为5000000，且必须小于或等于dpitch和spitch。 |
| height | 输入 | 待复制的数据高度。<br>height最大设置为5*1024*1024=5242880，否则接口返回失败。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

- 本接口仅支持ACL\_MEMCPY\_HOST\_TO\_DEVICE、ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_DEVICE\_TO\_DEVICE内存复制类型，且不同型号支持的类型不同。对于不支持的内存复制类型，接口返回ACL\_ERROR\_INVALID\_PARAM。
  
  <!-- npu="950,A3,910b" id14 -->
  其中，ACL\_MEMCPY\_DEVICE\_TO\_DEVICE类型，仅Ascend 950PR/Ascend 950DT、Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持。
  <!-- end id14 -->

<!-- npu="310p" id15 -->
- 对于Atlas 推理系列产品，Control CPU开放形态下，不支持调用本接口。另外，Atlas 推理系列加速模块产品也不支持本接口。
<!-- end id15 -->
<!-- npu="310b" id16 -->
- 对于Atlas 200I/500 A2 推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id16 -->

### 参考资源

本接口的内存复制示意图：

![](figures/memory_copy_diagram.png)

<br>
<br>
<br>

<a id="aclrtGetMemcpyDescSize"></a>

## aclrtGetMemcpyDescSize

```c
aclError aclrtGetMemcpyDescSize(aclrtMemcpyKind kind, size_t *descSize)
```

### 产品支持情况

<!-- npu="950" id1814 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1814 -->
<!-- npu="A3" id1815 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1815 -->
<!-- npu="910b" id1816 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1816 -->
<!-- npu="310b" id1817 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1817 -->
<!-- npu="310p" id1818 -->
- Atlas 推理系列产品：不支持
<!-- end id1818 -->
<!-- npu="910" id1819 -->
- Atlas 训练系列产品：不支持
<!-- end id1819 -->
<!-- npu="IPV350" id1820 -->
- IPV350：不支持
<!-- end id1820 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id10 -->

### 功能说明

获取当前Device的内存复制描述符占用的内存大小。

本接口需与其它关键接口配合使用，以便实现内存复制，详细描述请参见[aclrtMemcpyAsyncWithDesc](#aclrtMemcpyAsyncWithDesc)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。<br>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| descSize | 输出 | 内存大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtSetMemcpyDesc"></a>

## aclrtSetMemcpyDesc

```c
aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)
```

### 产品支持情况

<!-- npu="950" id1128 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1128 -->
<!-- npu="A3" id1129 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1129 -->
<!-- npu="910b" id1130 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1130 -->
<!-- npu="310b" id1131 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1131 -->
<!-- npu="310p" id1132 -->
- Atlas 推理系列产品：不支持
<!-- end id1132 -->
<!-- npu="910" id1133 -->
- Atlas 训练系列产品：不支持
<!-- end id1133 -->
<!-- npu="IPV350" id1134 -->
- IPV350：不支持
<!-- end id1134 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id11 -->

### 功能说明

设置内存复制描述符，此接口调用完成后，会将源地址，目的地址、内存复制长度记录到内存复制描述符中。

本接口需与其它关键接口配合使用，以便实现内存复制，详细描述请参见[aclrtMemcpyAsyncWithDesc](#aclrtMemcpyAsyncWithDesc)。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| desc | 输出 | 内存复制描述符地址指针。<br>需先调用[aclrtGetMemcpyDescSize](#aclrtGetMemcpyDescSize)接口获取内存描述符所需的内存大小，再申请Device内存后（例如aclrtMalloc接口），将Device内存地址作为入参传入此处。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。<br>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| srcAddr | 输入 | 源内存地址指针。<br>由用户申请内存并管理内存。 |
| dstAddr | 输入 | 目的内存地址指针。<br>由用户申请内存并管理内存。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| config | 输入 | 预留参数，当前固定传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemcpyAsyncWithDesc"></a>

## aclrtMemcpyAsyncWithDesc

```c
aclError aclrtMemcpyAsyncWithDesc(void *desc, aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3256 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3256 -->
<!-- npu="A3" id3257 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3257 -->
<!-- npu="910b" id3258 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3258 -->
<!-- npu="310b" id3259 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3259 -->
<!-- npu="310p" id3260 -->
- Atlas 推理系列产品：不支持
<!-- end id3260 -->
<!-- npu="910" id3261 -->
- Atlas 训练系列产品：不支持
<!-- end id3261 -->
<!-- npu="IPV350" id3262 -->
- IPV350：不支持
<!-- end id3262 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id12 -->

### 功能说明

使用内存复制描述符（二级指针方式）进行内存复制。异步接口。

本接口需与以下其它关键接口配合使用，以便实现内存复制：

1. 调用[aclrtGetMemcpyDescSize](#aclrtGetMemcpyDescSize)接口获取内存描述符所需的内存大小。
2. 申请Device内存，用于存放内存描述符。
3. 申请源内存、目的内存，分别用于存放复制前后的数据。
4. 调用[aclrtSetMemcpyDesc](#aclrtSetMemcpyDesc)接口将源内存地址、目的内存地址等信息设置到内存描述符中。
5. 调用aclrtMemcpyAsyncWithDesc接口实现内存复制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| desc | 输入 | 内存复制描述符地址指针，Device侧内存地址。<br>此处需先调用[aclrtSetMemcpyDesc](#aclrtSetMemcpyDesc)接口设置内存复制描述符，再将内存复制描述符地址指针作为入参传入本接口。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。<br>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemcpyAsyncWithOffset"></a>

## aclrtMemcpyAsyncWithOffset

```c
aclError aclrtMemcpyAsyncWithOffset(void **dst, size_t destMax, size_t dstDataOffset, const void **src, size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2983 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2983 -->
<!-- npu="A3" id2984 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2984 -->
<!-- npu="910b" id2985 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2985 -->
<!-- npu="310b" id2986 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2986 -->
<!-- npu="310p" id2987 -->
- Atlas 推理系列产品：不支持
<!-- end id2987 -->
<!-- npu="910" id2988 -->
- Atlas 训练系列产品：支持
<!-- end id2988 -->
<!-- npu="IPV350" id2989 -->
- IPV350：不支持
<!-- end id2989 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id13 -->

### 功能说明

实现内存复制，适用于基地址是二级指针、有地址偏移的场景。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| dstDataOffset | 输入 | 目的内存地址偏移。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| srcDataOffset | 输入 | 源内存地址偏移。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](25-02_Enumerations.md#aclrtMemcpyKind)。<br>当前kind只支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE（Device内的内存复制）。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemset"></a>

## aclrtMemset

```c
aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count)
```

### 产品支持情况

<!-- npu="950" id1996 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1996 -->
<!-- npu="A3" id1997 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id1997 -->
<!-- npu="910b" id1998 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id1998 -->
<!-- npu="310b" id1999 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1999 -->
<!-- npu="310p" id2000 -->
- Atlas 推理系列产品：支持
<!-- end id2000 -->
<!-- npu="910" id2001 -->
- Atlas 训练系列产品：支持
<!-- end id2001 -->
<!-- npu="IPV350" id2002 -->
- IPV350：支持
<!-- end id2002 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id14 -->

### 功能说明

初始化内存，将内存中的内容设置为指定的值。

要初始化的内存支持在Host侧或Device侧，系统根据地址判定是Host还是Device。如果Host内存不是用acl接口（例如aclrtMallocHost）申请的，将会导致未定义的行为。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输入 | 内存起始地址的指针。 |
| maxCount | 输入 | 内存的最大长度，单位Byte。 |
| value | 输入 | 设置的值。 |
| count | 输入 | 需要设置为指定值的内存长度，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

本接口会立刻进行内存初始化，函数内部不会进行隐式的device同步或流同步。

<br>
<br>
<br>

<a id="aclrtMemsetAsync"></a>

## aclrtMemsetAsync

```c
aclError aclrtMemsetAsync(void *devPtr, size_t maxCount, int32_t value, size_t count, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2059 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2059 -->
<!-- npu="A3" id2060 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2060 -->
<!-- npu="910b" id2061 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2061 -->
<!-- npu="310b" id2062 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2062 -->
<!-- npu="310p" id2063 -->
- Atlas 推理系列产品：支持
<!-- end id2063 -->
<!-- npu="910" id2064 -->
- Atlas 训练系列产品：支持
<!-- end id2064 -->
<!-- npu="IPV350" id2065 -->
- IPV350：不支持
<!-- end id2065 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id15 -->

### 功能说明

初始化内存，将内存中的内容设置为指定的值。异步接口。

要初始化的内存支持在Host侧或Device侧，系统根据地址判定是Host还是Device。如果Host内存不是用acl接口（例如aclrtMallocHost）申请的，将会导致未定义的行为。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devPtr | 输入 | 内存起始地址的指针。 |
| maxCount | 输入 | 内存的最大长度，单位Byte。 |
| value | 输入 | 设置的值。 |
| count | 输入 | 需要设置为指定值的内存长度，单位Byte。 |
| stream | 输入 | 指定执行内存初始化任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtMemsetD32"></a>

## aclrtMemsetD32

```c
aclError aclrtMemsetD32(void *ptr, size_t memSize, uint32_t value, size_t N)
```

### 产品支持情况

<!-- npu="950" id2892 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2892 -->
<!-- npu="A3" id2893 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2893 -->
<!-- npu="910b" id2894 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2894 -->
<!-- npu="310b" id2895 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2895 -->
<!-- npu="310p" id2896 -->
- Atlas 推理系列产品：不支持
<!-- end id2896 -->
<!-- npu="910" id2897 -->
- Atlas 训练系列产品：不支持
<!-- end id2897 -->
<!-- npu="IPV350" id2898 -->
- IPV350：不支持
<!-- end id2898 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id16 -->

### 功能说明

初始化内存，将其内容设置为指定的32位无符号整数值。

与aclrtMemset的区别在于：本接口以32位无符号整数为单位进行填充，其中N表示所填充的32位无符号整数值的数量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输入 | 内存起始地址的指针。此处的内存仅支持aclrtMallocHost或aclrtMalloc申请。|
| memSize | 输入 | 内存的最大长度，单位Byte（必须≥N*4）。 |
| value | 输入 | 要填充的32位无符号整数值。 |
| N | 输入 | 所填充的32位无符号整数值的数量。 |

### 返回值说明

返回ACL_SUCCESS表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

本接口会立即执行内存初始化，函数内部不会进行隐式device同步或流同步。

<br>
<br>
<br>

<a id="aclrtMemsetD32Async"></a>

## aclrtMemsetD32Async

```c
aclError aclrtMemsetD32Async(void *ptr, size_t memSize, uint32_t value, size_t N, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2052 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2052 -->
<!-- npu="A3" id2053 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2053 -->
<!-- npu="910b" id2054 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2054 -->
<!-- npu="310b" id2055 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2055 -->
<!-- npu="310p" id2056 -->
- Atlas 推理系列产品：不支持
<!-- end id2056 -->
<!-- npu="910" id2057 -->
- Atlas 训练系列产品：不支持
<!-- end id2057 -->
<!-- npu="IPV350" id2058 -->
- IPV350：不支持
<!-- end id2058 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-03_memory_copy_and_set_res.md#id17 -->

### 功能说明

初始化内存，将其内容设置为指定的32位无符号整数值。异步接口。

与aclrtMemset的区别在于：本接口以32位无符号整数为单位进行填充，其中N表示所填充的32位无符号整数值的数量。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| ptr | 输入 | 内存起始地址的指针。此处的内存仅支持aclrtMallocHost或aclrtMalloc申请。|
| memSize | 输入 | 内存的最大长度，单位Byte（必须≥N*4）。 |
| value | 输入 | 要填充的32位无符号整数值。 |
| N | 输入 | 所填充的32位无符号整数值的数量。 |
| stream | 输入 | 指定执行内存初始化任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回ACL_SUCCESS表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

### 约束说明

Device内存的初始化任务将被下发到指定的Stream上执行，调用方需确保该Stream有效且未被销毁。如果在stream参数处传入nullptr，则会使用默认Stream。

Host内存的初始化任务不会下发到Stream上执行，因此该接口的行为与aclrtMemsetD32接口一致。
