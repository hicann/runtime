# 函数：get\_tensor\_desc\_dim

**须知：此接口后续版本会废弃，请使用[acl.get\_tensor\_desc\_dim\_v2](function-get_tensor_desc_dim_v2.md)接口。**

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

获取Tensor描述中指定维度的大小。

## 函数原型

- **C函数原型**

    ```c
    int64_t aclGetTensorDescDim(const aclTensorDesc *desc, size_t index)
    ```

- **python函数**

    ```python
    dim_size = acl.get_tensor_desc_dim(desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，aclTensorDesc类型的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| index | int，指定获取第几个维度的大小，index值从0开始。用户调用acl.get_tensor_desc_dim接口获取Shape维度个数，index的取值范围：[0, (shape维度个数<br> 1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dim_size | int，获取Tensor描述中指定维度的大小。 |
