# aclrtKernelArgsParaUpdate

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

通过aclrtKernelArgsAppend接口追加的参数，可调用本接口更新参数值。

## 函数原型

```
aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param, size_t paramSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| argsHandle | 输入 | 参数列表句柄。 |
| paramHandle | 输入 | 参数句柄。 |
| param | 输入 | 待更新参数值的内存地址。<br>此处为Host内存地址。 |
| paramSize | 输入 | 内存大小，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

