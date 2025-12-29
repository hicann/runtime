# aclrtSetStreamOverflowSwitch

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

饱和模式下，对接上层训练框架时（例如PyTorch），针对指定Stream，打开或关闭溢出检测开关，关闭后无法通过溢出检测算子获取任务是否溢出。

## 函数原型

```
aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 待操作Stream。<br>若传入NULL，则操作默认Stream。 |
| flag | 输入 | 溢出检测开关，取值范围如下：<br><br>  - 0：关闭<br>  - 1：打开 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   在调用本接口前，可调用[aclrtSetDeviceSatMode](aclrtSetDeviceSatMode.md)接口设置饱和模式。
-   调用该接口打开或关闭溢出检测开关后，仅对后续新下发的任务生效，已下发的任务仍维持原样。

