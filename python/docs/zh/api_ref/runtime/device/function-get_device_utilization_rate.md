# 函数：get\_device\_utilization\_rate

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

查询Device上Cube、Vector、AI CPU等的利用率。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetDeviceUtilizationRate(int32_t deviceId, aclrtUtilizationInfo *utilizationInfo)
    ```

- **python函数**

    ```python
    utilization_info, ret = acl.rt.get_device_utilization_rate(device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device设备号。<br>用户调用[acl.rt.get_device_count](function-get_device_count.md)接口获取可用的Device数量后，该Device ID的取值范围为[0, (*可用的Device数量*-1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| utilization_info | dict，aclrtUtilizationInfo类型利用率信息字典，具体请参见[aclrtUtilizationInfo](../datatypes/aclrtUtilizationInfo.md)。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 昇腾虚拟化实例场景下，不支持调用本接口查询利用率，接口返回值无实际意义。
- 开启Profiling功能时，不支持调用本接口查询利用率，接口返回值无实际意义。
- 查询Device内存利用率为预留功能，当前版本不支持，若调用本接口查询内存利用率，查询到的利用率为-1。
<!-- npu="910" id7 -->
- Atlas训练系列产品上没有Vector，调用本接口查询Vector利用率时，查询到的利用率为-1。
<!-- end id7 -->
