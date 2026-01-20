# aclrtSnapShotCallbackUnregister

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

取消注册回调函数。取消注册之后，对应快照阶段将不再调用该回调函数。

## 函数原型

```
aclError aclrtSnapShotCallbackUnregister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stage | 输入 | 指定触发回调的快照阶段。 |
| callback | 输入 | 待取消注册的回调函数指针。<br>函数定义如下：<br>typedef uint32_t (\*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

