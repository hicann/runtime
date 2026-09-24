# 函数：get\_input\_name\_by\_index

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

获取模型中指定输入的输入名称。

## 函数原型

- **C函数原型**

    ```c
    const char *aclmdlGetInputNameByIndex(const aclmdlDesc *modelDesc, size_t index)
    ```

- **python函数**

    ```python
    input_name = acl.mdl.get_input_name_by_index(model_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型数据的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，指定获取第几个输入的大小，index值从0开始。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| input_name | str，返回指定输入的输入名称。 |
