# aclrtGetDevice

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前正在使用的Device的ID。

## 函数原型

```
aclError aclrtGetDevice(int32_t *deviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输出 | Device ID的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

如果没有提前指定计算设备（例如调用[aclrtSetDevice](aclrtSetDevice.md)接口），则调用aclrtGetDevice接口时，返回错误。

