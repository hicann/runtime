# cache_maintenance

本目录聚焦缓存维护、一致性控制以及相关性能影响分析主题。

## 样例列表

- [0_prefetch_strategy_comparison](./0_prefetch_strategy_comparison/README.md)：对等价工作集分别执行直接和描述符式预取，并验证计算结果一致。

## 建议关注

- 缓存刷新与一致性相关接口或机制。
- 与数据传输、共享内存配合时的注意事项。
- 性能与一致性之间的权衡。

## 可选参考

- [../memory_pool/README.md](../memory_pool/README.md)：流序内存池与内存管理。
- [../../1_basic_features/memory/](../../1_basic_features/memory/)：基础内存拷贝与共享能力。
