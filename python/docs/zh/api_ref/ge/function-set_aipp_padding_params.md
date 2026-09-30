# 函数：set\_aipp\_padding\_params

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

动态AIPP场景下，设置补边相关的参数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetAIPPPaddingParams(aclmdlAIPP *aippParmsSet, int8_t paddingSwitch, int32_t paddingSizeTop, int32_t paddingSizeBottom, int32_t paddingSizeLeft, int32_t paddingSizeRight, uint64_t batchIndex)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_aipp_padding_params(aipp_parms_set, padding_switch, padding_size_top, padding_size_bottom, padding_size_left, padding_size_right, batch_index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| aipp_parms_set | int，动态AIPP参数对象的指针地址，需提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |
| padding_switch | int，是否对图片执行补边操作。取值范围：- 0：不执行补边操作，默认为0（此时设置“padding_size_top”、“padding_size_bottom”、“padding_size_left”、“padding_size_right”参数无效）。<br> 1：执行补边操作。 |
| padding_size_top | int，在图片上方填充的值，取值范围：[0, 32]。 |
| padding_size_bottom | int，在图片下方填充的值，取值范围：[0, 32]。 |
| padding_size_left | int，在图片左方填充的值，取值范围：[0, 32]。 |
| padding_size_right | int，在图片右方填充的值，取值范围：[0, 32]。 |
| batch_index | int，指定对第几个Batch上的图片执行补边操作，默认为0，取值范围：[0, batch_size)，batch_size是在调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据时设置。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

补边之后，图片的宽必须小于等于1080。
