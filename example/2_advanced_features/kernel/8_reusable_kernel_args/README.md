# 8_reusable_kernel_args

## 描述

本样例展示单 Device 上由用户管理并复用 Kernel 参数内存的完整流程。程序根据核函数句柄分别查询参数列表句柄区和参数数据区所需大小，用查询结果申请两块 Host 内存并初始化参数列表；首次下发将标量 `7` 写入 Device 输出，随后通过首次追加时取得的参数句柄将标量更新为 `23`，再次完成参数组装并下发同一 Kernel。程序逐次回读输出，只有两次结果分别为 `7` 和 `23` 且所有 Runtime 操作与清理均成功时才返回成功。

本样例中的 `userArgsSize` 为两个 Kernel 参数各自按 8 字节对齐后的大小之和。参数列表句柄区和参数数据区均由用户申请并在 Stream 销毁后释放，体现 `aclrtKernelArgsInitByUserMem` 的内存所有权要求。

## 产品支持情况

全部源码 API 均由公开文档静态确认支持以下产品；本次在单 Device Atlas A3 环境完成实机验证，Atlas A2 与 Ascend 950PR/Ascend 950DT 完成交叉构建验证。

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/8_reusable_kernel_args
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. 编译并运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该 Sample 中，涉及的关键功能点及其接口如下：

- 初始化与去初始化
    - 调用 `aclInit` 初始化 CANN Runtime。
    - 调用 `aclFinalize` 去初始化 CANN Runtime。
- Device 与 Stream 管理
    - 调用 `aclrtSetDevice` 指定执行 Kernel 的 Device。
    - 调用 `aclrtResetDeviceForce` 复位 Device 并回收相关资源。
    - 调用 `aclrtCreateStream` 创建 Kernel 执行所用的 Stream。
    - 调用 `aclrtSynchronizeStream` 等待每次 Kernel 执行完成。
    - 调用 `aclrtDestroyStreamForce` 销毁 Stream。
- 内存与数据传输
    - 调用 `aclrtMallocHost` 按查询结果申请参数列表句柄区和参数数据区 Host 内存。
    - 调用 `aclrtFreeHost` 释放用户管理的两块 Host 内存。
    - 调用 `aclrtMalloc` 申请保存 Kernel 输出的 Device 内存。
    - 调用 `aclrtMemcpy` 将每次 Kernel 输出复制回 Host 进行校验。
    - 调用 `aclrtFree` 释放输出 Device 内存。
- Kernel 参数构造与复用
    - 调用 `aclrtGetFuncBySymbol` 根据 Kernel 符号获取核函数句柄。
    - 调用 `aclrtKernelArgsGetHandleMemSize` 查询参数列表句柄区所需内存大小。
    - 调用 `aclrtKernelArgsGetMemSize` 根据对齐后的用户参数总量查询参数数据区实际大小。
    - 调用 `aclrtKernelArgsInitByUserMem` 使用两块用户 Host 内存初始化参数列表。
    - 调用 `aclrtKernelArgsAppend` 依次追加输出地址和初始标量，并保留标量参数句柄。
    - 调用 `aclrtKernelArgsParaUpdate` 通过参数句柄将初始标量更新为新值。
    - 调用 `aclrtKernelArgsFinalize` 在首次追加和参数更新后分别完成参数组装。
    - 调用 `aclrtLaunchKernelWithConfig` 使用同一参数列表两次下发 Kernel。

## 示例输出

```text
[INFO]: Current compile soc version is Ascend910_9362
...
[INFO]  Start to run the 8_reusable_kernel_args sample.
[INFO]  Allocated user memory: handle=... bytes, argument buffer=... bytes.
[INFO]  Verified launch 1: scalar=7, output=7.
[INFO]  Updated the reusable scalar parameter from 7 to 23.
[INFO]  Verified launch 2: scalar=23, output=23.
[INFO]  Run the 8_reusable_kernel_args sample successfully.
```
