# 19-04 Marking Iteration Time in PyTorch Scenarios

<!-- md-trans-meta sourceCommit=a27302fd8cb673670a6b4f0c9fb858d9dac832e1 translatedAt=2026-11-11T07:09:21.800Z pushedAt=2026-11-16T11:33:00.517Z nl=2 -->

This topic describes the API for marking iteration time in PyTorch scenarios.

- [`aclError aclprofGetStepTimestamp(aclprofStepInfo* stepInfo, aclprofStepTag tag, aclrtStream stream)`](#aclprofGetStepTimestamp): Marks the start and end time of iterations in training scenarios implemented through the single operator model execution API, providing iteration identifiers for subsequent profiling parsing so that performance data can be displayed at iteration granularity.

<a id="aclprofGetStepTimestamp"></a>

## aclprofGetStepTimestamp

```c
aclError aclprofGetStepTimestamp(aclprofStepInfo* stepInfo, aclprofStepTag tag, aclrtStream stream)
```

### Applicable Products

<!-- npu="950" id2395 -->
- Ascend 950PR&950DT products: Supported
<!-- end id2395 -->
<!-- npu="A3" id2396 -->
- Atlas A3 products: Supported
<!-- end id2396 -->
<!-- npu="910b" id2397 -->
- Atlas A2 products: Supported
<!-- end id2397 -->
<!-- npu="310b" id2398 -->
- Atlas 200I/500 A2 inference products: Supported
<!-- end id2398 -->
<!-- npu="310p" id2399 -->
- Atlas inference products: Supported
<!-- end id2399 -->
<!-- npu="910" id2400 -->
- Atlas training products: Supported
<!-- end id2400 -->
<!-- npu="IPV350" id2401 -->
- IPV350: Not supported
<!-- end id2401 -->
<!-- npu="5162A" id5001 -->
- Hisilicon5162A: Not supported
<!-- end id5001 -->
<!-- @ref: runtime/res/docs/zh/api_ref/19-04_setting_Iteration_time_in_pytorch_scenarios_res.md#id1 -->

### Description

Marks the start and end time of iterations in training scenarios implemented through the single operator model execution API , providing iteration identifiers for subsequent profiling parsing so that performance data can be displayed at iteration granularity.

### Parameters

| Name | Input/Output | Description |
| --- | :---: | --- |
| stepInfo | Input | Iteration information. You need to call [aclprofCreateStepInfo](25-03_Operation_APIs.md#aclprofCreateStepInfo) in advance to create data of the [aclprofStepInfo](25-03_Operation_APIs.md#aclprofStepInfo) type.<br>For details about the type definition, see [aclprofStepInfo](25-03_Operation_APIs.md#aclprofStepInfo), [aclprofStepTag](25-02_Enumerations.md#aclprofStepTag), and [aclrtStream](25-05_Typedefs.md#aclrtStream). |
| tag | Input | Start or end time of an iteration. Pass the enumerated value **ACL_STEP_START** at the start of an iteration, and pass the enumerated value **ACL_STEP_END** at the end of an iteration.<br>For details about the values, see [aclprofStepTag](25-02_Enumerations.md#aclprofStepTag). |
| stream | Input | Stream.<br>For details about the values, see [aclrtStream](25-05_Typedefs.md#aclrtStream). |

### Return Values

Returns **0** if the operation is successful; returns other values if the operation fails. For details, see [aclError](25-01_aclError.md#aclError).
