# aclprofStop

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

停止Profiling数据采集。

## 函数原型

```
aclError aclprofStop(const aclprofConfig *profilerConfig)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| profilerConfig | 输入 | 指定停止Profiling数据采集的配置。<br>与[aclprofStart](aclprofStart.md)接口中的[aclprofConfig](aclprofConfig.md)类型数据保持一致。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

与[aclprofStart](aclprofStart.md)接口配对使用，先调用aclprofStart接口再调用aclprofStop接口。

