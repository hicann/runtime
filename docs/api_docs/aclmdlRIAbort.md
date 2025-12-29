# aclmdlRIAbort

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

停止正在执行的模型运行实例。

如需重新执行模型运行实例，需重新调用[aclmdlRIExecute](aclmdlRIExecute.md)或[aclmdlRIExecuteAsync](aclmdlRIExecuteAsync.md)接口。

## 函数原型

```
aclError aclmdlRIAbort(aclmdlRI modelRI)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

