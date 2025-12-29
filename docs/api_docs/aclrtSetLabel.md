# aclrtSetLabel

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Stream上设置标签。

## 函数原型

```
aclError aclrtSetLabel(aclrtLabel label, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| label | 输入 | 标签。<br>通过aclrtCreateLabel接口创建的标签作为此处的输入。 |
| stream | 输入 | 需设置标签的Stream，此处只支持通过[aclmdlRIBindStream](aclmdlRIBindStream.md)接口绑定过模型运行实例的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

