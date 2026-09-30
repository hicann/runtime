# 函数：set\_tensor\_const

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

为算子设置constant输入，指定存放输入Tensor数据的内存地址和地址长度。

## 函数原型

- **C函数原型**

    ```c
    aclError aclSetTensorConst(aclTensorDesc *desc, void *dataBuffer, size_t length)
    ```

- **python函数**

    ```python
    ret = acl.set_tensor_const(desc, dataBuffer, length)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，aclTensorDesc类型的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建aclTensorDesc类型。 |
| dataBuffer | int，存放constant输入Tensor数据的内存地址。此处算子输入Tensor数据的内存必须根据应用运行模式来确定。内存申请接口请参见[内存管理](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/API/runtimeapi/aclpythondevg_01_0109.html)。<br> 应用运行在Host时，此处需申请Host上的内存。<br> 应用运行在Device时，此处需申请Device上的内存。 |
| length | int，内存地址的长度，单位是Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
