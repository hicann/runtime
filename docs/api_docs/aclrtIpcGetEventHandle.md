# aclrtIpcGetEventHandle

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将本进程中的指定Event设置为IPC（Inter-Process Communication） Event，并返回其handle（即Event句柄），用于在跨进程场景下实现任务同步，支持同一个Device内的多个进程以及跨Device的多个进程。

**本接口需与以下其它关键接口配合使用**，此处以A进程、B进程为例：

1.  A进程中：
    1.  调用[aclrtCreateEventExWithFlag](aclrtCreateEventExWithFlag.md)接口创建flag为ACL\_EVENT\_IPC的Event。
    2.  调用aclrtIpcGetEventHandle接口获取用于进程间通信的Event句柄。
    3.  调用[aclrtRecordEvent](aclrtRecordEvent.md)接口在Stream中插入[1.a](#li288673614297)中创建的Event。

2.  B进程中：
    1.  调用[aclrtIpcOpenEventHandle](aclrtIpcOpenEventHandle.md)接口获取A进程中的Event句柄信息，并返回本进程可以使用的Event指针。
    2.  调用[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口阻塞指定Stream的运行，直到指定的Event完成。
    3.  Event使用完成后，调用[aclrtDestroyEvent](aclrtDestroyEvent.md)接口销毁Event。

## 函数原型

```
aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 指定Event。<br>仅支持通过[aclrtCreateEventExWithFlag](aclrtCreateEventExWithFlag.md)接口创建的、flag为ACL_EVENT_IPC的Event。 |
| handle | 输出 | 进程间通信的Event句柄。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

