# 函数：query\_event\_status

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

查询该Event捕获的所有任务的执行状态。具体见[acl.rt.record\_event](function-record_event.md)接口参考Event捕获的细节。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
    ```

- **python函数**

    ```python
    status, ret = acl.rt.query_event_status(event)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| event | int，指定待查询的Event对象的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| status | int，表示的是Event状态的指针地址。<br>**ACL_EVENT_RECORDED_STATUS_NOT_READY = 0**，Event未被记录到Stream中，或记录到Stream中的Event未被执行或执行失败。<br>**ACL_EVENT_RECORDED_STATUS_COMPLETE = 1**，记录到Stream中的Event执行成功。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

如果用户在不同线程上分别调用[acl.rt.record\_event](function-record_event.md)和acl.rt.query\_event\_status，可能由于多线程导致这两个API的执行时间乱序，进而导致查询到的Event对象的完成状态不符合预期。
