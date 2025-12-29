# aclprofCreateSubscribeConfig

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建aclprofSubscribeConfig类型的数据，表示创建订阅配置信息。

如需销毁aclprofSubscribeConfig类型的数据，请参见[aclprofDestroySubscribeConfig](aclprofDestroySubscribeConfig.md)。

## 约束说明

-   使用aclprofDestroySubscribeConfig接口销毁aclprofSubscribeConfig类型的数据，如不销毁会导致内存未被释放。

-   与[aclprofDestroySubscribeConfig](aclprofDestroySubscribeConfig.md)接口配对使用，先调用aclprofCreateSubscribeConfig接口再调用aclprofDestroySubscribeConfig接口。

## 函数原型

```
aclprofSubscribeConfig *aclprofCreateSubscribeConfig(int8_t timeInfoSwitch, aclprofAicoreMetrics aicoreMetrics, void *fd)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeInfoSwitch | 输入 | 是否采集网络模型中算子的性能数据：<br><br>  - 1：采集<br>  - 0：不采集 |
| aicoreMetrics | 输入 | 表示AI Core性能指标采集项。<br> 说明： 订阅接口目前仅提供算子耗时统计的功能，暂时不支持AicoreMetrics采集功能。 |
| fd | 输入 | 用户创建的管道写指针。<br>用户在调用aclprofModelUnSubscribe接口后，系统内部会在数据发送结束后，关闭该模型的管道写指针。 |

## 返回值说明

-   返回aclprofSubscribeConfig类型的指针，表示成功。
-   返回nullptr，表示失败。

