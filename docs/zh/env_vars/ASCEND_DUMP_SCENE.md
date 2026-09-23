# ASCEND_DUMP_SCENE

## 功能描述

在复现问题场景时，使用该环境变量开启异常算子Dump，导出异常算子的输入输出数据、workspace信息和Tiling信息。

支持如下取值：

- aic_err_brief_dump：表示轻量化exception dump，用于导出AI Core错误算子的输入&输出、workspace数据。
- aic_err_norm_dump：表示普通exception dump，在轻量化exception dump基础上，还会导出Shape、Data Type、Format以及属性信息。
- aic_err_detail_dump：在轻量化exception dump基础上，还会导出AI Core的内部存储、寄存器以及调用栈信息。

    配置该选项时，有以下注意事项：

  - 该选项仅支持以下型号：

    <!-- npu="910b" id1 -->
    Atlas A2系列产品
    <!-- end id1 -->

    <!-- npu="A3" id2 -->
    Atlas A3系列产品
    <!-- end id2 -->

    <!-- npu="950" id3 -->
    Ascend 950PR&950DT系列产品
    <!-- end id3 -->

  - 导出dump文件过程中，会暂停问题算子所在的AI Core，因此可能会影响Device上其他业务进程的正常执行，导出dump文件后，会自行恢复AI Core。
  - 导出dump文件后，会强制退出Host侧用户业务进程，强制退出过程中的报错可不作为AI Core问题分析的输入。
  - 配置aic_err_detail_dump选项后，如果生成了dump文件，但不是\*.core文件，则表示aic_err_detail_dump对应的功能没有启动成功，系统自动切换为按aic_err_brief_dump选项进行dump。

## 配置示例

```bash
export ASCEND_DUMP_SCENE=aic_err_brief_dump
```

## 使用约束

- 开启异常算子Dump功能有多种方式，优先级从高到低依次为：ASCEND_DUMP_SCENE环境变量 \> NPU_COLLECT_PATH环境变量 \> 配置文件（aclInit接口、aclmdlSetDump接口）。
- 通过此环境变量导出的dump信息存储路径，优先级从高到低依次为：ASCEND_DUMP_PATH环境变量 \> ASCEND_WORK_PATH环境变量 \> 默认路径（应用程序的当前执行目录）。

## 支持的型号

全量芯片支持
