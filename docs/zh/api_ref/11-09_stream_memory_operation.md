# 11-09 流内存操作

本章节描述内存值写入与等待接口，用于在 Stream 上异步写入/等待内存值。

- [`aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWrite)：向指定内存中写数据。异步接口。
- [`aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)`](#aclrtValueWait)：等待指定内存中的数据满足一定条件后解除阻塞。异步接口。
- [`aclError aclrtStreamBatchMemOp(aclrtStreamBatchMemOpParams* paramArray, size_t count, uint32_t flags, aclrtStream stream)`](#aclrtStreamBatchMemOp)：按数组顺序批量提交内存值写入与等待操作。异步接口。

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

### 功能说明

按数组顺序批量提交64位内存值写入与等待操作。异步接口。

Runtime先遍历参数数组完成整批预检，全部通过后再按数组顺序逐项提交，参数错误不发布任务。
批内保持相对顺序，不保证整批独占流。捕获及模型绑定行为沿用[aclrtValueWrite](#aclrtValueWrite)、
[aclrtValueWait](#aclrtValueWait)，不额外施加限制。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| paramArray | 输入 | Host侧操作参数数组，至少包含count个元素。调用期间数组须保持有效且不被并发修改，调用返回后可释放或复用。各元素的设置方式见下表。 |
| count | 输入 | 操作数量，取值范围为[1,255]。 |
| flags | 输入 | 预留参数，当前固定设置为0。 |
| stream | 输入 | 执行内存操作任务的stream。类型定义请参见[aclrtStream](25-05_Typedefs.md#aclrtStream)。<br>此处支持传NULL，表示使用当前Context的默认Stream。 |

每个 `aclrtStreamBatchMemOpParams` 按操作设置以下成员：

| operation | 使用成员 | 有效字段 |
| --- | --- | --- |
| ACL_RT_STREAM_MEM_OP_VALUE_WAIT=0 | valueWait | operation、devAddr、value、flag；flag 为 GEQ/EQ/AND/NOR（0..3） |
| ACL_RT_STREAM_MEM_OP_VALUE_WRITE=1 | valueWrite | operation、devAddr、value、flag；flag 必须为 0 |

两种成员具有共同 operation 前缀，union 保留 `uint64_t reserved[6]`。64 位 Host 上 union 为
48 字节、8 字节对齐。调用前应将整个参数数组初始化为0，再填写各项操作的有效字段。
`reserved` 与有效字段共享存储空间，不要求整个 `reserved[6]` 为0；有效成员之后的未使用尾部必须保持为0，
即64位Host上的第32～47字节。成员内部的隐式对齐字节不参与校验。
地址范围和每项操作语义沿用单项接口，Write 地址须 8 字节对齐。应用负责完整 64 位访问有效性，
并保持目标 Device 内存有效到操作完成；属性检查不持有或锁定该分配。

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。

成功表示整批任务已接受，完成需用既有流同步机制观察。提交阶段失败可能已有前缀发布，
不回滚、不自动整批重试，也不提供精确执行项数。

### 约束说明

Wait 沿用单项循环 GEQ 与其他条件语义。同流 Wait 后的唯一 Write 无法解除前面的 Wait；
跨流循环等待也可能无法进展，调用者应安排可推进的生产者与明确的依赖关系。
本接口不承诺减少底层发送次数或固定性能收益。

支持 aclgraph 捕获，批内每项操作按顺序形成已有的 Value Write/Value Wait 任务，不形成独立的
Batch 任务。调用返回后可释放或复用 Host 参数数组，捕获任务保存地址、值和比较方式；
目标 Device 内存须按 aclgraph 资源生命周期要求保持有效。每次模型执行重放这些操作，
不会自动重置信号值；失败处理、跨流依赖及任务参数更新沿用单项接口和 aclgraph 的既有规则。

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
