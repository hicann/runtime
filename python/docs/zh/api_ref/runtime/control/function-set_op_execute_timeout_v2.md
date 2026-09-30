# 函数：set\_op\_execute\_timeout\_v2

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

设置算子执行的超时时间，单位为微秒。如果算子下发时携带了超时时间，则该超时时间优先级高于本接口设置的超时时间。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetOpExecuteTimeOutV2(uint64_t timeout,  uint64_t *actualTimeout)
    ```

- **python函数**

    ```python
    actual_time_out, ret = acl.rt.set_op_execute_timeout_v2(timeout)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| timeout | int，设置超时时间，单位为微秒。将该参数设置为0时，表示使用最大超时时间。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| actual_time_out | int，返回实际生效的超时时间，单位为微秒。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

<!-- npu="950,A3,910b" id7 -->
- 对于以下产品型号，当调用acl.rt.get\_op\_timeout\_interval接口获取的时间间隔小于100000微秒，并且将timeout参数值设置为0时，表示AI Core算子将永不超时，此时，actual\_time\_out参数输出的值为uint64\_t的最大值。

    <!-- npu="950" id8 -->
    Ascend 950PR&950DT系列产品
    <!-- end id8 -->

    <!-- npu="A3" id9 -->
    Atlas A3系列产品
    <!-- end id9 -->

    <!-- npu="910b" id10 -->
    Atlas A2系列产品
    <!-- end id10 -->
<!-- end id7 -->

<!-- npu="910,310p,310b" id11 -->
- 对于以下产品型号，调用本接口只能设置AI Core算子执行的超时时间：

    <!-- npu="310b" id12 -->
    Atlas 200I/500 A2推理产品
    <!-- end id12 -->

    <!-- npu="310p" id13 -->
    Atlas推理系列产品
    <!-- end id13 -->

    <!-- npu="910" id14 -->
    Atlas训练系列产品
    <!-- end id14 -->
<!-- end id11 -->
