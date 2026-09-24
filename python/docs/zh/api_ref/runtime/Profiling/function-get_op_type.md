# 函数：get\_op\_type

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

获取指定算子的算子类型名称。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

[acl.prof.get\_op\_type](function-get_op_type.md)和[acl.prof.get\_op\_type\_v2](function-get_op_type_v2.md)接口功能一致，但[acl.prof.get\_op\_type\_v2](function-get_op_type_v2.md)接口会获取算子类型长度，并分配相应的空间，不需要用户传参来指定算子类型所需空间大小，建议优先使用[acl.prof.get\_op\_type\_v2](function-get_op_type_v2.md)接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofGetOpType(const void *opInfo, size_t opInfoLen, uint32_t index, char *opType, size_t opTypeLen)
    ```

- **python函数**

    ```python
    op_type, ret = acl.prof.get_op_type(op_info, op_info_len, index, op_type_len)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_info | int，指定算子信息的内存地址。 |
| op_info_len | int，算子信息的长度。 |
| index | int，指定获取第几个算子的算子类型名称。<br>用户调用[acl.prof.get_op_num](function-get_op_num.md)接口获取算子数量后，这个index的取值范围：[0, (算子数量- 1)]。 |
| op_type_len | int，op_type的长度。取值范围：[1, 65]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| op_type | str，算子类型名称。 |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |
