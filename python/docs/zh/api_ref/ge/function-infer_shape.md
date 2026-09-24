# 函数：infer\_shape

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

根据算子的输入Shape、输入值推导出算子的输出Shape。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopInferShape(const char *opType, int numInputs, aclTensorDesc *inputDesc[], aclDataBuffer *inputs[], int numOutputs, aclTensorDesc *outputDesc[], aclopAttr *attr)
    ```

- **python函数**

    ```python
    ret = acl.op.infer_shape(op_type, in_desc_list, in_list, num_outputs, out_desc_list, attr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_type | int，指定算子类型名称。 |
| in_desc_list | list，算子输入Tensor的描述。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| in_list | list，算子输入Tensor。此处算子输入Tensor数据的内存必须根据应用运行模式来确定，应用运行在Host时，此处需申请Host上的内存。应用运行在Device时，此处需申请Device上的内存。内存申请接口请参见[内存管理](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/API/runtimeapi/aclpythondevg_01_0109.html)。 |
| num_outputs | int，算子输出Tensor的数量。 |
| out_desc_list | list，算子输出Tensor的描述。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。out_desc_list列表中的元素个数必须与num_outputs参数值保持一致。 |
| attr | int，算子的属性地址对象。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 推导算子的输出Shape包含三种场景：
    - 根据Shape推导，可以得到算子的准确输出Shape，则返回准确输出Shape。
    - 根据Shape推导，无法得到算子的准确输出Shape，但可以得到输出Shape的范围，则在输出参数out\_desc\_list中将算子输出Tensor描述中的动态维度的维度值记为-1。该场景下，用户可调用[get\_tensor\_desc\_dim\_range](function-get_tensor_desc_dim_range.md)接口获取Tensor描述中指定维度的范围值。
    - （该场景预留）根据Shape推导，无法得到算子的准确输出Shape以及Shape范围，则在输出参数out\_desc\_list中将算子输出Tensor描述中的动态维度的维度值记为-2。

- 如果算子有动态输入或动态输出，在调用acl.op.infer\_shape接口推导算子的输出Shape前，需先调用[set\_tensor\_desc\_name](function-set_tensor_desc_name.md)接口设置所有输入和输出的Tensor描述的名称，且名称必须按照如下要求（算子IR原型中定义的输入/输出名称请参见《算子库》的“Ascend IR算子规格说明”。）

    - 对于必选输入、可选输入、必选输出，名称必须与算子IR原型中定义的输入/输出名称保持一致。
    - 对于动态输入、动态输出，名称必须是：算子IR原型中定义的输入/输出名称+_编号_。编号根据动态输入/输出的个数确定，从0开始，0对应第一个动态输入/输出，1对应第二个动态输入/输出，以此类推。

    例如某个算子有2个输入（第1个是必选输入x，第二个是动态输入y且输入个数为2）、1个必选输出z，则调用[set\_tensor\_desc\_name](function-set_tensor_desc_name.md)接口设置名称的代码示例如下：

    ```python
    acl.set_tensor_desc_name(input_tensor_desc[0], "x");
    acl.set_tensor_desc_name(input_tensor_desc[1], "y0");
    acl.set_tensor_desc_name(input_tensor_desc[2], "y1");
    acl.set_tensor_desc_name(input_tensor_desc[0], "z");
    ```
