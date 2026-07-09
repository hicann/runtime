# ASCEND\_PROCESS\_LOG\_PATH

## 功能描述

设置日志落盘路径。

日志存储时如果不存在该目录，会自动创建该目录；如果存在则直接存储。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_PROCESS\_LOG\_PATH**命令可以查看环境变量设置的路径。
>- 日志落盘优先级为：ASCEND\_PROCESS\_LOG\_PATH \> ASCEND\_WORK\_PATH \> 日志默认存储路径（$HOME/ascend/log）

## 配置示例

```sh
export ASCEND_PROCESS_LOG_PATH=$HOME/log/
```

可指定日志落盘路径为任意有读写权限的目录。

## 使用约束

仅适用于Ascend EP模式

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