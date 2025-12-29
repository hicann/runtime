# aclrtGetThreadLastTaskId

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前线程的最后一个下发的Task ID。

## 函数原型

```
aclError aclrtGetThreadLastTaskId(uint32_t *taskId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| taskId | 输出 | 当前线程的最后一个下发的Task ID。<br>此处的Task表示由用户显式创建的Stream上下发的Task。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

