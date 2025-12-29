# acltdtReceiveTensor

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Host接收Device发过来的数据。

## 函数原型

```
aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannel](acltdtCreateChannel.md)接口或[acltdtCreateChannelWithCapacity](acltdtCreateChannelWithCapacity.md)接口创建acltdtChannelHandle类型的数据。 |
| dataset | 输出 | 接收到的Device数据的指针。 |
| timeout | 输入 | 等待超时时间。<br>该参数取值范围如下：<br>  - -1：阻塞方式，一直等待直到数据接收完成。<br>  - 0：非阻塞方式，当通道空时，直接返回通道空这个错误，这时由用户自行设定重试间隔。<br>  - >0：配置具体的超时时间，单位为毫秒。通道空时，等待达到超时时间后返回报错。超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

