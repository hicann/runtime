# aclprofSetConfig

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

aclprofCreateConfig接口的扩展接口，用于设置性能数据采集参数。

该接口支持多次调用，用户需要保证数据的一致性和准确性。

## 函数原型

```
aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| configType | 输入 | 作为configType参数值。每个枚举表示不同采集配置，若要使用该接口下不同的选项采集多种性能数据，则需要多次调用该接口，详细请参见[aclprofConfigType](aclprofConfigType.md)。 |
| configType | 输入 | 作为configType参数值。每个枚举表示不同采集配置，若要使用该接口下不同的选项采集多种性能数据，则需要多次调用该接口，详细说明如下： |
| config | 输入 | 指定配置项参数值。 |
| configLength | 输入 | config的长度，单位为Byte，最大长度不超过256字节。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

先调用aclprofSetConfig接口再调用[aclprofStart](aclprofStart.md)接口，可根据需求选择调用该接口。

