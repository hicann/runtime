# 2_event_wait_diagnostics

## 描述

本样例演示单 Device 应用如何诊断生产者 Stream 与消费者 Stream 之间的 Event 等待过程。样例记录普通 Event 创建前后的可用数量，并在首次 Record 后获取 Event ID；随后为消费者设置有限等待超时，通过等待状态从未完成变为完成以及最终数据结果，验证两个 Stream 之间的任务依赖关系。

普通 Event 的资源可能在首次 Record 时才实际申请，因此创建前后的可用数量用于资源诊断，不要求固定减少一个。本样例必须使用 `aclrtCreateEvent` 创建 Event，不能替换为 `aclrtCreateEventExWithFlag`。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/1_basic_features/event/2_event_wait_diagnostics
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

3. 执行以下命令运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该 Sample 中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- Context 管理
    - 调用 `aclrtCreateContext` 接口创建 Context。
    - 调用 `aclrtDestroyContext` 接口销毁 Context。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建生产者 Stream 和消费者 Stream。
    - 调用 `aclrtStreamWaitEventWithTimeout` 接口为消费者 Stream 下发带有限超时的 Event Wait 任务。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上任务执行完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtDestroyStreamForce` 接口在失败清理路径中强制销毁 Stream。
- Event 管理
    - 调用 `aclrtGetEventAvailNum` 接口查询当前 Device 上可用的 Event 数量。
    - 调用 `aclrtCreateEvent` 接口创建普通 Event。
    - 调用 `aclrtGetEventId` 接口获取 Event ID。
    - 调用 `aclrtRecordEvent` 接口在生产者 Stream 中记录 Event。
    - 调用 `aclrtQueryEventWaitStatus` 接口查询 Event 对应等待任务的完成状态。
    - 调用 `aclrtDestroyEvent` 接口销毁 Event。
- 内存管理与数据传输
    - 调用 `aclrtMalloc` 接口申请 Device 内存。
    - 调用 `aclrtMemcpy` 接口在 Host 与 Device 之间复制数据。
    - 调用 `aclrtFree` 接口释放 Device 内存。

## 示例输出

```text
[INFO]: Current compile soc version is ...
Configuring CMake...
Building...
[INFO]  Available Events before creation: ...
[INFO]  Available Events after creation: ...
[INFO]  Producer starts a long task: value += 1.
[INFO]  Recorded ordinary Event ID: ...
[INFO]  Consumer waits for the Event with a 5-second timeout.
[INFO]  Wait status before consumer synchronization: NOT_READY.
[INFO]  Consumer submits the dependent task: value *= 2.
[INFO]  Wait status after consumer synchronization: COMPLETE.
[INFO]  Output value: 2 (expected: 2).
[INFO]  [SUCCESS] Event wait diagnostics sample completed successfully.
[SUCCESS] Event wait diagnostics sample executed successfully.
```
