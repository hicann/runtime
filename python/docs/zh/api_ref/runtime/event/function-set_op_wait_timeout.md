# 函数：set\_op\_wait\_timeout

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
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

本接口用于设置等待Event完成的超时时间。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetOpWaitTimeout(uint32_t timeout)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_op_wait_timeout(timeout)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| timeout | int，设置超时时间，单位为秒。将该参数设置为0时，表示不超时。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 不调用本接口，则默认不超时，一个进程内多次调用本接口，则以最后一次设置的时间为准。
- 一个进程内，调用[acl.init](../init/function-init.md)接口初始化后，调用本接口设置超时时间，本进程内后续调用[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口下发的任务支持在所设置的超时时间内等待。

    由于[acl.rt.stream\_wait\_event](function-stream_wait_event.md)接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，因此若等待的时间超过所设置的超时时间，则在调用[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)接口后，会返回报错。
