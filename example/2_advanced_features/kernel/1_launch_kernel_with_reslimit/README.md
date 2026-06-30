# 1_launch_kernel_with_reslimit

## 描述

本样例展示在当前进程设置 Device 资源限制后执行 Kernel 的基础流程。样例设置 Cube Core 资源限制，查询当前限制值，并下发打印 Kernel；运行后可以看到 Kernel 输出的 `Hello World` 日志和脚本校验结果。

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
cd ${git_clone_path}/example/2_advanced_features/kernel/1_launch_kernel_with_reslimit
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
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
- 运行时配置
    - 调用 `aclrtSetDeviceResLimit` 接口设置当前进程的 Device 资源限制。
    - 调用 `aclrtGetDeviceResLimit` 接口获取当前进程的 Device 资源限制。

## 示例输出

```text
[INFO]: Current compile soc version is ...
Configuring CMake...
Building...
[INFO]  ACL initialized.
[INFO]  Device 0 selected.
[INFO]  Stream created.
[INFO]  Device resource limit type 0 set to 8.
[INFO]  Current device resource limit type 0 is 8.
Hello World
Hello World
Hello World
Hello World
Hello World
Hello World
Hello World
Hello World
[INFO]  Run the launch_kernel_with_reslimit sample successfully.
[SUCCESS]: Launch kernels under resource limits successfully.
```
