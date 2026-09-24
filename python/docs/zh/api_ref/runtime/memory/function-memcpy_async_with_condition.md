# 函数：memcpy\_async\_with\_condition（废弃）

**须知：此接口后续版本会废弃，请使用[acl.rt.memcpy\_async](function-memcpy_async.md)接口。**

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

实现内存复制。

本接口在aclrtMemcpyAsync接口基础上扩展了功能，当传入的内存不是通过pyacl提供的接口申请的，本接口在内存复制完成后才会返回；否则本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保内存复制的任务已执行完成。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemcpyAsyncWithCondition(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind,aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.memcpy_async_with_condition(dst, dest_max, src, count, kind, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dst | int，目的内存地址指针。 |
| destMax | int，目的内存地址的最大内存长度，单位Byte。 |
| src | int，源内存地址指针。 |
| count | int，内存复制的长度，单位Byte。 |
| kind | int，内存复制的类型。<br>0：ACL_MEMCPY_HOST_TO_HOST，Host内的内存复制。<br>1：ACL_MEMCPY_HOST_TO_DEVICE， Host到Device的内存复制。<br>2：ACL_MEMCPY_DEVICE_TO_HOST，Device到Host的内存复制。<br>3：ACL_MEMCPY_DEVICE_TO_DEVICE，Device内的内存复制。不支持在Atlas 500 Pro智能边缘服务器（型号 3000）上使用。<br>4：ACL_MEMCPY_DEFAULT， 由系统根据源、目的内存地址自行判断拷贝方向。 |
| stream | int，指定stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- Ascend EP形态下，本接口不支持异步Host内的内存复制功能，若传入的kind为ACL\_MEMCPY\_HOST\_TO\_HOST时，接口返回报错ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT。
<!-- npu="310b" id7 -->
- Ascend RC形态下，在板端运行应用时，若调用本接口传入的kind为ACL\_MEMCPY\_HOST\_TO\_DEVICE或ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_HOST\_TO\_HOST，系统内部将默认使用ACL\_MEMCPY\_DEVICE\_TO\_DEVICE执行Device内的内存复制。
<!-- end id7 -->
<!-- npu="310p" id8 -->
- Control CPU开放形态下，在Device上运行应用时，若调用本接口传入的kind为ACL\_MEMCPY\_HOST\_TO\_DEVICE或ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_HOST\_TO\_HOST，系统内部将默认使用ACL\_MEMCPY\_DEVICE\_TO\_DEVICE执行Device内的内存复制。
<!-- end id8 -->
