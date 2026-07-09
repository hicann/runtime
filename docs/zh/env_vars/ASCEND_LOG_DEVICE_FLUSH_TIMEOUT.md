# ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT

## 功能描述

指定Device侧应用类日志回传到Host侧的延时时间。

业务进程退出前，系统有2000ms的默认延时将Device侧应用类日志回传到Host侧，超时后业务进程退出。未回传到Host侧的日志直接在Device侧落盘（路径为/var/log/npu/slog）。通过该环境变量可以修改该延时时间，取值范围为\[0, 180000\]，单位为ms，默认值为2000。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_LOG\_DEVICE\_FLUSH\_TIMEOUT**命令可以查看环境变量设置的值。
>- 若环境变量未配置/配置为非法值/配置为空，表示采用日志默认值。
>- 如果业务进程不需要等待所有Device侧应用类日志回传到Host侧，可将环境变量设置为0。
>- 针对业务进程退出后仍然有Device侧应用类日志未回传到Host侧的情况，建议设置更大的延时时间，具体调节的大小可以根据device-app-pid的日志内容进行判断。

## 配置示例

```sh
export ASCEND_LOG_DEVICE_FLUSH_TIMEOUT=5000
```

## 使用约束

仅适用于Ascend EP标准形态

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
