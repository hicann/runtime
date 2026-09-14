# adump

`adump`目录聚焦Dump相关能力，当前按“算子信息统计 -> 回调Dump -> 配置式Dump -> 异常算子Dump”递进组织：

## 文件解读

Dump文件路径、转换命令和字段含义请参见[Dump文件解读](./dump_artifact_analysis.md)。

## 样例列表

- [0_adump_args](./0_adump_args/README.md)：使用 `aclopStartDumpArgs` / `aclopStopDumpArgs` 对单算子参数进行 Dump，并查询当前 Dump 输出路径。
- [1_adump_callback](./1_adump_callback/README.md)：使用 `acldumpRegCallback` / `acldumpUnregCallback` 通过回调接收 Dump 数据，并演示 `acldumpChunk` 的基础解析。
- [2_model_dump_config](./2_model_dump_config/README.md)：使用 `aclmdlInitDump` / `aclmdlSetDump` / `acldumpGetPath` / `aclmdlFinalizeDump` 演示配置式 Dump。
- [3_save_exception_info](./3_save_exception_info/README.md)：使用 `acldumpGetExceptionInfoPath` / `acldumpSaveExceptionInfo` 将自定义 tensor 数据主动落盘到 Exception Dump 路径下。
