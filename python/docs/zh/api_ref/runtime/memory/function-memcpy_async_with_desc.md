# 函数：memcpy\_async\_with\_desc

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
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

使用内存复制描述符（二级指针方式）进行内存复制。

本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保任务已执行完成，否则可能会导致训练或推理等业务异常、Device断链掉卡等未知情况。

本接口需与以下其它关键接口配合使用，以便实现内存复制：

- 调用[acl.rt.get\_memcpy\_desc\_size](function-get_memcpy_desc_size.md)接口获取内存描述符所需的内存大小。
- 申请Device内存，用于存放内存描述符。
- 申请源内存、目的内存，分别用于存放复制前后的数据。
- 调用[acl.rt.set\_memcpy\_desc](function-set_memcpy_desc.md)接口将源内存地址、目的内存地址等信息设置到内存描述符中。
- 调用[acl.rt.memcpy\_async\_with\_desc](function-memcpy_async_with_desc.md)接口实现内存复制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemcpyAsyncWithDesc(void *desc, aclrtMemcpyKind kind, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.memcpy_async_with_desc(desc, kind, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，内存复制描述符地址指针，Device侧内存地址。此处需先调用[acl.rt.set_memcpy_desc](function-set_memcpy_desc.md)接口设置内存复制描述符，再将内存复制描述符地址指针作为入参传入本接口。 |
| kind | int，内存复制的类型。当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| stream | int，指定stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
