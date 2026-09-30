# 函数：launch\_callback

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

异步任务场景下，在Stream的任务队列中下发一个函数回调任务，系统内部在执行到该回调任务时，会在Stream上订阅的线程（通过[acl.rt.subscribe\_report](function-subscribe_report.md)接口注册的线程）中执行回调函数。异步接口。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的Callback功能：

1. 新建线程，在线程函数内，调用[acl.rt.process\_report](function-process_report.md)接口设置超时时间（需循环调用），等待[acl.rt.launch\_callback](function-launch_callback.md)接口下发的函数回调任务。
2. 调用[acl.rt.subscribe\_report](function-subscribe_report.md)接口建立第1步中的线程和Stream的绑定关系，该Stream下发的函数回调任务将在绑定的线程中执行。
3. 在指定Stream上执行异步任务（例如异步推理任务）。
4. 定义并实现回调函数，调用**acl.rt.launch\_callback**接口在Stream的任务队列中下发函数回调任务，触发**acl.rt.subscribe\_report**订阅的线程处理回调函数，每调用一次**acl.rt.launch\_callback**接口，就会下发一个回调函数任务。
5. 异步任务全部执行完成后，调用[acl.rt.unsubscribe\_report](function-unsubscribe_report.md)接口取消线程订阅，解除线程和Stream的绑定关系。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtLaunchCallback(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.launch_callback(fn, user_data_list, block_type, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| fn | function，表示Python侧的回调函数。 |
| user_data_list | list，表示需要传递给回调函数的参数（目前传入的是list类型的数据）。 |
| block_type | int，指定回调任务是否阻塞本Stream上后续任务的执行。<br>0：表示非阻塞。<br>1：表示阻塞。 |
| stream | int，表示指定的Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保任务已执行完成。
