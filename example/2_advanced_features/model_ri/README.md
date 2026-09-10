# model_ri

本目录聚焦模型运行实例的捕获、更新与切换能力。

## 样例列表

- [0_simple_model](./0_simple_model/README.md)：演示任务捕获、模型运行实例创建和执行。
- [1_model_update](./1_model_update/README.md)：演示对已捕获模型运行实例的任务更新。
- [2_model_switch](./2_model_switch/README.md)：演示模型运行实例中的 Stream 绑定、跳转与切换。
- [3_cond_model](./3_cond_model/README.md)：演示 aclGraph 条件操作（IF/WHILE/SWITCH 及嵌套组合）的图捕获与执行。
- [4_model_sync_external](./4_model_sync_external/README.md)：演示 ACL Graph 跨边界同步场景下 Event 的 Record External 和 Wait External 用法。
- [5_reusable_buffer_reset](./5_reusable_buffer_reset/README.md)：枚举异步清零模型的 Stream/Task 结构，并在结构有效时执行模型和校验缓冲区结果。
