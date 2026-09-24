# 函数：get\_input\_dynamic\_dims

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

根据模型描述信息获取模型的输入所支持的动态维度信息。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetInputDynamicDims(const aclmdlDesc *modelDesc, size_t index, aclmdlIODims *dims, size_t gearCount)
    ```

- **python函数**

    ```python
    dims_out, ret = acl.mdl.get_input_dynamic_dims(model_desc, index, gear_count)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型数据的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，预留参数，当前未使用，固定设置为<br> 1。 |
| gear_count | int，模型支持的动态维度档位数，需要先通过acl.mdl.get_input_dynamic_gear_count接口获取。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dims_out | list，获取输入的动态维度信息。dims_out参数是一个列表，模型有几个输入，则该列表就有几个元素。列表中的每个元素都是一个[aclmdlIODims](aclmdlIODims.md)的字典，aclmdlIODims字典中的dims是一个列表，该列表中的每个元素对应每一档中的具体值。例如：dims_out, ret = acl.mdl.get_input_dynamic_dims(model_desc, -1, gear_count) |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

只有在模型转换时通过--dynamic\_dims参数设置了分档信息后，才可以调用该接口获取动态维度信息。

例如，模型有三个输入，分别为data\(1, 1, 40, -1\)，label\(1, -1\)，mask\(-1, -1\) ， 其中-1表示动态可变。在模型转换时，--dynamic\_dims参数的配置示例为：--dynamic\_dims="20,20,1,1; 40,40,2,2; 80,60,4,4"，则通过本接口获取的动态维度信息为（**aclmdlIODims**字典内的name暂不使用）：

- 第0档：

    - **aclmdlIODims**内dimCount：8，表示所有输入Tensor的维度数量之和。

    - **aclmdlIODims**内的dims：“1,1,40,20,1,20,1,1”，表示data\(1,1,40,20\)+label\(1,20\)+mask\(1,1\)

- 第1档：

    - **aclmdlIODims**内dimCount：8，表示所有输入Tensor的维度数量之和。

    - **aclmdlIODims**内的dims：“1,1,40,40,1,40,2,2”，表示data\(1,1,40,40\)+label\(1,40\)+mask\(2,2\)

- 第2档：

    - **aclmdlIODims**内dimCount：8，表示所有输入Tensor的维度数量之和。

    - **aclmdlIODims**内的dims：“1,1,40,80,1,60,4,4”，表示data\(1,1,40,80\)+label\(1,60\)+mask\(4,4\)
