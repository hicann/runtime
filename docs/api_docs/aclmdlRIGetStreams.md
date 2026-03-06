# aclmdlRIGetStreams

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取模型运行实例关联的Stream。

通过两次调用本接口可以获取模型运行实例关联的所有Stream：

1.  第一次调用aclmdlRIGetStreams接口：streams参数处传入空指针，numStreams传入任意非负整数，调用aclmdlRIGetStreams接口获取模型运行实例关联的Stream的数量numStreams。
2.  第二次调用aclmdlRIGetStreams接口：为streams申请数组空间，大小为前一步中获取的numStreams，再将streams、numStreams作为输入传入aclmdlRIGetStreams接口，获取模型运行实例关联的所有Stream。

## 函数原型

```
aclError aclmdlRIGetStreams(aclmdlRI modelRI, aclrtStream *streams, uint32_t *numStreams)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例。 |
| streams | 输入&输出 | 若streams传入空指针，表示获取模型运行实例关联的Stream数量，该数量通过numStreams参数返回。<br>若streams是一个数组，其大小为numStreams，则表示用于存放模型运行实例关联的所有Stream。 |
| numStreams | 输入&输出 | 作为输入时，表示streams数组大小。<br>作为输出时，表示模型运行实例关联的Stream的数量。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

