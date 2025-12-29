# aclrtGetDevice

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
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

如果没有提前指定Device，则调用aclrtGetDevice接口时，返回错误。指定Device的方式包括：在[aclInit](aclInit.md)接口中开启默认Device、调用[aclrtSetDevice](aclrtSetDevice.md)接口显式指定Device、调用[aclrtCreateContext](aclrtCreateContext.md)接口隐式指定Device。

