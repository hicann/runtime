# 函数：create\_event

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

创建一个Event，创建的Event可用于统计两个Event之间的耗时、多Stream场景下的同步等待等场景。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCreateEvent(aclrtEvent *event)
    ```

- **python函数**

    ```python
    event, ret = acl.rt.create_event()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| event | int，创建的Event对象的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

采用本API创建的Event不支持在[acl.rt.reset\_event](function-reset_event.md)接口中使用，否则会导致未定义的行为。

调用本接口创建Event后，后续调用[acl.rt.record\_event](function-record_event.md)接口时，系统内部才会申请Event资源，因此会受Event数量的限制，Event达到上限后，系统内部会等待资源释放。

Event数量限制如下：

<!-- npu="950,A3,910b,310b" id7 -->
- 对于以下产品型号，单个Device支持的Event最大数为65536：

    <!-- npu="950" id8 -->
    Ascend 950PR&950DT系列产品
    <!-- end id8 -->

    <!-- npu="A3" id9 -->
    Atlas A3系列产品
    <!-- end id9 -->

    <!-- npu="910b" id10 -->
    Atlas A2系列产品
    <!-- end id10 -->

    <!-- npu="310b" id11 -->
    Atlas 200I/500 A2推理产品
    <!-- end id11 -->

<!-- end id7 -->
<!-- npu="310p" id12 -->
- 对于Atlas推理系列产品，单个Device支持的Event最大数为1023。
<!-- end id12 -->
<!-- npu="910" id13 -->
- 对于Atlas训练系列产品，单个Device支持的Event最大数为65535。
<!-- end id13 -->
