# 函数：query\_size\_from\_mem

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

根据内存中的模型数据获取模型执行时所需的权值内存大小、工作内存大小。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlQuerySizeFromMem(const void *model, size_t modelSize, size_t *workSize, size_t *weightSize)
    ```

- **python函数**

    ```python
    work_size, weight_size, ret = acl.mdl.query_size_from_mem(model, model_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model | int，需要获取内存信息的模型数据对应的指针地址。 |
| model_size | int，模型数据长度，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| work_size | int，模型执行时所需的工作内存的大小，单位Byte。 |
| weight_size | int，模型执行时所需权值内存的大小，单位Byte。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

执行和权重内存为Device内存，而且需要用户申请和释放。
