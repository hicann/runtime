# ASCEND\_SLOG\_PRINT\_TO\_STDOUT（废弃）

> [!WARNING]废弃说明
>
> ASCEND\_SLOG\_PRINT\_TO\_STDOUT环境变量在CANN 9.2.0版本标记废弃，将在13.0.0版本删除，替换为：[**ASCEND\_LOG\_PRINT\_TO\_STDOUT**](ASCEND_LOG_PRINT_TO_STDOUT.md)。
>
> 不建议用户使用，以防止引发兼容性问题。若同时配置两者，以**ASCEND\_LOG\_PRINT\_TO\_STDOUT**为准。

## 功能描述

是否开启Host侧应用类日志打印。开启后，日志将不会保存在log文件中，而是将产生的日志直接打印显示。

取值为：

- 0：关闭日志打印，即日志采用默认输出方式，将日志保存在log文件中。
- 1：开启日志打印。
- 其他值为非法值。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_SLOG\_PRINT\_TO\_STDOUT**命令可以查看环境变量设置的值。
>- 若环境变量未配置/配置为非法值/配置为空，表示采用日志默认输出方式。

## 配置示例

```sh
export ASCEND_SLOG_PRINT_TO_STDOUT=1
```

## 使用约束

无

## 支持的型号

全量芯片支持
