# 函数：get\_device\_res\_limit

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

获取当前进程的Device资源限制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t* value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.get_device_res_limit(device_id, type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device ID。 |
| type | int, 枚举值, 具体请参见新增数据结构[aclrtDevResLimitType](../datatypes/aclrtDevResLimitType.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
| value | int，资源限制的大小。 |
