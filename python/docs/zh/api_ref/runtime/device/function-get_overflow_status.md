# 函数：get\_overflow\_status

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

获取当前Device下所有Stream上任务的溢出状态，并将状态值拷贝到用户申请的Device内存中。异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetOverflowStatus(void *outputAddr, size_t outputSize, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.get_overflow_status(outputAddr, outputSize, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| outputAddr | int，用户申请的Device内存，需通过[acl.rt.malloc](../memory/function-malloc.md)接口申请。如果需要在Host侧查看数据，可调用[acl.rt.memcpy](../memory/function-memcpy.md)或[acl.rt.memcpy_async](../memory/function-memcpy_async.md)接口，将Device侧的数据传输到Host侧。 |
| outputSize | int，需申请的Device内存大小，单位Byte，固定大小为64Byte。 |
| stream | int，指定Stream的指针地址，用于下发溢出状态查询任务。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保任务已执行完成。

<!-- npu="950,A3,910b" id7 -->
对于以下产品型号，调用本接口查询出来的溢出状态是进程级别的：

<!-- npu="950" id8 -->
- Ascend 950PR&950DT系列产品
<!-- end id8 -->
<!-- npu="A3" id9 -->
- Atlas A3系列产品
<!-- end id9 -->
<!-- npu="910b" id10 -->
- Atlas A2系列产品
<!-- end id10 -->
<!-- end id7 -->
