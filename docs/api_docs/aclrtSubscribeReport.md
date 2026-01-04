# aclrtSubscribeReport

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

注册处理Stream上回调函数的线程。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的callback功能：

1.  定义并实现回调函数，函数原型为：typedef void \(\*aclrtCallback\)\(void \*userData\)；
2.  新建线程，在线程函数内，调用[aclrtProcessReport](aclrtProcessReport.md)接口设置超时时间（需循环调用），等待回调任务执行；
3.  调用[aclrtSubscribeReport](aclrtSubscribeReport.md)接口建立第2步中的线程和Stream的绑定关系，该Stream下发的回调函数将在绑定的线程中执行；
4.  在指定Stream上执行异步任务（例如异步推理任务）；
5.  调用[aclrtLaunchCallback](aclrtLaunchCallback.md)接口在Stream的任务队列中下发回调任务，触发第2步中注册的线程处理回调函数，每调用一次aclrtLaunchCallback接口，就会触发一次回调函数的执行；
6.  异步任务全部执行完成后，取消线程注册（[aclrtUnSubscribeReport](aclrtUnSubscribeReport.md)接口）。

## 函数原型

```
aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| threadId | 输入 | 指定线程的ID。 |
| stream | 输入 | 指定Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

支持多次调用aclrtSubscribeReport接口给多个Stream（仅支持同一Device内的多个Stream）注册同一个处理回调函数的线程；为确保Stream内的任务按调用顺序执行，不支持调用aclrtSubscribeReport接口给同一个Stream注册多个处理回调函数的线程；同一个进程内，在不同的Device上注册回调函数的线程时，不能指定同一个线程ID。

单进程内调用本接口注册的线程数量超过一定限制，则接口返回失败。考虑操作系统的线程切换性能开销，建议调用aclrtSubscribeReport接口注册的线程数量控制在32个以下（包括32）。各产品型号支持的线程数量最大值不同，如下表所示。
    
| 型号 | 线程数量最大值 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 1024 |

