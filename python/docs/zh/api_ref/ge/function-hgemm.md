# 函数：hgemm

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

执行矩阵-矩阵的乘法，C = αAB + βC，输入数据和输出数据的数据类型为**aclFloat16**，异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclblasHgemm(aclTransType transA,
    aclTransType transB,
    aclTransType transC,
    int m,
    int n,
    int k,
    const aclFloat16 *alpha,
    const aclFloat16 *matrixA,
    int lda,
    const aclFloat16 *matrixB,
    int ldb,
    const aclFloat16 *beta,
    aclFloat16 *matrixC,
    int ldc,
    aclComputeType type,
    aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.blas.hgemm(trans_a, trans_b, trans_c,
    m, n, k,
    alpha, matrix_a, lda,
    matrix_b, ldb,
    beta, matrix_c, ldc,
    type, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| trans_a | int，矩阵A是否转置的标记。 |
| trans_b | int，B矩阵是否转置的标记。 |
| trans_c | int，C矩阵的标记，当前仅支持aclTrans_N。 |
| m | int，矩阵A的行数与矩阵C的行数。 |
| n | int，矩阵B的列数与矩阵C的列数。 |
| k | int，矩阵A的列数与矩阵B的行数。 |
| alpha | int，用于执行乘操作的标量alpha数据指针地址。 |
| matrix_a | int，矩阵A的数据指针地址。 |
| lda | int，A矩阵的主维，此时选择转置，按行优先，则lda为A的列数。预留参数，当前只能设置为-1。 |
| matrix_b | int，矩阵B的数据指针地址。 |
| ldb | int，B矩阵的主维，此时选择转置，按行优先，则ldb为B的列数。预留参数，当前只能设置为-1。 |
| beta | int，用于执行乘操作的标量beta的数据指针地址。 |
| matrix_c | int，矩阵C的数据指针地址。 |
| ldc | int，C矩阵的主维。预留参数，当前只能设置为-1。 |
| type | int，计算精度。 |
| stream | int，执行算子所在的Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用流程，参见[接口调用流程](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0069.html)。
