# 函数：get\_tensor\_desc\_by\_index

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

获取算子的指定Index的Tensor描述信息。

## 函数原型

- **C函数原型**

    ```c
    aclTensorDesc *aclGetTensorDescByIndex(aclTensorDesc *desc, size_t index)
    ```

- **python函数**

    ```python
    tensor_desc = acl.get_tensor_desc_by_index(desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，Tensor描述数据的指针地址。调用[acl.mdl.create_and_get_op_desc](function-create_and_get_op_desc.md)接口，获取算子所有输入/输出的Tensor描述作为本接口的输入。 |
| index | int，指定获取第几个维度的大小，index值从0开始。调用[acl.mdl.create_and_get_op_desc](function-create_and_get_op_desc.md)接口获取的算子输入/输出的数量后，该index的取值范围：[0, (算子输入/输出的数量<br> 1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| tensor_desc | int，返回指定输入/输出的Tensor描述信息的指针地址。 |
