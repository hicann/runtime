# 函数：allocator\_set\_obj\_to\_desc

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

使用用户提供的Allocator场景下，向Allocator描述信息中设置Allocator对象。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtAllocatorSetObjToDesc(aclrtAllocatorDesc allocatorDesc,  aclrtAllocator allocator)
    ```

- **python函数**

    ```python
    ret = acl.rt.allocator_set_obj_to_desc(allocatorDesc, allocator)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| allocatorDesc | int，Allocator描述符指针地址。需提前调用[acl.rt.allocator_create_desc](function-allocator_create_desc.md)接口设置Allocator描述信息。 |
| allocator | int，用户提供的Allocator对象指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
