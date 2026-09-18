# context

本目录聚焦 Context 的创建、切换、绑定与销毁，以及多线程下的上下文使用方式。

## 样例列表

- [0_context_query](./0_context_query/README.md)：查询当前 Context、默认 Stream 和当前线程资源限制。
- [1_context_scoped_determinism](./1_context_scoped_determinism/README.md)：观察默认 Context 状态，并验证两个 Context 的确定性计算配置相互隔离。

## 建议关注

- `aclrtCreateContext`、`aclrtSetCurrentContext`、`aclrtDestroyContext` 等接口的典型用法。
- Device 与 Context 的关联关系。
- 多线程场景下的上下文隔离与复用。

## 可选参考

- [../device/](../device/)：Device 初始化与切换。
- [../stream/](../stream/)：流与上下文的配合关系。
