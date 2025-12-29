# aclmdlRICaptureTaskUpdateBegin

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

标记待更新任务的开始。

本接口与[aclmdlRICaptureTaskUpdateEnd](aclmdlRICaptureTaskUpdateEnd.md)接口成对使用，位于这两个接口之间的任务需更新。

aclmdlRICaptureTaskUpdateBegin、[aclmdlRICaptureTaskUpdateEnd](aclmdlRICaptureTaskUpdateEnd.md)接口之间的任务数量、任务类型必须与[aclmdlRICaptureTaskGrpBegin](aclmdlRICaptureTaskGrpBegin.md)、[aclmdlRICaptureTaskGrpEnd](aclmdlRICaptureTaskGrpEnd.md)接口之间任务数量、任务类型保持一致。

若任务更新时返回ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT，则表示底层驱动不支持该特性，需要将驱动包升级到25.0.RC1或更高版本。您可以单击[Link](https://www.hiascend.com/hardware/firmware-drivers/commercial)，在“固件与驱动”页面下载Ascend HDK  25.0.RC1或更高版本的驱动安装包，并参考相应版本的文档进行安装、升级。

## 函数原型

```
aclError aclmdlRICaptureTaskUpdateBegin(aclrtStream stream, aclrtTaskGrp handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>此处的Stream必须是不在捕获状态的Stream。 |
| handle | 输入 | 标识任务组的句柄。<br>提前调用[aclmdlRICaptureTaskGrpBegin](aclmdlRICaptureTaskGrpBegin.md)、[aclmdlRICaptureTaskGrpEnd](aclmdlRICaptureTaskGrpEnd.md)接口标记任务组之后，通过aclmdlRICaptureTaskGrpEnd接口获取任务组句柄，再作为入参传入此处。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

单个Device可支持同时更新的最大任务数是1024\*1024个，超出该规格，任务会在执行阶段报错。

