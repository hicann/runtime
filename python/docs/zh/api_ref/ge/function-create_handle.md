# 函数：create\_handle

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
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

创建一个执行算子的handle。

如需销毁handle，请参见[acl.op.destroy\_handle](function-destroy_handle.md)。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopCreateHandle(const char *opType, int numInputs, const aclTensorDesc *const inputDesc[], int numOutputs, const aclTensorDesc *const outputDesc[], const aclopAttr *opAttr, aclopHandle **handle)
    ```

- **python函数**

    ```python
    handle, ret = acl.op.create_handle(op_type, input_desc, output_desc, op_attr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_type | str，指定算子类型名称字符串类型。 |
| input_desc | list，算子输入Tensor的描述，整形列表。 |
| output_desc | list，算子输出Tensor的描述，整形列表。 |
| op_attr | int，算子属性指针地址，此对象使用调用[acl.op.create_attr](function-create_attr.md)创建。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| handle | int，算子handle地址对象。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

对于算子有constant输入的场景，如果未调用[acl.set\_tensor\_const](function-set_tensor_const.md)接口设置constant输入，则需调用[acl.set\_tensor\_place\_ment](function-set_tensor_place_ment.md)设置TensorDesc的placement属性，将mem\_type设置为Host内存。
