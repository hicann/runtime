# aclrtLaunchCallback

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Stream的任务队列中下发一个Host回调任务，系统内部在执行到该回调任务时，会在Stream上注册的线程（该线程由用户自行创建，并通过[aclrtSubscribeReport](aclrtSubscribeReport.md)接口注册）中执行回调函数。异步接口。

**本接口需与以下其它接口配合使用**，以便实现异步场景下的callback功能：

1.  定义并实现回调函数，函数原型为：typedef void \(\*aclrtCallback\)\(void \*userData\)；
2.  新建线程，在线程函数内，调用[aclrtProcessReport](aclrtProcessReport.md)接口设置超时时间（需循环调用），等待回调任务执行；
3.  调用[aclrtSubscribeReport](aclrtSubscribeReport.md)接口建立第2步中的线程和Stream的绑定关系，该Stream下发的回调函数将在绑定的线程中执行；
4.  在指定Stream上执行异步任务（例如异步推理任务）；
5.  调用[aclrtLaunchCallback](aclrtLaunchCallback.md)接口在Stream的任务队列中下发回调任务，触发第2步中注册的线程处理回调函数，每调用一次aclrtLaunchCallback接口，就会触发一次回调函数的执行；
6.  异步任务全部执行完成后，取消线程注册（[aclrtUnSubscribeReport](aclrtUnSubscribeReport.md)接口）。

本接口可用于实现异步场景下的callback功能，与另一个实现异步场景下的callback功能接口[aclrtLaunchHostFunc](aclrtLaunchHostFunc.md)的差别在于：使用aclrtLaunchHostFunc接口时，会在Stream上注册的线程（该线程在本接口内部创建并注册）中执行回调函数，并且回调任务默认阻塞本Stream上后续任务的执行。

对于同一个Stream，两套实现异步场景下的callback功能的接口不能混用，否则可能出现异常。

## 函数原型

```
aclError aclrtLaunchCallback(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| fn | 输入 | 指定要增加的回调函数。<br>回调函数的函数原型为：<br>typedef void (*aclrtCallback)(void *userData) |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |
| blockType | 输入 | 指定回调任务是否阻塞本Stream上后续任务的执行。<br>typedef enum aclrtCallbackBlockType {<br>   ACL_CALLBACK_NO_BLOCK,  //非阻塞<br>   ACL_CALLBACK_BLOCK,  //阻塞<br>} aclrtCallbackBlockType; |
| stream | 输入 | 指定Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

回调函数涉及共享资源（例如锁），因此在使用回调函数需慎重，不应该调用资源申请、资源释放、Stream同步、Device同步、任务下发、任务终止等接口，否则可能导致错误或死锁。

