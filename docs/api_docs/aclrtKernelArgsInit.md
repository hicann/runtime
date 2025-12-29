# aclrtKernelArgsInit

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。

与[aclrtKernelArgsInitByUserMem](aclrtKernelArgsInitByUserMem.md)接口的区别在于，调用本接口表示由系统管理内存。

## 函数原型

```
aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| funcHandle | 输入 | 核函数句柄。<br>调用[aclrtBinaryGetFunctionByEntry](aclrtBinaryGetFunctionByEntry.md)或[aclrtBinaryGetFunction](aclrtBinaryGetFunction.md)获取核函数句柄，再将其作为入参传入本接口。 |
| argsHandle | 输出 | 参数列表句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

