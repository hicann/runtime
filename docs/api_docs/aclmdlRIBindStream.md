# aclmdlRIBindStream

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将模型运行实例与Stream绑定。

## 函数原型

```
aclError aclmdlRIBindStream(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelRI | 输入 | 模型运行实例。<br>此处的modelRI需与[aclmdlRIBuildBegin](aclmdlRIBuildBegin.md)接口中的modelRI保持一致。 |
| stream | 输入 | 指定Stream。<br>此处的Stream需通过[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)接口创建ACL_STREAM_PERSISTENT类型的Stream。<br>不支持传NULL，不支持一个Stream绑定多个modelRI的场景。 |
| flag | 输入 | 标记该Stream是否从模型执行开始时就运行。<br><br>  - ACL_MODEL_STREAM_FLAG_HEAD：首Stream，模型执行开始时就运行的Stream。<br>  - ACL_MODEL_STREAM_FLAG_DEFAULT：模型执行过程中，根据分支算子或循环算子激活的Stream，后续可调用[aclrtActiveStream](aclrtActiveStream.md)接口激活Stream<br><br>宏定义如下：<br>#define ACL_MODEL_STREAM_FLAG_HEAD  0x00000000U <br>#define ACL_MODEL_STREAM_FLAG_DEFAULT 0x7FFFFFFFU |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

