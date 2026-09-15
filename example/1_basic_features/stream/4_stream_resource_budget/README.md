# 4_stream_resource_budget

## 描述

本样例演示单 Device 应用在创建 Stream 前检查可用数量，为该 Stream 设置 Vector Core 资源上限，并将资源配置绑定到当前线程后执行一个最小 Kernel。样例通过资源配置回读、Kernel 输出和重置后的默认配置回读，验证 Stream 资源预算的完整生命周期。

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
cd ${git_clone_path}/example/1_basic_features/stream/4_stream_resource_budget
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
- Stream 管理
    - 调用 `aclrtGetStreamAvailableNum` 接口获取当前 Device 上剩余可用的 Stream 数量。
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上任务执行完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtDestroyStreamForce` 接口在失败清理路径中强制销毁 Stream。
- Stream 资源配置
    - 调用 `aclrtSetStreamResLimit` 接口设置指定 Stream 的 Device 资源限制。
    - 调用 `aclrtGetStreamResLimit` 接口获取指定 Stream 的 Device 资源限制。
    - 调用 `aclrtUseStreamResInCurrentThread` 接口在当前线程中使用指定 Stream 上的 Device 资源限制。
    - 调用 `aclrtUnuseStreamResInCurrentThread` 接口在当前线程中取消使用指定 Stream 上的 Device 资源限制。
    - 调用 `aclrtResetStreamResLimit` 接口重置指定 Stream 的 Device 资源限制。
- 内存管理与数据传输
    - 调用 `aclrtMalloc` 接口申请 Device 内存。
    - 调用 `aclrtMemcpy` 接口在 Host 与 Device 之间复制数据。
    - 调用 `aclrtFree` 接口释放 Device 内存。

## 示例输出

```text
[INFO]: Current compile soc version is ...
Configuring CMake...
Building...
[INFO]  Available Streams before creation: ...
[INFO]  Available Streams after creation: ...
[INFO]  Default Vector Core limit: ...
[INFO]  Configured Vector Core limit: 1.
[INFO]  Use the Stream resource limit in the current thread.
[INFO]  Kernel output: 42 (expected: 42).
[INFO]  Stop using the Stream resource limit in the current thread.
[INFO]  Reset Vector Core limit: ...
[INFO]  [SUCCESS] Stream resource budget sample completed successfully.
[SUCCESS] Stream resource budget sample executed successfully.
```
