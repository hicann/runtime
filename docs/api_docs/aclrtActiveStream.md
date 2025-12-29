# aclrtActiveStream

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

激活Stream。异步接口。

被激活的Stream上的任务与当前Stream上的任务并行执行。

## 函数原型

```
aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| activeStream | 输入 | 待激活的Stream。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口。 |
| stream | 输入 | 执行激活任务的Stream。<br>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

