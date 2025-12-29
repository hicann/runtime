# aclrtSetStreamResLimit

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置指定Stream的Device资源限制。

本接口应在调用[aclrtSetDevice](aclrtSetDevice.md)接口之后且在执行算子之前使用。如果对同一Stream进行多次设置，将以最后一次设置为准。

调用本接口设置指定Stream的Device资源限制后，需配合调用[aclrtUseStreamResInCurrentThread](aclrtUseStreamResInCurrentThread.md)接口，设置在当前线程中使用指定Stream上的Device资源限制。

## 函数原型

```
aclError aclrtSetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>若传入NULL，则表示默认Stream。 |
| type | 输入 | 资源类型。 |
| value | 输入 | 资源限制的大小。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

