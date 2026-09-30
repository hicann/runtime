# 函数：set\_tensor\_shape\_range

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

调用[acl.create\_tensor\_desc](function-create_tensor_desc.md)接口创建Tensor描述信息后，可通过本接口设置Tensor的各个维度的取值范围。

使用场景：动态Shape的算子，其输入Shape中变化维度用-1表示，但每个变化维度的范围是不一样的，需要显式设置。

如Shape为\[16, -1, 20, -1\]，对应的shape range可以是\[\[16, 16\], \[1, 128\], \[20, 20\], \[1, 10\]\]，表示第一维的Shape范围固定为16，第二维的Shape范围为1到128，第三维的Shape范围固定为20，第四维的Shape范围为1到10。

## 函数原型

- **C函数原型**

    ```c
    aclError aclSetTensorShapeRange(aclTensorDesc* desc, size_t dimsCount, int64_t dimsRange[][ACL_TENSOR_SHAPE_RANGE_NUM])
    ```

- **python函数**

    ```python
    ret = acl.set_tensor_shape_range(desc, dims_range)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，Tensor描述数据的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| dims_range | list，用二维list表示每个维度的取值范围。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
