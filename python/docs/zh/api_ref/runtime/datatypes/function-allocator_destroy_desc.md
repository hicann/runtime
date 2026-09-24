# 函数：allocator\_destroy\_desc

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

销毁通过[acl.rt.allocator\_create\_desc](function-allocator_create_desc.md)接口创建的aclrtAllocatorDesc类型的数据。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtAllocatorDestroyDesc(aclrtAllocatorDesc alloctorDesc)
    ```

- **python函数**

    ```python
    ret = acl.rt.allocator_destroy_desc(alloctorDesc)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| allocatorDesc | int，待销毁的aclrtAllocatorDesc类型的数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
