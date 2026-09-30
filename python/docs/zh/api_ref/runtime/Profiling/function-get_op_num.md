# 函数：get\_op\_num

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

获取指定内存中算子的数量。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofGetOpNum(const void *opInfo, size_t opInfoLen, uint32_t *opNumber)
    ```

- **python函数**

    ```python
    op_num, ret = acl.prof.get_op_num(op_info, op_info_len)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_info | int，指定算子信息的内存地址。<br>调用[acl.prof.get_op_desc_size](function-get_op_desc_size.md)接口获取到单个算子数据结构的大小后，用户需按照“单个算子数据结构的大小*整数系数”得到的数值申请内存，用于存放Profiling采集到的算子信息数据，作为本接口的输入。 |
| op_info_len | int，算子信息的长度。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| op_num | int，算子的数量。 |
| ret | int，错误码。<br>返回0表示成功。<br>返回其它值表示失败。 |
