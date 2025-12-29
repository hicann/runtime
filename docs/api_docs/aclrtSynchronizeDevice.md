# aclrtSynchronizeDevice

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

阻塞应用程序运行，直到正在运算中的Device完成运算。

多Device场景下，调用该接口等待的是当前Context对应的Device。

## 函数原型

```
aclError aclrtSynchronizeDevice(void)
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

