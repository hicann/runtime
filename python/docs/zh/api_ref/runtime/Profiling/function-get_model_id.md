# 函数：get\_model\_id

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

获取指定算子所在模型的ID。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

## 函数原型

- **C函数原型**

    ```c
    size_t aclprofGetModelId(const void *opInfo, size_t opInfoLen, uint32_t index)
    ```

- **python函数**

    ```python
    model_id = acl.prof.get_model_id(op_info, op_info_len, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_info | int，指定算子信息的内存地址。 |
| op_info_len | int，算子信息的长度。 |
| index | int，指定获取第几个算子的算子名称。<br>用户调用[acl.prof.get_op_num](function-get_op_num.md)接口获取算子数量后，这个index的取值范围：[0, (算子数量- 1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| model_id | int，模型的ID。 |
