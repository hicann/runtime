# 13_memcpy_descriptor

## 描述

本样例演示在单 Device 内使用内存复制描述符异步复制一组数据，适用于源地址、目的地址和复制长度可通过描述符集中管理的场景。样例生成确定的输入数据，执行描述符方式的 Device 内复制，并在同步后回拷结果进行逐项校验。

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
cd ${git_clone_path}/example/1_basic_features/memory/13_memcpy_descriptor
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
    - 调用 `aclrtMalloc` 接口申请源数据、目的数据和内存复制描述符所需的 Device 内存。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口完成 Host 与 Device 之间的数据传输。
    - 调用 `aclrtGetMemcpyDescSize` 接口获取内存复制描述符占用的 Device 内存大小。
    - 调用 `aclrtSetMemcpyDesc` 接口在描述符中设置源地址、目的地址和复制长度。
    - 调用 `aclrtMemcpyAsyncWithDesc` 接口通过描述符异步执行 Device 内的数据复制。

## 示例输出

```text
Configuring CMake...
Building...
...
[INFO]  Configured a ...-byte memcpy descriptor for 4096 bytes of data
[INFO]  Verified all 1024 copied elements
[INFO]  [SUCCESS] Memcpy descriptor sample completed successfully
[SUCCESS] Memcpy descriptor sample executed successfully.
```
