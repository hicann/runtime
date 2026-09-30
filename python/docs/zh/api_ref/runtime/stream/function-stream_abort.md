# 函数：stream\_abort

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

停止指定Stream上的正在执行的任务、丢弃指定Stream上已下发但未执行的任务。本接口执行期间，指定Stream上新下发的任务不再生效。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtStreamAbort(aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.stream_abort(stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定待清除任务的Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 如果有其它Stream依赖本接口中指定的Stream（例如通过[acl.rt.record\_event](../event/function-record_event.md)、[acl.rt.stream\_wait\_event](../event/function-stream_wait_event.md)等接口实现两个Stream间同步等待），则其它Stream执行可能会卡住，此时您需要显式调用本接口清除其它Stream上的任务。
- 如果调用本接口清除指定Stream上的任务时，再调用同步等待接口（例如[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)、[acl.rt.synchronize\_event](../event/function-synchronize_event.md)等），同步等待接口会退出并返回ACL\_ERROR\_RT\_STREAM\_ABORT的报错。
