# aclmdlRIEndTask

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Stream上标记下发任务结束。

## 函数原型

```
aclError aclmdlRIEndTask(aclmdlRI modelRI, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例。<br>此处的modelRI需与[aclmdlRIBuildBegin](aclmdlRIBuildBegin.md)接口中的modelRI保持一致。 |
| stream | 输入 | 指定Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

