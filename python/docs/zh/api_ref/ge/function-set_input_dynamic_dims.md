# 函数：set\_input\_dynamic\_dims

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

如果模型输入的Shape是动态的、输入数据Format为ND格式（ND表示支持任意格式），在模型执行前调用本接口设置模型推理时具体维度的值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetInputDynamicDims(uint32_t modelId, aclmdlDataset *dataset, size_t index, const aclmdlIODims *dims)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_input_dynamic_dims(model_id, dataset_in, index, dims)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| modelId | int，模型ID。调用模型加载接口（例如[acl.mdl.load_from_file](function-load_from_file.md)接口、[acl.mdl.load_from_mem](function-load_from_mem.md)等）成功后，会返回模型ID，该ID作为本接口的输入。 |
| dataset | int，表示模型的输入数据。使用aclmdlDataset类型的数据描述模型推理时的输入数据，输入的内存地址、内存大小用aclDataBuffer类型的数据来描述，[acl.mdl.load_from_file](function-load_from_file.md)。 |
| index | int，标识动态维度的输入index。需调用[acl.mdl.get_input_index_by_name](function-get_input_index_by_name.md)接口获取，输入名称固定为ascend_mbatch_shape_data。 |
| dims | dict，指定具体某一档的所有维度信息，具体请参见[aclmdlIODims](aclmdlIODims.md)。可以调用acl.mdl.get_input_dynamic_dims接口获取指定模型支持的动态维度档位数以及每一档中的值。例如：在ATC工具进行模型转换时，使用以下参数：input_shape="data:1,1,40,-1;label:1,-1;mask:-1,-1" ，dynamic_dims="20,20,1,1; 40,40,2,2; 80,60,4,4" 若输入数据的真实维度为（1,1,40,20,1,20,1,1），则dims输入示例如下（name暂不使用）：dims = {'dimCount': 8, 'name': '', 'dims': [1,1,40,20,1,20,1,1]} |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用流程与示例，参见[动态Batch/动态分辨率/动态维度（设置多档维度值）](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0046.html)。
