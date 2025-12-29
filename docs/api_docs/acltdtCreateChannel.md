# acltdtCreateChannel

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道。通道使用完成后，需及时依次调用[acltdtStopChannel](acltdtStopChannel.md)、[acltdtDestroyChannel](acltdtDestroyChannel.md)接口释放通道资源。

## 函数原型

```
acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| name | 输入 | 队列通道名称的指针。 |

## 返回值说明

-   返回acltdtChannelHandle类型的指针，表示成功。
-   返回nullptr，表示失败。

