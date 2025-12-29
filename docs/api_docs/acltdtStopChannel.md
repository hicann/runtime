# acltdtStopChannel

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

调用acltdtSendTensor接口发送数据时或调用acltdtReceiveTensor接口接收数据时，用户线程可能在没有数据时会卡住，此时如果需要退出的话，需要先将线程唤醒，该接口就是用来唤醒被卡住阻塞的线程用的。需要用户在发送、接收线程之外的一个线程里调用这个函数，来唤醒处于阻塞状态的发送/接收线程。

## 函数原型

```
aclError acltdtStopChannel(acltdtChannelHandle *handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](acltdtCreateChannel.md)接口或[acltdtCreateChannelWithCapacity](acltdtCreateChannelWithCapacity.md)接口创建acltdtChannelHandle类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

