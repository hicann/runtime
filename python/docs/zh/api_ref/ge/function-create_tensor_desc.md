# 函数：create\_tensor\_desc

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

创建aclTensorDesc类型的数据，该数据类型用于描述Tensor的数据类型、Shape、Format等信息。

如需销毁aclTensorDesc类型的数据，请参见[函数：destroy\_tensor\_desc](function-destroy_tensor_desc.md)。

## 函数原型

- **C函数原型**

    ```c
    aclTensorDesc *aclCreateTensorDesc(aclDataType dataType, int numDims, const int64_t *dims, aclFormat format)
    ```

- **python函数**

    ```python
    tensor_desc = acl.create_tensor_desc(data_type, dims, format)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data_type | int，表示Tensor描述的数据类型。 |
| dims | list，Tensor描述指定维度大小。dims是一个int的列表，列表中的每项表示Tensor中每个维度的大小，如果列表中某个元素的值为0，则为空Tensor。如果用户需要使用空Tensor，则在申请内存时，内存大小最小为1Byte，以保障后续业务正常运行。 |
| format | int，Tensor描述的Format。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| tensor_desc | int，创建Tensor描述的地址对象。 |
