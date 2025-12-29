# aclrtKernelArgsAppendPlaceHolder

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

对于placeholder参数，调用本接口先占位，返回的是paramHandle占位符。

若参数列表中有多个参数，则需按顺序追加参数。等所有参数都追加之后，可调用[aclrtKernelArgsGetPlaceHolderBuffer](aclrtKernelArgsGetPlaceHolderBuffer.md)接口获取paramHandle占位符指向的内存地址。

## 函数原型

```
aclError aclrtKernelArgsAppendPlaceHolder(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| argsHandle | 输入 | 参数列表句柄。 |
| paramHandle | 输出 | 参数句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

