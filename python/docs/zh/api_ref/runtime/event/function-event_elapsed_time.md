# 函数：event\_elapsed\_time

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

统计两个Event之间的耗时。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)
    ```

- **python函数**

    ```python
    ms, ret = acl.rt.event_elapsed_time(start, end)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| start | int，指定起始Event对象的指针地址。 |
| end | int，指定结尾Event对象的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ms | float，表示的是两个Event之间的耗时，单位是毫秒。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

接口调用顺序：调用[acl.rt.create\_event](function-create_event.md)/[acl.rt.create\_event\_with\_flag](function-create_event_with_flag.md)接口创建event- - \>调用[acl.rt.record\_event](function-record_event.md)接口在同一个stream中记录起始event、结尾event- - \>调用[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)接口阻塞应用程序运行，直到指定Stream中的所有任务都完成- - \>调用[acl.rt.event\_elapsed\_time](function-event_elapsed_time.md)接口统计两个Event之间的耗时。
