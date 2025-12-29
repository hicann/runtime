# aclGetCannAttribute

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询运行环境是否支持指定的CANN特性。

## 函数原型

```
aclError aclGetCannAttribute(aclCannAttr cannAttr, int32_t *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| cannAttr | 输入 | 特性列表枚举值，一次查询可指定其中一项。 |
| value | 输出 | 是否支持：<br><br>  - 1：支持<br>  - 0：不支持 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

