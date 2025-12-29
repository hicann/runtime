# aclrtSynchronizeStreamWithTimeout

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

阻塞应用程序运行，直到指定Stream中的所有任务都完成，该接口是在[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出。

## 函数原型

```
aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定需要完成所有任务的Stream。 |
| timeout | 输入 | 接口的超时时间。<br>取值说明如下：<br><br>  - -1：表示永久等待，和接口[aclrtSynchronizeStream](aclrtSynchronizeStream.md)功能一样；<br>  - >0：配置具体的超时时间，单位是毫秒。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

