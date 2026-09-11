# 0_quickstart

本章节面向首次接触 Runtime 样例工程的开发者，先通过最小计算闭环跑通编译和执行流程，再补充错误处理、系统信息查询、跨版本兼容和自定义 Kernel 调用等入门主题。

## 样例列表

- [0_hello_cann](./0_hello_cann/README.md)：展示初始化配置、Device/Stream 管理、Tensor 与 DataBuffer 准备、workspace 申请、`aclnnAdd` 向量加法执行、同步等待和资源释放。
- [1_error_handling](./1_error_handling/README.md)：展示统一返回值检查、线程级 Runtime 错误码查询、最近错误描述获取和详细错误摘要查询。
- [2_system_info](./2_system_info/README.md)：展示 Runtime API 版本、CANN 软件包版本、运行模式、float16/float32 转换和数据类型大小查询。
- [4_custom_kernel_launch](./4_custom_kernel_launch/README.md)：展示使用 `<<<>>>` 内核调用符下发自定义 AscendC Kernel 的最小流程。
- [5_runtime_lifecycle_callbacks](./5_runtime_lifecycle_callbacks/README.md)：展示应用插件参与 ACL 初始化与去初始化流程，并通过回调注册、注销和引用计数验证生命周期语义。

## 相关主题

- [3_cross_version](./3_cross_version/README.md)：跨版本编译、接口差异适配和兼容性处理。
