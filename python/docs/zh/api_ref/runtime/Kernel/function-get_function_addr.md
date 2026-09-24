# 函数：get\_function\_addr

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

根据核函数句柄获取Device侧算子起始地址。对于包含矩阵计算和矢量计算的算子，一个算子有两个起始地址，分别在Cube（矩阵）计算单元、Vector（向量）计算单元上执行，通过本接口可获取Cube计算单元、Vector计算单元上的算子起始地址。若通过本接口获取到aivAddr为空，则表示该算子只在Cube计算单元上执行。

不同产品上的AI数据处理核心单元不同。

<!-- npu="910,310p" id7 -->
- 对于以下产品，通过aic\_addr参数返回的是AI Core上的算子起始地址。

    <!-- npu="910" id8 -->
    Atlas训练系列产品
    <!-- end id8 -->

    <!-- npu="310p" id9 -->
    Atlas推理系列产品
    <!-- end id9 -->
<!-- end id7 -->

<!-- npu="950,A3,910b,310b" id10 -->
- 对于以下产品，通过aic\_addr参数返回的是Cube Core上的算子起始地址。

    <!-- npu="950" id11 -->
    Ascend 950PR&950DT系列产品
    <!-- end id11 -->

    <!-- npu="A3" id12 -->
    Atlas A3系列产品
    <!-- end id12 -->

    <!-- npu="910b" id13 -->
    Atlas A2系列产品
    <!-- end id13 -->

    <!-- npu="310b" id14 -->
    Atlas 200I/500 A2推理产品
    <!-- end id14 -->
<!-- end id10 -->

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetFunctionAddr(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
    ```

- **python函数**

    ```python
    aic_addr, aiv_addr, ret = acl.rt.get_function_addr(func_handle)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| func_handle | int，核函数句柄。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| aic_addr | int，AI Core或Cube Core上的算子起始地址。 |
| aiv_addr | int，Vector Core上的算子起始地址。<br>若通过本接口获取到aivAddr为空，则表示该算子不在Vector Core上执行。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
