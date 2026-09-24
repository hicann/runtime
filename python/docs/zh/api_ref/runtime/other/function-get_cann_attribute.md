# 函数：get\_cann\_attribute

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

查询运行环境是否支持指定的CANN特性。

## 函数原型

- **C函数原型**

    ```c
    aclError aclGetCannAttribute(aclCannAttr cannAttr, int32_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.get_cann_attribute(cann_attr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| cann_attr | int，特性列表枚举值，一次查询可指定其中一项，具体请参见[aclCannAttr](../datatypes/aclCannAttr.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| value | int，是否支持。<br>1：支持<br>0：不支持 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
