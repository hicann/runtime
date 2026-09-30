# 函数：get\_op\_attr

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

获取整网中某个模型中某个算子的属性的值。

## 函数原型

- **C函数原型**

    ```c
    const char *aclmdlGetOpAttr(aclmdlDesc *modelDesc, const char *opName, const char *attr)
    ```

- **python函数**

    ```python
    attr_value = acl.mdl.get_op_attr(model_desc, op_name, attr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据，再调用[acl.mdl.get_desc](function-get_desc.md)接口根据模型ID获取到对应的aclmdlDesc类型的数据。 |
| op_name | str，算子名称。 |
| attr | str，算子属性。当前仅支持_datadump_original_op_names属性，用于记录某个算子是由哪些算子融合得到的。通过本接口获取到的_datadump_original_op_names属性值格式为[opName1_len]opName1…..[opNameN_len]opNameN，opNameN_len表示算子名称字符串的长度。_datadump_original_op_names属性值示例如下，表示某个融合算子由scale2c_branch2c、bn2c_branch2c、res2c_branch2c、res2c、res2c_relu这五个算子融合而成的，算子名称字符串的长度分别为16、13、14、5、10：[16]scale2c_branch2c[13]bn2c_branch2c[14]res2c_branch2c[5]res2c[10]res2c_relu |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| attr_value | str，返回属性值的字符串，若opName或者attr属性不存在或者attr属性值为空，均返回空字符串。若调用该接口失败，则返回None。 |
