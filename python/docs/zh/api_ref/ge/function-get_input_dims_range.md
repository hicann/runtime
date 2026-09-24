# 函数：get\_input\_dims\_range

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

根据模型描述信息获取模型的输入tensor的维度范围。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetInputDimsRange(const aclmdlDesc *modelDesc, size_t index, aclmdlIODimsRange *dimsRange)
    ```

- **python函数**

    ```python
    dims_range, ret = acl.mdl.get_input_dims_range(model_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型的指针。需提前调用[create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，指定获取第几个输入的维度信息，index值从0开始。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dims_range | dict，输入维度信息的字典。参考[aclmdlIODimsRange](aclmdlIODimsRange.md)。<br> 动态Shape且配置Shape范围的场景下，返回Shape范围，动态维度上下限不相同，静态维度上下限相同。例如，输入tensor的format为NCHW，dims为[1,3,10~224,10~300]，N和C维上是固定值，H和W维上是动态范围，那么通过本接口aclmdlIODimsRange.rangeCount为4，aclmdlIODimsRange.range数组中有4个元素，值分别为：{1,1}、{3,3}、{10,224}、{10,300}。<br> 动态Shape且配置分档的场景下，不支持使用本接口，aclmdlIODimsRange.rangeCount返回0。<br> 静态Shape场景下，返回Shape范围，但各维度上下限相同。 |
| ret | int，返回0表示成功，返回非0表示失败。 |
