# 函数：get\_output\_name\_by\_index

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

根据模型描述信息获取模型中指定输出的输出算子名称、算子输出边的下标、top名称或输出名称。

## 函数原型

- **C函数原型**

    ```c
    const char *aclmdlGetOutputNameByIndex(const aclmdlDesc *modelDesc, size_tindex)
    ```

- **python函数**

    ```python
    output_name = acl.mdl.get_output_name_by_index(model_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型数据的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，指定获取第几个输入的大小，index值从0开始。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| output_name | str，返回指定输出的输出名称。返回指定输出的输出算子名称、算子输出边的下标、top名称或输出名称。不同原始网络、不同构建模型的方式，调用本接口获取的返回值格式不同。<br> Caffe网络。返回值格式如下，各项之间以冒号分割，如果模型中包含top名称就返回，不包含就不返回：输出算子名称: 算子输出边下标: top名称<li>TensorFlow网络。<br> 使用ATC工具构建om模型的场景下，返回值格式如下，各项之间以冒号分割：输出算子名称: 算子输出边下标<br> 使用构图接口构建om模型的场景下，返回值格式如下，各项之间以下划线分割：output_网络输出下标_输出算子名称_算子输出边下标</li><li>ONNX网络。返回值格式如下，各项之间以冒号分割：输出算子名称: 算子输出边下标: 输出名称如果在构建om模型时，以下情况会在返回值中包含输出名称。<br> 不指定网络模型中输出算子的名称或输出的名称（系统会自动从原始模型中获取输出的名称）。<br> 仅指定网络模型中输出的名称。使用构图接口构建om模型时，如果指定了网络模型中输出算子的名称，则返回值格式如下，各项之间以下划线分割：output_网络输出下标_输出算子名称_算子输出边下标</li> |
