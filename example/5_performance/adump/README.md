# adump

`adump` 目录聚焦 Dump 相关能力，当前按“参数Dump -> 回调Dump -> 配置式Dump”递进组织：

## 样例列表

- [0_adump_args](./0_adump_args/README.md)：使用 `aclopStartDumpArgs` / `aclopStopDumpArgs` 对单算子参数进行 Dump，并查询当前 Dump 输出路径。
- [1_adump_callback](./1_adump_callback/README.md)：使用 `acldumpRegCallback` / `acldumpUnregCallback` 通过回调接收 Dump 数据，并演示 `acldumpChunk` 的基础解析。
- [2_model_dump_config](./2_model_dump_config/README.md)：使用 `aclmdlInitDump` / `aclmdlSetDump` / `acldumpGetPath` / `aclmdlFinalizeDump` 演示配置式 Dump。
