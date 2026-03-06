# aclrtStreamGetTasks

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取指定Stream中的所有任务。

调用本接口之前，先调用[aclmdlRIGetStreams](aclmdlRIGetStreams.md)接口获取模型运行实例关联的所有Stream，再根据指定Stream获取其中的所有任务。

通过两次调用本接口可以获取指定Stream中的所有任务：

1.  第一次调用aclrtStreamGetTasks接口：tasks参数处传入空指针，numTasks传入任意非负整数，调用aclrtStreamGetTasks接口获取指定Stream中所有任务数量numTasks。
2.  第二次调用aclrtStreamGetTasks接口：为tasks申请数组空间，大小为前一步中获取的numTasks，再将tasks、numTasks作为输入传入aclrtStreamGetTasks接口，获取指定Stream中的所有任务。

## 函数原型

```
aclError aclrtStreamGetTasks(aclrtStream stream, aclrtTask *tasks, uint32_t *numTasks)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>需传入与模型运行实例有关联的Stream。 |
| tasks | 输入&输出 | 若tasks传入空指针，表示获取指定Stream中所有的任务数量，该数量通过numTasks参数返回。<br>若tasks是一个数组，其大小为numTasks，则表示用于指定Stream中的所有任务。 |
| numTasks | 输入&输出 | 作为输入时，表示numTasks数组大小。<br>作为输出时，表示指定Stream中的所有任务数量。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

