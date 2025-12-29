# aclrtBinaryGetFunction

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据核函数名称，查找到对应的核函数，并使用funcHandle表达。

## 函数原型

```
aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binHandle | 输入 | 算子二进制句柄。<br>调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口或[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| kernelName | 输入 | 核函数名称。 |
| funcHandle | 输出 | 核函数句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

