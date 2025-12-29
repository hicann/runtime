# aclrtResetOverflowStatus

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

清除当前Device下所有Stream上任务的溢出状态。异步接口。

## 函数原型

```
aclError aclrtResetOverflowStatus(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream，用于下发溢出状态复位任务。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

对于以下产品型号，调用本接口清除的溢出状态是进程级别的：

-   Atlas A3 训练系列产品/Atlas A3 推理系列产品
-   Atlas A2 训练系列产品/Atlas A2 推理系列产品

