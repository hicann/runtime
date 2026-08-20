# host_register

本目录聚焦 Host 内存注册、锁页与高性能数据传输相关主题。

## 样例列表

- [0_simple_zero_copy](./0_simple_zero_copy/README.md)：使用映射 Host 内存完成单 Device 向量加法并校验结果。

## 建议关注

- Host 侧注册内存的使用方式。
- 与异步拷贝和流同步配合时的注意事项。
- Host/Device 传输链路中的性能优化思路。

## 可选参考

- [../../1_basic_features/memory/](../../1_basic_features/memory/)：基础内存传输样例。
- [../memory_pool/README.md](../memory_pool/README.md)：高级内存分配与释放方式。
