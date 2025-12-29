# aclrtWaitAndResetNotify

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

阻塞指定Stream的运行，直到指定的Notify完成，再复位Notify。异步接口。

## 函数原型

```
aclError aclrtWaitAndResetNotify(aclrtNotify notify, aclrtStream stream, uint32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| notify | 输入 | 需等待的Notify。 |
| stream | 输入 | 指定Stream。<br>多Stream同步等待场景下，例如，Stream2等Stream1的场景，此处配置为Stream2。<br>如果使用默认Stream，此处设置为NULL。 |
| timeout | 输入 | 等待的超时时间。<br>取值说明如下：<br><br>  - 0：表示永久等待；<br>  - >0：配置具体的超时时间，单位是秒。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

