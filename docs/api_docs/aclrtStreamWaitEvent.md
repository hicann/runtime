# aclrtStreamWaitEvent

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

阻塞指定Stream的运行，直到指定的Event完成，支持多个Stream等待同一个Event的场景。异步接口。

提交到Stream上的所有后续任务都需要等待Event捕获的任务都完成后才能开始执行。具体见[aclrtRecordEvent](aclrtRecordEvent.md)接口了解Event捕获的细节。

## 函数原型

```
aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream2。<br>如果使用默认Stream，此处设置为NULL。 |
| event | 输入 | 需等待的Event。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

一个进程内，调用[aclInit](aclInit.md)接口初始化后，若再调用[aclrtSetOpWaitTimeout](aclrtSetOpWaitTimeout.md)接口设置超时时间，那么本进程内后续调用[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口下发的任务支持在所设置的超时时间内等待，若等待的时间超过所设置的超时时间，则在调用同步等待接口（例如，[aclrtSynchronizeStream](aclrtSynchronizeStream.md)）后，会返回报错。

