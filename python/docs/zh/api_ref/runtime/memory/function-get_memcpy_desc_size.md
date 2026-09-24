# 函数：get\_memcpy\_desc\_size

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

获取当前Device的内存复制描述符占用的内存大小。

本接口需与其它关键接口配合使用，以便实现内存复制，详细描述请参见[acl.rt.memcpy\_async\_with\_desc](function-memcpy_async_with_desc.md)。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetMemcpyDescSize(aclrtMemcpyKind kind, size_t *descSize)
    ```

- **python函数**

    ```python
    desc_size, ret = acl.rt.get_memcpy_desc_size(kind)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| kind | int，内存复制的类型。<br>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| desc_size | int，内存大小，单位Byte。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
