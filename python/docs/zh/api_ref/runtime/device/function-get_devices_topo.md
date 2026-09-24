# 函数：get\_devices\_topo

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

>[!NOTE] 须知
>对于Atlas 200I/500 A2推理产品，本接口不支持在Ascend RC形态下调用。

## 功能说明

获取两个Device之间的网络拓扑关系。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetDevicesTopo(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.get_devices_topo(device_id, other_device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device ID。 |
| other_device_id | int，Device ID。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
| value | int，两个Device之间互联的拓扑关系。<br>0x01：ACL_RT_DEVS_TOPOLOGY_HCCS，通过HCCS连接，HCCS是Huawei Cache Coherence System（华为缓存一致性系统），用于CPU/NPU之间的高速互联<br>0x02：ACL_RT_DEVS_TOPOLOGY_PIX，通过同一个PCIe Switch连接<br>0x04：ACL_RT_DEVS_TOPOLOGY_PIB，预留值<br>0x08：ACL_RT_DEVS_TOPOLOGY_PHB，通过PCIe Host Bridge连接<br>0x10：ACL_RT_DEVS_TOPOLOGY_SYS，通过SMP（Symmetric Multiprocessing）连接，NUMA节点之间通过SMP互连<br>0x20：ACL_RT_DEVS_TOPOLOGY_SIO，片内连接方式，两个DIE之间通过该方式连接<br>0x40：ACL_RT_DEVS_TOPOLOGY_HCCS_SW，通过HCCS Switch连接 |

## 约束说明
<!-- npu="950" id10 -->
Ascend 950PR&950DT系列产品上，deviceId和otherDeviceId不能相同，否则返回报错。
<!-- end id10 -->