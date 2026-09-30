# 函数：get\_input\_dims

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

根据模型描述获取模型的输入Tensor的维度信息。

如果模型中含有静态AIPP配置信息，您可以根据实际需要选择acl.mdl.get\_input\_dims接口或acl.mdl.get\_input\_dims\_v2接口查询维度信息，两者的区别在于：

- 通过**acl.mdl.get\_input\_dims**接口获取的维度信息，各维度的值与输入图像的各维度的值保持一致，详细规则请参见表1。

- 通过**acl.mdl.get\_input\_dims\_v2**接口获取的维度信息，H维度的值 = 输入图像的H维度值 \* 系数，不同图片格式下C维度的值不同，详细规则请参见acl.mdl.get\_input\_dims\_v2接口处的表1，且各维度值相乘的结果值与通过acl.mdl.get\_input\_size\_by\_index接口获取的值保持一致。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetInputDims(const aclmdlDesc *modelDesc, size_t index, aclmdlIODims *dims)
    ```

- **python函数**

    ```python
    dims, ret = acl.mdl.get_input_dims(model_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型数据的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，指定获取第几个输入的dims，index值从0开始。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dims | dict，针对多batch或多种宽高的场景，按照该字典的数组返回其支持的最大档的组合，具体请参见[aclmdlIODims](aclmdlIODims.md)。针对动态Batch、动态分辨率（宽高）的场景，输入tensor的dims中batch size或宽高为<br> 1，表示其动态可变。例如，输入tensor的format为NCHW，在动态Batch场景下，动态可变的输入tensor的dims为[-1,3,224,224]；在动态分辨率场景下，动态可变的输入tensor的dims为[1,3,-1,-1]。举例中的斜体部分以实际情况为准。若tensor的name长度大于127，则在输出的dims.name时，接口会将tensor的name转换为“acl_modelId_${id}_input_${index}_${随机字符串} ”格式（如果转换后的tensor的name与模型中已有的tensor的name冲突，则会在转换后的name尾部增加“_${随机字符串} ”，否则不会增加随机字符串），并在转换后的name与原name之间建立映射关系，用户可调用[acl.mdl.get_tensor_real_name](function-get_tensor_real_name.md)接口，传入转换后的name，获取原name（若向接口传入原name，则获取的还是原name）；若tensor的name长度小于或等于127，则在输出的dims.name时，按tensor的name输出。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

**表 1** 静态AIPP场景下的维度定义规则

| 图像格式 | Format参考格式 | 维度定义规则 |
| --- | --- | --- |
| YUV420SP_U8 | NHWC | n,h,w,c |
| XRGB8888_U8 | NHWC | n,h,w,c |
| RGB888_U8 | NHWC | n,h,w,c |
| YUV400_U8 | NHWC | n,h,w,c |
| ARGB8888_U8 | NHWC | n,h,w,c |
| YUYV_U8 | NHWC | n,h,w,c |
| YUV422SP_U8 | NHWC | n,h,w,c |
| AYUV444_U8 | NHWC | n,h,w,c |
