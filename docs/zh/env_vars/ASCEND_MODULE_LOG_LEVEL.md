# ASCEND\_MODULE\_LOG\_LEVEL

## 功能描述

设置应用类日志的各模块日志级别，仅支持调试日志。

格式为：export ASCEND\_MODULE\_LOG\_LEVEL=_module\_name_=_module\_level_

- _module\_name_：为模块名，支持设置为GE、ASCENDCL、DRV、RUNTIME等，详细请参见CANN软件安装目录/include/base/log\_types.h。
- _module\_level_：为对应模块的日志级别，支持设置为如下值。
  - 0：对应DEBUG级别。
  - 1：对应INFO级别。
  - 2：对应WARNING级别。
  - 3：对应ERROR级别。
  - 4：对应NULL级别，不输出日志。
  - 其他值为非法值。

> [!NOTE]说明
>
>- 等号前后无空格，冒号为英文格式且前后无空格；如果同时设置多个模块日志级别，模块间使用冒号间隔。如果命令行格式错误（如存在除等号和冒号以外其他符号）、包括了不支持的模块名称，则命令行整体不生效。
>- 通过执行**echo $ASCEND\_MODULE\_LOG\_LEVEL**命令可以查看环境变量设置的日志级别。
>- 若环境变量未配置/配置为非法值/配置为空，表示采用全局日志级别。ASCEND\_MODULE\_LOG\_LEVEL环境变量优先级高于ASCEND\_GLOBAL\_LOG\_LEVEL，即如果同时设置，则以ASCEND\_MODULE\_LOG\_LEVEL为准。
>- 设置为DEBUG级别后，可能会因为日志流量过大影响业务性能。
>- 该环境变量只针对调试日志生效，对运行日志、安全日志不生效。

## 配置示例

```sh
export ASCEND_MODULE_LOG_LEVEL=TBE=0:RUNTIME=0
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
<!-- @ref: runtime/res/docs/05_env-vars/ASCEND_MODULE_LOG_LEVEL_res.md#id1 -->