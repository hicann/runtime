# aclrtQueryEventStatus

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询该Event捕获的所有任务的执行状态。具体见[aclrtRecordEvent](aclrtRecordEvent.md)接口参考Event捕获的细节。

## 函数原型

```
aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 指定待查询的Event。 |
| status | 输出 | Event状态的指针。<br>如果该Event捕获的所有任务都已经执行完成则返回ACL_EVENT_RECORDED_STATUS_COMPLETE，如果有任何一个任务未执行完成则返回ACL_EVENT_RECORDED_STATUS_NOT_READY。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

如果用户在不同线程上分别调用[aclrtRecordEvent](aclrtRecordEvent.md)和aclrtQueryEventStatus，可能由于多线程导致这两个API的执行时间乱序，进而导致查询到的Event对象的完成状态不符合预期。

