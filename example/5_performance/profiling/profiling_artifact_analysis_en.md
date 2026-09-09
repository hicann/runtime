# Profiling Artifact Analysis

This document describes artifact directories, parsing and export commands, and common field meanings after Profiling data collection. For API usage sequence and parameter constraints, see the [Profiling API reference](../../../docs/zh/api_ref/19-01_data_profiling_apis.md); for sample entry points, see the [Profiling samples](./README_en.md).

## Artifact Paths

Profiling result directories depend on the collection method and path configuration priority:

- When `aclprofInit(const char *profilerResultPath, size_t length)` is called, `profilerResultPath` specifies the performance data output directory.
- When the `msprof` command is used for collection, `--output` specifies the collection result directory.
- If `msprof` does not specify `--output` and `ASCEND_WORK_PATH` is set, the result directory is `ASCEND_WORK_PATH/profiling_data`.
- If an application is started by `msprof [msprof arguments] <app> [app arguments]`, and neither `--output` nor `ASCEND_WORK_PATH` is specified, the result is saved in the current directory.

For example, `example/5_performance/profiling/0_create_config` sets the `aclprofInit` output path to `./output`. After the sample finishes, the raw Profiling data is generated in the sample's `output` directory.

## Parsing and Export

Parse raw collection data:

```bash
msprof --parse=on --output=<profiling_result_dir>
```

Export parsed text or database files:

```bash
msprof --export=on --output=<profiling_result_dir> --summary-format=csv --type=text
msprof --export=on --output=<profiling_result_dir> --summary-format=json --type=text
msprof --export=on --output=<profiling_result_dir> --type=db
```

| Parameter | Description |
| --- | --- |
| `--parse=on` | Parses raw Profiling data generated during collection. |
| `--export=on` | Exports parsed performance data. |
| `--output` | Specifies the collection result directory or the result directory to be parsed. |
| `--summary-format` | Specifies the summary file format. `csv` and `json` are supported when `--type=text` is used. |
| `--type` | Specifies the export type. `text` exports text results, and `db` exports database results. |
| `--iteration-id` | Exports data of the specified iteration. If omitted, the first iteration is exported by default. |
| `--model-id` | Exports data of the specified model. If omitted, the minimum accessible model ID is exported by default. |

## Common Fields

| Field | Meaning | Analysis suggestion |
| --- | --- | --- |
| `Op Name` / `op_name` | Operator name. | Locate a specific operator in the model and determine whether it is an expected hotspot. |
| `Op Type` / `op_type` | Operator type. | Compare operators of the same type to identify abnormally slow operators. |
| `Task Type` / `task_type` | Task type. | Distinguishes AI Core, AI CPU, Runtime API, communication, and other data sources. |
| `Start Time` / `start_time` | Task start time. | Use with the end time and timeline view to determine concurrency. |
| `End Time` / `end_time` | Task end time. | Use with the start time to determine the task duration interval. |
| `Duration` / `duration` | Task duration. | Focus on tasks with a high duration ratio, repeated occurrences, or obvious jitter. |
| `Model ID` / `model_id` | Model ID. | Distinguishes Profiling data of different models in a multi-model process. |
| `Stream ID` / `stream_id` | Stream identifier. | Determines whether a task is executed on the expected stream. |
| `Task ID` / `task_id` | Device-side task identifier. | Use with logs or exception information to locate a specific task. |
| `msproftx message` | Description carried by `aclprofMark`, `aclprofPush`, `aclprofRangeStart`, or mstx markers. | Maps custom application phases to the performance timeline. |
| `Domain` | mstx domain name. | Filters or classifies custom application markers by domain. |

## Analysis Suggestions

- First check the operators, Runtime APIs, or communication tasks with the highest duration ratio in the summary, and then use the timeline to determine whether serial waiting exists.
- For `Op Name` values with obvious duration differences under the same `Op Type`, further locate the issue together with input shape, data type, and model structure.
- For `msproftx` or `mstx` data, first confirm that marker messages appear in the exported results, and then analyze the duration by business phase.
- If communication data is collected, first check the communication summary and communication matrix to determine whether communication time or communication waiting is concentrated.
