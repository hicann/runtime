# ASCEND\_SLOG\_PRINT\_TO\_STDOUT

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

<!-- npu="910" id1 -->
Atlas 训练系列产品
<!-- end id1 -->

<!-- npu="310p" id2 -->
Atlas 推理系列产品
<!-- end id2 -->

<!-- npu="910b" id3 -->
Atlas A2 训练系列产品/Atlas A2 推理系列产品
<!-- end id3 -->

<!-- npu="A3" id4 -->
Atlas A3 训练系列产品/Atlas A3 推理系列产品
<!-- end id4 -->

<!-- npu="950" id5 -->
Ascend 950PR/Ascend 950DT
<!-- end id5 -->

<!-- npu="310b" id6 -->
Atlas 200I/500 A2 推理产品
<!-- end id6 -->