# 函数：set\_dynamic\_batch\_size

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

在动态Batch场景下，在模型执行前调用本接口设置模型推理时的批量大小Batch（每次处理图片的数量）。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetDynamicBatchSize(uint32_t modelId, aclmdlDataset *dataset, size_t index, uint64_t batchSize)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_dynamic_batch_size(model_id, dataset, index, batch_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，模型ID。调用模型加载接口（例如[acl.mdl.load_from_file](function-load_from_file.md)接口、[acl.mdl.load_from_mem](function-load_from_mem.md)等）成功后，会返回模型ID，该ID作为本接口的输入。 |
| dataset | int，表示模型的输入数据对应的指针地址。使用aclmdlDataset类型的数据描述模型推理时的输入数据，输入的内存地址、内存大小用aclDataBuffer类型的数据来描述，具体请参见[acl.mdl.load_from_file](function-load_from_file.md)。 |
| index | int，标识动态Batch输入的输入index，需调用[acl.mdl.get_input_index_by_name](function-get_input_index_by_name.md)接口获取，动态Batch和动态分辨率输入的名称固定为ascend_mbatch_shape_data，动态AIPP输入的名称固定为ascend_dynamic_aipp_data。 |
| batch_size | int，指定模型推理时的批量大小Batch。此处设置的batch_size只能为模型构建时设置的Batch档位中的其中一档，也可调用[acl.mdl.get_dynamic_batch](function-get_dynamic_batch.md)接口获取指定模型支持的Batch档位数以及每一档中的Batch数。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用流程与示例，参见[动态Batch/动态分辨率/动态维度（设置多档维度值）](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0046.html)。
