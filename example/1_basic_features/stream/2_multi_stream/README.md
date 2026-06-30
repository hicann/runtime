# 2_multi_stream

## 描述
本样例展示多个 Stream 之间的任务同步方式，包括 Stream 同步、Event 同步和 Notify 同步。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1.下载样例代码至安装CANN软件的环境，切换到样例目录。
```bash
cd ${git_clone_path}/example/1_basic_features/stream/2_multi_stream
```

2.设置环境变量。
```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

3.执行以下命令运行样例。
```bash
bash run.sh
```
## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：
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
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口可以阻塞等待 Stream 上任务的完成。
    - 调用 `aclrtSetStreamFailureMode` 接口可以设置 Stream 执行任务遇到错误的操作，默认为遇错继续，可以设置为遇错即停。
    - 调用 `aclrtDestroyStreamForce` 接口强制销毁 Stream，丢弃所有任务。
    - 调用 `aclrtSynchronizeStreamWithTimeout` 接口进行超时等待，如果超过指定时间会抛弃任务。
- Event 管理
    - 调用 `aclrtCreateEvent` 接口创建 Event。
    - 调用 `aclrtRecordEvent` 接口记录 Event。
    - 调用 `aclrtStreamWaitEvent` 接口阻塞指定 Stream 等待 Event 完成。
    - 调用 `aclrtResetEvent` 接口复位 Event。
    - 调用 `aclrtSynchronizeEvent` 接口阻塞等待 Event 完成。
    - 调用 `aclrtSynchronizeEventWithTimeout` 接口进行超时等待，如果超过指定时间会抛弃任务。
- Notify 管理
    - 调用 `aclrtCreateNotify` 接口创建 Notify。
    - 调用 `aclrtRecordNotify` 接口记录 Notify。
    - 调用 `aclrtWaitAndResetNotify` 接口阻塞等待 Notify 并重置。
    - 调用 `aclrtDestroyNotify` 接口销毁 Notify。
- 内存管理
    - 调用 `aclrtMalloc` 接口申请 Device 上的内存。
    - 调用 `aclrtFree` 接口释放 Device 上的内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口通过内存复制的方式实现数据传输。

## 示例输出

```text
[INFO]  Use stream synchronize.
[INFO]  Applied resource successfully, begin assigning task.
[INFO]  Begin a long task, num += 1.
[INFO]  Stream synchronize.
[INFO]  Begin a short task, num *= 2.
[INFO]  The answer is 2.
[INFO]  Simulate timeout, wait 1000ms, the task will fail.
[ERROR]  Operation failed: aclrtSynchronizeStreamWithTimeout(stream1, kWaitTimeMs) returned error code 507046
[INFO]  Resource cleanup completed.
[INFO]  Use event synchronize.
...
[INFO]  Use notify synchronize.
[INFO]  The answer is 2.
[INFO]  Resource cleanup completed.
```
