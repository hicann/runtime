# 函数：set\_tensor\_storage\_format

**须知：此接口后续版本会废弃，请使用[acl.set\_tensor\_format](function-set_tensor_format.md)接口。**

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
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

调用[acl.create\_tensor\_desc](function-create_tensor_desc.md)接口创建Tensor描述信息后，可通过acl.set\_tensor\_storage\_format设置Tensor的实际Format信息，当前主要用于PyTorch场景下。

## 函数原型

- **C函数原型**

    ```c
    aclError aclSetTensorStorageFormat(aclTensorDesc *desc, aclFormat format)
    ```

- **python函数**

    ```python
    ret = acl.set_tensor_storage_format(desc, format)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，aclTensorDesc类型的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| format | int，指定Tensor描述的格式。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
