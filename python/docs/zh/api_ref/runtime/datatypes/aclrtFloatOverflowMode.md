# aclrtFloatOverflowMode

| 数据格式 | 说明 |
| --- | --- |
| ACL_RT_OVERFLOW_MODE_SATURATION = 0 | 饱和模式，设置成该模式，计算精度可能存在误差。该模式仅为兼容旧版本，后续不演进。 |
| ACL_RT_OVERFLOW_MODE_INFNAN = 1 | Inf/NaN模式（符合IEEE 754标准），默认值。 |
| ACL_RT_OVERFLOW_MODE_UNDEF = 2 | 预留参数。 |

<!-- npu="950" id1 -->
对于Ascend 950PR&950DT系列产品，仅支持Inf/NaN模式。
<!-- end id1 -->

<!-- npu="910,310p,310b" id2 -->
对于Atlas 200I/500 A2推理产品、Atlas推理系列产品、Atlas训练系列产品，仅支持设置饱和模式。
<!-- end id2 -->
