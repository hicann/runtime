# aclmdlRICaptureTaskUpdateEnd

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

标记待更新任务的结束。

[aclmdlRICaptureTaskUpdateBegin](aclmdlRICaptureTaskUpdateBegin.md)接口与本接口成对使用，位于这两个接口之间的任务需更新。

## 函数原型

```
aclError aclmdlRICaptureTaskUpdateEnd(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>此处的Stream需与[aclmdlRICaptureTaskUpdateBegin](aclmdlRICaptureTaskUpdateBegin.md)接口中指定的Stream保持一致。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

待更新的任务是异步接口，本接口返回成功，并不代表任务更新完成。

## 约束说明

单个Device可支持同时更新的最大任务数是1024\*1024个，超出该规格，任务会在执行阶段报错。

