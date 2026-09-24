# 函数：add\_dataset\_buffer

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

向aclmdlDataset中增加aclDataBuffer。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlAddDatasetBuffer(aclmdlDataset *dataset, aclDataBuffer *dataBuffer)
    ```

- **python函数**

    ```python
    dataset, ret = acl.mdl.add_dataset_buffer(dataset, data_buffer)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dataset | int，待增加aclDataBuffer的aclmdlDataset指针地址。需提前调用[acl.mdl.create_dataset](function-create_dataset.md)接口创建aclmdlDataset类型的数据。 |
| data_buffer | int，待增加的aclDataBuffer指针地址。需提前调用`acl.create_data_buffer`接口创建aclDataBuffer类型的数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dataset | int，待增加aclDataBuffer的aclmdlDataset指针地址。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
