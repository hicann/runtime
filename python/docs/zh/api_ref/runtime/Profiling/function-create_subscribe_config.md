# 函数：create\_subscribe\_config

## 产品支持情况
<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

创建aclprofSubscribeConfig类型的数据，表示创建订阅配置信息。

如需销毁aclprofSubscribeConfig类型的数据，请参见[acl.prof.destroy\_subscribe\_config](function-destroy_subscribe_config.md)。

## 函数原型

- **C函数原型**

    ```c
    aclprofSubscribeConfig *aclprofCreateSubscribeConfig(int8_t timeInfoSwitch, aclprofAicoreMetrics aicoreMetrics, void *fd)
    ```

- **python函数**

    ```python
    subscribe_config = acl.prof.create_subscribe_config(time_info_switch, aicore_metrics, fd)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| time_info_switch | int，是否采集网络模型中算子的性能数据：<br>1：采集<br>0：不采集 |
| aicore_metrics | int，表示AI Core性能指标采集项，参考[aclprofAicoreMetrics](../datatypes/aclprofAicoreMetrics.md)。<br>订阅接口目前仅提供算子耗时统计的功能，暂时不支持AicoreMetrics采集功能。 |
| fd | int，用户创建管道的写文件描述符。<br>用户在调用[acl.prof.model_unsubscribe](function-model_unsubscribe.md)接口后，系统内部会在数据发送结束后，关闭该模型的管道写文件描述符。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| subscribe_config | int。<br>返回非0值表示成功，返回aclprofSubscribeConfig的地址对象。<br>返回0表示失败。 |

## 约束说明

- 使用[acl.prof.destroy\_subscribe\_config](function-destroy_subscribe_config.md)接口销毁aclprofSubscribeConfig类型的数据，如不销毁会导致内存未被释放。

- 与[acl.prof.destroy\_subscribe\_config](function-destroy_subscribe_config.md)接口配对使用，先调用acl.prof.create\_subscribe\_config接口再调用[acl.prof.destroy\_subscribe\_config](function-destroy_subscribe_config.md)接口。
