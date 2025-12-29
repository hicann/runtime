# acltdtEnqueueData

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

向队列中添加数据。

## 函数原型

```
aclError acltdtEnqueueData(uint32_t qid, const void *data, size_t dataSize, const void *userData, size_t userDataSize, int32_t timeout, uint32_t rsv)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| qid | 输入 | 需要添加数据的队列。<br>队列需提前调用[acltdtCreateQueue](acltdtCreateQueue.md)接口创建。 |
| data | 输入 | 内存数据指针，支持Host侧或Device侧的内存。 |
| dataSize | 输入 | 内存数据大小，单位为Byte。 |
| userData | 输入 | 用户自定义数据指针。<br>若用户没有自定义数据，则传nullptr。 |
| userDataSize | 输入 | 用户自定义数据大小（<=96Byte）。<br>若用户没有自定义数据，则传0。 |
| timeout | 输入 | 等待超时时间。当队列满时，如果向队列中添加数据，系统内部会根据设置的等待超时时间来决定如何处理。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据成功加入队列。<br>  - 0：非阻塞方式（仅支持Device场景，Host场景无效），当队列满时，直接返回队列满这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。队列满时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |
| rsv | 输入 | 预留参数，暂不支持。当前可设置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

