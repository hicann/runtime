# aclrtKernelArgsFinalize

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在所有参数追加完成后，调用本接口以标识参数组装完毕。

## 函数原型

```
aclError aclrtKernelArgsFinalize(aclrtArgsHandle argsHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| argsHandle | 输入 | 参数列表句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

