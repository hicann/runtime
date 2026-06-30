# 1_ipcevent_multi_device

## 描述
本样例展示了在**多个Device**上通过 **IPC Event** 进行跨进程任务同步。  
- **生产者进程（proc_a）**：运行在Device 0上，创建一个IPC Event，记录事件并导出句柄到文件，然后等待所有消费者进程完成。  
- **消费者进程（proc_b）**：运行在其他Device（如Device 1、Device 2...）上，每个消费者读取事件句柄，打开事件，在Stream中等待该事件，然后记录事件并通知生产者。  

通过这种方式，一个生产者可以同步多个运行在不同Device上的消费者，实现分布式任务协调。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

环境安装详情以及通用运行步骤请见 example 目录下的 [README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh

# 编译运行
bash run.sh
```

本样例至少需要 2 个可用 Device。`run.sh` 中 `CONSUMER_NUM` 默认配置为 1，表示生产者使用 Device 0，消费者使用 Device 1；如需启动更多消费者，请根据实际可用 Device 数量调整 `CONSUMER_NUM`。
启动进程前，`run.sh` 会调用 `aclrtGetDeviceCount` 检查可用 Device 数量；若设备数不足，将输出 `[SKIP]` 提示并以退出码 0 结束，便于自动化框架识别为环境不满足而非用例失败。

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtResetDevice` 接口复位当前运算的 Device，回收 Device 上的资源。

    说明：本样例为单机多进程 IPC 场景，进程退出时使用 `aclrtResetDevice` 释放当前进程的 Device 资源，避免 `aclrtResetDeviceForce` 强制复位影响同机其他进程。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上的任务完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
- Event 管理
    - 调用 `aclrtCreateEventExWithFlag` 接口创建支持 IPC 的 Event。
    - 调用 `aclrtRecordEvent` 接口记录 Event。
    - 调用 `aclrtSynchronizeEvent` 接口阻塞等待 Event 完成。
    - 调用 `aclrtQueryEventStatus` 接口查询 Event 状态。
    - 调用 `aclrtIpcGetEventHandle` 接口获取 Event 的 IPC 句柄。
    - 调用 `aclrtIpcOpenEventHandle` 接口打开 IPC Event。
    - 调用 `aclrtStreamWaitEvent` 接口阻塞 Stream，等待 Event 完成。
    - 调用 `aclrtDestroyEvent` 接口销毁 Event。

## 示例输出

```text
[INFO] Starting producer on device 0, waiting for 1 consumer(s)...
[INFO] Starting consumer 1 on device 1
[INFO]  Consumer 1: IPC event opened on device 1
[INFO]  Consumer 1: event received, stream synchronized
[INFO]  Consumer 1: event status = 1 (1=completed)
[INFO]  Consumer 1 (device 1) finished successfully.
[INFO]  Producer: IPC event created on device 0
[INFO]  Producer: event status = 1 (1=completed)
[INFO]  All 1 consumers have finished.
[INFO]  Producer: finished successfully.
[SUCCESS] IPC event multi-device synchronization works correctly.
```
