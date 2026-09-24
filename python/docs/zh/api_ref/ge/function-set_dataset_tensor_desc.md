# 函数：set\_dataset\_tensor\_desc

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

如果模型输入或输出的Shape是动态的，在模型执行之前调用本接口设置模型输入或输出的Tensor描述信息。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetDatasetTensorDesc(aclmdlDataset *dataset, aclTensorDesc *tensorDesc, size_t index)
    ```

- **python函数**

    ```python
    dataset, ret = acl.mdl.set_dataset_tensor_desc(dataset, tensor_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dataset | int，待增加aclTensorDesc的aclmdlDataset指针地址，表示模型执行的输入或输出数据结构。需提前调用[acl.mdl.create_dataset](function-create_dataset.md)接口创建aclmdlDataset类型的数据，再调用[acl.mdl.add_dataset_buffer](function-add_dataset_buffer.md)接口向aclmdlDataset中增加aclDataBuffer。 |
| tensor_desc | int，待增加的aclTensorDesc指针地址，表示模型执行时对应的输入或输出的Tensor描述。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型的数据，当前仅支持设置模型输入、输出Tensor描述信息中的维度信息（对应[acl.create_tensor_desc](function-create_tensor_desc.md)接口中的代表维度个数的numDims参数、代表维度大小的dims参数），设置数据类型、Format无效。此处设置的维度个数、维度大小必须在模型构建时设置的输入Shape范围内，模型构建的详细说明请参见模型构建。 |
| index | int，表示第几个输入或输出的序号。模型存在多个输入、输出时，为避免序号出错，可以先调用[acl.mdl.get_input_name_by_index](function-get_input_name_by_index.md)、[acl.mdl.get_output_name_by_index](function-get_output_name_by_index.md)接口获取输入、输出的名称，然后根据输入、输出名称所对应的“index”来设置。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dataset | int，待增加aclTensorDesc的aclmdlDataset指针地址，表示模型执行的输入或输出数据结构。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

对同一个模型，[acl.mdl.set\_dynamic\_batch\_size](function-set_dynamic_batch_size.md)接口、[acl.mdl.set\_dynamic\_hw\_size](function-set_dynamic_hw_size.md)接口、[acl.mdl.set\_input\_dynamic\_dims](function-set_input_dynamic_dims.md)接口、[acl.mdl.set\_dataset\_tensor\_desc](function-set_dataset_tensor_desc.md)接口，只能调用其中一个接口。
