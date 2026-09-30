# 函数：device\_can\_access\_peer

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

查询Device之间是否支持内存复制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDeviceCanAccessPeer(int32_t *canAccessPeer, int32_t deviceId, int32_t peerDeviceId)
    ```

- **python函数**

    ```python
    can_access_peer, ret = acl.rt.device_can_access_peer(dev_id, peer_dev_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dev_id | int，指定Device的ID，不能与peer_dev_id参数值相同。<br>用户调用[acl.rt.get_device_count](function-get_device_count.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。 |
| peer_dev_id | int，指定Device的ID，不能与dev_id参数值相同。<br>用户调用[acl.rt.get_device_count](function-get_device_count.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| can_access_peer | int，通过dev_id参数指定的Device和通过peer_dev_id参数指定的Device之间是否支持内存复制，1表示支持，0表示不支持。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 仅支持物理机和容器场景。
- 仅支持同一个PCIe Switch内Device之间的内存复制。AI Server场景下，虽然是跨PCIe Switch，但也支持Device之间的内存复制。
- 仅支持同一个物理机或容器内的Device之间的内存复制操作。
- 仅支持同一个进程内、线程间的Device之间的内存复制，不支持不同进程间Device之间的内存复制。
- Host的相关端口要已使能（例如Host BIOS等），同一个PCIe Switch内Device之间的拷贝才能端到端可用。
- 不支持在Atlas 500 Pro智能边缘服务器（型号 3000）上使用。
