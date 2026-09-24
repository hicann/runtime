# 函数：set\_stream\_res\_limit

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

设置指定Stream的Device资源限制。

本接口应在调用[acl.rt.set\_device](../device/function-set_device.md)接口之后且在执行算子之前使用。如果对同一Stream进行多次设置，将以最后一次设置为准。

调用本接口设置指定Stream的Device资源限制后，需配合调用[acl.rt.use\_stream\_res\_in\_current\_thread](function-use_stream_res_in_current_thread.md)接口，设置在当前线程中使用指定Stream上的Device资源限制。可通过[acl.rt.get\_stream\_res\_limit](function-set_stream_res_limit.md)接口查询默认的资源限制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_stream_res_limit(stream, type, value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定Stream, 若传入0，则表示默认Stream。 |
| type | int，资源类型，当前支持Cube Core、Vector Core，具体请参见新增数据结构[aclrtDevResLimitType](../datatypes/aclrtDevResLimitType.md)。 |
| value | int，资源限制的大小。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
