# aclrtStreamAttr

```
typedef enum { 
    ACL_STREAM_ATTR_FAILURE_MODE         = 1,
    ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK = 2,
    ACL_STREAM_ATTR_USER_CUSTOM_TAG      = 3, 
    ACL_STREAM_ATTR_CACHE_OP_INFO        = 4, 
} aclrtStreamAttr;
```


| 枚举项 | 说明 |
| --- | --- |
| ACL_STREAM_ATTR_FAILURE_MODE | 当Stream上的任务执行出错时，可通过该属性设置Stream的任务调度模式，以便控制某个任务失败后是否继续执行下一个任务<br>默认Stream不支持设置任务调度模式。<br>通过该属性设置任务调度模式，与[aclrtSetStreamFailureMode](aclrtSetStreamFailureMode.md)接口的功能一致。 |
| ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK | 饱和模式下，当与上层训练框架（例如PyTorch）对接时，针对指定Stream，可通过该属性打开或关闭溢出检测开关。关闭后，将无法通过溢出检测算子获取任务是否溢出。<br>打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。<br>通过该属性设置溢出检测开关，与[aclrtSetStreamOverflowSwitch](aclrtSetStreamOverflowSwitch.md)接口的功能一致。 |
| ACL_STREAM_ATTR_USER_CUSTOM_TAG | 设置Stream上的溢出检测分组标签，以确定溢出发生时检测的粒度。如果不设置分组标签，默认为进程粒度。如果设置了分组标签，则仅检测与发生溢出的Stream具有相同分组标签的Stream。 |
| ACL_STREAM_ATTR_CACHE_OP_INFO | 基于捕获方式构建模型运行实例场景下，通过该属性设置Stream的算子信息缓存开关，以便于控制后续采集性能数据时是否附带算子信息。<br>该属性需与其它接口配合使用，请参见[aclrtCacheLastTaskOpInfo](aclrtCacheLastTaskOpInfo.md)中的接口调用流程。<br>跨Stream的任务捕获时，与主流关联的其他Stream，其算子信息缓存开关状态与主流一致。 |

