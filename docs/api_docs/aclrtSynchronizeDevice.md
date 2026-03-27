# aclrtSynchronizeDevice

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

阻塞当前线程，直到与当前线程绑定的Context所对应的Device完成运算。

## 函数原型

```
aclError aclrtSynchronizeDevice(void)
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

