# aclmdlRIExecuteAsync

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

执行模型推理。异步接口。

## 函数原型

```
aclError aclmdlRIExecuteAsync(aclmdlRI modelRI, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例。<br>modelRI支持通过以下方式获取：<br><br>  - 调用[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)接口捕获Stream上下发的任务后，可通过[aclmdlRICaptureGetInfo](aclmdlRICaptureGetInfo.md)接口获取模型运行实例，再传入本接口。<br>  - 调用[aclmdlRIBuildBegin](aclmdlRIBuildBegin.md)、[aclmdlRIBuildEnd](aclmdlRIBuildEnd.md)等接口构建模型运行实例，再传入本接口。 |
| stream | 输入 | 指定Stream，用于执行模型推理任务。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

