# 0_launch_kernel

## 描述

本样例展示基于 CANN Runtime Kernel 加载与执行接口运行 Add 自定义算子的流程，覆盖二进制加载、核函数句柄获取、参数组装、任务下发、Stream 同步和结果校验。样例支持 `simple` 和 `placeholder` 两种参数组织模式，运行后会生成输入数据、执行 Kernel，并校验输出结果。

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
cd ${git_clone_path}/example/2_advanced_features/kernel/0_launch_kernel
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# ${ascend_name} 替换为昇腾 AI 处理器型号，可通过 npu-smi info 查看 Name 字段并去掉空格获得
export SOC_VERSION=${ascend_name}

# ${cmake_path} 替换为 ascendc.cmake 所在目录，例如 ${install_root}/cann/aarch64-linux/tikcpp/ascendc_kernel_cmake
export ASCENDC_CMAKE_DIR=${cmake_path}
```

如果未提前设置环境变量，`run.sh` 会自动尝试探测 `ASCEND_INSTALL_PATH`、`ASCEND_HOME_PATH`、`$HOME/Ascend/cann`、`/usr/local/Ascend/cann`、`/opt/Ascend/cann`、`SOC_VERSION` 和 `ASCENDC_CMAKE_DIR`；如果自动探测失败，请按上述命令手动设置。

本样例的数据生成与结果校验依赖 `numpy`，执行 `run.sh` 前请确保 Python 环境已安装 `numpy`。

3. 执行以下命令运行样例。

```bash
# mode 可选 simple 或 placeholder；不指定时默认为 simple
bash run.sh -r simple
```

`simple` 模式中，Kernel 指针类型参数使用用户提前申请并拷贝数据后的 Device 内存地址。`placeholder` 模式中，placeholder 参数对应的数据由 Runtime 在 Kernel Launch 时传输到 Device 侧。

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
    - 调用 `aclrtMallocHost` 接口申请 Host 内存。
    - 调用 `aclrtMalloc` 接口申请 Device 内存。
    - 调用 `aclrtFreeHost` 接口释放 Host 内存。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口实现 Host 与 Device 之间的数据传输。
- Kernel 加载与执行
    - 调用 `aclrtBinaryLoadFromFile` 接口从文件加载并解析算子二进制文件。
    - 调用 `aclrtBinaryGetFunction` 接口获取核函数句柄。
    - 调用 `aclrtKernelArgsInit` 接口根据核函数句柄初始化参数列表。
    - 调用 `aclrtKernelArgsAppend` 接口将参数追加到参数列表中。
    - 调用 `aclrtKernelArgsAppendPlaceHolder` 接口追加 placeholder 参数。
    - 调用 `aclrtKernelArgsGetPlaceHolderBuffer` 接口获取 placeholder 参数对应的 Host 内存地址。
    - 调用 `aclrtKernelArgsFinalize` 接口标识参数组装完毕。
    - 调用 `aclrtLaunchKernelWithConfig` 接口下发 Kernel 计算任务。
    - 调用 `aclrtBinaryUnLoad` 接口卸载算子二进制文件。

## 示例输出

```text
Configuring CMake...
Building...
...
[INFO]  Kernel launch sample runs in simple mode.
[INFO]  Run the launch_kernel sample successfully.
... output/output_z.bin
... output/golden.bin
error ratio: 0.0000, tolerance: 0.0010
[SUCCESS] result correct
```
