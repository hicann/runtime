# aclrtKernelArgsGetPlaceHolderBuffer

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据用户指定的内存大小，获取paramHandle占位符指向的内存地址。

## 函数原型

```
aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| argsHandle | 输入 | 参数列表句柄。 |
| paramHandle | 输入 | 参数句柄。<br>此处的paramHandle需与[aclrtKernelArgsAppendPlaceHolder](aclrtKernelArgsAppendPlaceHolder.md)接口中的paramHandle保持一致。 |
| dataSize | 输入 | 内存大小。 |
| bufferAddr | 输出 | paramHandle占位符指向的内存地址。<br>后续由用户管理该内存中的数据，但无需管理该内存的生命周期。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

