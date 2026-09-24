# 函数：set\_tensor\_origin\_shape

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

调用[acl.create\_tensor\_desc](function-create_tensor_desc.md)接口创建Tensor描述信息后，可通过acl.set\_tensor\_origin\_shape设置Tensor的原始维度信息，当前主要用于PyTorch场景下。

例如，某算子的原始Format为NHWC（原始Shape为4维）或者NDHWC（原始Shape为5维），为了提高数据访问效率，在进行模型转换或者在线构建网络时会自动转换Format，将原始数据Format转化为AI处理器内部计算数据时用的Format（NC1HWC0或者NDC1HWC0），同时进行推导Shape用于内部计算。

## 函数原型

- **C函数原型**

    ```c
    aclError aclSetTensorOriginShape(aclTensorDesc *desc, int numDims, const int64_t *dims)
    ```

- **python函数**

    ```python
    ret = acl.set_tensor_origin_shape(desc, dims)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，Tensor描述数据的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| dims | list，待设置的维度。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
