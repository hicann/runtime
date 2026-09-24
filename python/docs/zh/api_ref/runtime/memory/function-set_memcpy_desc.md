# 函数：set\_memcpy\_desc

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

设置内存复制描述符，此接口调用完成后，会将源地址，目的地址、内存复制长度记录到内存复制描述符中。

本接口需与其它关键接口配合使用，以便实现内存复制，详细描述请参见[acl.rt.memcpy\_async\_with\_desc](function-memcpy_async_with_desc.md)。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)
    ```

- **python函数**

    ```python
    desc, ret = acl.rt.set_memcpy_desc(desc, kind, src_addr, dst_addr, count, config)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，内存复制描述符地址指针。<br>需先调用[acl.rt.get_memcpy_desc_size](function-get_memcpy_desc_size.md)接口获取内存描述符所需的内存大小，再申请Device内存后（例如[acl.rt.malloc](../memory/function-malloc.md)接口），将Device内存地址作为入参传入此处。 |
| kind | int，内存复制的类型。当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| src_addr | int，源内存地址指针。由用户申请内存并管理内存。 |
| dst_addr | int，目的内存地址指针。由用户申请内存并管理内存。 |
| count | int，内存复制的长度，单位Byte。 |
| config | int，预留参数，当前固定传0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| desc | int，内存复制描述符地址指针。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
