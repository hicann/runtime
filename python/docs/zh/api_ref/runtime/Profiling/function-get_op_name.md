# 函数：get\_op\_name

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

获取指定算子的算子名称。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

[acl.prof.get\_op\_name](function-get_op_name.md)和[acl.prof.get\_op\_name\_v2](function-get_op_name_v2.md)接口功能一致，但[acl.prof.get\_op\_name\_v2](function-get_op_name_v2.md)接口会获取算子名称长度，并分配相应的空间，不需要用户传参来指定算子名称所需空间大小，建议优先使用[acl.prof.get\_op\_name\_v2](function-get_op_name_v2.md)接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofGetOpName(const void *opInfo, size_t opInfoLen, uint32_t index, char *opName, size_t opNameLen)
    ```

- **python函数**

    ```python
    op_name, ret = acl.prof.get_op_name(op_info, op_info_len, index, op_name_len)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_info | int，指定算子信息的内存地址。 |
| op_info_len | int，算子信息的长度。 |
| index | int，指定获取第几个算子的算子名称。<br>用户调用[acl.prof.get_op_num](function-get_op_num.md)接口获取算子数量后，这个index的取值范围：[0, (算子数量- 1)]。 |
| op_name_len | int，op_name的长度。取值范围：[1, 257]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| op_name | str，算子名称。 |
| ret | int，错误码。<br>返回0表示成功。<br>返回其它值表示失败。 |
