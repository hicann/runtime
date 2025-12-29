# aclrtKernelArgsAppend

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

调用本接口将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。若参数列表中有多个参数，则需按顺序追加参数。

如果要更新参数值，可调用[aclrtKernelArgsParaUpdate](aclrtKernelArgsParaUpdate.md)接口进行更新。

## 函数原型

```
aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize, aclrtParamHandle *paramHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| argsHandle | 输入 | 参数列表句柄。 |
| param | 输入 | 待追加参数值的内存地址。<br>此处为Host内存地址。 |
| paramSize | 输入 | 内存大小，单位Byte。 |
| paramHandle | 输出 | 参数句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

