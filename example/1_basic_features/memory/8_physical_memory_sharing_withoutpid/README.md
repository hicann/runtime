# 8_physical_memory_sharing_withoutpid

## 描述
本样例展示同一个 Device、两个进程间的物理内存共享，并在共享内存时关闭进程白名单校验。进程 A 申请物理内存并导出共享句柄，进程 B 导入该句柄后映射虚拟内存并读取共享数据。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

本样例会由 `run.sh` 同时启动 `proc_a` 和 `proc_b` 两个进程，并通过 `file/` 目录下的临时文件交换共享句柄和完成标志。

1.下载样例代码至安装CANN软件的环境，切换到样例目录。
```bash
cd ${git_clone_path}/example/1_basic_features/memory/8_physical_memory_sharing_withoutpid
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
    - 调用 `aclrtMemGetAllocationGranularity` 接口查询内存申请粒度。
    - 调用 `aclrtMallocPhysical` 接口申请 Device 物理内存，并返回物理内存 handle。
    - 调用 `aclrtReserveMemAddress` 接口预留虚拟内存。
    - 调用 `aclrtMapMem` 接口将虚拟内存映射到物理内存。
    - 调用 `aclrtMemSetAccess` 接口设置虚拟内存访问权限。
    - 调用 `aclrtMemExportToShareableHandle` 接口导出物理内存共享句柄。
    - 调用 `aclrtMemImportFromShareableHandle` 接口导入共享句柄并获取本进程可用的物理内存 handle。
    - 调用 `aclrtUnmapMem` 接口取消虚拟内存与物理内存之间的映射关系。
    - 调用 `aclrtReleaseMemAddress` 接口释放预留的虚拟内存。
    - 调用 `aclrtFreePhysical` 接口释放物理内存。
    - 调用 `aclrtMallocHost` 接口申请 Host 上的内存。
    - 调用 `aclrtFreeHost` 接口释放 Host 上的内存。
- 数据传输
    - 调用 `aclrtMemcpy` 接口通过内存复制的方式实现数据传输。

## 示例输出

进程 A 典型输出如下：

```text
[INFO]  Process A: allocate physical memory successfully
[INFO]  Process A: reserve virtual memory successfully
[INFO]  Process A: export a shareable handle successfully, shareable handle = ...
Source data: 123
[INFO]  Process A: receive the completion signal from Process B, completion signal = 1
[INFO]  Process A: release the virtual and physical memory successfully
```

进程 B 典型输出如下：

```text
[INFO]  Process B: get a shareable handle successfully, shareable handle = ...
[INFO]  Process B: map virtual memory address to physical memory handle
[INFO]  Process B: copy memory from device address 0x... to host address 0x...
[INFO]  Destination data: 123
[INFO]  Process B: complete the physical memory sharing
[INFO]  Process B: release the virtual and physical memory successfully
```
