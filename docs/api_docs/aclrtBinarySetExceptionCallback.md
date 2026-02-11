# aclrtBinarySetExceptionCallback

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

调用本接口注册回调函数。若多次设置回调函数，以最后一次设置为准。

在执行算子之前，调用本接口注册回调函数。如果算子执行过程中出现异常，将触发回调函数的执行，并将异常信息存储在aclrtExceptionInfo结构体中。之后，可以通过调用[aclrtGetArgsFromExceptionInfo](aclrtGetArgsFromExceptionInfo.md)和[aclrtGetFuncHandleFromExceptionInfo](aclrtGetFuncHandleFromExceptionInfo.md)接口，从异常信息中获取用户下发算子执行任务时的参数以及核函数句柄。目前，仅支持获取AI Core算子执行异常时的信息。

## 函数原型

```
aclError aclrtBinarySetExceptionCallback(const aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void *userData)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binHandle | 输入 | 算子二进制句柄。<br>调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口或[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| callback | 输入 | 指定要注册的回调函数。<br>回调函数的函数原型为：<br/>typedef void (*aclrtOpExceptionCallback)(aclrtExceptionInfo *exceptionInfo, void *userData); |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

