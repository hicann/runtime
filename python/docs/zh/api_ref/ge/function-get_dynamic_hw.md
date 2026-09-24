# 函数：get\_dynamic\_hw

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

根据模型描述信息获取模型支持的动态宽高信息。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetDynamicHW(const aclmdlDesc *modelDesc, size_t index, aclmdlHW *hw)
    ```

- **python函数**

    ```python
    hw_info, ret = acl.mdl.get_dynamic_hw(model_desc, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_desc | int，aclmdlDesc类型数据的指针地址。需提前调用[acl.mdl.create_desc](function-create_desc.md)接口创建aclmdlDesc类型的数据。 |
| index | int，预留参数，当前未使用，固定设置为<br> 1。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| hw_info | dict，获取的模型支持的宽高信息。<br> 最大的HW数量为128。hw_info = { "hwCount": int，#模型中支持的宽高分档数 "hw":[xx, xx,] # 模型中支持的具体分档，每组分档中，数组下标为0代表的是高，下标为1代表的是宽} - hwCount等于0时，表示不支持设置档位信息，以模型中的档位为准。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
