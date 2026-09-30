# 函数：allocator\_set\_get\_addr\_from\_block\_func\_to\_desc

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

使用用户提供的Allocator场景下，设置"根据申请来的block获取device内存地址"的回调函数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtAllocatorSetGetAddrFromBlockFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorGetAddrFromBlockFunc func)
    ```

- **python函数**

    ```python
    ret = acl.rt.allocator_set_get_addr_from_block_func_to_desc(allocatorDesc, func)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| allocatorDesc | int，Allocator描述符指针地址。需提前调用[acl.rt.allocator_create_desc](function-allocator_create_desc.md)接口设置Allocator描述信息。 |
| func | 根据申请来的block获取device内存地址的回调函数。<br>回调函数定义如下：<br>`def allocator_get_addr_from_block_func(block): pass` |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
