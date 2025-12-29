# aclrtUpdateTaskAsync

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

刷新目标任务的信息。异步接口。

## 函数原型

```
aclError aclrtTaskUpdateAsync(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| taskStream | 输入 | 目标任务所在的Stream。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口。 |
| taskId | 输入 | 目标任务ID。<br>可调用[aclrtGetThreadLastTaskId](aclrtGetThreadLastTaskId.md)接口获取任务ID。 |
| info | 输入 | 配置信息。 |
| execStream | 输入 | 执行刷新任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

