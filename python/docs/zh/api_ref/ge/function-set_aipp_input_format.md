# 函数：set\_aipp\_input\_format

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

动态AIPP场景下，必须设置原始输入图像的格式。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetAIPPInputFormat(aclmdlAIPP *aippParmsSet, aclAippInputFormat inputFormat)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_aipp_input_format(aipp_parms_set, input_format)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| aipp_parms_set | int，动态AIPP参数对象的指针地址，需提前调用[acl.mdl.create_aipp](function-create_aipp.md)接口创建aclmdlAIPP类型的数据。 |
| input_format | int，表示原始输入图像的格式，具体请参见[aclAippInputFormat](aclAippInputFormat.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |
