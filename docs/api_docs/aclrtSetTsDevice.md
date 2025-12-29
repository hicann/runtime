# aclrtSetTsDevice

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置本次计算需要使用的Task Schedule。

## 函数原型

```
aclError aclrtSetTsDevice(aclrtTsId tsId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| tsId | 输入 | 指定本次计算需要使用的Task Schedule。如果昇腾AI处理器中只有AI CORE Task Schedule，没有VECTOR Core Task Schedule，则设置该参数无效，默认使用AI CORE Task Schedule。<br>typedef enum aclrtTsId {<br>   ACL_TS_ID_AICORE  = 0, //使用AI CORE Task Schedule<br>   ACL_TS_ID_AIVECTOR = 1, //使用VECTOR Core Task Schedule<br>   ACL_TS_ID_RESERVED = 2,<br>} aclrtTsId; |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

