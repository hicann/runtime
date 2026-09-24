# 函数：push

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

msproftx用于记录事件发生的时间跨度的开始时间。

调用此接口后，Profiling自动在Stamp中记录开始的时间戳，将Event type设置为Push/Pop。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofPush(void *stamp)
    ```

- **python函数**

    ```python
    ret = acl.prof.push(stamp)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stamp | int，Stamp指针地址，指代msproftx事件标记。指定[acl.prof.create_stamp](function-create_stamp.md)接口的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回其它值表示失败。 |

## 约束说明

- 与[函数：pop](function-pop.md)接口成对使用，表示时间跨度的开始和结束。
- 不能跨线程调用，若需要跨线程可使用[函数：range\_start](function-range_start.md)/[函数：range\_stop](function-range_stop.md)接口。
- 在[函数：create\_stamp](function-create_stamp.md)接口和[函数：destroy\_stamp](function-destroy_stamp.md)接口之间调用。
