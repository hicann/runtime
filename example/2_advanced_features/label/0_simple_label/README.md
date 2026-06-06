# 0_simple_label

## 描述

本样例展示 CANN Runtime Label 管理的基础使用流程，包括创建 Label、组装 LabelList、在模型运行实例绑定的持久化 Stream 上设置 Label，并按 Device 内存中的索引执行 Label 切换。运行后可以看到模型运行实例构建、执行和资源释放完成的日志。

## 产品支持情况

本样例在以下产品上的支持情况如下：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

环境安装、环境变量配置和通用运行说明请参见 example 目录下的 [README](../../../README.md)。可提前执行 `source <cann_path>/set_env.sh` 设置 CANN 环境变量；如果未提前设置，`run.sh` 会自动尝试探测 `ASCEND_INSTALL_PATH`、`ASCEND_HOME_PATH`、`$HOME/Ascend/cann`、`/usr/local/Ascend/cann` 和 `/opt/Ascend/cann`。

进入当前样例目录后，执行以下命令运行样例：

```bash
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 与 Context 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtCreateContext` 接口创建 Context。
    - 调用 `aclrtDestroyContext` 接口销毁 Context。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- Stream 管理
    - 调用 `aclrtCreateStreamWithConfig` 接口创建持久化 Stream。
    - 调用 `aclrtCreateStream` 接口创建执行模型运行实例的 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上任务执行完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
- 内存管理
    - 调用 `aclrtMalloc` 接口申请 Device 内存。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口将 Host 侧分支索引写入 Device 内存。
- 模型运行实例管理
    - 调用 `aclmdlRIBuildBegin` 和 `aclmdlRIBuildEnd` 接口开始和结束模型运行实例构建。
    - 调用 `aclmdlRIBindStream` 和 `aclmdlRIUnbindStream` 接口绑定和解绑持久化 Stream。
    - 调用 `aclmdlRIEndTask` 接口标记绑定 Stream 上的任务下发结束。
    - 调用 `aclmdlRIExecuteAsync` 接口异步执行模型运行实例。
    - 调用 `aclmdlRIDestroy` 接口销毁模型运行实例。
- Label 管理
    - 调用 `aclrtCreateLabel` 和 `aclrtDestroyLabel` 接口创建并释放 Label（Ascend 950PR/Ascend 950DT、Atlas A2支持，Atlas A3不支持）。
    - 调用 `aclrtCreateLabelList` 和 `aclrtDestroyLabelList` 接口组装并释放 LabelList（Ascend 950PR/Ascend 950DT、Atlas A2支持，Atlas A3不支持）。
    - 调用 `aclrtSetLabel` 接口在模型运行实例绑定的 Stream 上设置 Label（Ascend 950PR/Ascend 950DT、Atlas A2支持，Atlas A3不支持）。
    - 调用 `aclrtSwitchLabelByIndex` 接口根据 Device 内存中的分支索引执行 Label 切换（Ascend 950PR/Ascend 950DT、Atlas A2支持，Atlas A3不支持）。

## 示例输出

```text
[INFO]  ACL initialized.
[INFO]  Device 0 selected.
[INFO]  Context created on device 0.
[INFO]  Persistent label stream created.
[INFO]  Execute stream created.
[INFO]  Model runtime instance build started.
[INFO]  Persistent label stream bound to the model runtime instance.
[INFO]  Allocated device memory for branch index.
[INFO]  Copied branch index 1 from host to device.
[INFO]  Created label 0.
[INFO]  Created label 1.
[INFO]  Created label list with 2 labels.
[INFO]  Submitted switch-label task with branch index 1.
[INFO]  Set label 0 on the persistent stream.
[INFO]  Set label 1 on the persistent stream.
[INFO]  Model runtime instance build finished.
[INFO]  Switch label executed successfully with branch index 1.
[INFO]  Run the simple_label sample successfully.
```
