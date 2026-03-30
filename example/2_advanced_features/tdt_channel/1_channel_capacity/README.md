# 1_channel_capacity

## 概述

本示例演示带容量限制的 TDT Channel，重点观察容量查询、清理与停止操作，以及切片信息和 Tensor 类型查询。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

- 创建一个容量为 1 的 Channel。
- 发送第一份 Dataset 后查询通道大小。
- 尝试再次发送 Dataset 观察容量受限时的返回结果。
- 调用 SliceInfo、TensorType 和 DatasetName 查询接口补充检查。
- 完成 Channel 清理、停止和销毁。

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
- 容量受限Channel创建
    - 调用acltdtCreateChannelWithCapacity接口创建带容量限制的Channel。
    - 调用acltdtCreateDataItem、acltdtCreateDataset和acltdtAddDataItem接口构造Dataset。
- Tensor发送与容量查询
    - 调用acltdtSendTensor接口发送Dataset，并观察容量受限时的返回结果。
    - 调用acltdtQueryChannelSize接口查询Channel当前大小。
- 附加信息查询
    - 调用acltdtGetDataItem和acltdtGetDatasetSize接口读取Dataset中的DataItem。
    - 调用acltdtGetSliceInfoFromItem、acltdtGetTensorTypeFromItem和acltdtGetDatasetName接口查看Slice信息、Tensor类型和Dataset名称。
- Channel清理与资源释放
    - 调用acltdtCleanChannel、acltdtStopChannel和acltdtDestroyChannel接口清理、停止并销毁Channel。
    - 调用acltdtDestroyDataItem和acltdtDestroyDataset接口释放Dataset资源。

## 已知 issue

暂无。
