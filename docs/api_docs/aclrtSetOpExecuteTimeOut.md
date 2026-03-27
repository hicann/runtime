# aclrtSetOpExecuteTimeOut

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置算子执行的超时时间，单位为秒。一个进程内多次调用本接口，则以最后一次设置的时间为准。

建议使用aclrtSetOpExecuteTimeOutV2接口，该接口会返回实际生效的超时时间。

## 函数原型

```
aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 设置超时时间，单位为秒。<br>将该参数设置为0时，表示使用最大超时时间。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

不调用本接口，算子的默认超时时间如下表所示：


| 型号 | AI Core算子的默认超时时间 | AI CPU算子的默认超时时间 |
| --- | --- | --- |
| Ascend 950PR/Ascend950DT | 1091秒 | 28秒 |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | 1091秒 | 60秒 |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 1091秒 | 28秒 |

由于不同产品型号的架构差异，AI Core算子、AI CPU算子的最大超时时间有所不同：


| 型号 | 最大超时时间 |
| --- | --- |
| Ascend 950PR/Ascend950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | interval * 254，单位是微秒，interval可通过aclrtGetOpTimeoutInterval接口获取。 |

