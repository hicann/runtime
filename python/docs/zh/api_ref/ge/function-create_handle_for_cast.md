# 函数：create\_handle\_for\_cast

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
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

创建数据类型转换的handle。

创建handle成功后，需调用[acl.op.execute\_with\_handle](function-execute_with_handle.md)接口执行算子。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopCreateHandleForCast(const aclTensorDesc *srcDesc, const aclTensorDesc *dstDesc, uint8_t truncate, aclopHandle **handle)
    ```

- **python函数**

    ```python
    handle, ret = acl.op.create_handle_for_cast(src_desc, dst_desc, truncate)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| src_desc | int，输入Tensor描述指针地址。 |
| dst_desc | int，输出Tensor描述指针地址。 |
| truncate | int，预留。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| handle | int，输出的handle的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |
