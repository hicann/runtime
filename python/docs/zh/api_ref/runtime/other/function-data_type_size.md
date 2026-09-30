# 函数：data\_type\_size

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

获取[aclDataType](../datatypes/aclDataType.md)数据的大小，单位Byte。

## 函数原型

- **C函数原型**

    ```c
    size_t aclDataTypeSize(aclDataType dataType)
    ```

- **python函数**

    ```python
    size = acl.data_type_size(data_type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data_type | int，指定要获取大小的aclDataType数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| size | int，aclDataType数据的大小，单位Byte。 |
