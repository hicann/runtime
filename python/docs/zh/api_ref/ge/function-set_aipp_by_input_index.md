# 函数：set\_aipp\_by\_input\_index

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

动态AIPP场景下，根据指定的模型输入的输入index，设置模型推理时的AIPP参数值。

动态AIPP支持的几种操作的计算方式及其计算顺序如下：抠图-\>色域转换-\>减均值/归一化-\>padding。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetAIPPByInputIndex(uint32_t modelId, aclmdlDataset *dataset, size_t index, const aclmdlAIPP *aippParmsSet)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_aipp_by_input_index(model_id, dataset_in, index, aipp)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，模型ID。调用模型加载接口（例如[acl.mdl.load_from_file](function-load_from_file.md)接口、[acl.mdl.load_from_mem](function-load_from_mem.md)等）成功后，会返回模型ID，该ID作为本接口的输入。 |
| dataset_in | int，表示模型推理的输入数据的指针地址。使用aclmdlDataset类型的数据描述模型推理时的输入数据，输入的内存地址、内存大小用aclDataBuffer类型的数据来描述，具体请参见[acl.mdl.load_from_file](function-load_from_file.md)。 |
| index | int，表示在第几个输入上设置动态AIPP参数。如果该输入没有关联动态AIPP输入，则返回报错。可调用[acl.mdl.get_aipp_type](function-get_aipp_type.md)查询指定模型的指定输入是否有关联的动态AIPP输入，如存在关联则本接口的index参数值与[acl.mdl.get_aipp_type](function-get_aipp_type.md)接口的index参数值保持一致；如不存在则无需设置动态AIPP参数。 |
| aipp | int，动态AIPP参数对象的指针地址。提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 经过动态AIPP处理后的图像的宽、高必须与原始模型输入Shape中的宽、高保持一致。

- 多Batch场景下，根据每个Batch的配置计算出动态AIPP后输出图片的宽、高，经过动态AIPP后每个Batch的输出图片宽、高必须是一致的。计算输出图片宽、高的计算公式如表1所示。

- 抠图或者缩放或者补边操作之后，对图片宽、高的校验规则如下，其中，aippOutputW、aippOutputH分别表示AIPP输出图片的宽、高，其它参数是**acl.mdl.set\_aipp\_srcImage\_size、acl.mdl.set\_aipp\_scf\_params、acl.mdl.set\_aipp\_crop\_params、acl.mdl.set\_aipp\_padding\_params**接口的入参，具体请参考表1。

 **表 1** 输出图片宽、高计算公式

 | 抠图 | 缩放 | 补边（padding） | 动态AIPP输出图片的宽、高 |
| --- | --- | --- | --- |
| 否 | 否 | 否 | aippOutputW = srcImageSizeW aippOutputH = srcImageSizeH |
| 是 | 否 | 否 | aippOutputW = cropSizeW aippOutputH = cropSizeH |
| 是 | 是 | 否 | aippOutputW = scfOutputSizeW aippOutputH = scfOutputSizeH |
| 是 | 否 | 是 | aippOutputW = cropSizeW + paddingSizeLeft + paddingSizeRight aippOutputH = cropSizeH + paddingSizeTop + paddingSizeBottom |
| 否 | 否 | 是 | aippOutputW = srcImageSizeW + paddingSizeLeft + paddingSizeRight aippOutputH = srcImageSizeH + paddingSizeTop + paddingSizeBottom |
| 否 | 是 | 是 | aippOutputW = scfOutputSizeW + paddingSizeLeft + paddingSizeRight aippOutputH = scfOutputSizeH + paddingSizeTop + paddingSizeBottom |
| 否 | 是 | 否 | aippOutputW = scfOutputSizeW aippOutputH = scfOutputSizeH |
| 是 | 是 | 是 | aippOutputW = scfOutputSizeW + paddingSizeLeft + paddingSizeRight aippOutputH = scfOutputSizeH + paddingSizeTop + paddingSizeBottom |

## 资源参考

接口调用示例，参见[接口调用流程](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0069.html)。
