# 0_uvm_allocate

## 描述

本样例基于UVM（Unified Virtual Memory）统一虚拟内存机制，通过UVM内存申请接口为算子输入、输出分配内存，消除了算子参数追加和结果回写过程中的显式数据搬运。覆盖UVM类型内存申请、二进制加载、核函数句柄获取、参数组装、任务下发、Stream 同步和结果校验。运行该样例后会生成算子输入数据、执行算子，并校验算子输出结果。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | × |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

> 说明：样例会在运行时检查当前 SOC 是否支持 UVM。在不支持 UVM 的产品（如 Ascend 910 系列产品）上，`aclrtMemAllocManaged` 返回 `ACL_ERROR_RT_FEATURE_NOT_SUPPORT (207000)`，样例打印 `[SKIP]` 提示并以退出码 0 正常结束；`run.sh` 识别到 `[SKIP]` 后会跳过后续结果校验，同样正常结束。


## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/3_memory_advanced/managed_memory/0_uvm_allocate
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

本样例的数据生成与结果校验依赖 `numpy`，执行 `run.sh` 前请确保 Python 环境已安装 `numpy`。依赖numpy版本 >= 1.19.0。

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
    - 调用 `aclrtMemAllocManaged` 接口申请 uvm 类型内存。
    - 调用 `aclrtFree` 接口释放 uvm 类型内存。
- Kernel 加载与执行
    - 调用 `aclrtBinaryLoadFromFile` 接口从文件加载并解析算子二进制文件。
    - 调用 `aclrtBinaryGetFunction` 接口获取核函数句柄。
    - 调用 `aclrtKernelArgsInit` 接口根据核函数句柄初始化参数列表。
    - 调用 `aclrtKernelArgsAppend` 接口将参数追加到参数列表中。
    - 调用 `aclrtKernelArgsFinalize` 接口标识参数组装完毕。
    - 调用 `aclrtLaunchKernelWithConfig` 接口下发 Kernel 计算任务。
    - 调用 `aclrtBinaryUnLoad` 接口卸载算子二进制文件。

## 示例输出

```text
Configuring CMake...
Building...
...
[INFO]  Run the uvm_allocate sample successfully.
... output/output_z.bin
... output/golden.bin
error ratio: 0.0000, tolerance: 0.0010
[SUCCESS] result correct
```

在不支持 UVM 的产品上运行时，输出示例：

```text
[INFO]  [SKIP] uvm_allocate sample skipped: the current SOC (Ascend910A) does not support UVM, aclrtMemAllocManaged returned error code 207000.
[SUCCESS] uvm_allocate sample skipped because the current SOC does not support UVM.
```
