# 6_memory_loaded_vector_add

## 描述

本样例面向需要将 Kernel 二进制保存在内存缓存、资源包或网络缓冲区中的单 Device 应用。样例把构建出的 Ascend C 向量加法二进制读入 Host 内存，通过 `aclrtBinaryLoadFromData` 在当前 Device 加载，获取 `add_custom` 函数并完成 FP16 向量加法，最终逐元素验证 `1.0 + 2.0 = 3.0`，并在同一 Context 中卸载二进制和释放资源。

本样例在单 Device Atlas A3 环境实测。Atlas A2 与 Ascend 950PR/Ascend 950DT 的支持结论来自全部源码 API 的公开文档静态准入，未在本次任务中实机验证。

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
cd ${git_clone_path}/example/2_advanced_features/kernel/6_memory_loaded_vector_add
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

- 初始化
    - 调用 `aclInit` 接口初始化 ACL 运行环境。
    - 调用 `aclFinalize` 接口完成去初始化。
- Device 管理
    - 调用 `aclrtSetDevice` 接口选择加载和执行 Kernel 的 Device 0。
    - 调用 `aclrtResetDeviceForce` 接口复位 Device 并回收相关资源。
- Stream 管理
    - 调用 `aclrtCreateStream` 接口创建承载 Kernel 任务的 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待向量加法任务执行完成。
    - 调用 `aclrtDestroyStreamForce` 接口销毁 Stream。
- FP16 数据准备与验证
    - 调用 `aclFloatToFloat16` 接口将确定性输入转换为 FP16 数据。
    - 调用 `aclFloat16ToFloat` 接口转换输出元素并验证计算结果。
- 内存管理
    - 调用 `aclrtMalloc` 接口分配三个向量的 Device 内存。
    - 调用 `aclrtMemcpy` 接口传输输入数据并取回计算结果。
    - 调用 `aclrtFree` 接口释放 Device 向量内存。
- 内存二进制加载与执行
    - 调用 `aclrtBinaryLoadFromData` 接口从 Host 内存字节加载 Kernel 二进制。
    - 调用 `aclrtBinaryGetFunction` 接口从已加载二进制获取 `add_custom` 函数句柄。
    - 调用 `aclrtLaunchKernelWithHostArgs` 接口传入 Device 地址并下发向量加法 Kernel。
    - 调用 `aclrtBinaryUnLoad` 接口在同一 Context 中卸载 Kernel 二进制。

## 示例输出

```text
[INFO]  Start to run 6_memory_loaded_vector_add sample.
[INFO]  Loaded ... binary bytes from Host memory.
[INFO]  Verified 16384 FP16 additions: 1.0 + 2.0 = 3.0.
[INFO]  Run the 6_memory_loaded_vector_add sample successfully.
```
