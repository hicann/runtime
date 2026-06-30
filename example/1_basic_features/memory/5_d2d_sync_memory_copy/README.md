# 5_d2d_sync_memory_copy

## 描述
本样例展示 Device 内同步内存复制，使用 `aclrtMemcpy` 接口完成数据传输。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1.下载样例代码至安装CANN软件的环境，切换到样例目录。
```bash
cd ${git_clone_path}/example/1_basic_features/memory/5_d2d_sync_memory_copy
```

2.设置环境变量。
```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh
```

3.执行以下命令运行样例。
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
    - 调用 `aclrtDestroyStreamForce` 接口强制销毁 Stream，丢弃所有任务。
- 内存管理
    - 调用 `aclrtMalloc` 接口申请 Device 上的内存。
    - 调用 `aclrtFree` 接口释放 Device 上的内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口通过内存复制的方式实现 Device-to-Device 数据传输。

## 示例输出

```text
[INFO]  Allocate memory on the device memory 0x... successfully
[INFO]  Allocate memory on the device memory 0x... successfully
[INFO]  Write the data 123 to the virtual memory 0x...
[INFO]  Copy memory from memory 0x... to memory 0x...
Source data: 123
Destination data: 123
```
