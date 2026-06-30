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

- 创建一个容量为 2 的 Channel，以满足接口文档要求的最小容量限制。
- 发送第一份 Dataset 后查询通道大小。
- 以非阻塞方式继续发送 Dataset，观察容量受限时的返回结果；如果第二次发送成功，则继续第三次发送直到触发容量压力。
- 调用 SliceInfo、TensorType 和 DatasetName 查询接口补充检查。
- 完成 Channel 清理、停止和销毁。

## 说明

在当前 Runtime 未启用队列式 TDT Channel 能力、相关依赖未就绪，或底层队列初始化/创建失败时，`acltdtCreateChannelWithCapacity` 可能返回 `nullptr`。样例当前会将该情况记录为告警，跳过容量受限演示流程，并在完成清理后正常退出。

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
    - 调用acltdtCreateChannelWithCapacity接口创建带容量限制的Channel，并将容量设置为文档允许的最小值 2。
    - 调用acltdtCreateDataItem、acltdtCreateDataset和acltdtAddDataItem接口构造Dataset。
- Tensor发送与容量查询
    - 调用acltdtSendTensor接口发送第一份Dataset，并调用acltdtQueryChannelSize接口查询Channel当前大小。
    - 在非阻塞模式下继续调用acltdtSendTensor接口，观察当前环境下何时触发容量受限返回结果。
- 附加信息查询
    - 调用acltdtGetDataItem和acltdtGetDatasetSize接口读取Dataset中的DataItem。
    - 调用acltdtGetSliceInfoFromItem、acltdtGetTensorTypeFromItem和acltdtGetDatasetName接口查看Slice信息、Tensor类型和Dataset名称。
- Channel清理与资源释放
    - 调用acltdtCleanChannel、acltdtStopChannel和acltdtDestroyChannel接口清理、停止并销毁Channel。
    - 调用acltdtDestroyDataItem和acltdtDestroyDataset接口释放Dataset资源。

## 示例输出

```text
[INFO]  Slice info ret=..., sliceNum=..., sliceId=..., tensorType=..., datasetName=...
[INFO]  Channel size after first send: 1
[INFO]  Channel size after second send: 2
[INFO]  Third send ret under capacity pressure: ...
[INFO]  Run the channel_capacity sample successfully.
```

若当前运行环境未启用容量受限 TDT Channel 能力，可能输出如下告警并正常结束：

```text
[WARN]  acltdtCreateChannelWithCapacity returned nullptr: the current runtime likely does not enable capacity-limited TDT channels on this product/build
```

## 已知 issue

暂无。
