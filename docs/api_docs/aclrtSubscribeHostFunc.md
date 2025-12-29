# aclrtSubscribeHostFunc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

调用本接口注册处理Stream上回调函数的线程（线程需由用户自行创建）。

## 函数原型

```
aclError aclrtSubscribeHostFunc(uint64_t hostFuncThreadId, aclrtStream exeStream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| hostFuncThreadId | 输入 | 指定线程的ID。 |
| exeStream | 输入 | 指定Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   支持多次调用aclrtSubscribeHostFunc接口给多个Stream（仅支持同一Device内的多个Stream）注册同一个处理回调函数的线程。
-   为确保Stream内的任务按调用顺序执行，不支持调用aclrtSubscribeHostFunc接口给同一个Stream注册多个处理回调函数的线程。

