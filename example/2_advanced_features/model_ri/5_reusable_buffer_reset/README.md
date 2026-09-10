# 5_reusable_buffer_reset

## 描述

本样例演示 CANN Runtime 中可复用 Model RI 的捕获、结构枚举和执行流程：程序在单个 Device 0 上把异步缓冲区清零任务捕获为可复用 Model RI，通过 `aclmdlRIGetStreams` 与 `aclmdlRIGetTasksByStream` 生成 Stream/Task 结构清单，并仅在清单有效时执行模型，最终得到已全部清零的 4096 字节 Device 缓冲区。

程序先验证缓冲区已填充非零字节，再要求 Model RI 至少包含一条 Stream 和一个 Task，最后逐字节验证执行结果为零。任一 Runtime 接口、结构关系、数据不变量或清理操作失败时，程序都会输出 `ERROR` 并返回非零；只有业务检查和清理全部成功后才输出最终成功标记。`aclmdlRIGetStreams` 和 `aclmdlRIGetTasksByStream` 是试验特性，后续版本可能变更且不支持用于生产环境，本样例仅用于教学和功能验证。

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
cd ${git_clone_path}/example/2_advanced_features/model_ri/5_reusable_buffer_reset
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

- 初始化与运行条件确认
    - 调用 `aclInit` 接口完成 ACL 初始化。
    - 调用 `aclrtGetDeviceCount` 接口确认 Device 0 可用。
    - 调用 `aclrtCreateContext` 接口在 Device 0 上创建当前线程使用的 Context。
- Stream 与缓冲区管理
    - 调用 `aclrtCreateStream` 接口创建捕获和执行 Model RI 使用的 Stream。
    - 调用 `aclrtMalloc` 接口申请可复用的 Device 缓冲区。
    - 调用 `aclrtMemsetAsync` 接口预填非零数据，并捕获异步清零任务。
    - 调用 `aclrtSynchronizeStream` 接口等待异步预填或模型执行完成。
    - 调用 `aclrtMemcpy` 接口将 Device 缓冲区复制到 Host 侧以验证数据。
- Model RI 捕获与结构清单
    - 调用 `aclmdlRICaptureBegin` 接口开始捕获异步清零任务。
    - 调用 `aclmdlRICaptureEnd` 接口结束捕获并获取可复用 Model RI。
    - 调用 `aclmdlRIGetStreams` 接口分两次获取 Model RI 关联的 Stream 数量和句柄。
    - 调用 `aclmdlRIGetTasksByStream` 接口分两次获取各 Stream 的 Task 数量和句柄。
- Model RI 执行与资源清理
    - 调用 `aclmdlRIExecuteAsync` 接口异步执行结构清单有效的 Model RI。
    - 调用 `aclmdlRIDestroy` 接口销毁 Model RI。
    - 调用 `aclrtFree` 接口释放 Device 缓冲区。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtDestroyContext` 接口销毁显式创建的 Context。
    - 调用 `aclFinalize` 接口完成 ACL 去初始化。

## 示例输出

```text
[INFO]  Start to run 5_reusable_buffer_reset sample.
[INFO]  Prepared 4096-byte reusable buffer with pattern 0xA5.
[INFO]  Model RI manifest: streams=1, tasks=2.
[INFO]  Verified 4096-byte reusable buffer reset to zero.
[INFO]  Run the 5_reusable_buffer_reset sample successfully.
```

以上 Stream 和 Task 数量来自 CANN 9.2.0 环境的一次真实成功运行；数量可能随 CANN 版本变化，但必须均为正数。
