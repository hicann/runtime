# 函数：set\_input\_aipp

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

动态AIPP场景下，根据指定的动态AIPP输入的输入index，设置模型推理时的AIPP参数值。

动态AIPP支持的几种操作的计算方式及其计算顺序如下：抠图-\>色域转换-\>减均值/归一化-\>padding。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetInputAIPP(uint32_t modelId, aclmdlDataset *dataset, size_t index, const aclmdlAIPP *aippParmsSet)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_input_aipp(model_id, dataset, index, aipp_parms_set)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，模型的ID，可在以下接口成功加载模型后获取到模型ID。<br> [acl.mdl.load_from_file](function-load_from_file.md)<br> [acl.mdl.load_from_mem](function-load_from_mem.md)<br> [acl.mdl.load_from_file_with_mem](function-load_from_file_with_mem.md)<br> [acl.mdl.load_from_mem_with_mem](function-load_from_mem_with_mem.md) |
| dataset | int，表示模型的输入数据的指针地址，使用aclmdlDataset类型的数据描述模型推理时的输入数据，输入的内存地址、内存大小用aclDataBuffer类型的数据来描述。 |
| index | int，标识动态AIPP输入的输入index。<br> 多个动态AIPP输入的场景下，用户可调用[acl.mdl.get_aipp_type](function-get_aipp_type.md)接口获取指定模型输入所关联的动态AIPP输入的输入index。<br> 为保证向前兼容，如果明确只有一个动态AIPP输入，可调用[acl.mdl.get_input_index_by_name](function-get_input_index_by_name.md)接口获取，输入名称固定为“ascend_dynamic_aipp_data”。 |
| aipp_parms_set | int，动态AIPP参数对象的指针地址，需提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 经过动态AIPP处理后的图像的宽、高必须与原始模型中输入Shape中的宽、高保持一致。
- 多Batch场景下，根据每个Batch的配置计算出动态AIPP后输出图片的宽、高，经过动态AIPP后每个Batch的输出图片宽、高必须是一致的。计算输出图片宽、高的计算公式如表1。
- 抠图或者缩放或者补边之后，对图片宽、高的校验规则如下，其中，aippOutputW、aippOutputH分别表示AIPP输出图片的宽、高，其它参数是[acl.mdl.set\_aipp\_src\_image\_size](function-set_aipp_src_image_size.md)、[acl.mdl.set\_aipp\_crop\_params](function-set_aipp_crop_params.md)、[acl.mdl.set\_aipp\_padding\_params](function-set_aipp_padding_params.md)接口的入参。

## 参考资源

接口调用流程与示例，参见[动态AIPP（单个动态AIPP输入）](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0041.html)。

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
