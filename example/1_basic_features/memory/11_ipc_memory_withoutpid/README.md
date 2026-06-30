# 11_ipc_memory_withoutpid

## 描述
本样例展示同一个 Device、两个进程间通过 IPC 共享 Device 内存，并在内存共享时关闭进程白名单校验。进程 A 导出共享内存 key，进程 B 通过 key 导入共享内存并读取数据。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

本样例会由 `run.sh` 同时启动 `proc_a` 和 `proc_b` 两个进程，并通过 `file/` 目录下的临时文件交换共享内存 key 和完成标志。

1.下载样例代码至安装CANN软件的环境，切换到样例目录。
```bash
cd ${git_clone_path}/example/1_basic_features/memory/11_ipc_memory_withoutpid
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
    - 调用 `aclrtIpcMemGetExportKey` 接口将指定 Device 内存设置为 IPC 共享内存，并返回共享内存 key。
    - 调用 `aclrtIpcMemImportByKey` 接口获取 key 信息，并返回本进程可使用的 Device 内存地址。
    - 调用 `aclrtIpcMemClose` 接口关闭 IPC 共享内存。

## 示例输出

```text
[INFO]  Process B: get the shareable memory identifier successfully, shareable identifier = ...
[INFO]  Process B: complete ipc memory sharing
Destination data: 123
[INFO]  Allocate memory on the device 0x... successfully
[INFO]  Write data 123 to the device address 0x...
[INFO]  Process A: get the shareable memory identifier ... successfully
Source data: 123
[INFO]  Process A: receive the completion signal from Process B, completion signal = 1
[SUCCESS] IPC memory sharing successfully. Values at source and destination are equal: 123
```
