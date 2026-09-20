# 2_reusable_stream_handoff

## 描述

本样例演示单 Device 上的生产 Stream 和消费 Stream 如何通过一组可复用 Notify 轮转三槽数据。每轮为各槽生成带轮次和槽位标识的数据，记录并核对 Notify ID，由消费 Stream 等待生产 Stream 完成对应数据传输，再逐项校验输出；一轮结束后批量复位全部 Notify。样例连续执行三轮，用不同数据模式验证复用过程中没有跨轮次或跨槽位串扰。

本样例不适用于昇腾虚拟化实例。

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
cd ${git_clone_path}/example/2_advanced_features/notify/2_reusable_stream_handoff
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh
```

3. 执行以下命令编译并运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 与 Context 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtCreateContext` 接口创建 Context。
    - 调用 `aclrtDestroyContext` 接口销毁 Context。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前 Device 并回收资源。
- Stream 管理与数据传输
    - 调用 `aclrtCreateStream` 接口创建生产 Stream 和消费 Stream。
    - 调用 `aclrtMemcpyAsync` 接口异步传输每个槽位的数据。
    - 调用 `aclrtSynchronizeStream` 接口等待一轮任务完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtDestroyStreamForce` 接口在失败清理路径中强制销毁 Stream。
- Notify 管理
    - 调用 `aclrtCreateNotify` 接口为每个数据槽创建 Notify。
    - 调用 `aclrtGetNotifyId` 接口记录 Notify ID，并在每轮复用前核对 ID 未变化。
    - 调用 `aclrtRecordNotify` 接口在生产 Stream 上记录数据就绪状态。
    - 调用 `aclrtWaitAndResetNotify` 接口使消费 Stream 等待对应槽位的数据就绪。
    - 调用 `aclrtNotifyBatchReset` 接口在每轮校验完成后批量复位全部 Notify。
    - 调用 `aclrtDestroyNotify` 接口销毁 Notify。
- 内存管理
    - 调用 `aclrtMallocHost` 和 `aclrtMalloc` 接口分别申请 Host 内存和 Device 内存。
    - 调用 `aclrtFreeHost` 和 `aclrtFree` 接口释放内存。

## 示例输出

```text
Configuring CMake...
Building...
[INFO]  Notify slot 0 has ID ....
[INFO]  Notify slot 1 has ID ....
[INFO]  Notify slot 2 has ID ....
[INFO]  Round 1 reused 3 stable Notify IDs.
[INFO]  Round 1 verified 96 values without cross-round or cross-slot interference.
[INFO]  Round 1 batch-reset 3 Notifies.
[INFO]  Round 2 reused 3 stable Notify IDs.
[INFO]  Round 2 verified 96 values without cross-round or cross-slot interference.
[INFO]  Round 2 batch-reset 3 Notifies.
[INFO]  Round 3 reused 3 stable Notify IDs.
[INFO]  Round 3 verified 96 values without cross-round or cross-slot interference.
[INFO]  Round 3 batch-reset 3 Notifies.
[INFO]  [SUCCESS] Reusable Stream handoff sample completed successfully.
[SUCCESS] Reusable Stream handoff sample executed successfully.
```
