# aclmdlRICaptureEnd

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

结束Stream的捕获动作，并获取模型运行实例，该模型用于暂存所捕获的任务。

本接口需与其它接口配合使用，以便捕获Stream上下发的任务，暂存在内部创建的模型中，用于后续的任务执行，以此减少Host侧的任务下发开销，配合使用流程请参见[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)接口处的说明。

在[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)接口中，如果将mode设置为非ACL\_MODEL\_RI\_CAPTURE\_MODE\_RELAXED的值，则本接口和[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)接口必须位于同一线程中。

## 函数原型

```
aclError aclmdlRICaptureEnd(aclrtStream stream, aclmdlRI *modelRI)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。 |
| modelRI | 输出 | 模型运行实例，该模型用于暂存所捕获的任务。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

