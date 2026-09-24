# 函数：execute

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

执行指定的算子。异步接口。

>[!NOTE] 须知
>此接口后续版本会废弃，请使用[acl.op.execute\_v2](function-execute_v2-1.md)接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopExecute(const char *opType, int numInputs, const aclTensorDesc *const inputDesc[], const aclDataBuffer *const inputs[], int numOutputs, const aclTensorDesc *const outputDesc[], aclDataBuffer *const outputs[], const aclopAttr *attr, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.op.execute(op_type, input_desc, inputs, output_desc, outputs, attr,stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_type | str，指定算子类型名称。 |
| input_desc | list，表示算子输入Tensor的描述, 整形列表，包含多个acl的Tensor描述地址对象。 |
| inputs | list，表示算子输入Tensor，整形列表，包含多个aclDataBuffer数据地址对象。 |
| output_desc | list，表示算子输出Tensor的描述，整形列表，包含多个acl的Tensor描述地址对象。 |
| outputs | list，表示算子输出Tensor，整形列表，包含多个aclDataBuffer数据地址对象。 |
| attr | int，算子的属性地址对象。 |
| stream | int，该算子需要加载的Stream对象。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，`acl.rt.synchronize\_stream`）确保任务已执行完成。
- 多线程场景下，不支持调用本接口时指定同一个Stream或使用默认Stream，否则可能任务执行异常。
- 每个算子的输入、输出、属性不同，需要应用在调用时严格按照算子输入、输出、属性来组织算子。用户在调用acl.op.execute接口时，根据op\_type、输入Tensor的描述、输出Tensor的描述、attr等信息查找对应的任务，并下发执行。
