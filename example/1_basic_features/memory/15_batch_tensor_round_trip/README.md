# 15_batch_tensor_round_trip

## 描述

本样例演示推理前后处理过程中对一组互不依赖的小张量进行批量往返传输。样例使用同一组长度不同的张量，分别通过旧版同步、V2 同步、旧版异步和 V2 异步批量复制完成 Host 到 Device、Device 到 Host 的传输，并逐张量、逐元素校验结果。

运行时可观察旧版接口在复制成功后通过 `failIndex` 返回 `SIZE_MAX`，以及 V2 接口仅返回调用结果、不再提供 `failIndex` 输出参数的差异。

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
cd ${git_clone_path}/example/1_basic_features/memory/15_batch_tensor_round_trip
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh

# 加载 Runtime 样例的环境配置
source ${git_clone_path}/example/set_sample_env.sh
```

3. 执行以下命令运行样例。

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
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上任务执行完成。
    - 调用 `aclrtDestroyStreamForce` 接口强制销毁 Stream。
- 内存管理
    - 调用 `aclrtMallocHost` 接口申请锁页 Host 内存。
    - 调用 `aclrtMalloc` 接口申请 Device 内存。
    - 调用 `aclrtFreeHost` 接口释放 Host 内存。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- 批量数据传输
    - 调用 `aclrtMemcpyBatch` 接口同步完成批量 Host 到 Device 和 Device 到 Host 的数据传输，并通过 `failIndex` 获取失败复制项下标。
    - 调用 `aclrtMemcpyBatchV2` 接口同步完成批量 Host 到 Device 和 Device 到 Host 的数据传输，该接口不提供 `failIndex` 输出参数。
    - 调用 `aclrtMemcpyBatchAsync` 接口在 Stream 上异步完成批量 Host 到 Device 和 Device 到 Host 的数据传输，并通过 `failIndex` 获取失败复制项下标。
    - 调用 `aclrtMemcpyBatchAsyncV2` 接口在 Stream 上异步完成批量 Host 到 Device 和 Device 到 Host 的数据传输，该接口不提供 `failIndex` 输出参数。

## 示例输出

```text
Configuring CMake...
Building...
...
[INFO]  Legacy synchronous mode returned ACL_SUCCESS; H2D and D2H failIndex are SIZE_MAX
[INFO]  Legacy synchronous mode verified tensor 0 (4 elements)
[INFO]  Legacy synchronous mode verified tensor 1 (7 elements)
[INFO]  Legacy synchronous mode verified tensor 2 (11 elements)
[INFO]  V2 synchronous mode returned ACL_SUCCESS for H2D and D2H; V2 has no failIndex output
[INFO]  V2 synchronous mode verified tensor 0 (4 elements)
[INFO]  V2 synchronous mode verified tensor 1 (7 elements)
[INFO]  V2 synchronous mode verified tensor 2 (11 elements)
[INFO]  Legacy asynchronous mode returned ACL_SUCCESS; H2D and D2H failIndex are SIZE_MAX
[INFO]  Legacy asynchronous mode verified tensor 0 (4 elements)
[INFO]  Legacy asynchronous mode verified tensor 1 (7 elements)
[INFO]  Legacy asynchronous mode verified tensor 2 (11 elements)
[INFO]  V2 asynchronous mode returned ACL_SUCCESS for H2D and D2H; V2 has no failIndex output
[INFO]  V2 asynchronous mode verified tensor 0 (4 elements)
[INFO]  V2 asynchronous mode verified tensor 1 (7 elements)
[INFO]  V2 asynchronous mode verified tensor 2 (11 elements)
[INFO]  [SUCCESS] Batch tensor round-trip sample completed successfully
[SUCCESS] Batch tensor round-trip sample executed successfully.
```
