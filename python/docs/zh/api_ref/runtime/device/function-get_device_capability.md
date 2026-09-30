# 函数：get\_device\_capability

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

查询device特性是否支持。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetDeviceCapability(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.get_device_capability(device_id, dev_feature_type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device ID。 |
| dev_feature_type | int, 枚举值，具体请参见新增数据结构[aclrtDevFeatureType](../datatypes/aclrtDevFeatureType.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
| value | int，特性是否支持。<br>0：不支持<br>1：支持 |
