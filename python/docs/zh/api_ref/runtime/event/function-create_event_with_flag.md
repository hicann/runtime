# 函数：create\_event\_with\_flag

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

创建一个带flag的Event，不同flag的Event用于不同的功能。支持创建Event时携带多个flag（按位进行或操作），从而同时使能对应flag的功能。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)
    ```

- **python函数**

    ```python
    event, ret = acl.rt.create_event_with_flag(flag)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| flag | int，Event的flag，可支持以下选项。<br>**0x00000008：ACL_EVENT_TIME_LINE**，表示创建的Event数量不受限制且创建出来的Event可用于统计两个Event之间的耗时。<br>**0x00000001：ACL_EVENT_SYNC**，表示创建的Event支持多Stream间的同步。<br>**0x00000002：ACL_EVENT_CAPTURE_STREAM_PROGRESS**，表示创建的Event用于跟踪Stream的任务执行进度。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| event | int，创建的Event对象的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

使用本接口创建Event时，“flag”为bitmap，支持对单个flag或者多个flag进行操作，例如：acl.rt.create\_event\_with\_flag\(  **ACL\_EVENT\_TIME\_LINE | ACL\_EVENT\_SYNC**  \)。

- 若“flag”参数值包含“ACL\_EVENT\_SYNC”，则创建出来的Event数量受限，具体参考如下：

    Atlas 200I/500 A2推理产品，单个Device上最多支持65536个Event。

    Atlas推理系列产品，单个Device上最多支持1023个Event。

    Atlas训练系列产品，单个Device上最多支持65535个Event。

    Atlas A2系列产品，单个Device上最多支持65536个Event。

    Atlas A3系列产品，单个Device上最多支持65536个Event。

- 若flag参数值不包含“ACL\_EVENT\_SYNC”，则不支持在以下API中使用本接口创建的Event：[acl.rt.reset\_event](function-reset_event.md)、[acl.rt.stream\_wait\_event](function-stream_wait_event.md)、[acl.rt.query\_event\_wait\_status](function-query_event_wait_status.md)。
