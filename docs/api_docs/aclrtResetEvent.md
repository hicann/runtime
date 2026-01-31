# aclrtResetEvent

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

复位Event，恢复Event初始状态，便于Event对象重复使用。异步接口。

对于多个Stream间任务同步的场景，通常在调用[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口之后再复位Event。

## 函数原型

```
aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 待复位的Event。 |
| stream | 输入 | 指定Stream。<br>多个Stream间任务同步的场景，例如，Stream2中的任务依赖Stream1中的任务时，此处配置为Stream2。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 使用约束

仅支持复位由[aclrtCreateEventWithFlag](aclrtCreateEventWithFlag.md)接口创建的、带有ACL\_EVENT\_SYNC标志的Event。

在多个Stream中的任务需要等待同一个Event的情况下，不建议使用调用此接口来复位Event。例如，stream2、stream3中的任务等待同一个Event完成，如果在stream2中的aclrtStreamWaitEvent接口之后调用aclrtResetEvent接口，Event将被复位，这会导致stream3中的aclrtStreamWaitEvent接口无法成功。

