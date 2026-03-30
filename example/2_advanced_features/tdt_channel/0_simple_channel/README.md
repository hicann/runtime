# 0_simple_channel

## 概述

本示例演示 TDT Channel 基础数据传输，覆盖 Channel、Dataset、DataItem 的创建、发送、接收和数据校验流程。

## 产品支持情况

本样例关键接口在不同产品上的支持情况如下：

| 接口 | Atlas A3 训练系列产品/Atlas A3 推理系列产品 | Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| --- | --- | --- |
| acltdtCreateChannel | x | x |
| acltdtCreateDataItem | √ | √ |
| acltdtCreateDataset | √ | √ |
| acltdtAddDataItem | √ | √ |
| acltdtSendTensor | √ | √ |
| acltdtReceiveTensor | √ | √ |
| acltdtGetDataItem | √ | √ |
| acltdtGetDatasetSize | √ | √ |
| acltdtGetDataAddrFromItem | √ | √ |
| acltdtGetDataSizeFromItem | √ | √ |
| acltdtGetDataTypeFromItem | √ | √ |
| acltdtGetDimNumFromItem | √ | √ |
| acltdtGetDimsFromItem | √ | √ |
| acltdtGetTensorTypeFromItem | √ | √ |
| acltdtQueryChannelSize | √ | √ |
| acltdtStopChannel | √ | √ |
| acltdtCleanChannel | √ | √ |
| acltdtDestroyDataset | √ | √ |
| acltdtDestroyDataItem | √ | √ |
| acltdtDestroyChannel | √ | √ |

如需在当前产品上体验 TDT Channel，可参考 [1_channel_capacity](../1_channel_capacity/README.md)。

## 功能说明

- 创建一个 TDT Channel 并构造浮点 Tensor 对应的 DataItem。
- 使用 Dataset 封装单个 Tensor 并通过 Channel 发送。
- 在同一进程中接收 Dataset，并读取维度、数据类型、数据地址和首元素值。
- 查询 Channel 当前尺寸，并完成停止、清理与销毁。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Channel与Dataset创建
    - 调用acltdtCreateChannel接口创建TDT Channel。
    - 调用acltdtCreateDataItem接口基于Tensor数据构造DataItem。
    - 调用acltdtCreateDataset和acltdtAddDataItem接口封装Dataset。
- Tensor收发与信息查询
    - 调用acltdtSendTensor和acltdtReceiveTensor接口完成Dataset的发送和接收。
    - 调用acltdtGetDatasetSize和acltdtGetDataItem接口读取Dataset中的DataItem。
    - 调用acltdtGetDataAddrFromItem、acltdtGetDataSizeFromItem、acltdtGetDataTypeFromItem、acltdtGetTensorTypeFromItem、acltdtGetDimNumFromItem和acltdtGetDimsFromItem接口查看Tensor数据、数据类型和维度信息。
- Channel状态与资源释放
    - 调用acltdtQueryChannelSize接口查询Channel当前大小。
    - 调用acltdtStopChannel、acltdtCleanChannel和acltdtDestroyChannel接口停止、清理并销毁Channel。
    - 调用acltdtDestroyDataItem和acltdtDestroyDataset接口释放Dataset资源。

## 已知 issue

暂无。
