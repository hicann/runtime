# aclrtLaunchHostFunc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Stream的任务队列中下发一个Host回调任务，系统内部在执行到该回调任务时，会在Stream上注册的线程（该线程在本接口内部创建并注册）中执行回调函数，并且回调任务默认阻塞本Stream上后续任务的执行。异步接口。

本接口可用于实现异步场景下的callback功能，与另一套实现异步场景下的callback功能接口（[aclrtLaunchCallback](aclrtLaunchCallback.md)、[aclrtSubscribeReport](aclrtSubscribeReport.md)、[aclrtProcessReport](aclrtProcessReport.md)、[aclrtUnSubscribeReport](aclrtUnSubscribeReport.md)）的差别在于：使用aclrtLaunchCallback等接口时，Stream上注册的线程需由用户自行创建并通过[aclrtSubscribeReport](aclrtSubscribeReport.md)接口注册，另外也可以指定回调任务是否阻塞本Stream上后续任务的执行。

对于同一个Stream，两套实现异步场景下的callback功能的接口不能混用，否则可能出现异常。

## 函数原型

```
aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定执行回调任务的Stream。 |
| fn | 输入 | 指定要增加的回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtHostFunc)(void *args) |
| args | 输入 | 待传递给回调函数的用户数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

回调函数涉及共享资源（例如锁），因此在使用回调函数需慎重，不应该调用资源申请、资源释放、Stream同步、Device同步、任务下发、任务终止等接口，否则可能导致错误或死锁。

