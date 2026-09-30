# 函数：create\_handle\_for\_gemv\_ex

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

创建矩阵-向量乘的handle，输入数据、输出数据的数据类型通过入参设置。

创建handle成功后，需调用[acl.op.execute\_with\_handle](function-execute_with_handle.md)接口执行算子。

## 函数原型

- **C函数原型**

    ```c
    aclError aclblasCreateHandleForGemvEx(aclTransType transA,
    int m,
    int n,
    aclDataType dataTypeA,
    aclDataType dataTypeX,
    aclDataType dataTypeY,
    aclComputeType type,
    aclopHandle **handle)
    ```

- **python函数**

    ```python
    handle, ret = acl.blas.create_handle_for_gemv_ex(trans_a, m, n, data_type_a, data_type_x, data_type_y, type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| trans_a | int，矩阵A是否转置的标记。 |
| m | int，矩阵A的行数，存储矩阵乘数据时，行优先。 |
| n | int，矩阵A的列数。 |
| data_type_a | int，矩阵A的数据类型。 |
| data_type_x | int，向量x的数据类型。 |
| data_type_y | int，向量y的数据类型。 |
| type | int，计算精度。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| handle | int，执行算子的handle数据的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

A、x、y的数据类型支持仅支持以下组合， α和β的数据类型与y一致。

| A的数据类型 | x的数据类型 | y的数据类型 |
| --- | --- | --- |
| aclFloat16 | aclFloat16 | aclFloat16 |
| aclFloat16 | aclFloat16 | float(float32) |
| int8_t | int8_t | float(float32) |
| int8_t | int8_t | int32_t |
