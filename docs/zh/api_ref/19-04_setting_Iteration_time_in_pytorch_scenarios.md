# 19-04 PyTorch场景标记迭代时间

本章节描述PyTorch场景下标记迭代时间的接口。

- [`aclError aclprofGetStepTimestamp(aclprofStepInfo* stepInfo, aclprofStepTag tag, aclrtStream stream)`](#aclprofGetStepTimestamp)：利用单算子模型执行接口实现训练的场景下，使用本接口用于标记迭代开始与结束时间，为后续Profiling解析提供迭代标识，以便以迭代为粒度展示性能数据。

<a id="aclprofGetStepTimestamp"></a>

## aclprofGetStepTimestamp

```c
aclError aclprofGetStepTimestamp(aclprofStepInfo* stepInfo, aclprofStepTag tag, aclrtStream stream)
```

### 产品支持情况

<!-- npu="950" id2395 -->
- Ascend 950PR/Ascend 950DT：支持
<!-- end id2395 -->
<!-- npu="A3" id2396 -->
- Atlas A3 训练系列产品/Atlas A3 推理系列产品：支持
<!-- end id2396 -->
<!-- npu="910b" id2397 -->
- Atlas A2 训练系列产品/Atlas A2 推理系列产品：支持
<!-- end id2397 -->
<!-- npu="310b" id2398 -->
- Atlas 200I/500 A2 推理产品：支持
<!-- end id2398 -->
<!-- npu="310p" id2399 -->
- Atlas 推理系列产品：支持
<!-- end id2399 -->
<!-- npu="910" id2400 -->
- Atlas 训练系列产品：支持
<!-- end id2400 -->
<!-- npu="IPV350" id2401 -->
- IPV350：不支持
<!-- end id2401 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-04_setting_Iteration_time_in_pytorch_scenarios_res.md#id1 -->

### 功能说明

利用单算子模型执行接口实现训练的场景下，使用本接口用于标记迭代开始与结束时间，为后续Profiling解析提供迭代标识，以便以迭代为粒度展示性能数据。

### 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | :---: | --- |
| stepinfo | 输入 | 指定迭代信息。需提前调用[aclprofCreateStepInfo](25-03_Operation_APIs.md#aclprofCreateStepInfo)接口创建[aclprofStepInfo](25-03_Operation_APIs.md#aclprofStepInfo)类型的数据。<br>类型定义请参见[aclprofStepInfo](25-03_Operation_APIs.md#aclprofStepInfo)、[aclprofStepTag](25-02_Enumerations.md#aclprofStepTag)和[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |
| tag | 输入 | 用于标记迭代开始或结束。在迭代开始时传入枚举值ACL_STEP_START，迭代结束时需传入枚举值ACL_STEP_END。<br>取值详见[aclprofStepTag](25-02_Enumerations.md#aclprofStepTag)。 |
| stream | 输入 | 指定Stream。<br>取值详见[aclrtStream](25-05_Typedefs.md#aclrtStream)。 |

### 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](25-01_aclError.md#aclError)。
