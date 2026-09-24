# aclrtStreamAttr

| 枚举项 | 说明 |
| --- | --- |
| ACL_STREAM_ATTR_FAILURE_MODE = 1 | 当Stream上的任务执行出错时，可通过该属性设置Stream的任务调度模式，以便控制某个任务失败后是否继续执行下一个任务<br>默认Stream不支持设置任务调度模式。<br>通过该属性设置任务调度模式，与[set_stream_failure_mode](../stream/function-set_stream_failure_mode.md)接口的功能一致。 |
| ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK = 2 | 当与上层训练框架（例如PyTorch）对接时，针对指定Stream，可通过该属性打开或关闭溢出检测开关。关闭后，将无法通过溢出检测算子获取任务是否溢出。<br>打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。<br>通过该属性设置溢出检测开关，与[set_stream_overflow_switch](../stream/function-set_stream_overflow_switch.md)接口的功能一致。 |
| ACL_STREAM_ATTR_USER_CUSTOM_TAG = 3 | 设置Stream上的溢出检测分组标签，以确定溢出发生时检测的粒度。如果不设置分组标签，默认为进程粒度。如果设置了分组标签，则仅检测与发生溢出的Stream具有相同分组标签的Stream。 |
| ACL_STREAM_ATTR_PRIORITY = 5 | 通过该属性设置Stream优先级。 |

<!-- npu="950,A3,910b" id1 -->
对于Ascend 950PR&950DT系列产品、Atlas A3系列产品、Atlas A2系列产品，支持设置Stream优先级。
<!-- end id1 -->

<!-- npu="910,310p,310b" id2 -->
对于Atlas 200I/500 A2推理产品、Atlas推理系列产品、Atlas训练系列产品，不支持设置Stream优先级。
<!-- end id2 -->
