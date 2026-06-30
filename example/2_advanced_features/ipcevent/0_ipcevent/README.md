# 0_ipcevent

## 描述
本样例展示了两个进程之间通过 **IPC Event** 进行任务同步。  
- 进程A（生产者）：创建IPC事件，记录事件并导出句柄，然后等待消费者完成。  
- 进程B（消费者）：导入IPC事件句柄，等待事件，完成工作后记录事件通知生产者。  

该示例使用二进制文件传递事件句柄，展示了IPC事件的核心用法：创建、导出、导入、等待、记录、查询和销毁。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

本样例会由 `run.sh` 同时启动 `proc_a` 和 `proc_b` 两个进程，并通过临时文件交换 IPC Event 句柄。
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

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtResetDevice` 接口复位 Device。

    说明：本样例为单机多进程 IPC 场景，进程退出时使用 `aclrtResetDevice` 释放当前进程的 Device 资源，避免 `aclrtResetDeviceForce` 强制复位影响同机其他进程。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 任务完成。
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
[INFO]  Process A: IPC event created
[INFO]  Process A: event recorded and synchronized
[INFO]  Process A: event status = 1 (1=completed)
[INFO]  Process A: IPC event handle written to ./event_handle.bin
[INFO]  Process A: consumer finished
[INFO]  Process A: cleanup completed
[INFO]  Process B: IPC event opened
[INFO]  Process B: event received, stream synchronized
[INFO]  Process B: event status = 1 (1=completed)
[INFO]  Process B: cleanup completed
[SUCCESS] IPC event synchronization works correctly.
```
