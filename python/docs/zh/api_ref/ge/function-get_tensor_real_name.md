# 函数：get\_tensor\_real\_name

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

根据指定名称获取Tensor的真实名称。

acl.mdl.get\_tensor\_real\_name接口需要与以下接口配合使用。

- [acl.mdl.get\_input\_dims](function-get_input_dims.md)
- [acl.mdl.get\_input\_dims\_v2](function-get_input_dims_v2.md)
- [acl.mdl.get\_output\_dims](function-get_output_dims.md)
- [acl.mdl.get\_cur\_output\_dims](function-get_cur_output_dims.md)

## 函数原型

- **C函数原型**

    ```c
    const char *aclmdlGetTensorRealName(const aclmdlDesc *modelDesc, const char *name)
    ```

- **python函数**

    ```python
    real_name = acl.mdl.get_tensor_real_name(model_desc, name)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| name | str，指定名称，用于根据该名称获取Tensor的真实名称。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| real_name | str，返回Tensor真实名称。若model_desc或name为空，则返回0。 |
