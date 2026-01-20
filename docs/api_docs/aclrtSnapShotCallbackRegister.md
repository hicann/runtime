# aclrtSnapShotCallbackRegister

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

注册一个回调函数，该回调函数将在快照操作的不同阶段被调用。不支持重复注册。

## 函数原型

```
aclError aclrtSnapShotCallbackRegister(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void *args)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stage | 输入 | 指定触发回调的快照阶段。 |
| callback | 输入 | 指向回调函数的指针。当指定的快照阶段到达时，系统将自动调用此函数。<br>函数定义如下：<br>typedef uint32_t (\*aclrtSnapShotCallBack)(int32_t deviceId, void* args); |
| args | 输入 | 用户自定义参数指针，在回调函数调用时传递，可以为NULL，表示不需要传递额外参数。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

