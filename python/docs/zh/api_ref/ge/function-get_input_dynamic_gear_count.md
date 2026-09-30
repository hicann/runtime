# 函数：get\_input\_dynamic\_gear\_count

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

根据模型描述信息获取模型的输入所支持的动态维度档位数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetInputDynamicGearCount(const aclmdlDesc *modelDesc, size_t index, size_t *gearCount)
    ```

- **python函数**

    ```python
    gear_count, ret = acl.mdl.get_input_dynamic_gear_count(model_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型模型描述信息数据的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，预留参数，当前未使用，固定设置为<br> 1。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| gear_count | int，动态维度档位数。例如，模型的输入Tensor是4维，在模型转换时通过<br> -dynamic_dims参数设置的分档为“1, 3, 224, 224; 2, 3, 224, 224; 1, 3, 256, 256”，那么通过该接口获取的动态维度档位数为3。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

如果模型构建时没有设置动态维度的分档，那么通过该接口获取的动态维度档位数为0。模型构建的详细说明请参见[模型构建](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0030.html)。
