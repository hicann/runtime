# 3_bounded_cross_stream_execution

## 描述

本样例演示单 Device 数据处理流程如何统一设置算子执行超时、跨 Stream Event 等待超时和 Device 同步超时。样例读取硬件支持的算子超时时间粒度，分别设置秒级和微秒级算子执行超时并校验硬件实际值；随后让消费者 Stream 在有限预算内等待生产者 Event，提交异步数据传输任务，在限定时间内同步 Device，并通过逐项比较输入和输出验证跨 Stream 依赖关系。

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
cd ${git_clone_path}/example/1_basic_features/event/3_bounded_cross_stream_execution
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
- 算子执行超时配置
    - 调用 `aclrtGetOpTimeOutInterval` 接口获取硬件支持的算子超时时间粒度。
    - 调用 `aclrtSetOpExecuteTimeOut` 接口以秒为单位设置算子执行超时。
    - 调用 `aclrtSetOpExecuteTimeOutV2` 接口以微秒为单位设置算子执行超时，并获取实际生效值。
    - 调用 `aclrtGetOpExecuteTimeout` 接口以毫秒为单位回读硬件实际生效的算子执行超时。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtSynchronizeDeviceWithTimeout` 接口在有限时间内等待 Device 上的任务完成。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- Context 管理
    - 调用 `aclrtCreateContext` 接口创建 Context。
    - 调用 `aclrtDestroyContext` 接口销毁 Context。
- Stream 与 Event 管理
    - 调用 `aclrtCreateStream` 接口创建生产者 Stream 和消费者 Stream。
    - 调用 `aclrtCreateEvent` 接口创建用于跨 Stream 同步的 Event。
    - 调用 `aclrtSetOpWaitTimeout` 接口设置后续 Event Wait 任务的等待超时。
    - 调用 `aclrtRecordEvent` 接口在生产者 Stream 中记录 Event。
    - 调用 `aclrtStreamWaitEvent` 接口使消费者 Stream 等待生产者 Event。
    - 调用 `aclrtDestroyEvent` 接口销毁 Event。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtDestroyStreamForce` 接口在失败清理路径中强制销毁 Stream。
- 内存管理与数据传输
    - 调用 `aclrtMallocHost` 接口申请锁页 Host 内存。
    - 调用 `aclrtMalloc` 接口申请 Device 内存。
    - 调用 `aclrtMemcpyAsync` 接口在生产者 Stream 和消费者 Stream 中异步传输数据。
    - 调用 `aclrtFreeHost` 和 `aclrtFree` 接口释放内存。

## 示例输出

```text
Configuring CMake...
Building...
[INFO]  Hardware operation timeout interval: ... us.
[INFO]  Second-level request: 1 s; hardware readback: ... ms.
[INFO]  Microsecond request: ... us; actual: ... us.
[INFO]  Event wait budget: 5 s.
[INFO]  Submitted producer copy, cross-Stream Event wait, and consumer copy.
[INFO]  Device synchronized within 5000 ms.
[INFO]  Verified 256 values transferred across the Event dependency.
[INFO]  [SUCCESS] Bounded cross-Stream execution sample completed successfully.
[SUCCESS] Bounded cross-Stream execution sample executed successfully.
```
