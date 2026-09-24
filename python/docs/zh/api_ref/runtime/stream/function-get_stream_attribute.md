# 函数：get\_stream\_attribute

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

获取Stream属性值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.get_stream_attribute(stream, stm_attr_type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定Stream。 |
| stm_attr_type | int，属性类型。具体请参见新增数据结构[aclrtStreamAttr](../datatypes/aclrtStreamAttr.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| value | dict，属性值。具体请参见新增数据结构[aclrtStreamAttrValue](../datatypes/aclrtStreamAttrValue.md)。 |
| ret | int，返回0表示成功，返回其他值表示失败，请参见[其它值](../datatypes/aclError.md)。 |

## 约束说明

<!-- npu="950,A3,910b" id7 -->
- 对于Ascend 950PR&950DT系列产品、Atlas A3系列产品、Atlas A2系列产品，支持指定默认Stream（即stream参数传入0）。
<!-- end id7 -->
<!-- npu="910,310p,310b" id8 -->
- 对于Atlas 200I/500 A2推理产品、Atlas推理系列产品、Atlas训练系列产品，不支持指定默认Stream（即stream参数传入0）。
<!-- end id8 -->
