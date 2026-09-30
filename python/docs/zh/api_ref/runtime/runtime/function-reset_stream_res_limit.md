# 函数：reset\_stream\_res\_limit

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

调用[acl.rt.set\_stream\_res\_limit](function-set_stream_res_limit.md)接口设置指定Stream的Device资源限制后，可调用本接口重置指定Stream的Device资源限制，恢复默认配置，此时可通过[acl.rt.get\_stream\_res\_limit](function-get_stream_res_limit.md)接口查询默认的资源限制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtResetStreamResLimit(aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.reset_stream_res_limit(stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定Stream, 若传入0，则表示默认Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
