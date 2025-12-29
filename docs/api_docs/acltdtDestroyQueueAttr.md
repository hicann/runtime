# acltdtDestroyQueueAttr

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁通过acltdtCreateQueueAttr接口创建的acltdtQueueAttr类型的数据。

## 函数原型

```
aclError acltdtDestroyQueueAttr(const acltdtQueueAttr *attr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| attr | 输入 | 待销毁的acltdtQueueAttr类型的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

