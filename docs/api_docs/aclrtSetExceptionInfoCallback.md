# aclrtSetExceptionInfoCallback

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置异常回调函数。

## 函数原型

```
aclError aclrtSetExceptionInfoCallback(aclrtExceptionInfoCallback callback)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| callback | 输入 | 指定要注册的回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtExceptionInfoCallback)(aclrtExceptionInfo *exceptionInfo); |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   回调函数涉及共享资源（例如锁），因此在使用回调函数需慎重，在回调函数内调用资源申请&释放、Stream同步、Device同步、任务下发、任务终止等接口，可能会导致错误或死锁。
-   您需要在执行异步任务之前，设置异常回调函数，当Device上的任务执行异常时，系统会向用户设置的异常回调函数中传入一个包含任务ID、Stream ID、线程ID、Device ID以及错误码的aclrtExceptionInfo结构体指针，并执行回调函数，用户可以再分别调用[aclrtGetTaskIdFromExceptionInfo](aclrtGetTaskIdFromExceptionInfo.md)、[aclrtGetStreamIdFromExceptionInfo](aclrtGetStreamIdFromExceptionInfo.md)、[aclrtGetThreadIdFromExceptionInfo](aclrtGetThreadIdFromExceptionInfo.md)、[aclrtGetDeviceIdFromExceptionInfo](aclrtGetDeviceIdFromExceptionInfo.md)、[aclrtGetErrorCodeFromExceptionInfo](aclrtGetErrorCodeFromExceptionInfo.md)接口获取产生异常的任务ID、Stream ID、线程ID、Device ID以及错误码，便于定位问题。

    **使用场景举例**：例如，在调用aclopExecuteV2接口前，调用aclrtSetExceptionInfoCallback接口设置异常回调函数，当算子在Device执行异常时，系统会向用户设置的异常回调函数中传入一个包含任务ID、Stream ID、线程ID、Device ID以及错误码的aclrtExceptionInfo结构体指针，并执行回调函数。

-   如果多次设置异常回调函数，以最后一次设置为准。
-   如果想清空回调函数，可调用aclrtSetExceptionInfoCallback接口，将入参设置为空指针。

