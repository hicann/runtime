# aclrtRecordEvent

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在指定Stream中记录一个Event。异步接口。

aclrtRecordEvent接口与aclrtStreamWaitEvent接口配合使用时，主要用于多Stream之间同步等待的场景，在调用aclrtRecordEvent接口时，系统内部会申请Event资源。

调用aclrtRecordEvent接口时，会捕获当前Stream上已下发的任务，并记录到Event事件中，因此后续若调用[aclrtQueryEventStatus](aclrtQueryEventStatus.md)或[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口时，会检查或等待该Event事件中所捕获的任务都已经完成。

另外，对于使用[aclrtCreateEventExWithFlag](aclrtCreateEventExWithFlag.md)创建的Event：

-   aclrtRecordEvent接口支持对同一个Event多次record实现Event复用，每次Record会重新捕获当前Stream上已下发的任务，并覆盖保存到Event中。在调用aclrtStreamWaitEvent接口时，会使用最近一次Event中所保存的任务，且不会被后续的aclrtRecordEvent调用影响。
-   在首次调用aclrtRecordEvent接口前，由于Event中没有任务，因此调用aclrtQueryEventStatus接口时会返回ACL\_EVENT\_RECORDED\_STATUS\_COMPLETE。

## 函数原型

```
aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 待记录的Event。 |
| stream | 输入 | 指定Stream。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream1。<br>如果使用默认Stream，此处设置为NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

