# aclrtEventGetTimestamp

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取Event的执行结束时间点（表示从昇腾AI处理器系统启动以来的时间）。

本接口需与其它关键接口配合使用，接口调用顺序：调用[aclrtCreateEvent](aclrtCreateEvent.md)/[aclrtCreateEventWithFlag](aclrtCreateEventWithFlag.md)接口创建Event**--\>**调用[aclrtRecordEvent](aclrtRecordEvent.md)接口在Stream中记录Event**\>**调用[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口阻塞应用程序运行，直到指定Stream中的所有任务都完成**--\>**调用aclrtEventGetTimestamp接口获取Event的执行时间。

## 函数原型

```
aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 查询的Event。 |
| timestamp | 输出 | Event执行结束的时间点，单位为微秒。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

