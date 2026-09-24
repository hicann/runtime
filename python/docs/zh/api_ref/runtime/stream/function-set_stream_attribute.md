# 函数：set\_stream\_attribute

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

设置Stream属性值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_stream_attribute(stream, stm_attr_type, value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定Stream。 |
| stm_attr_type | int，属性类型。具体请参见新增数据结构[aclrtStreamAttr](../datatypes/aclrtStreamAttr.md)。 |
| value | dict，属性值。具体请参见新增数据结构[aclrtStreamAttrValue](../datatypes/aclrtStreamAttrValue.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |

## 约束说明

- 溢出检测属性：调用该接口打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。
- 对于Ascend 950PR&950DT系列产品、Atlas A3系列产品、Atlas A2系列产品，支持指定默认Stream（即stream参数传入0）。
- 对于Atlas 200I/500 A2推理产品、Atlas推理系列产品、Atlas训练系列产品，不支持指定默认Stream（即stream参数传入0）。
- Failure Mode：不支持对Context默认Stream设置Failure Mode。
<!-- npu="A3,910b,910,310p,310b" id7 -->
- stm\_attr\_type设置为ACL\_STREAM\_ATTR\_FAILURE\_MODE时，支持如下产品型号：
  <!-- npu="310p" id8 -->
  - Atlas推理系列产品
  <!-- end id8 -->
  <!-- npu="310b" id9 -->
  - Atlas 200I/500 A2推理产品
  <!-- end id9 -->
  <!-- npu="910" id10 -->
  - Atlas训练系列产品
  <!-- end id10 -->
  <!-- npu="910b" id11 -->
  - Atlas A2系列产品
  <!-- end id11 -->
  <!-- npu="A3" id12 -->
  - Atlas A3系列产品
  <!-- end id12 -->
<!-- end id7 -->

<!-- npu="A3,910b" id13 -->
- stm\_attr\_type设置为ACL\_STREAM\_ATTR\_FLOAT\_OVERFLOW\_CHECK、ACL\_STREAM\_ATTR\_USER\_CUSTOM\_TAG时，支持如下产品型号：
  <!-- npu="910b" id14 -->
  - Atlas A2系列产品
  <!-- end id14 -->
  <!-- npu="A3" id15 -->
  - Atlas A3系列产品
  <!-- end id15 -->
<!-- end id13 -->
