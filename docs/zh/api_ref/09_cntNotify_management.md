# 9. CntNotify管理

本章节描述 CANN Runtime 的 CntNotify（计数型通知）管理接口，用于 CntNotify 的创建、记录、等待及销毁。

- [`aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag)`](#aclrtCntNotifyCreate)：创建CntNotify。
- [`aclError aclrtCntNotifyRecord(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo *info)`](#aclrtCntNotifyRecord)：在指定Stream上记录一个CntNotify。异步接口。
- [`aclError aclrtCntNotifyWaitWithTimeout(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo *info)`](#aclrtCntNotifyWaitWithTimeout)：阻塞指定Stream的运行，直到指定的CntNotify完成。异步接口。
- [`aclError aclrtCntNotifyReset(aclrtCntNotify cntNotify, aclrtStream stream)`](#aclrtCntNotifyReset)：复位一个CntNotify，将CntNotify的计数值清空为0。异步接口。
- [`aclError aclrtCntNotifyGetId(aclrtCntNotify cntNotify, uint32_t *notifyId)`](#aclrtCntNotifyGetId)：获取CntNotify的ID。
- [`aclError aclrtCntNotifyDestroy(aclrtCntNotify cntNotify)`](#aclrtCntNotifyDestroy)：销毁CntNotify。

<a id="aclrtCntNotifyCreate"></a>

## aclrtCntNotifyCreate

```c
aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag)
```

### 产品支持情况

<!-- npu="950" id1961 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1961 -->
<!-- npu="A3" id1962 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id1962 -->
<!-- npu="910b" id1963 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id1963 -->
<!-- npu="310b" id1964 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1964 -->
<!-- npu="310p" id1965 -->
- Atlas 推理系列产品：不支持
<!-- end id1965 -->
<!-- npu="910" id1966 -->
- Atlas 训练系列产品：不支持
<!-- end id1966 -->
<!-- npu="IPV350" id1967 -->
- IPV350：不支持
<!-- end id1967 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id1 -->

### 功能说明

创建CntNotify。

CntNotify通常也用于Device与Device之间的状态/动作通信通知。但CntNotify是利用计数值实现任务间的同步，跟Notify的区别是，Notify的计数值仅支持1，CntNotify的计数值支持\[1\~uint32\_t最大值\]。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输出 | CntNotify的指针。类型定义请参见[aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify)。 |
| flag | 输入 | 预留参数，当前固定配置为0。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCntNotifyRecord"></a>

## aclrtCntNotifyRecord

```c
aclError aclrtCntNotifyRecord(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo *info)
```

### 产品支持情况

<!-- npu="950" id3123 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id3123 -->
<!-- npu="A3" id3124 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id3124 -->
<!-- npu="910b" id3125 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id3125 -->
<!-- npu="310b" id3126 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id3126 -->
<!-- npu="310p" id3127 -->
- Atlas 推理系列产品：不支持
<!-- end id3127 -->
<!-- npu="910" id3128 -->
- Atlas 训练系列产品：不支持
<!-- end id3128 -->
<!-- npu="IPV350" id3129 -->
- IPV350：不支持
<!-- end id3129 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id2 -->

### 功能说明

在指定Stream上记录一个CntNotify。异步接口。

aclrtCntNotifyRecord接口与aclrtCntNotifyWaitWithTimeout接口配合使用时，主要用于多Stream之间同步等待的场景。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | 需记录的CntNotify。类型定义请参见[aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>如果使用默认Stream，此处设置为NULL。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream1。 |
| info | 输入 | 控制Record的行为模式。类型定义请参见[aclrtCntNotifyRecordInfo](25-04_Structs.md#aclrtCntNotifyRecordInfo)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCntNotifyWaitWithTimeout"></a>

## aclrtCntNotifyWaitWithTimeout

```c
aclError aclrtCntNotifyWaitWithTimeout(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo *info)
```

### 产品支持情况

<!-- npu="950" id2199 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2199 -->
<!-- npu="A3" id2200 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2200 -->
<!-- npu="910b" id2201 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2201 -->
<!-- npu="310b" id2202 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2202 -->
<!-- npu="310p" id2203 -->
- Atlas 推理系列产品：不支持
<!-- end id2203 -->
<!-- npu="910" id2204 -->
- Atlas 训练系列产品：不支持
<!-- end id2204 -->
<!-- npu="IPV350" id2205 -->
- IPV350：不支持
<!-- end id2205 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id3 -->

### 功能说明

阻塞指定Stream的运行，直到指定的CntNotify完成。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | 需等待的CntNotify。类型定义请参见[aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>如果使用默认Stream，此处设置为NULL。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream2。 |
| info | 输入 | 控制Wait的行为模式。类型定义请参见[aclrtCntNotifyWaitInfo](25-04_Structs.md#aclrtCntNotifyWaitInfo)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCntNotifyReset"></a>

## aclrtCntNotifyReset

```c
aclError aclrtCntNotifyReset(aclrtCntNotify cntNotify, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2045 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2045 -->
<!-- npu="A3" id2046 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id2046 -->
<!-- npu="910b" id2047 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id2047 -->
<!-- npu="310b" id2048 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2048 -->
<!-- npu="310p" id2049 -->
- Atlas 推理系列产品：不支持
<!-- end id2049 -->
<!-- npu="910" id2050 -->
- Atlas 训练系列产品：不支持
<!-- end id2050 -->
<!-- npu="IPV350" id2051 -->
- IPV350：不支持
<!-- end id2051 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id4 -->

### 功能说明

复位一个CntNotify，将CntNotify的计数值清空为0。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | CntNotify的指针。类型定义请参见[aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify)。 |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>如果使用默认Stream，此处设置为NULL。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream2。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCntNotifyGetId"></a>

## aclrtCntNotifyGetId

```c
aclError aclrtCntNotifyGetId(aclrtCntNotify cntNotify, uint32_t *notifyId)
```

### 产品支持情况

<!-- npu="950" id358 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id358 -->
<!-- npu="A3" id359 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id359 -->
<!-- npu="910b" id360 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id360 -->
<!-- npu="310b" id361 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id361 -->
<!-- npu="310p" id362 -->
- Atlas 推理系列产品：不支持
<!-- end id362 -->
<!-- npu="910" id363 -->
- Atlas 训练系列产品：不支持
<!-- end id363 -->
<!-- npu="IPV350" id364 -->
- IPV350：不支持
<!-- end id364 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id5 -->

### 功能说明

获取CntNotify的ID。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | cntNotify的指针。类型定义请参见[aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify)。 |
| notifyId | 输出 | cntNotify ID。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtCntNotifyDestroy"></a>

## aclrtCntNotifyDestroy

```c
aclError aclrtCntNotifyDestroy(aclrtCntNotify cntNotify)
```

### 产品支持情况

<!-- npu="950" id1058 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id1058 -->
<!-- npu="A3" id1059 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持
<!-- end id1059 -->
<!-- npu="910b" id1060 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持
<!-- end id1060 -->
<!-- npu="310b" id1061 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id1061 -->
<!-- npu="310p" id1062 -->
- Atlas 推理系列产品：不支持
<!-- end id1062 -->
<!-- npu="910" id1063 -->
- Atlas 训练系列产品：不支持
<!-- end id1063 -->
<!-- npu="IPV350" id1064 -->
- IPV350：不支持
<!-- end id1064 -->
<!-- @ref: runtime/res/docs/zh/api_ref/09_cntNotify_management_res.md#id6 -->

### 功能说明

销毁CntNotify。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| cntNotify | 输入 | CntNotify的指针。类型定义请参见[aclrtCntNotify](25-05_Typedefs.md#aclrtCntNotify)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
