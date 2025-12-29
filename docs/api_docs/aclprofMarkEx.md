# aclprofMarkEx

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

aclprofMarkEx打点接口。

调用此接口向配置的Stream流上下发打点任务，用于标识Host侧打点与Device侧打点任务的关系。

## 函数原型

```
aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| msg | 输入 | 打点信息字符串指针。 |
| msgLen | 输入 | 字符串长度。最大支持127字符。 |
| stream | 输入 | 指定Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

