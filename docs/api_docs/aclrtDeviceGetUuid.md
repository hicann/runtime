# aclrtDeviceGetUuid

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取Device的唯一标识UUID（Universally Unique Identifier）。

## 函数原型

```
aclError aclrtDeviceGetUuid (int32_t deviceId, aclrtUuid *uuid)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID，与[aclrtSetDevice](aclrtSetDevice.md)接口中的Device ID保持一致。 |
| uuid | 输出 | Device的唯一标识。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

