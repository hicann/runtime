# 函数：get\_stream\_res\_limit

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

获取指定Stream的Device资源限制。

若没有调用[acl.rt.set\_stream\_res\_limit](function-set_stream_res_limit.md)接口设置Device资源限制，则调用本接口获取到的Device资源限制优先级为：当前进程的Device资源限制（调用[acl.rt.set\_stream\_res\_limit](function-set_stream_res_limit.md)接口设置） \>  AI处理器硬件默认的资源限制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.get_stream_res_limit(stream,  type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定Stream, 若传入0，则表示默认Stream。 |
| type | int，资源类型，当前支持Cube Core、Vector Core，具体请参见新增数据结构[aclrtDevResLimitType](../datatypes/aclrtDevResLimitType.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| value | int，资源限制的大小。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
