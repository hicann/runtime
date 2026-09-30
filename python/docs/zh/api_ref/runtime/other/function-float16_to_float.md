# 函数：float16\_to\_float

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

将[aclFloat16](../datatypes/aclFloat16.md)类型的数据转换为float（指float32）类型的数据。

## 函数原型

- **C函数原型**

    ```c
    float aclFloat16ToFloat(aclFloat16 value)
    ```

- **python函数**

    ```python
    output = acl.float16_to_float(value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| value | int，待转化的数据，[aclFloat16](../datatypes/aclFloat16.md)类型的数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| output | float，浮点数类型。 |
