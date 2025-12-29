# aclprofSetStampTraceMessage

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

为msproftx事件标记携带字符串描述，在Profiling解析并导出结果中msprof\_tx summary数据展示。

## 函数原型

```
aclError aclprofSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](aclprofCreateStamp.md)接口的指针。 |
| msg | 输入 | Stamp信息字符串指针。 |
| msgLen | 输入 | 字符串长度。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

在[aclprofCreateStamp](aclprofCreateStamp.md)接口和[aclprofDestroyStamp](aclprofDestroyStamp.md)接口之间调用。

