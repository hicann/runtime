# context

本目录聚焦 Context 的创建、切换、绑定与销毁，以及多线程下的上下文使用方式。

## 建议关注

- `aclrtCreateContext`、`aclrtSetCurrentContext`、`aclrtDestroyContext` 等接口的典型用法。
- Device 与 Context 的关联关系。
- 多线程场景下的上下文隔离与复用。

## 可先参考

- [../device/](../device/)：Device 初始化与切换。
- [../stream/](../stream/)：流与上下文的配合关系。