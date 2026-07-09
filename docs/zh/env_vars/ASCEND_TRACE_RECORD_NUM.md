# ASCEND\_TRACE\_RECORD\_NUM

## 功能描述

设置trace日志文件的老化规格，取值范围\[10, 1000\]。

具体指`$HOME/ascend/atrace/trace_{进程组pid}_{首次加载trace动态库的进程pid}_{首次加载trace动态库的时间戳}/`目录下`schedule_event_{当前进程pid}_{目录生成时的时间戳}`子目录的老化规格。Host侧的trace日志文件和Device侧的trace日志文件分开计数，配置后将分别控制Host和Device的目录数量。

## 配置示例

```sh
export ASCEND_TRACE_RECORD_NUM=15
```

表示`$HOME/ascend/atrace/trace_{进程组pid}_{首次加载trace动态库的进程pid}_{首次加载trace动态库的时间戳}/`下最多生成15个名称为`schedule_event_{当前进程pid}_{目录生成时的时间戳}`的目录。超过该目录数量后，会自动删除时间戳较老的目录。

## 使用约束

无。

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
