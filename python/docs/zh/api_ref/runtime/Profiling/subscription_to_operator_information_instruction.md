# 总体说明

## 总体约束

不能与[Profiling数据采集接口](../Profiling/data_profiling_apis.md)的接口交叉调用：[acl.prof.model\_subscribe](function-model_subscribe.md)接口和[acl.prof.model\_unsubscribe](function-model_unsubscribe.md)接口之间不能调用[acl.prof.init](function-init-Profiling.md)接口、[acl.prof.start](function-start.md)接口、[acl.prof.stop](function-stop.md)接口、[acl.prof.finalize](function-finalize-Profiling.md)接口。

## 接口约束说明

- **接口调用要求**：
  - [acl.prof.model\_subscribe](function-model_subscribe.md)接口在模型执行之前调用，若在模型执行过程中调用[acl.prof.model\_subscribe](function-model_subscribe.md)接口，Profiling采集到的数据为调用[acl.prof.model\_subscribe](function-model_subscribe.md)接口之后的数据，可能导致数据不完整。
  - [acl.prof.model\_subscribe](function-model_subscribe.md)接口需与[acl.prof.model\_unsubscribe](function-model_unsubscribe.md)接口配对使用，不能在调用[acl.prof.model\_unsubscribe](function-model_unsubscribe.md)接口前，多次调用[acl.prof.model\_subscribe](function-model_subscribe.md)接口重复订阅相同的模型。
  - 不能调用[acl.prof.model\_subscribe](function-model_subscribe.md)接口订阅不存在的模型ID。
  - 不能调用[acl.prof.model\_unsubscribe](function-model_unsubscribe.md)接口取消订阅不存在的模型ID或未订阅过的模型ID。
  - 如果在同一个Device上加载了多个模型，只能对多个模型下发同样的订阅配置。

- **接口调用顺序**：
  - **建议的接口调用顺序如下**：

    模型加载--\>[acl.prof.model\_subscribe](function-model_subscribe.md)接口--\>[acl.prof.get\_op\_desc\_size](function-get_op_desc_size.md)接口--\>[acl.prof.get\_op\_num](function-get_op_num.md)接口--\>[acl.prof.get\_op\_type](function-get_op_type.md)/[acl.prof.get\_op\_name](function-get_op_name.md)/[acl.prof.get\_op\_start](function-get_op_start.md)/[acl.prof.get\_op\_end](function-get_op_end.md)/[acl.prof.get\_op\_duration](function-get_op_duration.md)/[acl.prof.get\_model\_id](function-get_model_id.md)接口--\>[acl.prof.model\_unsubscribe](function-model_unsubscribe.md)接口

  - **错误的接口调用顺序示例如下**，以重复定义同一个模型为例：

    模型1加载--\>[acl.prof.model\_subscribe](function-model_subscribe.md)接口\(指定模型1\)--\>[acl.prof.model\_subscribe](function-model_subscribe.md)接口\(指定模型1\)--\>[acl.prof.model\_unsubscribe](function-model_unsubscribe.md)接口
