# ASCEND\_LOG\_PRINT\_TO\_STDOUT

## 功能描述

是否开启Host侧应用类日志打屏，并指定打屏的日志级别。开启后，日志在打屏显示的同时，也会同步保存一份到log文件中。

取值为：

- 0：关闭日志打屏，即日志采用默认输出方式，仅将日志保存在log文件中。
- 1：开启日志打屏，所有通过日志级别控制的日志均打屏显示。
- 2：开启日志打屏，仅WARNING、ERROR级别的日志打屏显示。
- 3：开启日志打屏，仅ERROR级别的日志打屏显示。
- 其他值为非法值。

> [!NOTE]说明
>
 >- 通过执行**echo $ASCEND\_LOG\_PRINT\_TO\_STDOUT**命令可以查看环境变量设置的值。
 >- 若环境变量未配置/配置为非法值/配置为空，表示采用日志默认输出方式（仅落盘，不打屏）。
 >- 旧变量[**ASCEND\_SLOG\_PRINT\_TO\_STDOUT**](ASCEND_SLOG_PRINT_TO_STDOUT_deprecated.md)（已废弃）不支持按级别打屏（取值2/3）与“打屏同步落盘”行为，仅保持原有0/1开关语义（=1时只打屏不落盘）。
 >- Event日志为独立级别（落盘由[**ASCEND\_GLOBAL\_EVENT\_ENABLE**](ASCEND_GLOBAL_EVENT_ENABLE.md)控制）：=1时事件日志随打屏输出；=2/3时事件日志不参与级别阈值过滤、不上屏。
 >- 打屏开启时，日志在打屏的同时仍会保存到log文件中；实际打屏的日志级别由该环境变量与[**ASCEND\_GLOBAL\_LOG\_LEVEL**](ASCEND_GLOBAL_LOG_LEVEL.md)共同决定，取两者中较高的级别。例如：
 >- ASCEND\_GLOBAL\_LOG\_LEVEL=3，ASCEND\_LOG\_PRINT\_TO\_STDOUT=2时，打屏日志级别为ERROR，debug类日志落盘级别为ERROR。
 >- ASCEND\_GLOBAL\_LOG\_LEVEL=2，ASCEND\_LOG\_PRINT\_TO\_STDOUT=3时，打屏日志级别为ERROR，debug类日志落盘级别为WARNING。

## 配置示例

```sh
export ASCEND_LOG_PRINT_TO_STDOUT=2
```

## 使用约束

无

## 支持的型号

全量芯片支持
