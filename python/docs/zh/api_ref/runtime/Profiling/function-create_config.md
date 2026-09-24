# 函数：create\_config

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

创建aclprofConfig类型的数据，表示创建Profiling配置数据。

aclProfConfig类型数据可以只创建一次、多处使用，用户需要保证数据的一致性和准确性。

如需销毁aclprofConfig类型的数据，请参见[函数：destroy\_config](function-destroy_config.md)。

## 函数原型

- **C函数原型**

    ```c
    aclprofConfig *aclprofCreateConfig(uint32_t *deviceIdlist, uint32_t deviceNums, aclprofAicoreMetrics aicoreMetrics, aclprofAicoreEvents *aicoreEvents, uint64_t dataTypeConfig)
    ```

- **python函数**

    ```python
    prof_config = acl.prof.create_config(device_list, aicore_metrics, aicore_events, data_type_config)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_list | list，Device ID列表。须根据实际环境的Device ID配置。 |
| aicore_metrics | int，表示[aclprofAicoreMetrics](../datatypes/aclprofAicoreMetrics.md)。 |
| aicore_events | int，表示AI Core事件，目前配置为0。 |
| data_type_config | int，用户选择如下多个[aclproftype](../datatypes/aclproftype.md)的值进行逻辑或（例如：ACL_PROF_ACL_API\|ACL_PROF_AICORE_METRICS），作为data_type_config参数值。每个值表示某一类性能数据，详细说明如下：<br>ACL_PROF_ACL_API：表示采集接口的性能数据，包括Host与Device之间的同步异步内存复制时延等。<br>ACL_PROF_TASK_TIME：采集算子下发耗时、算子执行耗时数据以及算子基本信息数据，提供更全面的性能分析数据。<br>ACL_PROF_TASK_TIME_L0：采集算子下发耗时、算子执行耗时数据。与ACL_PROF_TASK_TIME相比，由于不采集算子基本信息数据，采集时性能开销较小，可更精准统计相关耗时数据。<br>ACL_PROF_AICORE_METRICS：表示采集AI Core性能指标数据，逻辑或时必须包括该值，aicore_metrics入参处配置的性能指标采集项才有效。<br>ACL_PROF_TASK_MEMORY：控制CANN算子的内存占用情况采集开关。仅采集GE组件算子。<br>ACL_PROF_AICPU：表示采集AI CPU任务的开始、结束数据。<br>ACL_PROF_L2CACHE：表示采集L2 Cache数据。<br>ACL_PROF_HCCL_TRACE：控制通信数据采集开关。<br>ACL_PROF_MSPROFTX：获取用户和上层框架程序输出的性能数据。需要先在应用程序脚本中添加如下其中一套接口：<br>mstx API（MindStudio Tools Extension API）接口详细操作请参见[《性能调优工具》](https://hiascend.com/document/redirect/CannCommunityToolProfiling) 中的“附录 &gt; mstx API使用示例”。<br>[msproftx扩展接口](msproftx_extension_apis.md)。<br>ACL_PROF_TRAINING_TRACE：控制迭代轨迹数据采集开关。<br>ACL_PROF_RUNTIME_API：控制runtime api性能数据采集开关。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| prof_config | int。<br>返回非0值表示成功，返回值为返回aclprofConfig类型的指针地址。<br>返回0表示失败。 |

## 约束说明

- 使用[acl.prof.destroy\_config](function-destroy_config.md)接口销毁aclprofConfig类型的数据，如不销毁会导致内存未被释放。

- 与[acl.prof.destroy\_config](function-destroy_config.md)接口配对使用，先调用acl.prof.create\_config接口再调用[acl.prof.destroy\_config](function-destroy_config.md)接口。
