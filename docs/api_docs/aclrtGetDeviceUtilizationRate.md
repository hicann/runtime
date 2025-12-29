# aclrtGetDeviceUtilizationRate

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询Device上Cube、Vector、AI CPU等的利用率。

## 函数原型

```
aclError aclrtGetDeviceUtilizationRate(int32_t deviceId, aclrtUtilizationInfo *utilizationInfo)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| utilizationInfo | 输出 | 利用率信息结构体指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   查询Device内存利用率为预留功能，当前版本不支持，若调用本接口查询内存利用率，查询到的利用率为-1。
-   昇腾虚拟化实例场景下，不支持调用本接口查询利用率，接口返回值无实际意义。
-   开启Profiling功能时，不支持调用本接口查询利用率，接口返回值无实际意义。

