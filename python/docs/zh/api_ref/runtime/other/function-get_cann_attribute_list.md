# 函数：get\_cann\_attribute\_list

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

查询运行环境中CANN软件和对应芯片支持的特性列表。

## 函数原型

- **C函数原型**

    ```c
    aclError aclGetCannAttributeList(const aclCannAttr **cannAttrList, size_t *num)
    ```

- **python函数**

    ```python
    cann_attr_list, num, ret = acl.get_cann_attribute_list()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| cann_attr_list | list，用于保存运行环境支持的特性枚举列表，具体请参见[aclCannAttr](../datatypes/aclCannAttr.md)。<br>用户无需提前申请内存，应用进程退出时，内存自动释放。 |
| num | int，用于保存支持的特性数量，与“cann_attr_list”列表长度保持一致。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
