# 样例归类矩阵

## 顶层章节

| 章节 | 适用场景 | 常见主题 |
| --- | --- | --- |
| `example/0_quickstart` | 最小闭环、首次接触的入门样例 | hello world、错误处理、版本查询、运行模式、兼容性 |
| `example/1_basic_features` | Runtime 基础对象与生命周期 | device、context、stream、event、memory |
| `example/2_advanced_features` | 面向能力族的高级特性 | kernel、model_ri、callback、notify、label、built_in_task |
| `example/3_memory_advanced` | 高级内存管理模式 | allocator、memory_pool、cache maintenance、host register、managed memory |
| `example/4_reliability` | 稳定性与故障处理 | snapshot、overflow detection、error recovery、fault tolerant execution |
| `example/5_performance` | 性能观测、分析与 dump | profiling、adump |
| `example/6_scenarios` | 端到端场景样例 | training pipeline、inference pipeline、fault tolerant exec |

## 归类规则

- 环境初始化、版本查询、运行模式、错误提示等入门内容，优先归到 `0_quickstart`。
- 围绕 Runtime 基础对象的操作，归到 `1_basic_features`。
- 需要多对象协同或按能力族组织的主题，归到 `2_advanced_features`。
- 面向内存调优或特殊内存模型的主题，归到 `3_memory_advanced`。
- 面向恢复、容错、检测的主题，归到 `4_reliability`。
- 面向 profiling、dump、观测的主题，归到 `5_performance`。
- 面向流水线和场景化整合的主题，归到 `6_scenarios`。

## 本仓库中的典型落点

- `aclGetRecentErrMsg`、`aclrtGetLastError` 适合放在 `example/0_quickstart/1_error_handling`。
- `aclrtGetVersion`、`aclsysGetVersionStr`、`aclsysGetVersionNum`、`aclrtGetRunMode` 适合放在 `example/0_quickstart/2_system_info`。
- `acldump*` 相关扩展适合放在 `example/5_performance/adump`。

## 命名规则

- 当主题仍属于现有能力族时，优先复用已有主题目录。
- 当主题值得单独讲解时，在该目录下新增编号样例。
- 编号只在当前主题目录内保持局部稳定，不跨目录追求全局连续。
