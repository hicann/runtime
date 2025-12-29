# aclmdlRIBuildBegin

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

开始构建一个模型运行实例。

在[aclmdlRIBuildBegin](aclmdlRIBuildBegin.md)接口之后，先调用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口将模型运行实例与Stream绑定，接着在指定的Stream上下发任务，所有任务下发完成后，调用[aclmdlRIEndTask](aclmdlRIEndTask.md)接口在Stream上标记任务下发结束，随后调用[aclmdlRIBuildEnd](aclmdlRIBuildEnd.md)接口结束模型构建。此时，所有在指定Stream上下发的任务不会立即执行，只有在调用[aclmdlRIExecute](aclmdlRIExecute.md)或[aclmdlRIExecuteAsync](aclmdlRIExecuteAsync.md)接口执行模型推理时，这些任务才会被真正执行。

所有任务执行完毕后，如果不再使用模型运行实例，可调用[aclmdlRIUnbindStream](aclmdlRIUnbindStream.md)接口解除模型运行实例与Stream的绑定关系。可调用[aclmdlRIDestroy](aclmdlRIDestroy.md)接口及时销毁该资源。

## 函数原型

```
aclError aclmdlRIBuildBegin(aclmdlRI *modelRI, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例，该模型用于暂存所编译的任务。 |
| flag | 输入 | 预留参数。当前固定配置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

