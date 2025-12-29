# aclmdlRICaptureTaskGrpEnd

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

标记任务组的结束。

[aclmdlRICaptureTaskGrpBegin](aclmdlRICaptureTaskGrpBegin.md)接口与本接口成对使用，位于这两个接口之间的任务构成一组任务，当前仅支持在这两个接口之间下发单算子调用的任务。

## 函数原型

```
aclError aclmdlRICaptureTaskGrpEnd(aclrtStream stream, aclrtTaskGrp *handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>此处的Stream需与[aclmdlRICaptureTaskGrpBegin](aclmdlRICaptureTaskGrpBegin.md)接口中指定的Stream保持一致。 |
| handle | 输出 | 标识任务组的句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

