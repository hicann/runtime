# 函数：set\_device\_sat\_mode

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

设置当前Device的浮点计算结果输出模式。

调用该接口成功后，后续在该Device上新创建的Stream按设置的模式生效，对之前已创建的Stream不生效。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetDeviceSatMode(aclrtFloatOverflowMode mode)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_device_sat_mode(mode)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| mode | int，设置浮点计算结果输出模式，具体请参见[aclrtFloatOverflowMode](../datatypes/aclrtFloatOverflowMode.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

调用该接口成功后，后续在该Device上新创建的Stream按设置的模式生效，对之前已创建的Stream不生效。
