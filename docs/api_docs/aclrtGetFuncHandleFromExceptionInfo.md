# aclrtGetFuncHandleFromExceptionInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

从aclrtExceptionInfo异常信息中获取核函数句柄。此接口与[aclrtBinarySetExceptionCallback](aclrtBinarySetExceptionCallback.md)接口配合使用。

## 函数原型

```
aclError aclrtGetFuncHandleFromExceptionInfo(const aclrtExceptionInfo *info, aclrtFuncHandle *func)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| info | 输入 | 异常信息的指针。 |
| func | 输出 | 核函数句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

