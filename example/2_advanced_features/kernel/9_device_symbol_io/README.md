# 9_device_symbol_io

## 描述

展示单 Device 上通过 Device 变量保存 Kernel 共享状态的完整读写流程。程序检查 Device 变量的地址和大小，使用锁页 Host 内存异步写入一组确定性初值，由 Ascend C Kernel 更新全部数值，再分别通过同步和异步方式读回并逐项校验。地址或大小异常、两种读取结果不一致、数值不符合预期，或任一 Runtime 操作与清理失败时，程序均返回非零值。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/9_device_symbol_io
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. 执行以下命令编译并运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化与去初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定运行样例的 Device。
    - 调用 `aclrtResetDeviceForce` 接口复位 Device 并回收相关资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Device 变量异步读写及 Kernel 执行所用的 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待 Stream 中的任务执行完成。
    - 调用 `aclrtDestroyStreamForce` 接口销毁 Stream。
- Host 内存管理
    - 调用 `aclrtMallocHost` 接口申请异步读写使用的锁页 Host 内存。
    - 调用 `aclrtFreeHost` 接口释放锁页 Host 内存。
- Device 变量内存操作
    - 调用 `aclrtGetSymbolAddress` 接口查询 Device 变量地址并检查有效性。
    - 调用 `aclrtGetSymbolSize` 接口查询 Device 变量大小并确认读写边界。
    - 调用 `aclrtMemcpyToSymbolAsync` 接口异步写入 Device 变量初值。
    - 调用 `aclrtMemcpyFromSymbol` 接口同步读回 Kernel 更新后的 Device 变量。
    - 调用 `aclrtMemcpyFromSymbolAsync` 接口异步读回 Kernel 更新后的 Device 变量。
- Kernel 配置与执行
    - 调用 `aclrtGetFuncBySymbol` 接口根据 Kernel 符号获取函数句柄。
    - 调用 `aclrtLaunchKernelWithArgsArray` 接口下发 Device 变量更新任务。

## 示例输出

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] SOC_VERSION=Ascend910_9362
[INFO] ASCENDC_CMAKE_DIR=...
...
[INFO]  Start to run the 9_device_symbol_io sample.
[INFO]  Resolved Device variable at ... with 32 bytes.
[INFO]  Initialized 8 values asynchronously and added 7 in the Kernel.
[INFO]  Verified 8 values through the synchronous read path.
[INFO]  Verified 8 values through the asynchronous read path.
[INFO]  Both read paths returned [17, ..., 87].
[INFO]  Run the 9_device_symbol_io sample successfully.
```
