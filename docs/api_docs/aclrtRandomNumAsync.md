# aclrtRandomNumAsync

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

下发并执行随机数生成任务。异步接口。

## 函数原型

```
aclError aclrtRandomNumAsync(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| taskInfo | 输入 | 随机数生成任务信息 |
| stream | 输入 | 执行随机数生成任务的Stream。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

