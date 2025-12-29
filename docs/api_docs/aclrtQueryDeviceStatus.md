# aclrtQueryDeviceStatus

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询Device状态是正常可用、还是异常不可用。

## 函数原型

```
aclError aclrtQueryDeviceStatus(int32_t deviceId, aclrtDeviceStatus *deviceStatus)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| deviceStatus | 输出 | Device状态。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

