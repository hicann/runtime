# 11-06 CMO 缓存操作

本章节描述 CMO（Cache Maintenance Operations）缓存操作接口，用于缓存刷新与失效操作。

- [`aclError aclrtCmoAsync(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)`](#aclrtCmoAsync)：实现Device上的Cache内存操作。异步接口。
- [`aclError aclrtCmoAsyncWithBarrier(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId, aclrtStream stream)`](#aclrtCmoAsyncWithBarrier)：实现Device上的Cache内存操作，同时携带barrierId，barrierId表示Cache内存操作的屏障标识。异步接口。
- [`aclError aclrtCmoWaitBarrier(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)`](#aclrtCmoWaitBarrier)：等待具有指定barrierId的Invalid内存操作任务执行完成。异步接口。
- [`aclError aclrtCmoGetDescSize(size_t *size)`](#aclrtCmoGetDescSize)：获取当前Device上的Cache内存描述符占用的内存大小。
- [`aclError aclrtCmoSetDesc(void *cmoDesc, void *src, size_t size)`](#aclrtCmoSetDesc)：设置Cache内存描述符，此接口调用完成后，会将源内存地址、内存大小记录到Cache内存描述符中。
- [`aclError aclrtCmoAsyncWithDesc(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)`](#aclrtCmoAsyncWithDesc)：使用内存描述符（二级指针方式）操作Device上的Cache内存。异步接口。

<a id="aclrtCmoAsync"></a>

## aclrtCmoAsync

```c
aclError aclrtCmoAsync(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3081 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3081 -->
<!-- npu="A3" id3082 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id3082 -->
<!-- npu="910b" id3083 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id3083 -->
<!-- npu="310b" id3084 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3084 -->
<!-- npu="310p" id3085 -->
- Atlas 推理系列产品：不支持
<!-- end id3085 -->
<!-- npu="910" id3086 -->
- Atlas 训练系列产品：不支持
<!-- end id3086 -->
<!-- npu="IPV350" id3087 -->
- IPV350：不支持
<!-- end id3087 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id1 -->

### 功能说明

实现Device上的Cache内存操作。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| src | 输入 | 待操作的Device内存地址。<br>只支持本Device上的Cache内存操作。 |
| size | 输入 | 待操作的Device内存大小，单位Byte。 |
| cmoType | 输入 | Cache内存操作类型。类型定义请参见[aclrtCmoType](25-02_Enumerations.md#aclrtCmoType)。<br>当前仅支持ACL_RT_CMO_TYPE_PREFETCH（内存预取）。 |
| stream | 输入 | 执行内存操作任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCmoAsyncWithBarrier"></a>

## aclrtCmoAsyncWithBarrier

```c
aclError aclrtCmoAsyncWithBarrier(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id3480 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id3480 -->
<!-- npu="A3" id3481 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3481 -->
<!-- npu="910b" id3482 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id3482 -->
<!-- npu="310b" id3483 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id3483 -->
<!-- npu="310p" id3484 -->
- Atlas 推理系列产品：不支持
<!-- end id3484 -->
<!-- npu="910" id3485 -->
- Atlas 训练系列产品：不支持
<!-- end id3485 -->
<!-- npu="IPV350" id3486 -->
- IPV350：不支持
<!-- end id3486 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id2 -->

### 功能说明

实现Device上的Cache内存操作，同时携带barrierId，barrierId表示Cache内存操作的屏障标识。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| src | 输入 | 待操作的Device内存地址。<br>只支持本Device上的Cache内存操作。 |
| size | 输入 | 待操作的Device内存大小，单位Byte。 |
| cmoType | 输入 | Cache内存操作类型。类型定义请参见[aclrtCmoType](25-02_Enumerations.md#aclrtCmoType)。 |
| barrierId | 输入 | 屏障标识。<br>当cmoType为ACL_RT_CMO_TYPE_INVALID时，barrierId有效，支持传入大于0的数字，配合[aclrtCmoWaitBarrier](#aclrtCmoWaitBarrier)接口使用，等待具有指定barrierId的Invalid内存操作任务执行完成。当cmoType为其它值时，barrierId固定传0。 |
| stream | 输入 | 执行内存操作任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)接口。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCmoWaitBarrier"></a>

## aclrtCmoWaitBarrier

```c
aclError aclrtCmoWaitBarrier(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)
```

### 产品支持情况

<!-- npu="950" id1086 -->
- Ascend 950PR/Ascend 950DT：不支持
<!-- end id1086 -->
<!-- npu="A3" id1087 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id1087 -->
<!-- npu="910b" id1088 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id1088 -->
<!-- npu="310b" id1089 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id1089 -->
<!-- npu="310p" id1090 -->
- Atlas 推理系列产品：不支持
<!-- end id1090 -->
<!-- npu="910" id1091 -->
- Atlas 训练系列产品：不支持
<!-- end id1091 -->
<!-- npu="IPV350" id1092 -->
- IPV350：不支持
<!-- end id1092 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id3 -->

### 功能说明

等待具有指定barrierId的Invalid内存操作任务执行完成。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| taskInfo | 输入 | Cache内存操作的任务信息。类型定义请参见[aclrtBarrierTaskInfo](25-04_Structs.md#aclrtBarrierTaskInfo)。<br>任务信息中的cmoType当前仅支持ACL_RT_CMO_TYPE_INVALID。 |
| stream | 输入 | 执行等待任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](15_model_running_instance__management.md#aclmdlRIBindStream)接口。 |
| flag | 输入 | 预留参数。当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCmoGetDescSize"></a>

## aclrtCmoGetDescSize

```c
aclError aclrtCmoGetDescSize(size_t *size)
```

### 产品支持情况

<!-- npu="950" id2745 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2745 -->
<!-- npu="A3" id2746 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2746 -->
<!-- npu="910b" id2747 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2747 -->
<!-- npu="310b" id2748 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2748 -->
<!-- npu="310p" id2749 -->
- Atlas 推理系列产品：不支持
<!-- end id2749 -->
<!-- npu="910" id2750 -->
- Atlas 训练系列产品：不支持
<!-- end id2750 -->
<!-- npu="IPV350" id2751 -->
- IPV350：不支持
<!-- end id2751 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id4 -->

### 功能说明

获取当前Device上的Cache内存描述符占用的内存大小。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| size | 输出 | Cache内存描述符大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCmoSetDesc"></a>

## aclrtCmoSetDesc

```c
aclError aclrtCmoSetDesc(void *cmoDesc, void *src, size_t size)
```

### 产品支持情况

<!-- npu="950" id925 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id925 -->
<!-- npu="A3" id926 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id926 -->
<!-- npu="910b" id927 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id927 -->
<!-- npu="310b" id928 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id928 -->
<!-- npu="310p" id929 -->
- Atlas 推理系列产品：不支持
<!-- end id929 -->
<!-- npu="910" id930 -->
- Atlas 训练系列产品：不支持
<!-- end id930 -->
<!-- npu="IPV350" id931 -->
- IPV350：不支持
<!-- end id931 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id5 -->

### 功能说明

设置Cache内存描述符，此接口调用完成后，会将源内存地址、内存大小记录到Cache内存描述符中。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cmoDesc | 输入 | Cache内存描述符地址指针。<br>需先调用aclrtCmoGetDescSize接口获取Cache内存描述符所需的内存大小，再申请Device内存后（例如aclrtMalloc接口），将Device内存地址作为入参传入此处。 |
| src | 输入 | 待操作的Device内存地址。<br>只支持本Device上的Cache内存操作。 |
| size | 输入 | 待操作的Device内存大小，单位Byte。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCmoAsyncWithDesc"></a>

## aclrtCmoAsyncWithDesc

```c
aclError aclrtCmoAsyncWithDesc(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)
```

### 产品支持情况

<!-- npu="950" id2619 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2619 -->
<!-- npu="A3" id2620 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2620 -->
<!-- npu="910b" id2621 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2621 -->
<!-- npu="310b" id2622 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2622 -->
<!-- npu="310p" id2623 -->
- Atlas 推理系列产品：不支持
<!-- end id2623 -->
<!-- npu="910" id2624 -->
- Atlas 训练系列产品：不支持
<!-- end id2624 -->
<!-- npu="IPV350" id2625 -->
- IPV350：不支持
<!-- end id2625 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-06_CMO_memory_operation_res.md#id6 -->

### 功能说明

使用内存描述符（二级指针方式）操作Device上的Cache内存。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cmoDesc | 输入 | Cache内存描述符地址指针，Device侧内存地址。<br>此处需先调用aclrtCmoSetDesc接口设置内存描述符，再将内存描述符地址指针作为入参传入本接口。 |
| cmoType | 输入 | Cache内存操作类型。类型定义请参见[aclrtCmoType](25-02_Enumerations.md#aclrtCmoType)。<br>当前仅支持ACL_RT_CMO_TYPE_PREFETCH（内存预取）。 |
| stream | 输入 | 执行内存操作任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
