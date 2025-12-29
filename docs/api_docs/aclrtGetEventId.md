# aclrtGetEventId

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取指定Event的ID。

## 函数原型

```
aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 指定要查询的Event。 |
| eventId | 输出 | Event ID。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

