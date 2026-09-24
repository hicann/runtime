# 函数：get\_dataset\_buffer

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

获取aclmdlDataset中的第n个aclDataBuffer。

## 函数原型

- **C函数原型**

    ```c
    aclDataBuffer* aclmdlGetDatasetBuffer(const aclmdlDataset *dataset, size_t index)
    ```

- **python函数**

    ```python
    data_buffer = acl.mdl.get_dataset_buffer(dataset, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dataset | int，aclmdlDataset数据对象的指针地址。需提前调用[acl.mdl.create_dataset](function-create_dataset.md)接口创建aclmdlDataset类型的数据。 |
| index | int，表明获取的是第几个aclDataBuffer。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| data_buffer | int，aclDataBuffer数据对象指针地址。<br>获取成功，返回aclDataBuffer的地址。<br>获取失败返回空地址。 |
