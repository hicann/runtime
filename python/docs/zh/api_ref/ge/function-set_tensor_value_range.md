# 函数：set\_tensor\_value\_range

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

调用[acl.create\_tensor\_desc](function-create_tensor_desc.md)接口创建Tensor描述信息后，可通过本接口设置Tensor的数据值的范围。

使用场景：部分算子input的值就是该算子的输出Shape，在动态Shape场景下，这个Shape的值就有一个取值范围，在执行算子时，需要在input上设置Shape值的范围（例如：\[\[16, 16\], \[1, 128\], \[20, 20\], \[1, 10\]\]），才能正常执行算子。

## 函数原型

- **C函数原型**

    ```c
    aclError aclSetTensorValueRange(aclTensorDesc* desc, size_t valueCount, int64_t valueRange[][ACL_TENSOR_VALUE_RANGE_NUM])
    ```

- **python函数**

    ```python
    ret = acl.set_tensor_value_range(desc, value_range)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，aclTensorDesc类型的指针地址。需提前调用[函数：create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| value_range | list，用二维列表表示每个数据值的范围。ACL_TENSOR_VALUE_RANGE_NUM = 2 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
