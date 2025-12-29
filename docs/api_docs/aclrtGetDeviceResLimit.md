# aclrtGetDeviceResLimit

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前进程的Device资源限制。

若没有调用[aclrtSetDeviceResLimit](aclrtSetDeviceResLimit.md)接口设置当前进程的Device资源限制，则调用本接口获取到的是昇腾AI处理器硬件默认的资源限制。

## 函数原型

```
aclError aclrtGetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t* value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| type | 输入 | 资源类型，当前支持Cube Core、Vector Core。 |
| value | 输出 | 资源限制的大小。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

