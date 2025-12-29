# aclrtReduceAsync

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

执行Reduce操作，包括SUM、MIN、MAX等。异步接口。

## 函数原型

```
aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void *reserve)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 源内存大小，单位为Byte。 |
| kind | 输入 | 操作类型。 |
| type | 输入 | 数据类型。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品支持如下类型：int8、int16、int32、fp16、fp32、bf16。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品支持如下类型：int8、int16、int32、fp16、fp32、bf16。 |
| stream | 输入 | 指定执行Reduce操作任务的Stream。<br>如果使用默认Stream，此处设置为NULL。 |
| reserve | 输入 | 预留参数。当前固定传NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

dts、src必须跟stream所在的Device是同一个设备。

