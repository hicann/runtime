# 函数：get\_dataset\_tensor\_desc

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

如果模型输入或输出的Shape是动态的，模型在模型执行之后可以调用本接口从aclmdlDataset类型的数据（该类型用于描述模型推理时的输入数据、输出数据）中获取指定的输入或者输出的Tensor描述信息。

**典型场景举例**：如果模型输入Shape是动态的，在模型执行之前调[acl.mdl.set\_dataset\_tensor\_desc](function-set_dataset_tensor_desc.md)设置该输入的Tensor描述信息，在模型执行之后，调用acl.mdl.get\_dataset\_tensor\_desc接口获取模型动态输出的Tensor描述信息。

## 函数原型

- **C函数原型**

    ```c
    aclTensorDesc *aclmdlGetDatasetTensorDesc(const aclmdlDataset *dataset, size_t index)
    ```

- **python函数**

    ```python
    tensorDesc = acl.mdl.get_dataset_tensor_desc(dataset, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dataset | int，表示模型执行的输入或输出数据结构的指针地址。 |
| index | int，表示第几个输入或输出的序号。模型存在多个输入、输出时，为避免序号出错，可以先调用[acl.mdl.get_input_name_by_index](function-get_input_name_by_index.md)、[acl.mdl.get_output_name_by_index](function-get_output_size_by_index.md)接口获取输入、输出的名称，根据输入、输出名称所对应的index来设置。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| tensor_desc | int，返回指定输入或输出Tensor描述信息的指针地址。 |
