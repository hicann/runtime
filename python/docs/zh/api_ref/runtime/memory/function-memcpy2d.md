# 函数：memcpy2d

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

实现同步内存复制，主要用于矩阵数据的复制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemcpy2d(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind)
    ```

- **python函数**

    ```python
    ret = acl.rt.memcpy2d(dst, dpitch, src, spitch, width, height, kind)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dst | int，目的内存地址的指针地址。 |
| dpitch | int，目的内存中相邻两列向量的地址距离。 |
| src | int，源内存地址的指针地址。 |
| spitch | int，源内存中相邻两列向量的地址距离。 |
| width | int，待复制的矩阵宽度。 |
| height | int，待复制的矩阵高度。 |
| kind | int，内存复制的类型。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 当前仅支持“ACL\_MEMCPY\_HOST\_TO\_DEVICE”类型和“ACL\_MEMCPY\_DEVICE\_TO\_HOST”类型的内存复制。
<!-- npu="310p" id7 -->
- Atlas推理系列产品，Control CPU开放形态下，不支持调用本接口。另外Atlas 推理系列加速模块产品也不支持该接口。
<!-- end id7 -->
<!-- npu="310b" id8 -->
- Atlas 200I/500 A2推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id8 -->
