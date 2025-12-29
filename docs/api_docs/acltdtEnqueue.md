# acltdtEnqueue

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

向队列中添加数据，存放数据的内存必须调用[acltdtAllocBuf](acltdtAllocBuf.md)接口申请。

## 函数原型

```
aclError acltdtEnqueue(uint32_t qid, acltdtBuf buf, int32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| qid | 输入 | 需要添加数据的队列。<br>队列需提前调用[acltdtCreateQueue](acltdtCreateQueue.md)接口创建。 |
| buf | 输入 | 共享Buffer指针。<br>该内存必须提前调用[acltdtAllocBuf](acltdtAllocBuf.md)接口申请。 |
| timeout | 输入 | 等待超时时间。当队列满时，如果向队列中添加数据，系统内部会根据设置的等待超时时间来决定如何处理。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据成功加入队列。<br>  - 0：非阻塞方式，当队列满时，直接返回队列满这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。队列满时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

