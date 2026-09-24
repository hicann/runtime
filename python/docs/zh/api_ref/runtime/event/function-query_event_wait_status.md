# 函数：query\_event\_wait\_status

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

调用[acl.stream\_wait\_event](function-stream_wait_event.md)接口后查询该Event对应的等待任务是否都执行完成。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)
    ```

- **python函数**

    ```python
    status, ret = acl.rt.query_event_wait_status(event)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| event | int，指定待查询的Event对象的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| status | int，Event状态的指针地址，具体请参见[aclrtEventWaitStatus](../datatypes/aclrtEventWaitStatus.md)。<br>**ACL_EVENT_RECORDED_STATUS_NOT_READY = 0**，Event未被记录到Stream中，或记录到Stream中的Event未被执行或执行失败。<br>**ACL_EVENT_RECORDED_STATUS_COMPLETE = 1**，记录到Stream中的Event执行成功。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

通过[acl.rt.create\_event\_ex\_with\_flag](function-create_event_ex_with_flag.md)接口创建的Event，不支持调用本接口。
