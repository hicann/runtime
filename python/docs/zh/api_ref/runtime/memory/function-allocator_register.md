# 函数：allocator\_register

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

调用该接口注册用户提供的Allocator以及Allocator对应的回调函数，用于使用用户提供的Allocator。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
    ```

- **python函数**

    ```python
    ret = acl.rt.allocator_register(stream, allocatorDesc)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，该Allocator需要注册的Stream。传入的stream参数值不能为NULL，否则返回报错。 |
| allocatorDesc | int，Allocator描述符指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 当前仅支持在单算子模型执行、动态shape模型推理场景下使用本接口。

    单算子模型场景下，需在算子执行接口（例如：`acl.op.execute_v2`等）之前调用本接口。

    动态shape模型推理场景，本接口需配合aclmdlExecuteAsync接口一起使用，且需在aclmdlExecuteAsync接口之前调用本接口。

- 调用本接口前，需要先调用[acl.rt.allocator\_create\_desc](../datatypes/function-allocator_create_desc.md)创建Allocator描述符，再分别调用[acl.rt.allocator\_set\_obj\_to\_desc](../datatypes/function-allocator_set_obj_to_desc.md)、[acl.rt.allocator\_set\_alloc\_func\_to\_desc](../datatypes/function-allocator_set_alloc_func_to_desc.md)、[acl.rt.allocator\_set\_get\_addr\_from\_block\_func\_to\_desc](../datatypes/function-allocator_set_get_addr_from_block_func_to_desc.md)、[acl.rt.allocator\_set\_free\_func\_to\_desc](../datatypes/function-allocator_set_free_func_to_desc.md)设置Allocator对象及回调函数。Allocator描述符使用完成后，可调用[acl.rt.allocator\_destroy\_desc](../datatypes/function-allocator_destroy_desc.md)接口销毁Allocator描述符。
- 对于同一条流，多次调用本接口，以最后一次注册为准。
- 对于不同流，如果用户使用同一个Allocator，不可以多条流并发执行，在执行下一条Stream前，需要对上一Stream做流同步。
- 将Allocator中的内存释放给操作系统前，需要先调用[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)接口执行流同步，确保Stream中的任务已执行完成。
