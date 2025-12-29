# aclprofModelSubscribe

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

网络场景下，订阅算子的基本信息，包括算子名称、算子类型、算子执行耗时等。

## 函数原型

```
aclError aclprofModelSubscribe(uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| modelId | 输入 | 待订阅的网络模型的ID。<br>调用aclmdlLoadFromFile接口/aclmdlLoadFromMem接口/aclmdlLoadFromFileWithMem接口/aclmdlLoadFromMemWithMem接口加载模型成功后，会返回模型ID。 |
| profSubscribeConfig | 输入 | 待订阅的配置信息。<br>需提前调用[aclprofCreateSubscribeConfig](aclprofCreateSubscribeConfig.md)接口创建aclprofSubscribeConfig类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

与[aclprofModelUnSubscribe](aclprofModelUnSubscribe.md)接口配对使用。

