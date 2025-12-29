# aclrtStreamWaitEventWithTimeout

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取算子二进制数据在Device上的内存地址及内存大小。

## 函数原型

```
aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>多Stream同步等待场景下，例如，Stream2等待Stream1的场景，此处配置为Stream2。<br>如果使用默认Stream，此处设置为NULL。 |
| event | 输入 | 需等待的Event。 |
| timeout | 输入 | 超时时间。<br>取值>0，用于配置具体的超时时间，单位是毫秒。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

