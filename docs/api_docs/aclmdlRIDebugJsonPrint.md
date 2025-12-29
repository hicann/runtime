# aclmdlRIDebugJsonPrint

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

维测场景下，使用本接口将模型运行实例信息以JSON格式导出到文件中，包括Model ID、Stream ID、Task ID、Task Type等信息。然后，通过traceing方式（例如chrome://tracing/）查看模型的可视化信息。

## 函数原型

```
aclError aclmdlRIDebugJsonPrint(aclmdlRI modelRI, const char *path, uint32_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例，该模型用于暂存所捕获的任务。<br>需确保modelRI是有效的。 |
| path | 输入 | 需要导出的文件路径，包含文件名。<br>该文件路径需存在，且有可读可写权限，否则本接口返回失败。 |
| flags | 输入 | 预留，当前固定配置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

