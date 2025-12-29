# aclrtDeviceGetStreamPriorityRange

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询硬件支持的Stream最低、最高优先级。

## 函数原型

```
aclError aclrtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| leastPriority | 输出 | 最低优先级。 |
| greatestPriority | 输出 | 最高优先级。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

