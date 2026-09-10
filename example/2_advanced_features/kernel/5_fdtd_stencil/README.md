# 5_fdtd_stencil

## 描述

展示单 Device 上执行三维有限差分模板更新的完整流程。程序先确认 FDTD Kernel 为可用的 Vector Core Kernel，再将本轮中心点和相邻点系数写入 Device 变量，对带 halo 的确定性三维网格执行一次更新，并将 64 个内部点与 Host 参考结果逐点比较。Kernel 类型不匹配、Device 变量大小异常、最大误差超过 `1e-5` 或任一 Runtime 操作与清理失败时，程序均返回非零值。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A2 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |


## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/2_advanced_features/kernel/5_fdtd_stencil
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
    - 调用 `aclInit` 接口初始化 CANN Runtime。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定执行 FDTD 计算的 Device。
    - 调用 `aclrtResetDeviceForce` 接口复位 Device 并回收相关资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Kernel 执行所用的 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待 FDTD Kernel 执行完成。
    - 调用 `aclrtDestroyStreamForce` 接口销毁 Stream。
- 内存与数据传输
    - 调用 `aclrtMalloc` 接口申请输入和输出 Device 内存。
    - 调用 `aclrtFree` 接口释放输入和输出 Device 内存。
    - 调用 `aclrtMemcpy` 接口在 Host 与 Device 间传输网格数据。
    - 调用 `aclrtGetSymbolSize` 接口确认 FDTD 系数 Device 变量的大小。
    - 调用 `aclrtMemcpyToSymbol` 接口将本轮 FDTD 系数写入 Device 变量。
- Kernel 配置与执行
    - 调用 `aclrtGetFuncBySymbol` 接口根据 FDTD Kernel 符号获取函数句柄。
    - 调用 `aclrtGetFunctionAttribute` 接口查询 Kernel 类型并确认 Vector Core 兼容性。
    - 调用 `aclrtLaunchKernelWithArgsArray` 接口下发 FDTD 模板更新任务。

## 示例输出

```text
[INFO]: Current compile soc version is Ascend910_9362
...
[INFO]  Start to run the 5_fdtd_stencil sample.
[INFO]  Kernel type 2 confirms Vector Core compatibility.
[INFO]  Copied 2 FDTD coefficients to the Device variable.
[INFO]  Verified 64 interior points; max error is 0.00000000.
[INFO]  Run the 5_fdtd_stencil sample successfully.
```
