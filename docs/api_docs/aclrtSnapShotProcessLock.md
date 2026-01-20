# aclrtSnapShotProcessLock

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

锁定Device上的当前进程，以阻止后续的运行时接口调用，包括Device设置/释放、内存的申请/释放/拷贝、Context/Stream/Event/Notify等资源的创建与销毁、以及部分任务下发接口。

在调用此接口之前，必须确保当前进程处于RUNNING状态，当前进程默认是RUNNING状态；调用该接口后，当前进程将变为LOCKED状态。

## 函数原型

```
aclError aclrtSnapShotProcessLock()
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

