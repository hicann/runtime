# 函数：device\_peer\_access\_status

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

查询两个Device之间的数据交互状态。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDevicePeerAccessStatus(int32_t deviceId, int32_t peerDeviceId, int32_t *status)
    ```

- **python函数**

    ```python
    status, ret = acl.rt.device_peer_access_status(device_id, peer_device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，指定Device的ID。 |
| peer_dev_id | int，指定Device的ID。<br>用户调[acl.rt.get_device_count](function-get_device_count.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| status | int，设备状态。<br>0：未开启数据交互；<br>1：已开启数据交互。 |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

该接口仅可用于查询取值范围内两个Device ID对应设备的数据交互状态。若传入的Device ID超出\[0, \(可用的Device数量-1\)\]取值区间，接口查询结果为0或直接返回错误码ACL\_ERROR\_RT\_PARAM\_INVALID。
