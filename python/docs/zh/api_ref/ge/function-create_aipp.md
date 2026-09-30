# 函数：create\_aipp

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

动态AIPP场景下，根据模型支持的batch size创建aclmdlAIPP类型的数据，用于存放动态AIPP的参数。

如需销毁aclmdlAIPP类型的数据，请参见[函数：destroy\_aipp](function-destroy_aipp.md)。

## 函数原型

- **C函数原型**

    ```c
    aclmdlAIPP *aclmdlCreateAIPP(uint64_t batchSize)
    ```

- **python函数**

    ```python
    aipp_ptr = acl.mdl.create_aipp(batch_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| batch_size | int，模型的Batch数。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| aipp_ptr | int，aclmdlAIPP类型数据对象地址。 |
