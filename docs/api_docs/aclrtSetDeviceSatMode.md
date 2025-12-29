# aclrtSetDeviceSatMode

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置当前Device的浮点计算结果输出模式。

调用该接口成功后，后续在该Device上新创建的Stream按设置的模式生效，对之前已创建的Stream不生效。

## 函数原型

```
aclError aclrtSetDeviceSatMode(aclrtFloatOverflowMode mode)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| mode | 输入 | 设置浮点计算结果输出模式。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

