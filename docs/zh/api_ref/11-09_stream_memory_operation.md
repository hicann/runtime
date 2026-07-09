# 11-09 流内存操作

本章节描述内存值写入与等待接口，用于在 Stream 上异步写入/等待内存值。

- [`aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWrite)：向指定内存中写数据。异步接口。
- [`aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWait)：等待指定内存中的数据满足一定条件后解除阻塞。异步接口。

<a id="aclrtValueWrite"></a>

## aclrtValueWrite

```c
aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2234 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2234 -->
<!-- npu="A3" id2235 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2235 -->
<!-- npu="910b" id2236 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2236 -->
<!-- npu="310b" id2237 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id2237 -->
<!-- npu="310p" id2238 -->
- Atlas 推理系列产品：不支持
<!-- end id2238 -->
<!-- npu="910" id2239 -->
- Atlas 训练系列产品：不支持
<!-- end id2239 -->
<!-- npu="IPV350" id2240 -->
- IPV350：不支持
<!-- end id2240 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-09_stream_memory_operation_res.md#id1 -->

### 功能说明

向指定内存中写数据。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devAddr | 输入 | Device侧内存地址。<br>此处需用户提前申请Device内存（例如调用aclrtMalloc接口），devAddr要求8字节对齐，有效内存位宽为64bit。 |
| value | 输入 | 需向内存中写入的数据。 |
| flag | 输入 | 预留参数，当前固定设置为0。 |
| stream | 输入 | 执行写数据任务的stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处支持传NULL，表示使用默认Stream。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtValueWait"></a>

## aclrtValueWait

```c
aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id883 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id883 -->
<!-- npu="A3" id884 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id884 -->
<!-- npu="910b" id885 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id885 -->
<!-- npu="310b" id886 -->
- Atlas 200I/500 A2 推理产品：不支持
<!-- end id886 -->
<!-- npu="310p" id887 -->
- Atlas 推理系列产品：不支持
<!-- end id887 -->
<!-- npu="910" id888 -->
- Atlas 训练系列产品：不支持
<!-- end id888 -->
<!-- npu="IPV350" id889 -->
- IPV350：不支持
<!-- end id889 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-09_stream_memory_operation_res.md#id2 -->

### 功能说明

等待指定内存中的数据满足一定条件后解除阻塞。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devAddr | 输入 | Device侧内存地址。<br>devAddr的有效内存位宽为64bit。 |
| value | 输入 | 需与内存中的数据作比较的值。 |
| flag | 输入 | 比较的方式，等满足条件后解除阻塞。取值如下：<br>ACL_STREAM_WAIT_VALUE_GEQ = 0x00000000U;  // 等到(int64_t)(*devAddr - value) >= 0 <br>ACL_STREAM_WAIT_VALUE_EQ = 0x00000001U;  // 等到*devAddr == value <br>ACL_STREAM_WAIT_VALUE_AND = 0x00000002U;  // 等到(*devAddr & value) != 0 <br>ACL_STREAM_WAIT_VALUE_NOR = 0x00000003U;  // 等到~(*devAddr \| value) != 0 |
| stream | 输入 | 执行等待任务的stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处支持传NULL，表示使用默认Stream。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
