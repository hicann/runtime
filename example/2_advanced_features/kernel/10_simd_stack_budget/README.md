# 10_simd_stack_budget

## 描述

展示单 Device 计算任务在执行具有较大局部数据的 SIMD Kernel 前预留栈空间的完整流程。程序在初始化后、绑定 Device 前，将当前进程中每个 AI Core 的 SIMD 栈空间预算配置为 A2、A3、A5 共同支持的 64 KiB，并读回配置值进行确认。随后执行使用 48 KiB 局部栈数据的校验 Kernel，读回并核对确定性 checksum。配置值不一致、Kernel 结果不符合预期，或任一 Runtime 操作与清理失败时，程序均返回非零值。


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
cd ${git_clone_path}/example/2_advanced_features/kernel/10_simd_stack_budget
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/cann/set_env.sh
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
    - 调用 `aclrtDeviceSetLimit` 接口在绑定 Device 前将当前进程的 SIMD 栈空间预算设置为 64 KiB。
    - 调用 `aclrtDeviceGetLimit` 接口读取并确认当前进程的 SIMD 栈空间预算。
    - 调用 `aclrtSetDevice` 接口指定运行样例的 Device，并使预先设置的资源限制生效。
    - 调用 `aclrtResetDeviceForce` 接口复位 Device 并回收相关资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Kernel 执行所用的 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待 Kernel 执行完成。
    - 调用 `aclrtDestroyStreamForce` 接口销毁 Stream。
- Device 内存管理
    - 调用 `aclrtMalloc` 接口申请保存 Kernel checksum 的 Device 内存。
    - 调用 `aclrtMemcpy` 接口将 Kernel checksum 复制回 Host 进行校验。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- Kernel 配置与执行
    - 调用 `aclrtBinaryLoadFromFile` 接口在 SIMD 栈空间预算生效后加载校验 Kernel 二进制。
    - 调用 `aclrtBinaryGetFunction` 接口根据校验 Kernel 名称获取函数句柄。
    - 调用 `aclrtLaunchKernelWithArgsArray` 接口下发使用局部栈数据的校验 Kernel。
    - 调用 `aclrtBinaryUnLoad` 接口卸载校验 Kernel 二进制。

## 示例输出

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] SOC_VERSION=Ascend910_9362
[INFO] ASCENDC_CMAKE_DIR=...
...
[INFO]  Start to run the 10_simd_stack_budget sample.
[INFO]  Configured and verified the SIMD stack budget: 65536 bytes.
[INFO]  Verified Kernel checksum 723969 using 49152 bytes of local stack data.
[INFO]  Run the 10_simd_stack_budget sample successfully.
```
