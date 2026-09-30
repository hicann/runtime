# 函数：set\_op\_execute\_time\_out

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

设置算子执行的超时时间，单位为秒。一个进程内多次调用本接口，则以最后一次设置的时间为准。如果算子下发时携带了超时时间，则该超时时间优先级高于本接口设置的超时时间。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_op_execute_time_out(timeout)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| timeout | int，设置超时时间，单位为秒。将该参数设置为0时，表示使用最大超时时间。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 不调用本接口，不同产品型号的AI Core算子、AI CPU算子默认超时时间不同：
  <!-- npu="950" id7 -->
  - 对于Ascend 950PR&950DT系列产品，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为28秒。
  <!-- end id7 -->
  <!-- npu="A3" id8 -->
  - 对于Atlas A3系列产品，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为60秒。
  <!-- end id8 -->
  <!-- npu="910b" id9 -->
  - 对于Atlas A2系列产品，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为28秒。
  <!-- end id9 -->
  <!-- npu="310b" id10 -->
  - 对于Atlas 200I/500 A2推理产品，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为28秒。
  <!-- end id10 -->
  <!-- npu="310p" id11 -->
  - 对于Atlas推理系列产品，AI Core算子的默认超时时间为547秒，AI CPU算子的默认超时时间为28秒。
  <!-- end id11 -->
  <!-- npu="910" id12 -->
  - 对于Atlas训练系列产品，AI Core算子的默认超时时间为68秒，AI CPU算子的默认超时时间为28秒。
  <!-- end id12 -->

<!-- npu="950,A3,910b,910,310p,310b" id13 -->
- 由于不同产品型号的架构差异，AI Core算子、AI CPU算子的最大超时时间有所不同：
  <!-- npu="950,910b,A3" id14 -->
  - 对于以下产品型号，最大超时时间为interval * 254,单位是微秒，interval可通过[acl.rt.get_op_timeout_interval](function-get_op_timeout_interval.md)接口获取。
  Ascend 950PR&950DT系列产品
  Atlas A3系列产品
  Atlas A2系列产品
  <!-- end id14 -->
  <!-- npu="310b" id18 -->
  - Atlas 200I/500 A2推理产品，最大超时时间为1091秒
  <!-- end id18 -->
  <!-- npu="910" id15 -->
  - 对于Atlas训练系列产品，最大超时时间为2176秒。
  <!-- end id15 -->
  <!-- npu="310p" id16 -->
  - 对于Atlas推理系列产品，AI Core算子的最大超时时间为547秒，AI CPU算子的最大超时时间不支持设置。
  <!-- end id16 -->
<!-- end id13 -->
