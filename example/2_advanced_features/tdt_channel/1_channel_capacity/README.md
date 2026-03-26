# 1_channel_capacity

## 概述

本示例演示带容量限制的 TDT Channel，重点观察容量查询、清理与停止操作，以及切片信息和 Tensor 类型查询。

## 功能说明

- 创建一个容量为 1 的 Channel。
- 发送第一份 Dataset 后查询通道大小。
- 尝试再次发送 Dataset 观察容量受限时的返回结果。
- 调用 SliceInfo、TensorType 和 DatasetName 查询接口补充检查。
- 完成 Channel 清理、停止和销毁。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

## 运行前环境变量

运行 bash run.sh 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```
## 相关 API

- acltdtCreateChannelWithCapacity
- acltdtQueryChannelSize
- acltdtSendTensor
- acltdtGetSliceInfoFromItem / acltdtGetTensorTypeFromItem / acltdtGetDatasetName
- acltdtCleanChannel / acltdtStopChannel / acltdtDestroyChannel

## 已知 issue

暂无。
