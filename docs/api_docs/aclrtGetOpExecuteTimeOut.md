# aclrtGetOpExecuteTimeOut

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取AI Core算子执行的超时时间。

## 函数原型

```
aclError aclrtGetOpExecuteTimeout(uint32_t *const timeoutMs)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeoutMs | 输出 | 超时时间，单位为毫秒。<br>若已调用set接口（例如aclrtSetOpExecuteTimeOut）设置过超时时间，则返回硬件的实际超时时间，否则，返回AI Core的默认超时时间。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

