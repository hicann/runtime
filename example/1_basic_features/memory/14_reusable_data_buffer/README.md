# 14_reusable_data_buffer

## 描述

本样例演示在单 Device 数据分批处理中复用同一个 `aclDataBuffer`。样例为两种有效长度准备独立的 Device 缓冲区，将描述对象从短数据切换至长数据，并检查切换前后的地址、有效大小及逐字节回拷内容，适用于输入地址和长度随批次变化的场景。

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
cd ${git_clone_path}/example/1_basic_features/memory/14_reusable_data_buffer
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
- 内存管理
    - 调用 `aclrtMallocAlign32` 接口为两种有效长度的数据申请按 32 Byte 对齐大小的 Device 内存。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- DataBuffer 管理
    - 调用 `aclCreateDataBuffer` 接口创建描述数据地址和有效大小的 `aclDataBuffer`。
    - 调用 `aclUpdateDataBuffer` 接口更新同一个 `aclDataBuffer` 中的数据地址和有效大小。
    - 调用 `aclGetDataBufferAddr` 接口获取并检查 `aclDataBuffer` 中的数据地址。
    - 调用 `aclGetDataBufferSizeV2` 接口获取并检查 `aclDataBuffer` 中的数据有效大小。
    - 调用 `aclDestroyDataBuffer` 接口销毁 `aclDataBuffer`。
- 数据传输
    - 调用 `aclrtMemcpy` 接口完成 Host 与 Device 之间的数据传输，并校验描述对象指向的数据内容。

## 示例输出

```text
Configuring CMake...
Building...
...
[INFO]  Verified short payload binding: address=0x..., size=37 bytes, content matched
[INFO]  Updated one aclDataBuffer from 37 to 83 bytes
[INFO]  Verified long payload binding: address=0x..., size=83 bytes, content matched
[INFO]  [SUCCESS] Reusable data buffer sample completed successfully
[SUCCESS] Reusable data buffer sample executed successfully.
```
