# 函数：get\_tensor\_desc\_dim\_range

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

获取Tensor描述中指定维度的范围，\[1, -1\]表示全Shape范围。

## 函数原型

- **C函数原型**

    ```c
    aclError aclGetTensorDescDimRange(const aclTensorDesc *desc, size_t index, size_t dimRangeNum, int64_t *dimRange)
    ```

- **python函数**

    ```python
    dim_range, ret = acl.get_tensor_desc_dim_range(desc, index, dim_range_num)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，aclTensorDesc类型的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| index | int，指定获取第几个维度的大小，index值从0开始。用户调用[acl.get_tensor_desc_num_dims](function-get_tensor_desc_num_dims.md)接口获取Shape维度个数，该index的取值范围：[0, (shape维度个数<br> 1)]。 |
| dim_range_num | int，“dim_range”的长度，该值必须大于或等于2。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dim_range | list，Tensor描述中index指定维度的Shape范围。<br> 第一个元素值表示Shape范围的最小值，第二个元素值表示Shape范围的最大值。该数组中仅前2个元素值有效。<br> 当dim_range数组的值为[1, -1]时，表示全Shape范围。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

当[acl.get\_tensor\_desc\_num\_dims](function-get_tensor_desc_num_dims.md)接口的返回值为**ACL\_UNKNOWN\_RANK（0xFFFFFFFFFFFFFFFE）**时，表示动态Shape场景下维度个数未知，则不能调用acl.get\_tensor\_desc\_dim\_range接口获取指定维度的范围。
