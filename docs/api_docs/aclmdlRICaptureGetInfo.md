# aclmdlRICaptureGetInfo

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取Stream的捕获信息，包括捕获状态、模型运行实例。

## 函数原型

```
aclError aclmdlRICaptureGetInfo(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。 |
| status | 输出 | Stream上任务的捕获状态。 |
| modelRI | 输出 | 模型运行实例，该模型用于暂存所捕获的任务。<br>若本接口指定的Stream不在捕获状态，则此处返回的modelRI无效。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

