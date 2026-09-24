# 函数：set\_aipp\_csc\_params

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

动态AIPP场景下，设置CSC色域转换相关的参数，若色域转换开关关闭，则调用该接口设置的参数无效。

```python
YUV转BGR：
| B |   | cscMatrixR0C0 cscMatrixR0C1 cscMatrixR0C2 | | Y - cscInputBiasR0 |
| G | = | cscMatrixR1C0 cscMatrixR1C1 cscMatrixR1C2 | | U - cscInputBiasR1 | >> 8
| R |   | cscMatrixR2C0 cscMatrixR2C1 cscMatrixR2C2 | | V - cscInputBiasR2 |
BGR转YUV：
| Y |   | cscMatrixR0C0 cscMatrixR0C1 cscMatrixR0C2 | | B |        | cscOutputBiasR0 |
| U | = | cscMatrixR1C0 cscMatrixR1C1 cscMatrixR1C2 | | G | >> 8 + | cscOutputBiasR1 |
| V |   | cscMatrixR2C0 cscMatrixR2C1 cscMatrixR2C2 | | R |        | cscOutputBiasR2 |
```

色域转换参数值与转换前图片的格式、转换后图片的格式强相关，您可以参见[《ATC离线模型编译工具》](https://hiascend.com/document/redirect/cannCommunityATC)下的色域转换配置说明，按照转换前图片格式、转换后图片格式来配置色域转换参数。如果手册中列举的图片格式不满足要求，您需自行根据实际需求配置色域转换参数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetAIPPCscParams(aclmdlAIPP *aippParmsSet, int8_t cscSwitch,
    int16_t cscMatrixR0C0, int16_t cscMatrixR0C1, int16_t cscMatrixR0C2,
    int16_t cscMatrixR1C0, int16_t cscMatrixR1C1,int16_t cscMatrixR1C2,
    int16_t cscMatrixR2C0, int16_t cscMatrixR2C1, int16_t cscMatrixR2C2,
    uint8_t cscOutputBiasR0, uint8_t cscOutputBiasR1, uint8_t cscOutputBiasR2,
    uint8_t cscInputBiasR0, uint8_t cscInputBiasR1, uint8_t cscInputBiasR2)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_aipp_csc_params(aipp_parms_set, csc_switch, csc_matrix_R0C0, csc_matrix_R0C1, csc_matrix_R0C2,csc_matrix_R1C0, csc_matrix_R1C1, csc_matrix_R1C2, csc_matrix_R2C0, csc_matrix_R2C1, csc_matrix_R2C2, csc_output_bias_R0, csc_output_bias_R1, csc_output_bias_R2, csc_input_bias_R0, csc_input_bias_R1, csc_input_bias_R2)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| aipp_parms_set | int，动态AIPP参数对象的指针地址，需提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |
| csc_switch | int，色域转换开关。<br>取值范围：<br> 0：关闭色域转换开关，默认为0。<br> 1：打开色域转换开关。 |
| csc_matrix_R0C0 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R0C1 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R0C2 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R1C0 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R1C1 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R1C2 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R2C0 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R2C1 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_matrix_R2C2 | int，色域转换矩阵参数，取值范围：[-32677, 32676]。 |
| csc_output_bias_R0 | int，RGB转YUV时的输出偏移，默认值为0，取值范围：[0, 255]。 |
| csc_output_bias_R1 | int，RGB转YUV时的输出偏移，默认值为0，取值范围：[0, 255]。 |
| csc_output_bias_R2 | int，RGB转YUV时的输出偏移，默认值为0，取值范围：[0, 255]。 |
| csc_input_bias_R0 | int，YUV转RGB时的输入偏移，默认值为0，取值范围：[0, 255]。 |
| csc_input_bias_R1 | int，YUV转RGB时的输入偏移，默认值为0，取值范围：[0, 255]。 |
| csc_input_bias_R2 | int，YUV转RGB时的输入偏移，默认值为0，取值范围：[0, 255]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

如果通过[acl.mdl.set\_aipp\_input\_format](function-set_aipp_input_format.md)接口设置的原始图像格式为YUV400，则不支持通过本接口设置色域转换参数。
