# 11-09 流内存操作

本章节描述内存值写入与等待接口，用于在 Stream 上异步写入/等待内存值。

- [`aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWrite)：向指定内存中写数据。异步接口。
- [`aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWait)：等待指定内存中的数据满足一定条件后解除阻塞。异步接口。
- [`aclError aclrtStreamBatchMemOp(aclrtStreamBatchMemOpParams* paramArray, size_t count, uint32_t flags, aclrtStream stream)`](#aclrtStreamBatchMemOp)：按`paramArray`中的元素顺序批量提交写入或等待操作。异步接口。

<a class="method_anchor" id="aclrtValueWrite"></a>

## aclrtValueWrite

```c
aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2234 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id2234 -->
<!-- npu="A3" id2235 -->
- Atlas A3系列产品：支持
<!-- end id2235 -->
<!-- npu="910b" id2236 -->
- Atlas A2系列产品：支持
<!-- end id2236 -->
<!-- npu="310b" id2237 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id2237 -->
<!-- npu="310p" id2238 -->
- Atlas推理系列产品：不支持
<!-- end id2238 -->
<!-- npu="910" id2239 -->
- Atlas训练系列产品：不支持
<!-- end id2239 -->
<!-- npu="IPV350" id2240 -->
- IPV350：不支持
<!-- end id2240 -->
<!-- npu="5162A" id5001 -->
- Hisilicon5162A：不支持
<!-- end id5001 -->
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

<a class="method_anchor" id="aclrtValueWait"></a>

## aclrtValueWait

```c
aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id883 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id883 -->
<!-- npu="A3" id884 -->
- Atlas A3系列产品：支持
<!-- end id884 -->
<!-- npu="910b" id885 -->
- Atlas A2系列产品：支持
<!-- end id885 -->
<!-- npu="310b" id886 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id886 -->
<!-- npu="310p" id887 -->
- Atlas推理系列产品：不支持
<!-- end id887 -->
<!-- npu="910" id888 -->
- Atlas训练系列产品：不支持
<!-- end id888 -->
<!-- npu="IPV350" id889 -->
- IPV350：不支持
<!-- end id889 -->
<!-- npu="5162A" id5002 -->
- Hisilicon5162A：不支持
<!-- end id5002 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-09_stream_memory_operation_res.md#id2 -->

### 功能说明

等待指定内存中的数据满足一定条件后解除阻塞。异步接口。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| devAddr | 输入 | Device侧内存地址。<br>devAddr的有效内存位宽为64bit。 |
| value | 输入 | 需与内存中的数据作比较的值。 |
| flag | 输入 | 比较的方式，等满足条件后解除阻塞。取值如下：<br>ACL_STREAM_WAIT_VALUE_GEQ = 0x00000000U;  // 等到(int64_t)(\*devAddr - value) >= 0 <br>ACL_STREAM_WAIT_VALUE_EQ = 0x00000001U;  // 等到\*devAddr == value <br>ACL_STREAM_WAIT_VALUE_AND = 0x00000002U;  // 等到(\*devAddr & value) != 0 <br>ACL_STREAM_WAIT_VALUE_NOR = 0x00000003U;  // 等到~(\*devAddr \| value) != 0 |
| stream | 输入 | 执行等待任务的stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处支持传NULL，表示使用默认Stream。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

<br>
<br>
<br>

<a id="aclrtStreamBatchMemOp"></a>

## aclrtStreamBatchMemOp

```c
aclError aclrtStreamBatchMemOp(aclrtStreamBatchMemOpParams* paramArray, size_t count, uint32_t flags, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id5003 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id5003 -->
<!-- npu="A3" id5004 -->
- Atlas A3系列产品：支持
<!-- end id5004 -->
<!-- npu="910b" id5005 -->
- Atlas A2系列产品：支持
<!-- end id5005 -->
<!-- npu="310b" id5006 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id5006 -->
<!-- npu="310p" id5007 -->
- Atlas推理系列产品：不支持
<!-- end id5007 -->
<!-- npu="910" id5008 -->
- Atlas训练系列产品：不支持
<!-- end id5008 -->
<!-- npu="IPV350" id5009 -->
- IPV350：不支持
<!-- end id5009 -->
<!-- npu="5162A" id5010 -->
- Hisilicon5162A：不支持
<!-- end id5010 -->
<!-- @ref: runtime/res/docs/zh/api_ref/11-09_stream_memory_operation_res.md#id3 -->

### 功能说明

在指定Stream上按`paramArray`中的元素顺序提交写入或等待操作。写入值和比较值均为`uint64_t`类型。异步接口。

接口先检查数组指针、`count`和`flags`，再检查每项的操作类型、Device内存地址、`flag`和未使用的保留字节。全部通过后才开始提交。任一检查失败，整批不提交。

多个线程向同一Stream提交任务时，其他任务可能插入本批的两项操作之间。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| paramArray | 输入 | Host侧操作参数数组，至少包含`count`个元素。调用期间数组须保持有效且内容不变，接口返回后可释放或复用。类型定义请参见[aclrtStreamBatchMemOpParams](25-04_Structs.md#aclrtStreamBatchMemOpParams)。 |
| count | 输入 | 操作数量，取值范围为[1,255]。 |
| flags | 输入 | 预留参数，当前固定设置为0。 |
| stream | 输入 | 执行内存操作任务的Stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处支持传NULL，表示使用默认Stream。 |

### 返回值说明

返回0表示整批任务提交成功。在未处于捕获状态的Stream上提交任务后，可调用[aclrtSynchronizeStream](06_stream_management.md#aclrtSynchronizeStream)等待执行完成。

返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。逐项提交遇到错误时，接口立即返回，停止提交后续操作，已提交的操作不会撤销。返回值只提供错误码，调用方应避免直接重试整批。

### 约束说明

- 等待条件请参见[aclrtValueWait](#aclrtValueWait)的`flag`说明。若用写入解除等待，应将写入排在同一Stream的等待操作之前，或安排在能独立执行该写入的其他Stream上。避免多个Stream相互等待。
- 目标Device内存须保持有效，直至操作执行完成。
- 在处于ACL Graph捕获状态的Stream上调用时，本批操作按数组顺序记录到模型中，在调用[aclmdlRIExecuteAsync](15_model_running_instance_management.md#aclmdlRIExecuteAsync)执行模型时运行。目标Device内存须保持有效，直至模型最后一次执行完成。多次执行时，按业务需要初始化内存值。

### 调用示例

```c
aclrtStreamBatchMemOpParams ops[2] = {0};
ops[0].valueWrite.operation = ACL_RT_STREAM_MEM_OP_VALUE_WRITE;
ops[0].valueWrite.devAddr = devAddr;
ops[0].valueWrite.value = 1;
ops[1].valueWait.operation = ACL_RT_STREAM_MEM_OP_VALUE_WAIT;
ops[1].valueWait.devAddr = devAddr;
ops[1].valueWait.value = 1;
ops[1].valueWait.flag = ACL_STREAM_WAIT_VALUE_EQ;
aclError ret = aclrtStreamBatchMemOp(ops, 2, 0, stream);
/* 即使 ret 非 0，也不要自动重试整个批次。 */
```
