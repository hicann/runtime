# aclrtGetDevicesTopo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取两个Device之间的网络拓扑关系。

## 函数原型

```
aclError aclrtGetDevicesTopo(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | 指定Device的ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| otherDeviceId | 输入 | 指定Device的ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| value | 输出 | 两个Device之间互联的拓扑关系。取值如下：<br><br>  - ACL_RT_DEVS_TOPOLOGY_HCCS：通过HCCS连接HCCS是Huawei Cache Coherence System（华为缓存一致性系统），用于CPU/NPU之间的高速互联。<br>  - ACL_RT_DEVS_TOPOLOGY_PIX：通过同一个PCIe Switch连接。<br>  - ACL_RT_DEVS_TOPOLOGY_PHB：通过PCIe Host Bridge连接。<br>  - ACL_RT_DEVS_TOPOLOGY_SYS：通过SMP（Symmetric Multiprocessing）连接，NUMA节点之间通过SMP互连。<br>  - ACL_RT_DEVS_TOPOLOGY_SIO：片内连接方式，两个DIE之间通过该方式连接。<br>  - ACL_RT_DEVS_TOPOLOGY_HCCS_SW：通过HCCS Switch连接。<br>  - ACL_RT_DEVS_TOPOLOGY_PIB：预留值，暂不支持。<br><br><br>宏的定义如下：<br>#define ACL_RT_DEVS_TOPOLOGY_HCCS  0x01ULL<br>#define ACL_RT_DEVS_TOPOLOGY_PIX  0x02ULL<br>#define ACL_RT_DEVS_TOPOLOGY_PHB  0x08ULL<br>#define ACL_RT_DEVS_TOPOLOGY_SYS  0x10ULL<br>#define ACL_RT_DEVS_TOPOLOGY_SIO  0x20ULL<br>#define ACL_RT_DEVS_TOPOLOGY_HCCS_SW  0x40ULL<br>#define ACL_RT_DEVS_TOPOLOGY_PIB  0x04ULL<br> |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

