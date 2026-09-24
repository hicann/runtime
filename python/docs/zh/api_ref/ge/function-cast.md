# 函数：cast

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
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

转换输入数据的数据类型，异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopCast(const aclTensorDesc *srcDesc, const aclDataBuffer *srcBuffer, const aclTensorDesc *dstDesc, aclDataBuffer *dstBuffer, uint8_t truncate, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.op.cast(src_desc, src_buffer, dst_desc, dst_buffer,truncate, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| src_desc | int，输入Tensor描述指针地址。 |
| src_buffer | int，输入Tensor，调用`acl.create_data_buffer`创建的aclDataBuffer指针地址。 |
| dst_desc | int，输出Tensor的描述指针地址。 |
| dst_buffer | int，输出Tensor，调用`acl.create_data_buffer`创建的aclDataBuffer指针地址。 |
| truncate | int，预留。 |
| stream | int，执行算子所在的Stream，Stream地址对象。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用示例，参见[接口调用流程](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0069.html)。
