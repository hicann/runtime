# 函数：load

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

从内存中加载单算子模型数据，由用户管理内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopLoad(const void *model, size_t modelSize)
    ```

- **python函数**

    ```python
    ret = acl.op.load(model, model_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model | int，表示单算子模型数据的地址对象。 |
| model_size | int，表示内存中的模型数据长度，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

<!-- npu="950,A3,910b,910,310p,310b" id7 -->
在加载前，请先根据单算子om文件的大小评估内存空间是否足够，内存空间不足，会导致应用程序异常。针对不同产品型号，一个进程内正在执行的算子的最大个数上限不同：
<!-- end id7 -->

<!-- npu="950,A3,910b" id8 -->
- 对于Ascend 950PR&950DT系列产品、Atlas A3系列产品、Atlas A2系列产品，最大个数为2000000。
<!-- end id8 -->
<!-- npu="910,310b" id9 -->
- 对于Atlas 200I/500 A2推理产品、Atlas训练系列产品，最大个数为40000000。
<!-- end id9 -->
<!-- npu="310p" id10 -->
- 对于Atlas推理系列产品，Ascend EP形态下，上限是40000000；Control CPU开放形态下，上限是2000000。
<!-- end id10 -->

## 资源参考

接口调用流程，参见[单算子调用](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0067.html)。
