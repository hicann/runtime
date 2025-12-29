# aclmdlRIDebugPrint

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

维测场景下使用本接口打印内部模型信息，包括Device ID、Stream ID、Task ID等信息。

## 函数原型

```
aclError aclmdlRIDebugPrint(aclmdlRI modelRI)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例，该模型用于暂存所捕获的任务。<br>仅支持在[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之后打印模型信息，将[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口输出的模型运行实例作为入参传入本接口，但需确保modelRI是有效的。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

