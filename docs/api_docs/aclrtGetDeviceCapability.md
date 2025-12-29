# aclrtGetDeviceCapability

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询支持的特性信息。

## 函数原型

```
aclError aclrtGetDeviceCapability(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。 |
| devFeatureType | 输入 | 特性类型。 |
| value | 输出 | 特性是否支持。<br><br>  - ACL_DEV_FEATURE_NOT_SUPPORT(0)：不支持<br>  - ACL_DEV_FEATURE_SUPPORT(1)：支持<br><br><br>相关宏定义如下：<br>#define ACL_DEV_FEATURE_SUPPORT  0x00000001<br>#define ACL_DEV_FEATURE_NOT_SUPPORT 0x00000000 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

