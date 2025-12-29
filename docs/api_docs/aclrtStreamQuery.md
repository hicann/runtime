# aclrtStreamQuery

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询指定Stream上的所有任务的执行状态。

## 函数原型

```
aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | Stream的指针。 |
| status | 输出 | Stream上的任务状态。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

