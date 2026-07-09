# ASCEND\_GLOBAL\_LOG\_LEVEL

## 功能描述

设置应用类日志的日志级别及各模块日志级别，仅支持调试日志。

取值为：

- 0：对应DEBUG级别。
- 1：对应INFO级别。
- 2：对应WARNING级别。
- 3：对应ERROR级别，默认为ERROR级别。
- 4：对应NULL级别，不输出日志。
- 其他值为非法值。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_GLOBAL\_LOG\_LEVEL**命令可以查看环境变量设置的日志级别。
>- 若环境变量未配置/配置为非法值/配置为空，采用默认日志级别。
>- 设置为DEBUG级别后，可能会因为日志流量过大影响业务性能。

## 配置示例

```sh
export ASCEND_GLOBAL_LOG_LEVEL=1
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
<!-- @ref: runtime/res/docs/05_env-vars/ASCEND_GLOBAL_LOG_LEVEL_res.md#id1 -->
