# 3_binary_get_function_count

## 描述

本样例展示如何使用 `aclrtBinaryGetFunctionCount` 接口查询算子二进制文件中包含的核函数数量，并基于该数量完成后续的核函数获取、信息查询、任务下发和结果验证的完整流程。样例将 `add_custom`、`sub_custom` 和 `mul_custom` 三个 AscendC 核函数编译到同一个独立算子二进制文件中，查询核函数总数后按名称获取句柄、查询函数信息、准备 FP16 输入数据，最终分别下发三个核函数并校验计算结果。

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
cd ${git_clone_path}/example/2_advanced_features/kernel/3_binary_get_function_count
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
- 内存管理
    - 调用 `aclrtMallocHost` 接口分配 Host 内存。
    - 调用 `aclrtMalloc` 接口分配 Device 内存。
    - 调用 `aclrtMemcpy` 接口执行 Host 与 Device 之间的内存拷贝。
    - 调用 `aclrtFreeHost` 接口释放 Host 内存。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- 二进制管理
    - 调用 `aclrtBinaryLoadFromFile` 接口从文件加载并解析算子二进制文件，输出 binHandle。
    - 调用 `aclrtBinaryGetFunctionCount` 接口获取算子二进制中核函数句柄的总数。
    - 调用 `aclrtBinaryGetFunction` 接口根据核函数名称获取对应的核函数句柄。
    - 调用 `aclrtGetFunctionName` 接口根据核函数句柄获取核函数名称。
    - 调用 `aclrtGetFunctionAddr` 接口根据核函数句柄获取 Device 侧算子起始地址。
    - 调用 `aclrtLaunchKernelWithHostArgs` 接口下发 Kernel 计算任务，Host 侧参数在调用时自动拷贝到 Device。
    - 调用 `aclrtBinaryUnLoad` 接口卸载算子二进制文件，释放相关资源。

## 示例输出

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] ASCENDC_CMAKE_DIR=...
[INFO] SOC_VERSION=...
Configuring CMake...
Building...
[INFO]  Querying the number of kernel functions in the binary
[INFO]  aclrtBinaryGetFunctionCount returned 3 functions
[INFO]  Getting function handles by name
[INFO]  Querying function names and addresses
[INFO]  function[0]: name=add_custom, handle=..., aic=..., aiv=...
[INFO]  function[1]: name=sub_custom, handle=..., aic=..., aiv=...
[INFO]  function[2]: name=mul_custom, handle=..., aic=..., aiv=...
[INFO]  Preparing input data
[INFO]  Launching kernels and verifying results
[INFO]  add_custom result verified
[INFO]  sub_custom result verified
[INFO]  mul_custom result verified
[INFO]  aclrtBinaryGetFunctionCount sample PASSED
```
