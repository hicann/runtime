# 0_simple_zero_copy

## 描述

本样例展示单个受支持 Device 使用映射 Host 内存直接完成向量加法的流程。应用申请三块 Host 锁页内存，将其注册并映射为 Device 可访问地址，然后把这些映射地址传给 AscendC Kernel。Kernel 对两组确定的 FP16 输入执行加法并直接写回映射的 Host 输出缓冲区，应用同步 Stream 后校验全部 16384 个结果。任一接口调用、结果校验或资源清理失败时，样例输出 `ERROR` 并返回非零值。

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
cd ${git_clone_path}/example/3_memory_advanced/host_register/0_simple_zero_copy
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
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
- Device 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待 Kernel 计算完成，使 Host 侧能够读取输出。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
- Host 内存管理
    - 调用 `aclrtMallocHost` 接口申请 Host 锁页内存。
    - 调用 `aclrtHostRegisterV2` 接口将 Host 锁页内存注册为 Device 可映射内存。
    - 调用 `aclrtHostGetDevicePointer` 接口获取 Host 内存对应的 Device 映射地址。
    - 调用 `aclrtHostUnregister` 接口取消 Host 内存注册。
    - 调用 `aclrtFreeHost` 接口释放 Host 锁页内存。
- Kernel 加载与执行
    - 调用 `aclrtBinaryLoadFromFile` 接口加载 AscendC Kernel 二进制文件。
    - 调用 `aclrtBinaryGetFunction` 接口获取 Kernel 函数句柄。
    - 调用 `aclrtKernelArgsInit` 接口初始化 Kernel 参数列表。
    - 调用 `aclrtKernelArgsAppend` 接口将三个映射 Device 地址追加到参数列表。
    - 调用 `aclrtKernelArgsFinalize` 接口完成 Kernel 参数组装。
    - 调用 `aclrtLaunchKernelWithConfig` 接口下发向量加法 Kernel。
    - 调用 `aclrtBinaryUnLoad` 接口卸载 Kernel 二进制文件。

## 示例输出

```text
[INFO]: Current compile soc version is Ascend910B3
...
[INFO]  Start to run simple_zero_copy sample.
[INFO]  Registered three Host buffers and obtained their Device mapping addresses.
[INFO]  Verified 16384 FP16 additions through mapped Host memory.
[INFO]  Run the simple_zero_copy sample successfully.
```
