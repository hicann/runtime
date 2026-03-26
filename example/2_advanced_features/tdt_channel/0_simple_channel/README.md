# 0_simple_channel

## 概述

本示例演示 TDT Channel 基础数据传输，覆盖 Channel、Dataset、DataItem 的创建、发送、接收和数据校验流程。

## 功能说明

- 创建一个 TDT Channel 并构造浮点 Tensor 对应的 DataItem。
- 使用 Dataset 封装单个 Tensor 并通过 Channel 发送。
- 在同一进程中接收 Dataset，并读取维度、数据类型、数据地址和首元素值。
- 查询 Channel 当前尺寸，并完成停止、清理与销毁。

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

- acltdtCreateChannel / acltdtDestroyChannel
- acltdtSendTensor / acltdtReceiveTensor
- acltdtCreateDataItem / acltdtDestroyDataItem
- acltdtCreateDataset / acltdtDestroyDataset / acltdtAddDataItem
- acltdtGetDataItem / acltdtGetDatasetSize
- acltdtGetDataAddrFromItem / acltdtGetDataSizeFromItem / acltdtGetDataTypeFromItem
- acltdtGetDimNumFromItem / acltdtGetDimsFromItem
- acltdtQueryChannelSize / acltdtStopChannel / acltdtCleanChannel

## 已知 issue

暂无。
