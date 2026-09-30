# 函数：destroy\_attr

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

销毁通过[acl.op.create\_attr](function-create_attr.md)接口创建的aclopAttr类型的数据。

## 函数原型

- **C函数原型**

    ```c
    void aclopDestroyAttr(const aclopAttr *attr)
    ```

- **python函数**

    ```python
    acl.op.destroy_attr(attr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| attr | int，待销毁的aclopAttr类型数据指针地址，此对象使用调用[acl.op.create_attr](function-create_attr.md)创建。 |

## 返回值说明

无
