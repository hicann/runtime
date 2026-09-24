# 函数：get\_tensor\_desc\_address

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

获取指定算子输入/输出的Tensor数据的指针地址。

## 函数原型

- **C函数原型**

    ```c
    void *aclGetTensorDescAddress(const aclTensorDesc *desc)
    ```

- **python函数**

    ```python
    addr = acl.get_tensor_desc_address(desc)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，Tensor描述信息的指针地址。调用[acl.get_tensor_desc_by_index](function-get_tensor_desc_by_index.md)接口获取算子所有输入/输出的Tensor描述，作为本接口的输入。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| addr | int，返回指定算子输入/输出的Tensor数据的指针地址。 |
