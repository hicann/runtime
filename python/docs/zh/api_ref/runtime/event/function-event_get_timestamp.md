# 函数：event\_get\_timestamp

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

获取Event的执行结束时间点（表示从AI处理器系统启动以来的时间）。

本接口需与其它关键接口配合使用，接口调用顺序：

- 调用  [acl.rt.create\_event](function-create_event.md)/[acl.rt.create\_event\_with\_flag](function-create_event_with_flag.md)接口创建Event。
- 调用[acl.rt.record\_event](function-record_event.md)接口在Stream中记录Event。
- 调用[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)接口阻塞应用程序运行， 直到指定Stream中的所有任务都完成。
- 调用[acl.rt.event\_get\_timestamp](function-event_get_timestamp.md)接口获取Event的执行时间。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)
    ```

- **python函数**

    ```python
    timestamp, ret = acl.rt.event_get_timestamp(event)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| event | int，查询的Event。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| timestamp | int，Event执行结束的时间点，单位为微秒。 |
| ret | int，返回0表示成功，返回其他值表示失败，请参见[其它值](../datatypes/aclError.md)。 |
