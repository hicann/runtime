# aclrtDeviceDisablePeerAccess

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

关闭当前Device与指定Device之间的数据交互功能。关闭数据交互功能是Device级的。

调用[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口开启当前Device与指定Device之间的数据交互后，可调用aclrtDeviceDisablePeerAccess接口关闭数据交互功能。

## 函数原型

```
aclError aclrtDeviceDisablePeerAccess(int32_t peerDeviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| peerDeviceId | 输入 | Device ID，该ID不能与当前Device的ID相同。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

