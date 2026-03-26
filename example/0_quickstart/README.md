# 0_quickstart

本章节用于帮助开发者快速建立对 Runtime 样例工程的整体认识，先从最小闭环跑通，再补充错误处理、系统信息和兼容性相关主题。

## 当前可运行样例

- [0_hello_cann](./0_hello_cann/README.md)：最基础的 Runtime Hello World，展示初始化、建流、执行算子、同步、DataBuffer 包装和资源释放。
- [1_error_handling](./1_error_handling/README.md)：展示统一错误检查宏、最近错误描述、Peek/GetLastError 以及详细错误信息的获取方式。
- [2_system_info](./2_system_info/README.md)：展示版本查询、运行模式判断、数据类型大小与 float16/float32 转换。
- [4_custom_kernel_launch](./4_custom_kernel_launch/README.md)：提供 CANN `<<<>>>` 自定义 Kernel 调用的最小可运行样例。

## 相关主题

- [3_cross_version](./3_cross_version/README.md)：跨版本编译、接口差异适配和兼容性处理。
