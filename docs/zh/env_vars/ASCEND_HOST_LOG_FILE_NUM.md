# ASCEND\_HOST\_LOG\_FILE\_NUM

## 功能描述

Ascend EP场景下，设置应用类日志目录（plog和device-id）下存储每个进程日志文件的数量。

环境变量取值范围为\[1, 1000\]，默认值为10。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_HOST\_LOG\_FILE\_NUM**命令可以查看环境变量设置的值。
>- 若环境变量未配置/配置为非法值/配置为空，表示采用日志默认值。
>- 如果plog和device-id日志目录下存储的单个进程的日志文件数量超过设置的值，将会自动删除最早的日志。另外每个plog-_pid_\_\*.log或device-_pid_\_\*.log日志文件的大小最大固定为20MB。如果超过该值，会生成新的日志文件。

## 配置示例

```sh
export ASCEND_HOST_LOG_FILE_NUM=20
```

## 使用约束

仅适用于Ascend EP形态

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
