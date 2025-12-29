# aclrtQueryEvent（废弃）

**须知：此接口后续版本会废弃，请使用[aclrtQueryEventStatus](aclrtQueryEventStatus.md)接口。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询与本接口在同一线程中的[aclrtRecordEvent](aclrtRecordEvent.md)接口所记录的Event是否执行完成。

## 函数原型

```
aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 指定待查询的Event。 |
| status | 输出 | Event状态的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

