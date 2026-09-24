# 函数：record\_event

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

在Stream中记录一个Event。本接口被调用时，会捕获当前Stream上已下发的任务并记录到Event事件中，因此后续若调用[acl.rt.query\_event\_status](function-query_event_status.md)或[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口时，会检查或等待该Event事件中所捕获的任务都已经完成。

对于使用[acl rt.create\_event\_ex\_with\_flag](function-create_event_ex_with_flag.md)创建的Event：

- **本接口支持对同一个Event多次record实现Event复用**，每次Record会重新捕获当前Stream上已下发的任务，并覆盖保存到Event中。在调用[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口时，会使用最近一次Event中所保存的任务，且不会被后续的acl.rt.record\_event调用影响。
- **在首次调用本接口前**，由于Event中没有任务，因此调用[acl.rt.query\_event\_status](function-query_event_status.md)接口时会返回“ACL\_EVENT\_RECORDED\_STATUS\_COMPLETE”。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.record_event(event, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| event | int，待记录的Event的指针地址。 |
| stream | int，将该Event记录在指定的Stream（指针地址）中，如果使用默认Stream，此处设置为0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保任务已执行完成。
- [acl.rt.record\_event](function-record_event.md)接口与[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口配合使用时，主要用于多Stream之间同步的场景，在调用[acl.rt.record\_event](function-record_event.md)接口时，系统内部会申请Event资源，在调用[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口之后，请及时调用[acl.rt.reset\_event](function-reset_event.md)接口释放Event资源。

    **接口调用顺序**：[acl.rt.create\_event](function-create_event.md)**--\>**[acl.rt.record\_event](function-record_event.md)**--\>**[acl.rt.stream\_wait\_event](function-stream_wait_event.md)**--\>**[acl.rt.reset\_event](function-reset_event.md)
