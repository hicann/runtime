# 函数：set\_attr\_bool

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

设置bool类型标量的属性值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopSetAttrBool(aclopAttr *attr, const char *attrName, uint8_t attrValue)
    ```

- **python函数**

    ```python
    ret = acl.op.set_attr_bool(attr, attr_name, attr_value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| attr | int，aclopAttr类型数据的指针地址。需提前调用[acl.op.create_attr](function-create_attr.md)接口创建aclopAttr类型数据。 |
| attr_name | str，属性名。 |
| attr_value | int，属性值。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
