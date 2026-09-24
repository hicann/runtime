# 函数：get\_step\_timestamp

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

利用[单算子加载与执行接口](zh- cn_topic_0000002538270774.md)实现训练的场景下，使用本接口用于标记迭代开始与结束时间，为后续Profiling解析提供迭代标识，以便以迭代为粒度展示性能数据。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofGetStepTimestamp(aclprofStepInfo* stepInfo, aclprofStepTag tag, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret =acl.prof.get_step_timestamp(stepinfo, tag, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stepinfo | int，指定迭代信息。需提前调用[acl.prof.create_step_info](function-create_step_info.md)接口创建aclprofStepInfo类型的数据。 |
| tag | int，用于标记迭代开始或结束。在迭代开始时传入ACL_STEP_START，迭代结束时需传入ACL_STEP_END。 |
| stream | int，指定Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |
