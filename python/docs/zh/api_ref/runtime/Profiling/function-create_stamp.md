# 函数：create\_stamp

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

创建msproftx事件标记。后续调用[函数：mark](function-mark.md)、[函数：set\_stamp\_trace\_message](function-set_stamp_trace_message.md)、[函数：push](function-push.md)和[函数：range\_start](function-range_start.md)接口时需要以描述该事件的指针地址作为输入，表示记录该事件发生的时间跨度。

与[函数：destroy\_stamp](function-destroy_stamp.md)接口配对使用，需提前调用[函数：start](function-start.md)接口。

## 函数原型

- **C函数原型**

    ```c
    void *aclprofCreateStamp(void)
    ```

- **python函数**

    ```python
    stamp = acl.prof.create_stamp()
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stamp | int，指针地址。<br>返回0表示失败。<br>返回void类型的指针地址表示成功。 |

## 约束说明

与[函数：destroy\_stamp](function-destroy_stamp.md)接口配对使用，需提前调用[acl.prof.start](function-start.md)接口。
