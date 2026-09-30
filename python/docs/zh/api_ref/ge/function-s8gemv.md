# 函数：s8gemv

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

执行矩阵-向量的乘法，y = αAx + βy，输入数据的数据类型为int8\_t，输出数据的数据类型为int32\_t，异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclblasS8gemv(aclTransType transA,
    int m,
    int n,
    const int32_t *alpha,
    const int8_t *a,
    int lda,
    const int8_t *x,
    int incx,
    const int32_t *beta,
    int32_t *y,
    int incy,
    aclComputeType type,
    aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.blas.s8gemv(trans_a, m, n, alpha, a, lda, x, incx, beta, y, incy, type, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| trans_a | int，矩阵A是否转置的标记。 |
| m | int，矩阵A的行数，存储矩阵乘数据时，行优先。 |
| n | int，矩阵A的列数。 |
| alpha | int，用于执行乘操作的标量alpha数据指针地址。 |
| a | int，矩阵A的数据指针地址。 |
| lda | int，A矩阵的主位，此时选择转置，按行优先，则lda为A的列数。预留参数，当前只能设置为-1。 |
| x | int，向量x的数据指针地址。 |
| incx | int，x连续元素之间的步长。预留参数，当前只能设置为-1。 |
| beta | int，用于执行乘操作的标量beta的数据指针地址。 |
| y | int，向量y的数据指针地址。 |
| incy | int，y连续元素之间的步长。预留参数，当前只能设置为-1。 |
| type | int，计算精度。 |
| stream | int，执行算子所在的Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用流程，参见[接口调用流程](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0069.html)。
