# 函数：create\_stream\_with\_config

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

在当前进程或线程中创建一个Stream。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
    ```

- **python函数**

    ```python
    stream, ret = acl.rt.create_stream_with_config(priority, flag)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| priority | **priority**：int，优先级。<br>该参数取值范围：[0, 7]，总共最多支持8个优先级，数字越小代表优先级越高，其中，0的优先级最高，7的优先级最低。如果设置的优先级超过取值范围，则就近修正为边界值。 |
| flag | int，Stream的flag。<br>flag参数值请参见“flag取值说明”。 |

## flag取值说明

flag既支持配置单个值，也支持配置多个值位或（例如0x0 | 0x2）。对于不支持位或的值，本接口会返回报错。配置取值范围之外的值，本接口创建出来的Stream等同于[acl.rt.create\_stream](../stream/function-create_stream.md)接口。

- **0x00000001：ACL\_STREAM\_FAST\_LAUNCH**，使用该模式创建出来的Stream，在使用Stream时，下发任务的速度更快。

    相比[acl.rt.create\_stream](../stream/function-create_stream.md)接口创建出来的Stream，在使用Stream时才会申请系统内部资源，导致下发任务的时长增加，使用本接口的“ACL\_STREAM\_FAST\_LAUNCH”模式创建Stream时，会在创建Stream时预申请系统内部资源，因此创建Stream的时长增加，下发任务的时长缩短，总体来说，创建一次Stream，使用多次的场景下，总时长缩短，但创建Stream时预申请内部资源会增加内存消耗。

- **0x00000002：ACL\_STREAM\_FAST\_SYNC**，使用该模式创建出来的Stream，在调用[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)接口时，会阻塞当前线程，主动查询任务的执行状态，一旦任务完成，立即返回。

    相比[acl.rt.create\_stream](../stream/function-create_stream.md)接口创建出来的Stream，在调用[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)接口时，会一直被动等待Device上任务执行完成的通知，等待时间长，使用本接口的“ACL\_STREAM\_FAST\_SYNC”模式创建的Stream，没有被动等待，总时长缩短，但主动查询的操作会增加CPU的性能消耗。

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| stream | int，表示创建的Stream对象的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
