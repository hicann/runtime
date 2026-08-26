# Profiling产物解读

本文介绍Profiling数据采集后的产物目录、解析导出命令和常见字段含义。采集接口的调用顺序和参数约束请参见[Profiling数据采集接口](../api_ref/19-01_data_profiling_apis.md)。

## 产物路径

Profiling采集结果目录由采集方式和路径配置优先级决定：

- 调用`aclprofInit(const char *profilerResultPath, size_t length)`时，`profilerResultPath`指定性能数据保存目录。
- 使用`msprof`命令采集时，`--output`指定采集结果的存放目录。
- `msprof`未指定`--output`且设置了`ASCEND_WORK_PATH`时，结果目录为`ASCEND_WORK_PATH/profiling_data`。
- 通过`msprof [msprof arguments] <app> [app arguments]`启动应用，且未指定`--output`、未设置`ASCEND_WORK_PATH`时，结果保存在当前目录。

以`example/5_performance/profiling/0_create_config`为例，样例将`aclprofInit`的输出路径设置为`./output`。运行结束后，可在样例目录的`output`下查看原始Profiling数据。

## 解析与导出

解析原始采集数据：

```bash
msprof --parse=on --output=<profiling_result_dir>
```

导出解析后的文本或数据库文件：

```bash
msprof --export=on --output=<profiling_result_dir> --summary-format=csv --type=text
msprof --export=on --output=<profiling_result_dir> --summary-format=json --type=text
msprof --export=on --output=<profiling_result_dir> --type=db
```

参数说明：

| 参数 | 说明 |
| --- | --- |
| `--parse=on` | 解析采集阶段生成的原始Profiling数据。 |
| `--export=on` | 导出解析后的性能数据。 |
| `--output` | 指定采集结果的存放目录或待解析结果目录。 |
| `--summary-format` | 指定summary文件格式，支持`csv`和`json`，在`--type=text`时生效。 |
| `--type` | 指定导出类型，支持`text`和`db`；`text`导出文本结果，`db`导出数据库结果。 |
| `--iteration-id` | 导出指定迭代的数据，未指定时默认导出第1次迭代。 |
| `--model-id` | 导出指定模型的数据，未指定时默认导出可访问的最小模型ID。 |

## 常见字段

| 字段 | 含义 | 使用建议 |
| --- | --- | --- |
| `Op Name` / `op_name` | 算子名称。 | 用于定位模型中具体算子，结合模型结构判断是否为预期热点。 |
| `Op Type` / `op_type` | 算子类型。 | 同类型算子可横向比较耗时，识别异常慢算子。 |
| `Task Type` / `task_type` | 任务类型。 | 区分AI Core、AI CPU、Runtime API、通信等数据来源。 |
| `Start Time` / `start_time` | 任务开始时间。 | 与结束时间、时间线视图一起判断并发关系。 |
| `End Time` / `end_time` | 任务结束时间。 | 与开始时间共同判断任务持续区间。 |
| `Duration` / `duration` | 任务耗时。 | 优先关注耗时占比高、重复出现或抖动明显的任务。 |
| `Model ID` / `model_id` | 模型ID。 | 多模型进程中用于区分不同模型的Profiling数据。 |
| `Stream ID` / `stream_id` | Stream标识。 | 用于判断任务是否按预期落在目标Stream。 |
| `Task ID` / `task_id` | Device侧任务标识。 | 与日志或异常信息联合定位具体任务。 |
| `msproftx message` | `aclprofMark`、`aclprofPush`、`aclprofRangeStart`或mstx标记携带的描述。 | 用于把应用自定义阶段映射到性能时间线。 |
| `Domain` | mstx domain名称。 | 用于按domain过滤或归类应用自定义打点。 |

## 分析建议

- 先查看summary中耗时占比最高的算子、Runtime API或通信任务，再结合时间线判断是否存在串行等待。
- 对同一`Op Type`下耗时差异明显的`Op Name`，结合输入shape、数据类型和模型结构进一步定位。
- 对`msproftx`或`mstx`数据，先确认打点消息是否出现在导出结果中，再按消息对应的业务阶段分析耗时。
- 若采集项包含通信数据，优先查看通信summary和通信矩阵，判断是否存在通信耗时集中或通信等待。
