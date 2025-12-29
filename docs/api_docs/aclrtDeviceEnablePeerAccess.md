# aclrtDeviceEnablePeerAccess

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

开启当前Device与指定Device之间的数据交互。开启数据交互是Device级的。

可提前调用[aclrtDeviceCanAccessPeer](aclrtDeviceCanAccessPeer.md)接口查询当前Device与指定Device之间能否进行数据交互。开启Device间的数据交互功能后，若想关闭该功能，可调用[aclrtDeviceDisablePeerAccess](aclrtDeviceDisablePeerAccess.md)接口。

## 函数原型

```
aclError aclrtDeviceEnablePeerAccess(int32_t peerDeviceId, uint32_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| peerDeviceId | 输入 | Device ID，该ID不能与当前Device的ID相同。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| flags | 输入 | 保留参数，当前必须设置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

