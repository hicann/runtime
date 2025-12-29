# aclrtResetDevice

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

复位当前运算的Device，释放Device上的资源。释放的资源包括默认Context、默认Stream以及默认Context下创建的所有Stream。若默认Context或默认Stream下的任务还未完成，系统会等待任务完成后再释放。

aclrtResetDevice接口内部涉及引用计数的实现，建议aclrtResetDevice接口与[aclrtSetDevice](aclrtSetDevice.md)接口配对使用，aclrtSetDevice接口每被调用一次，则引用计数加一，aclrtResetDevice接口每被调用一次，则该引用计数减一，当引用计数减到0时，才会真正释放Device上的资源。

如果多次调用aclrtSetDevice接口而不调用aclrtResetDevice接口释放本线程使用的Device资源，功能上不会有问题，因为在进程退出时也会释放本进程使用的Device资源。

## 函数原型

```
aclError aclrtResetDevice(int32_t deviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

若要复位的Device上存在显式创建的Context、Stream、Event，在复位前，建议遵循如下接口调用顺序，否则可能会导致业务异常。

**接口调用顺序：**调用[aclrtDestroyEvent](aclrtDestroyEvent.md)接口释放Event/调用[aclrtDestroyStream](aclrtDestroyStream.md)接口释放显式创建的Stream**--\>**调用[aclrtDestroyContext](aclrtDestroyContext.md)释放显式创建的Context**--\>**调用aclrtResetDevice接口

