# 16_guarded_result_slice

## 描述

本样例演示在单 Device 上局部更新结果表。样例为结果表设置 32 位哨兵值，通过 Device 内保存的基地址和字节偏移异步复制一段源数据；回传结果表后，分别校验目标切片及其前后未覆盖区，适用于只更新部分结果且需要检测意外越界覆盖的场景。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/1_basic_features/memory/16_guarded_result_slice
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh

# 加载 Runtime 样例的环境配置
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
    - 调用 `aclrtMallocHost` 接口申请锁页 Host 内存。
    - 调用 `aclrtMalloc` 接口申请 Device 内存。
    - 调用 `aclrtMemsetD32` 接口用 32 位无符号整数值同步填充 Host 侧期望结果表。
    - 调用 `aclrtMemsetD32Async` 接口在 Stream 上用 32 位无符号整数值异步填充 Device 侧结果表。
    - 调用 `aclrtFreeHost` 接口释放 Host 内存。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口完成 Host 与 Device 之间的数据传输。
    - 调用 `aclrtMemcpyAsyncWithOffset` 接口通过间接基地址和偏移在 Device 内异步复制结果切片。

## 示例输出

```text
Configuring CMake...
Building...
...
[INFO]  Verified Host sentinel baseline (16 elements)
[INFO]  Prepared expected result table with sentinel 0xDEADBEEF
[INFO]  Verified prefix guard [0, 5)
[INFO]  Verified copied slice [5, 11)
[INFO]  Verified suffix guard [11, 16)
[INFO]  [SUCCESS] Guarded result slice sample completed successfully
[SUCCESS] Guarded result slice sample executed successfully.
```
