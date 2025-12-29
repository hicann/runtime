# aclrtUnSubscribeHostFunc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

与[aclrtSubscribeHostFunc](aclrtSubscribeHostFunc.md)接口配合使用，调用模型执行接口后，调用本接口取消线程注册，Stream上的回调函数不再由指定线程处理。

## 函数原型

```
aclError aclrtUnSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| hostFuncThreadId | 输入 | 指定线程的ID。 |
| exeStream | 输入 | 指定Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

