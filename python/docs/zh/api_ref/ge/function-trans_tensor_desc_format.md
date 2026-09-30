# 函数：trans\_tensor\_desc\_format

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

根据指定的dstFormat转换srcDesc（输入源aclTensorDesc中）的Format，生成新的目标aclTensorDesc，源aclTensorDesc中的Format保持不变。当前版本不支持该接口，预留接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclTransTensorDescFormat(const aclTensorDesc *srcDesc, aclFormat dstFormat, aclTensorDesc **dstDesc)
    ```

- **python函数**

    ```python
    dst_desc, ret = acl.trans_tensor_desc_format(src_desc, dst_format)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| src_desc | int，输入源aclTensorDesc数据的指针地址。需提前调用[函数：create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| dst_format | int，需要设置的目标Format，具体请参见[aclFormat](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/API/runtimeapi/aclpythondevg_01_0914.html)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dst_desc | int，输出aclTensorDesc的指针地址。需提前调用[函数：create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
