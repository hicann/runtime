# aclmdlRITaskGetType

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取任务类型。

调用本接口之前，先调用[aclmdlRIGetTasksByStream](aclmdlRIGetTasksByStream.md)接口获取指定Stream中的所有任务，再根据指定任务获取其类型。

## 函数原型

```
aclError aclmdlRITaskGetType(aclmdlRITask task, aclmdlRITaskType *type)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| task | 输入 | 指定任务。 |
| type | 输出 | 任务类型。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

