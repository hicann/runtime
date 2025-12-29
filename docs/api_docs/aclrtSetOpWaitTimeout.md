# aclrtSetOpWaitTimeout

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

本接口用于设置等待Event完成的超时时间。

不调用本接口，则默认不超时；一个进程内多次调用本接口，则以最后一次设置的时间为准。

## 函数原型

```
aclError aclrtSetOpWaitTimeout(uint32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 设置超时时间，单位为秒。<br>将该参数设置为0时，表示不超时。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

一个进程内，调用[aclInit](aclInit.md)接口初始化后，若再调用[aclrtSetOpWaitTimeout](aclrtSetOpWaitTimeout.md)接口设置超时时间，那么本进程内后续调用[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口下发的任务支持在所设置的超时时间内等待，若等待的时间超过所设置的超时时间，则在调用同步等待接口（例如，[aclrtSynchronizeStream](aclrtSynchronizeStream.md)）后，会返回报错。

