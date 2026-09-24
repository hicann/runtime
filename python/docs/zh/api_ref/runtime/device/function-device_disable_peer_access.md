# 函数：device\_disable\_peer\_access

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

关闭当前Device与指定Device之间的内存复制功能。关闭内存复制功能是Device级的。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDeviceDisablePeerAccess(int32_t peerDeviceId)
    ```

- **python函数**

    ```python
    ret = acl.rt.device_disable_peer_access(peer_dev_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| peer_dev_id | int，Device ID，该ID不能与当前Device的ID相同。<br>用户调[acl.rt.get_device_count](function-get_device_count.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 需调用两次[acl.rt.device\_disable\_peer\_access](function-device_disable_peer_access.md)接口使能两个Device之间的数据交互功能（例如，调用一次[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口使能Device 0到Device 1的数据交互，再调用一次[acl.rt.device\_disable\_peer\_access](function-device_disable_peer_access.md)接口使能Device 1到Device 0的数据交互）。
- 不支持在Atlas 500 Pro智能边缘服务器（型号 3000）上使用。
