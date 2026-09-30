# 函数：set\_aipp\_src\_image\_size

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

动态AIPP场景下，必须设置原始图片的宽和高。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetAIPPSrcImageSize(aclmdlAIPP *aippParmsSet, int32_t srcImageSizeW, int32_t srcImageSizeH)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_aipp_src_image_size(aipp_parms_set, src_image_size_w, src_image_size_h)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| aipp_parms_set | int，动态AIPP参数对象，需提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |
| src_image_size_w | int，原始图片的宽，对于YUV420SP_U8类型的图像，要求取值是偶数，取值范围：[2, 4096]。 |
| src_image_size_h | int，原始图片的高，对于YUV420SP_U8类型的图像，要求取值是偶数，取值范围：[1, 4096]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
