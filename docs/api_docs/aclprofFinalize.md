# aclprofFinalize

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

结束Profiling。

## 函数原型

```
aclError aclprofFinalize()
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

与[aclprofInit](aclprofInit.md)接口配对使用，先调用aclprofInit接口再调用aclprofFinalize接口。

