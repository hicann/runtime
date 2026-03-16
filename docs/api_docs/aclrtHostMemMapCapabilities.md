# aclrtHostMemMapCapabilities

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询指定的硬件驱动加速器是否支持访问通过[aclrtHostRegister](aclrtHostRegister.md)接口注册的内存。

## 函数原型

```
aclError aclrtHostMemMapCapabilities(uint32_t deviceId, aclrtHacType hacType, aclrtHostMemMapCapability *capabilities)
```

## 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| hacType | 输入 | 硬件驱动加速器类型。 |
| capabilities | 输出 | 是否支持访问通过[aclrtHostRegister](aclrtHostRegister.md)接口注册的内存。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。
