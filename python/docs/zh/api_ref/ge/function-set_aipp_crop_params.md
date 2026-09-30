# 函数：set\_aipp\_crop\_params

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

动态AIPP场景下，设置缩放相关的参数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetAIPPCropParams(aclmdlAIPP *aippParmsSet, int8_t cropSwitch, int32_t cropStartPosW, int32_t cropStartPosH, int32_t cropSizeW, int32_t cropSizeH,uint64_t batchIndex)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_aipp_crop_params(aipp_parms_set, crop_switch, crop_start_pos_w, crop_start_pos_h, crop_size_w, crop_size_h, batch_index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| aipp_parms_set | int，动态AIPP参数对象的指针地址，需提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |
| crop_switch | int，是否对图片执行抠图操作。<br> 取值范围：<br> 0：不执行抠图操作，设置为0时，则设置cropStartPosW、cropStartPosH、cropSizeW、cropSizeH参数无效。<br> 1：执行抠图操作。 |
| crop_start_pos_w | int，抠图时，坐标点起始位置在图中横向的坐标。对于YUV420SP_U8格式的图像，参数取值要求是偶数，取值范围：[0, 4095]。 |
| crop_start_pos_h | int，抠图时，坐标点起始位置在图中纵向的坐标。对于YUV420SP_U8格式的图像，参数取值要求是偶数，取值范围：[0, 4095]。 |
| crop_size_w | int，抠图区域的宽度。取值范围：[1, 4096]。 |
| crop_size_h | int，抠图区域的高度。取值范围：[1, 4096]。 |
| batch_index | int，指定对第几个Batch上的图片执行抠图操作，默认为0，取值范围：[0, batch_size)，batch_size是在调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据时设置。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

若开启抠图功能，则通过[acl.mdl.set\_aipp\_src\_image\_size](function-set_aipp_src_image_size.md)接口设置的参数与通过`acl.mdl.set\_aipp\_crop\_params`接口设置的参数之间必须满足以下公式：

- srcImageSizeW ≥ cropSizeW + cropStartPosW
- srcImageSizeH ≥ cropSizeH + cropStartPosH
