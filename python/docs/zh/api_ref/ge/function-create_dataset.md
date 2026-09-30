# 函数：create\_dataset

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

创建aclmdlDataset类型的数据。

该数据类型用于描述模型推理时的输入数据、输出数据，模型可能存在多个输入、多个输出，每个输入/输出的内存地址、内存大小用aclDataBuffer类型的数据来描述。

如需销毁aclmdlDataset类型的数据，请参见[函数：destroy\_dataset](function-destroy_dataset.md)。

## 函数原型

- **C函数原型**

    ```c
    aclmdlDataset *aclmdlCreateDataset()
    ```

- **python函数**

    ```python
    mdl_dataset = acl.mdl.create_dataset()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| mdl_dataset | int，aclmdlDataset类型的指针地址。 |
