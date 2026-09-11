# 0_prefetch_strategy_comparison

## 描述

本样例面向需要为不同复用特征的 Device 工作集选择预取方式的开发者。程序在单个 Device 上准备两份内容相同的 256 元素工作集，在普通 Stream 上对一次性工作集执行直接异步预取；对于重复使用工作集，程序查询、分配并配置可复用的 Device 侧 CMO 描述符，将持久化 Stream 绑定到最小 Model RI 后执行描述符式异步预取。两条路径由同一个 Ascend C Kernel 变换工作集。

程序逐元素验证两种预取路径的结果均符合 `output = input * 3 + 7`，并验证两份结果完全一致。描述符大小查询结果用于实际内存分配；任一 Runtime 接口、结果不变量或清理操作失败时，程序输出 `ERROR` 并返回非零值。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Ascend 950PR/Ascend 950DT | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。
2. 设置环境变量。
3. 执行以下命令编译并运行样例。

```bash
cd ${git_clone_path}/example/3_memory_advanced/cache_maintenance/0_prefetch_strategy_comparison
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- Runtime 初始化与 Device 管理
    - `aclInit`：初始化 ACL Runtime。
    - `aclrtSetDevice`：选择 Device 0 执行预取策略对比。
    - `aclrtResetDeviceForce`：释放 Device 0 上的 Runtime 资源。
    - `aclFinalize`：去初始化 ACL Runtime。
- Stream 与内存管理
    - `aclrtCreateStream`：创建执行直接预取和第一轮 Kernel 的普通 Stream。
    - `aclrtCreateStreamWithConfig`：创建可绑定 Model RI 并承载描述符 CMO 和第二轮 Kernel 的持久化 Stream。
    - `aclrtMalloc`：分配两组 Device 工作集、输出缓冲区和 CMO 描述符。
    - `aclrtMemcpy`：在 Model RI 执行前同步写入工作集，并在执行完成后回读两种策略的输出。
    - `aclrtSynchronizeStream`：等待普通 Stream 上的直接预取和 Kernel 完成，并在清理前再次确认其空闲。
    - `aclrtFree`：释放工作集、输出和描述符的 Device 内存。
    - `aclrtDestroyStream`：销毁直接预取和描述符预取使用的两个 Stream。
- CMO 预取策略
    - `aclrtCmoAsync`：为一次性工作集提交直接异步预取。
    - `aclrtCmoGetDescSize`：查询可复用 CMO 描述符所需的 Device 内存大小。
    - `aclrtCmoSetDesc`：把重复使用工作集的地址和大小写入 CMO 描述符。
    - `aclrtCmoAsyncWithDesc`：使用已配置描述符提交异步预取。
- Model RI 任务承载与执行
    - `aclmdlRIBuildBegin`：开始构建承载描述符预取路径的最小 Model RI。
    - `aclmdlRIBindStream`：把持久化 Stream 绑定为 Model RI 的首 Stream。
    - `aclmdlRIEndTask`：标记描述符预取和第二轮 Kernel 任务下发结束。
    - `aclmdlRIBuildEnd`：完成 Model RI 构建，使任务可执行。
    - `aclmdlRIExecute`：在 5 秒超时边界内同步执行描述符预取计算路径。
    - `aclmdlRIUnbindStream`：在结果验证后解除 Model RI 与持久化 Stream 的绑定。
    - `aclmdlRIDestroy`：销毁不再使用的 Model RI。

## 示例输出

```text
[INFO]  Start to run 0_prefetch_strategy_comparison sample.
[INFO]  Verified 256 elements: direct and descriptor prefetch results are identical and correct.
[INFO]  Run the 0_prefetch_strategy_comparison sample successfully.
```
