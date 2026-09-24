# 函数：get\_tensor\_desc\_type

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

获取Tensor描述中的数据类型。

## 函数原型

- **C函数原型**

    ```c
    aclDataType aclGetTensorDescType(const aclTensorDesc *desc)
    ```

- **python函数**

    ```python
    type = acl.get_tensor_desc_type(desc)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，aclTensorDesc类型的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| type | int，返回指定Tensor描述的数据类型。 |
