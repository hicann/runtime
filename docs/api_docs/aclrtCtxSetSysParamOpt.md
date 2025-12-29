# aclrtCtxSetSysParamOpt

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置当前Context中的系统参数值，多次调用本接口，以最后一次设置的值为准。调用本接口设置运行时参数值后，若需获取参数值，需调用[aclrtCtxGetSysParamOpt](aclrtCtxGetSysParamOpt.md)接口。

本接口与[aclrtSetSysParamOpt](aclrtSetSysParamOpt.md)接口的差别是，本接口作用域是Context，aclrtSetSysParamOpt的作用域是进程。

## 函数原型

```
aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| opt | 输入 | 系统参数。 |
| value | 输入 | 系统参数值。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

