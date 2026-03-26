# 2_advanced_features

本章节覆盖较高阶的 Runtime 能力，适合在掌握基础特性后继续学习 Kernel 执行、模型实例运行、回调、通知、TDT 通道和高级执行控制。

## 当前可运行样例

- [kernel](./kernel/)：Kernel 二进制加载、参数组织、执行和资源限制。
- [model_ri](./model_ri/)：任务捕获、模型实例创建、更新和切换。
- [callback](./callback/)：Host 回调、异常回调、HostFunc 订阅和流上回调任务。
- [notify](./notify/)：进程间 Notify 共享和流间同步。
- [tdt_channel](./tdt_channel/README.md)：TDT Channel 的数据传输、容量控制和数据结构解析。
- [tdt_queue](./tdt_queue/README.md)：TDT Queue 的属性配置、路由管理和权限附加。
- [tdt_buffer](./tdt_buffer/README.md)：TDT Buffer 的共享、引用和链式组织。
- [label](./label/README.md)：Label、流跳转和设备端流程控制。
- [group](./group/README.md)：算力 Group 查询与设置。
- [built_in_task](./built_in_task/)：Reduce 与随机数等内建任务。