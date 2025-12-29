# aclrtDeviceTaskAbort

**须知：本接口为预留接口，暂不支持。**

## 功能说明

停止指定Device上的正在执行的任务，同时丢弃指定Device上已下发的任务。该接口支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则调用本接口超出超时时间，则接口返回报错。

## 函数原型

```
aclError aclrtDeviceTaskAbort(int32_t deviceId, uint32_t timeout);
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>与[aclrtSetDevice](aclrtSetDevice.md)接口中Device ID保持一致。 |
| timeout | 输入 | 超时时间。<br>取值说明如下：<br><br>  - 0：表示永久等待；<br>  - >0：配置具体的超时时间，单位是毫秒。最大超时时间36分钟。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

