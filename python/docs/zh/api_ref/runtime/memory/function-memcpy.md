# 函数：memcpy

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

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind)
    ```

- **python函数**

    ```python
    ret = acl.rt.memcpy(dst, dest_max, src, count, kind)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dst | int，目的内存地址指针地址。 |
| destMax | int，目的内存地址的最大内存长度，单位Byte。 |
| src | int，源内存地址指针地址。 |
| count | int，内存复制的长度，单位Byte。 |
| kind | int，内存复制的类型，预留参数，配置枚举值中的值无效，系统内部会根据源内存地址的指针地址、目的内存地址的指针地址判断是否可以将源地址的数据复制到目的地址，如果不可以，则系统会返回报错。<br>0：ACL_MEMCPY_HOST_TO_HOST，Host内的内存复制。<br>1：ACL_MEMCPY_HOST_TO_DEVICE，Host到Device的内存复制。<br>2：ACL_MEMCPY_DEVICE_TO_HOST，Device到Host的内存复制。<br>3：ACL_MEMCPY_DEVICE_TO_DEVICE，Device内的内存复制。不支持在Atlas 500 Pro智能边缘服务器（型号 3000）上使用。<br>4：ACL_MEMCPY_DEFAULT, 由系统根据源、目的内存地址自行判断拷贝方向 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 本接口会立刻进行内存复制，函数内部不会进行隐式的device同步或流同步。
<!-- npu="950,910b,910,310p" id7 -->
- 如果执行两个Device间的内存复制，需先调用[acl.rt.device\_can\_access\_peer](../device/function-device_can_access_peer.md)接口查询两个Device间是否支持数据交互、调用[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口开启两个Device间的数据交互功能，再调用本接口进行内存复制。

    **该约束适用以下型号：**

    <!-- npu="950" id8 -->
    Ascend 950PR&950DT系列产品
    <!-- end id8 -->

    <!-- npu="910b" id9 -->
    Atlas A2系列产品
    <!-- end id9 -->

    <!-- npu="310p" id10 -->
    Atlas推理系列产品
    <!-- end id10 -->

    <!-- npu="910" id11 -->
    Atlas训练系列产品
    <!-- end id11 -->
<!-- end id7 -->
