# 函数：synchronize\_event\_with\_timeout

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

阻塞当前线程运行直到Event捕获的所有任务都执行完成（具体见[acl.rt.record\_event](function-record_event.md)接口参考Event捕获的细节）。

该接口在[acl.rt.synchronize\_event](function-synchronize_event.md)接口的基础上进行了增强，支持用户设置永久等待或配置具体的超时时间，若配置具体的超时时间，则当应用程序异常时可根据所设置的超时时间自行退出。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)
    ```

- **python函数**

    ```python
    ret = acl.rt.synchronize_event_with_timeout(event, timeout)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| event | int，指定需等待的Event对象的指针地址。 |
| timeout | int，接口的超时时间。<br>取值说明如下：<br>-1：表示永久等待与接口[acl.rt.synchronize_event](function-synchronize_event.md)功能一致。<br>&gt;0：配置具体的超时时间，单位是毫秒。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
