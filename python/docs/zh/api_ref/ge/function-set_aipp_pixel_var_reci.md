# 函数：set\_aipp\_pixel\_var\_reci

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

动态AIPP场景下，设置通道的方差。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetAIPPPixelVarReci(aclmdlAIPP *aippParmsSet, float dtcPixelVarReciChn0, float dtcPixelVarReciChn1, float dtcPixelVarReciChn2, float dtcPixelVarReciChn3, uint64_t batchIndex)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_aipp_pixel_var_reci(aipp_parms_set, dtc_pixel_var_reci_chn0, dtc_pixel_var_reci_chn1, dtc_pixel_var_reci_chn2, dtc_pixel_var_reci_chn3, batch_index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| aipp_parms_set | int，动态AIPP参数对象的指针地址，需提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |
| dtc_pixel_var_reci_chn0 | float，通道0的方差，默认值为1.0，取值范围：[-65504, 65504]。 |
| dtc_pixel_var_reci_chn1 | float，通道1的方差，默认值为1.0，取值范围：[-65504, 65504]。 |
| dtc_pixel_var_reci_chn2 | float，通道2的方差，默认值为1.0，取值范围：[-65504, 65504]。 |
| dtc_pixel_var_reci_chn3 | float，通道3的方差，如果只有3个通道，则该参数传默认值1.0，取值范围：[-65504, 65504]。 |
| batch_index | int，指定对第几个Batch上的图片设置通道均值，默认为0，取值范围：[0, batch_size)，batch_size是在调用acl.mdl.create_aipp接口创建aclmdlAIPP类型的数据时设置。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
