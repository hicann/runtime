# aclmdlRIUpdate

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

更新指定的模型。

## 函数原型

```
aclError aclmdlRIUpdate(aclmdlRI modelRI)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 指定更新的模型，类型定义请参见[aclmdlRI](aclmdlRI.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

由于profiling不支持在模型执行过程中动态更新上报的算子参数，因此若需分析profiling数据，必须在模型首次执行前完成所有参数的更新。