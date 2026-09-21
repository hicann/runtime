# 11_device_argument_vector_add

## 描述

本样例面向需要在 Device 侧维护 Kernel 参数包的单 Device 向量计算任务。样例复用已有 FP16 向量加法 Kernel，将三个向量的 Device 地址组成参数包并上传至 Device 内存，通过 `aclrtLaunchKernelV2` 异步下发计算。Device 参数包会保留到 Stream 同步完成后再释放，体现其与 Host 参数接口不同的生命周期。程序最终逐项校验 16384 个向量加法结果，任一结果不符合预期或资源清理失败时均返回非零值。


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
cd ${git_clone_path}/example/2_advanced_features/kernel/11_device_argument_vector_add
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
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定加载和执行 Kernel 的 Device。
    - 调用 `aclrtResetDeviceForce` 接口复位 Device 并回收相关资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建承载 Kernel 任务的 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待异步 Kernel 任务完成，并确定 Device 参数包可以释放。
    - 调用 `aclrtDestroyStreamForce` 接口销毁 Stream。
- 数据准备与校验
    - 调用 `aclFloatToFloat16` 接口将确定性输入转换为 FP16 数据。
    - 调用 `aclFloat16ToFloat` 接口转换输出并逐项校验计算结果。
    - 调用 `aclrtMalloc` 接口申请向量和参数包的 Device 内存。
    - 调用 `aclrtMemcpy` 接口上传输入与参数包，并将结果复制回 Host。
    - 调用 `aclrtFree` 接口在任务完成后释放 Device 内存。
- Kernel 加载与执行
    - 调用 `aclrtBinaryLoadFromFile` 接口加载向量加法 Kernel 二进制。
    - 调用 `aclrtBinaryGetFunction` 接口获取 `add_custom` 函数句柄。
    - 调用 `aclrtLaunchKernelV2` 接口使用 Device 内存中的参数包异步下发向量加法 Kernel。
    - 调用 `aclrtBinaryUnLoad` 接口卸载 Kernel 二进制。

## 示例输出

```text
[INFO] ASCEND_HOME_PATH=...
[INFO] SOC_VERSION=...
[INFO] ASCENDC_CMAKE_DIR=...
...
[INFO]  Start to run the 11_device_argument_vector_add sample.
[INFO]  Uploaded a 24-byte Kernel argument package to Device memory.
[INFO]  Released the Device argument package after Stream synchronization.
[INFO]  Verified 16384 FP16 vector additions element by element.
[INFO]  Run the 11_device_argument_vector_add sample successfully.
```
