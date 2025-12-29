# aclrtSetOpExecuteTimeOutWithMs

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

设置算子执行的超时时间，单位为毫秒。

## 函数原型

```
aclError aclrtSetOpExecuteTimeOutWithMs(uint32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 设置超时时间，单位为毫秒。将该参数设置为0时，表示使用最大超时时间。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

