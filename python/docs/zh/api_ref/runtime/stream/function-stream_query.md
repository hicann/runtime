# 函数：stream\_query

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

查询指定Stream上的所有任务的执行状态。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)
    ```

- **python函数**

    ```python
    status, ret = acl.rt.stream_query(stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，待操作Stream的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| status | Stream上的任务状态，具体请参见[aclrtStreamStatus](../datatypes/aclrtStreamStatus.md)。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

昇腾虚拟化实例（Ascend Virtual Instance）场景下支持使用该接口查询任务的执行状态。
