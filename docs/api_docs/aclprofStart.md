# aclprofStart

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

下发Profiling请求，使能对应数据的采集。

用户可根据需要，在模型执行过程中按需调用aclprofStart接口，Profiling采集到的数据为调用该接口之后的数据。

## 函数原型

```
aclError aclprofStart(const aclprofConfig *profilerConfig)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| profilerConfig | 输入 | 指定Profiling配置数据。<br>需提前调用[aclprofCreateConfig](aclprofCreateConfig.md)接口创建aclprofConfig类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

与[aclprofStop](aclprofStop.md)接口配对使用，先调用aclprofStart接口再调用aclprofStop接口。

