# 0_model_task_fallback

## 描述

本样例面向需要在输入不适合可选后处理时执行降级策略的开发者。样例先运行由主计算任务和可选后处理任务组成的完整路径，再检查模型中的 Stream 与任务，按任务类型、函数句柄和序列 ID 唯一识别两个任务，将主任务输入切换到备用数据并禁用可选任务，最后验证主输出来自备用输入且可选输出保持预置值。


## 产品支持情况

| 产品 | 是否支持 |
| --- | :---: |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Ascend 950PR/Ascend 950DT | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/6_scenarios/fault_tolerant_exec/0_model_task_fallback
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

- Runtime 生命周期
    - `aclInit`：初始化 ACL。
    - `aclrtSetDevice`：选择本样例使用的 Device 0。
    - `aclrtResetDeviceForce`：释放本样例在 Device 0 上占用的资源。
    - `aclFinalize`：去初始化 ACL。
- Device 内存
    - `aclrtMalloc`：申请两组输入和两组输出的 Device 内存。
    - `aclrtMemcpy`：写入输入与输出哨兵值，并回读两条路径的结果。
    - `aclrtFree`：释放 Device 缓冲区。
- Stream
    - `aclrtCreateStream`：创建模型捕获和执行使用的 Stream。
    - `aclrtSynchronizeStreamWithTimeout`：在有限时间内等待模型执行完成。
    - `aclrtDestroyStream`：销毁 Stream。
- Kernel
    - `aclrtBinaryLoadFromFile`：加载包含主任务和可选任务的 Kernel 二进制。
    - `aclrtBinaryGetFunction`：取得两个 Kernel 的函数句柄。
    - `aclrtLaunchKernelWithHostArgs`：使用紧凑排列的 Host 参数下发两个待捕获任务。
    - `aclrtBinaryUnLoad`：卸载 Kernel 二进制。
- 模型捕获与执行
    - `aclmdlRICaptureBegin`：开始捕获两个任务。
    - `aclmdlRICaptureEnd`：结束捕获并取得模型运行实例。
    - `aclmdlRIExecuteAsync`：执行完整路径或更新后的回退路径。
    - `aclmdlRIDestroy`：销毁模型运行实例。
- 任务识别与回退更新
    - `aclmdlRIGetStreams`：取得模型关联的唯一 Stream，作为任务查询输入。
    - `aclmdlRIGetTasksByStream`：取得该 Stream 上的任务集合。
    - `aclmdlRITaskGetType`：筛选计算任务。
    - `aclmdlRITaskGetSeqId`：验证主任务先于可选任务执行。
    - `aclmdlRITaskGetParams`：读取 Kernel 函数、参数布局和 Block 数用于识别与更新。
    - `aclmdlRITaskSetParams`：将主任务输入切换为备用输入。
    - `aclmdlRITaskDisable`：禁用可选后处理任务。
    - `aclmdlRIUpdate`：提交任务参数和禁用状态的更新。

## 示例输出

```text
[INFO]  Start to run 0_model_task_fallback sample.
[INFO]  Baseline path verified: main_first=11, optional_first=22.
[INFO]  Selected fallback tasks: main_seq=0, optional_seq=1.
[INFO]  Fallback path verified: main_first=31, optional_first=-1.
[INFO]  Run the 0_model_task_fallback sample successfully.
```
