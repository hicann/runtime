# aclmdlRICaptureTaskGrpBegin

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

标记任务组的开始。

本接口与[aclmdlRICaptureTaskGrpEnd](aclmdlRICaptureTaskGrpEnd.md)接口成对使用，位于这两个接口之间的任务构成一组任务，当前仅支持在这两个接口之间下发单算子调用的任务。

若下发任务时返回ACL\_ERROR\_RT\_TASK\_TYPE\_NOT\_SUPPORT，则表示不支持该单算子任务，可通过应用类日志查看详细的报错信息。日志文件的详细说明，请参见《日志参考》。

## 函数原型

```
aclError aclmdlRICaptureTaskGrpBegin(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>此处的Stream必须是在捕获状态的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

