# acltdtCleanChannel

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

清空通道中的所有数据。

## 函数原型

```
aclError acltdtCleanChannel(acltdtChannelHandle *handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 指定通道。<br>需提前调用[acltdtCreateChannelWithCapacity](acltdtCreateChannelWithCapacity.md)接口创建acltdtChannelHandle类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

