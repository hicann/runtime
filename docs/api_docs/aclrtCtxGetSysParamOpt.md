# aclrtCtxGetSysParamOpt

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前Context中的系统参数值。

系统参数无默认值，如果不调用[aclrtCtxSetSysParamOpt](aclrtCtxSetSysParamOpt.md)接口设置系统参数的值，直接调用本接口获取系统参数的值，接口会返回失败。

## 函数原型

```
aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| opt | 输入 | 系统参数。 |
| value | 输出 | 存放系统参数值的内存的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

