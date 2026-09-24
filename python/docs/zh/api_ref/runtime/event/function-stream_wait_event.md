# 函数：stream\_wait\_event

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

阻塞指定Stream的运行，直到指定的Event完成，支持多个Stream等待同一个Event的场景。异步接口。

提交到Stream上的所有后续任务都需要等待Event捕获的任务都完成后才能开始执行。具体见[acl.rt.record\_event](function-record_event.md)接口了解Event捕获的细节。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)
    ```

- **python函数**

    ```python
    ret = acl.rt.stream_wait_event(stream, event)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定需要等待Event完成的Stream的指针地址。如果使用默认Stream，此处设置为0。 |
| event | int，需等待的Event的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保任务已执行完成。
- [acl.rt.record\_event](function-record_event.md)接口与[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口配合使用时，主要用于多Stream之间同步的场景，在调用[acl.rt.record\_event](function-record_event.md)接口时，系统内部会申请Event资源，在调用[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口之后，请及时调用[acl.rt.reset\_event](function-reset_event.md)接口释放Event资源。

    **接口调用顺序**：[acl.rt.create\_event](function-create_event.md)**--\>**[acl.rt.record\_event](function-record_event.md)**--\>**[acl.rt.stream\_wait\_event](function-stream_wait_event.md)**--\>**[acl.rt.reset\_event](function-reset_event.md)

- 一个进程内，调用[acl.init](../init/function-init.md)接口初始化后，调用[acl.rt.set\_op\_wait\_timeout](function-set_op_wait_timeout.md)接口设置超时时间，本进程内后续调用[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口下发的任务支持在所设置的超时时间内等待，若等待的时间超过所设置的超时时间，则会返回报错。

    由于acl.rt.stream\_wait\_event接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，因此若等待的时间超过所设置的超时时间，则在调用[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)接口后，会返回报错。
