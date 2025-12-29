# aclrtSynchronizeDeviceWithTimeout

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

阻塞应用程序运行，直到正在运算中的Device完成运算。该接口是在[aclrtSynchronizeDevice](aclrtSynchronizeDevice.md)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出，超时退出时本接口返回ACL\_ERROR\_RT\_STREAM\_SYNC\_TIMEOUT。

多Device场景下，调用该接口等待的是当前Context对应的Device。

## 函数原型

```
aclError aclrtSynchronizeDeviceWithTimeout(int32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待，和接口[aclrtSynchronizeDevice](aclrtSynchronizeDevice.md)功能一样；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

