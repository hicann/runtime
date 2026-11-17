# ASCEND\_SLOG\_PRINT\_TO\_STDOUT（废弃）

> [!WARNING]废弃说明
>
> ASCEND\_SLOG\_PRINT\_TO\_STDOUT环境变量在CANN 9.2.0版本标记为废弃，将在2027年9月30日之后的版本删除，替换为：[**ASCEND\_LOG\_PRINT\_TO\_STDOUT**](ASCEND_LOG_PRINT_TO_STDOUT.md)。
>
> 不建议用户使用，以防止引发兼容性问题。若同时配置两者，以**ASCEND\_LOG\_PRINT\_TO\_STDOUT**为准。

## 功能描述

是否开启Host侧应用类日志打屏。开启后，日志将直接打屏显示，不会保存到log文件中。

取值为：

- 0：关闭日志打屏，即日志采用默认输出方式，将日志保存在log文件中。
- 1：开启日志打屏。
- 其他值为非法值。

> [!NOTE]说明
>
 >- 通过执行**echo $ASCEND\_SLOG\_PRINT\_TO\_STDOUT**命令可以查看环境变量设置的值。
 >- 若环境变量未配置/配置为非法值/配置为空，表示采用日志默认输出方式（仅落盘，不打屏）。
 >- 本变量不支持按级别打屏（取值2/3）与“打屏同步落盘”行为，相关能力仅在[**ASCEND\_LOG\_PRINT\_TO\_STDOUT**](ASCEND_LOG_PRINT_TO_STDOUT.md)上提供。

## 配置示例

```sh
export ASCEND_SLOG_PRINT_TO_STDOUT=1
```

## 使用约束

无

## 支持的型号

全量芯片支持
