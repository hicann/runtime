# aclFloat16ToFloat

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将[aclFloat16](aclFloat16.md)类型的数据转换为float（指float32）类型的数据。

## 函数原型

```
float aclFloat16ToFloat(aclFloat16 value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| value | 输入 | 待转换的数据。 |

## 返回值说明

转换后的数据。

