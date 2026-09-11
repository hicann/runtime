# 5_runtime_lifecycle_callbacks

本主题展示应用插件如何参与 ACL 初始化与去初始化流程，并验证回调注册、注销和引用计数语义。

## 样例列表

- [0_reference_counted_plugin_lifecycle](./0_reference_counted_plugin_lifecycle/README.md)：注册有效与待取消的生命周期回调，通过一次单 Device 业务验证仅有效回调被执行，且最终引用计数归零。
