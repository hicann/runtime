# aclrtStreamAbort

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

停止指定Stream上正在执行的任务、丢弃指定Stream上已下发但未执行的任务。本接口执行期间，指定Stream上新下发的任务不再生效。

## 函数原型

```
aclError aclrtStreamAbort(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定待停止任务的Stream。<br>不支持使用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口来绑定模型运行实例的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

如果有其它Stream依赖本接口中指定的Stream（例如通过[aclrtRecordEvent](aclrtRecordEvent.md)、[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)等接口实现两个Stream间同步等待），则其它Stream执行可能会卡住，此时您需要显式调用本接口清除其它Stream上的任务。

如果调用本接口清除指定Stream上的任务时，再调用同步等待接口（例如[aclrtSynchronizeStream](aclrtSynchronizeStream.md)、[aclrtSynchronizeEvent](aclrtSynchronizeEvent.md)等），同步等待接口会退出并返回ACL\_ERROR\_RT\_STREAM\_ABORT的报错。

