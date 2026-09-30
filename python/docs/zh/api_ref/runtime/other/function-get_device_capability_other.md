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

查询运行环境中对应Device的硬件规格大小。

## 函数原型

- **C函数原型**

    ```c
    aclError aclGetDeviceCapability(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.get_device_capability(device_id, device_info)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device ID。<br>用户调用[acl.rt.get_device_count](../device/function-get_device_count.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (*可用的Device数量* - 1)]。 |
| device_info | int，指定Device上的硬件规格类型，具体请参见[aclDeviceInfo](../datatypes/aclDeviceInfo.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| value | int，硬件规格值。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
