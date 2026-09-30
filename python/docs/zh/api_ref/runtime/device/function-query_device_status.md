# 函数：query\_device\_status

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

查询Device状态是正常可用、还是异常不可用。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtQueryDeviceStatus(int32_t deviceId, aclrtDeviceStatus *deviceStatus)
    ```

- **python函数**

    ```python
    device_status, ret = acl.rt.query_device_status(device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device设备号。<br>用户调用[acl.rt.get_device_count](function-get_device_count.md)接口获取可用的Device数量后，该Device ID的取值范围为[0, (*可用的Device数量*- 1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| device_status | int，Device状态，具体请参见[aclrtDeviceStatus](../datatypes/aclrtDeviceStatus.md)。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
