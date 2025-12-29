# aclrtCntNotifyCreate

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

创建CntNotify。

## 函数原型

```
aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| cntNotify | 输入 | CntNotify的指针。 |
| flag | 输入 | 预留参数，当前固定配置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

