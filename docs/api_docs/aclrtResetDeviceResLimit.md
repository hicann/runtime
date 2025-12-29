# aclrtResetDeviceResLimit

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

调用[aclrtSetDeviceResLimit](aclrtSetDeviceResLimit.md)接口设置Device资源限制后，可调用本接口重置当前进程的Device资源限制，恢复默认配置，此时可通过[aclrtGetDeviceResLimit](aclrtGetDeviceResLimit.md)接口查询默认的资源限制。

## 函数原型

```
aclError aclrtResetDeviceResLimit(int32_t deviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

