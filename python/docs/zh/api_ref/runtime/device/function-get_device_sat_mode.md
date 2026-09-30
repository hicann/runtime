# 函数：get\_device\_sat\_mode

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

查询当前Device的浮点计算结果输出模式。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetDeviceSatMode(aclrtFloatOverflowMode *mode)
    ```

- **python函数**

    ```python
    mode, ret = acl.rt.get_device_sat_mode()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| mode | int，获取浮点计算结果输出模式，具体请参见[aclrtFloatOverflowMode](../datatypes/aclrtFloatOverflowMode.md)。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
