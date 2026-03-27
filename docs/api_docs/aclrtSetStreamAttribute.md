# aclrtSetStreamAttribute

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置Stream属性值。

## 函数原型

```
aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。类型定义请参见[aclrtStream](aclrtStream.md)。<br>各产品型号对默认Stream（即该参数传入NULL）的支持情况不同，如下：<br>Ascend 950PR/Ascend950DT，不支持<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持 |
| stmAttrType | 输入 | 属性类型。类型定义请参见[aclrtStreamAttr](aclrtStreamAttr.md)。 |
| value | 输入 | 属性值。类型定义请参见[aclrtStreamAttrValue](aclrtStreamAttrValue.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   溢出检测属性：调用该接口打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。
-   Failure Mode：不支持对Context默认Stream设置Failure Mode。

