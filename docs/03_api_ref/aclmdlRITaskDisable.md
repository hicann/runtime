# aclmdlRITaskDisable

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将指定任务设置为disable状态，标识该任务不再参与调度。

在调用本接口之前，先调用[aclmdlRIGetTasksByStream](aclmdlRIGetTasksByStream.md)接口获取指定Stream中的所有任务。调用本接口后，需调用[aclmdlRIUpdate](aclmdlRIUpdate.md)接口更新模型。

## 函数原型

```
aclError aclmdlRITaskDisable(aclmdlRITask task)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| task | 输入 | 指定任务，类型定义请参见[aclmdlRITask](aclmdlRITask.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。