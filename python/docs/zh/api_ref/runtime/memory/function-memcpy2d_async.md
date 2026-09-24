# 函数：memcpy2d\_async

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

实现异步内存复制，主要用于矩阵数据的复制。异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemcpy2dAsync(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.memcpy2d_async(dst, dpitch, src, spitch, width, height, kind, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dst | int，目的内存地址的指针地址。 |
| dpitch | int，目的内存中相邻两列向量的地址距离。 |
| src | int，源内存地址的指针地址。 |
| spitch | int，源内存中相邻两列向量的地址距离。 |
| width | int，待复制的矩阵宽度。<br>width最大设置为5000000，且必须小于或等于dpitch和spitch。 |
| height | int，待复制的矩阵高度。<br>“height”最大可设置为5 *1024* 1024 = 5242880，否则接口返回失败。 |
| kind | int，内存复制的类型。<br>ACL_MEMCPY_HOST_TO_HOST = 0 // Host内的内存复制<br>ACL_MEMCPY_HOST_TO_DEVICE = 1 // Host到Device的内存复制<br>ACL_MEMCPY_DEVICE_TO_HOST = 2 // Device到Host的内存复制<br>ACL_MEMCPY_DEVICE_TO_DEVICE = 3 // Device内的内存复制<br>ACL_MEMCPY_DEFAULT = 4 // 由系统根据源、目的内存地址自行判断拷贝方向 |
| stream | int，指定Stream的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保内存复制的任务已执行完成。
- 本接口仅支持ACL\_MEMCPY\_HOST\_TO\_DEVICE、ACL\_MEMCPY\_DEVICE\_TO\_HOST或ACL\_MEMCPY\_DEVICE\_TO\_DEVICE内存复制类型，且不同型号支持的类型不同。对于不支持的内存复制类型，接口返回ACL\_ERROR\_INVALID\_PARAM。

    <!-- npu="950,A3,910b" id7 -->
    其中ACL\_MEMCPY\_DEVICE\_TO\_DEVICE类型，以下型号支持：

    <!-- npu="950" id10 -->
    Ascend 950PR&950DT系列产品
    <!-- end id10 -->

    <!-- npu="A3" id11 -->
    Atlas A3系列产品
    <!-- end id11 -->

    <!-- npu="910b" id12 -->
    Atlas A2系列产品
    <!-- end id12 -->
    <!-- end id7 -->

<!-- npu="310p" id8 -->
- 对于Atlas推理系列产品，Control CPU开放形态下，不支持调用本接口。另外，Atlas 推理系列加速模块产品也不支持本接口。
<!-- end id8 -->
<!-- npu="310b" id9 -->
- 对于Atlas 200I/500 A2推理产品，Ascend RC形态下，不支持调用本接口。
<!-- end id9 -->
