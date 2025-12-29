# aclrtSetDeviceResLimit

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置当前进程的Device资源限制。

本接口应在调用[aclrtSetDevice](aclrtSetDevice.md)接口之后且在执行算子之前使用。如果对同一Device进行多次设置，将以最后一次设置为准。

除了进程级别的Device资源限制，当前还支持设置Stream级别的Device资源限制，可通过[aclrtSetStreamResLimit](aclrtSetStreamResLimit.md)、[aclrtUseStreamResInCurrentThread](aclrtUseStreamResInCurrentThread.md)接口配合使用实现。

Device资源限制的优先级为：Stream级别的Device资源限制 \> 进程级别的Device资源限制 \>  昇腾AI处理器硬件的资源限制

## 函数原型

```
aclError aclrtSetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| type | 输入 | 资源类型。 |
| value | 输入 | 资源限制的大小。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

本接口的设置仅对后续下发的任务有效。例如在调用[aclmdlRICaptureBegin](aclmdlRICaptureBegin.md)、[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)等接口捕获Stream任务到模型中、再执行模型推理的场景下，则需要在捕获之前调用本接口设置Device资源。

