# 函数：set\_tensor\_place\_ment

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

设置Tensor描述的placement属性，用于标识存放Tensor数据的内存为Host内存或Device内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclSetTensorPlaceMent(aclTensorDesc *desc, aclMemType memType)
    ```

- **python函数**

    ```python
    ret = acl.set_tensor_place_ment(desc, mem_type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，Tensor描述信息的指针地址。需提前调用[acl.create_tensor_desc](function-create_tensor_desc.md)接口创建算子输入/输出的Tensor描述，作为本接口的输入。 |
| mem_type | int，指定placement属性值，其取值参考[aclMemType](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/API/runtimeapi/aclpythondevg_01_0940.html)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
