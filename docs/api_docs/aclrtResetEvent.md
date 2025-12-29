# aclrtResetEvent

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

复位一个Event。用户需确保等待Stream中的任务都完成后，再复位Event。异步接口。

## 函数原型

```
aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 待复位的Event。 |
| stream | 输入 | 指定Stream。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream2。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

