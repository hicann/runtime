# aclmdlRITaskSetParams

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置指定任务的参数信息。

在调用本接口之前，请先调用[aclmdlRIGetTasksByStream](aclmdlRIGetTasksByStream.md)接口获取指定Stream中的所有任务，然后使用[aclmdlRITaskGetParams](aclmdlRITaskGetParams.md)接口获取指定任务的参数信息。如果需要更新参数信息，再调用aclmdlRITaskSetParams接口。

## 函数原型

```
aclError aclmdlRITaskSetParams(aclmdlRITask task, aclmdlRITaskParams* params)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| task | 输入 | 指定任务，类型定义请参见[aclmdlRITask](aclmdlRITask.md)。 |
| params | 输入 | 更新的参数信息，类型定义请参见[aclmdlRITaskParams](aclmdlRITaskParams.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。