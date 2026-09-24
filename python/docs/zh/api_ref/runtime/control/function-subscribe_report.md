# 函数：subscribe\_report

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

异步任务场景下，指定处理Stream上回调函数的线程。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的Callback功能：

1. 新建线程，在线程函数内，调用[acl.rt.process\_report](function-process_report.md)接口设置超时时间（需循环调用），等待[acl.rt.launch\_callback](function-launch_callback.md)接口下发的函数回调任务。
2. 调用[acl.rt.subscribe\_report](function-subscribe_report.md)接口建立第1步中的线程和Stream的绑定关系，该Stream下发的函数回调任务将在绑定的线程中执行。
3. 在指定Stream上执行异步任务（例如异步推理任务）。
4. 定义并实现回调函数，调用**acl.rt.launch\_callback**接口在Stream的任务队列中下发函数回调任务，触发**acl.rt.subscribe\_report**订阅的线程处理回调函数，每调用一次**acl.rt.launch\_callback**接口，就会下发一个回调函数任务。
5. 异步任务全部执行完成后，调用[acl.rt.unsubscribe\_report](function-unsubscribe_report.md)接口取消线程订阅，解除线程和Stream的绑定关系。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.subscribe_report(thread_id, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| thread_id | int，指定线程id。 |
| stream | int，指定需要处理的Stream的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 支持多次调用acl.rt.subscribe\_report接口给多个Stream（仅支持同一Device内的多个Stream）订阅同一个处理回调函数的线程。

- 为确保Stream内的任务按调用顺序执行，不支持调用acl.rt.subscribe\_report接口给同一个Stream订阅多个处理回调函数的线程。

- 单进程内调用本接口注册的线程数量超过一定限制，则接口返回失败。考虑操作系统的线程切换性能开销，建议调用aclrtSubscribeReport接口注册的线程数量控制在32个以下（包括32）。当前支持的线程数量最大值为1024。
- 同一个进程内，在不同的Device上订阅回调函数的线程时，不能指定同一个线程ID。
