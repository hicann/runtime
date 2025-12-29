# aclrtDestroyLabelList

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁标签列表。

## 函数原型

```
aclError aclrtDestroyLabelList(aclrtLabelList labelList)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| labelList | 输入 | 通过接口创建的标签列表。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

