# aclrtEventElapsedTime

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

统计两个Event之间的耗时。

本接口需与其它关键接口配合使用，接口调用顺序：调用[aclrtCreateEvent](aclrtCreateEvent.md)/[aclrtCreateEventWithFlag](aclrtCreateEventWithFlag.md)接口创建Event**--\>**调用[aclrtRecordEvent](aclrtRecordEvent.md)接口在同一个Stream中记录起始Event、结尾Event**--\>**调用[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口阻塞应用程序运行，直到指定Stream中的所有任务都完成**--\>**调用aclrtEventElapsedTime接口统计两个Event之间的耗时

## 函数原型

```
aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ms | 输出 | 表示两个Event之间耗时的指针，单位为毫秒。 |
| startEvent | 输入 | 起始Event。 |
| endEvent | 输入 | 结尾Event。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

