# aclrtGetSysParamOpt

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前进程中的运行时参数值。

如果不调用[aclrtSetSysParamOpt](aclrtSetSysParamOpt.md)接口设置运行时参数的值，直接调用本接口可获取各参数的默认值0，表示不开启确定性计算或内存访问越界检测；调用[aclrtSetSysParamOpt](aclrtSetSysParamOpt.md)接口设置运行时参数值后，若需获取参数值，需调用[aclrtGetSysParamOpt](aclrtGetSysParamOpt.md)接口。

## 函数原型

```
aclError aclrtGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| opt | 输入 | 运行时参数。 |
| value | 输出 | 运行时参数值。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

