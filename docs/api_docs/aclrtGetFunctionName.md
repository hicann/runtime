# aclrtGetFunctionName

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据核函数句柄获取核函数名称。

## 函数原型

```
aclError aclrtGetFunctionName(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| funcHandle | 输入 | 核函数句柄。 |
| maxLen | 输入 | 用户申请用于存储核函数名称的最大内存大小，单位Byte。 |
| name | 输出 | 核函数名称。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

