# aclrtDeviceCanAccessPeer

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询Device之间是否支持数据交互。

## 函数原型

```
aclError aclrtDeviceCanAccessPeer(int32_t *canAccessPeer, int32_t deviceId, int32_t peerDeviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| canAccessPeer | 输出 | 是否支持数据交互，1表示支持，0表示不支持。 |
| deviceId | 输入 | 指定Device的ID，不能与peerDeviceId参数值相同。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| peerDeviceId | 输入 | 指定Device的ID，不能与deviceId参数值相同。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   仅支持物理机和容器场景；
-   仅支持同一个PCIe Switch内Device之间的数据交互。AI Server场景下，虽然是跨PCIe Switch，但也支持Device之间的数据交互。
-   仅支持同一个物理机或容器内的Device之间的数据交互操作；
-   仅支持同一个进程内、线程间的Device之间的数据交互，不支持不同进程间Device之间的数据交互。

