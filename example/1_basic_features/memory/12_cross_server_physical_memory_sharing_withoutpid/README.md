# 12_cross_server_physical_memory_sharing_withoutpid

## 描述
本样例展示通过 `aclrtMemExportToShareableHandleV2` 和 `aclrtMemImportFromShareableHandleV2` 接口实现跨服务器物理内存共享，并在内存共享时关闭进程白名单校验。服务端申请物理内存并导出 Fabric 共享句柄，客户端通过网络接收句柄后导入并映射该物理内存。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | × |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | × |

## 编译运行

本样例依赖跨服务器共享句柄能力，仅面向 Atlas A3 训练系列产品/Atlas A3 推理系列产品，需在两台已完成环境配置且网络互通的服务器上分别运行。

1.下载样例代码至安装CANN软件的环境，在服务端和客户端分别切换到样例目录。
```bash
cd ${git_clone_path}/example/1_basic_features/memory/12_cross_server_physical_memory_sharing_withoutpid
```

2.设置环境变量。

在服务端和客户端分别执行：
```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 设置 SOC_VERSION 和 ASCENDC_CMAKE_DIR
# -SOC_VERSION: 昇腾AI处理器的型号，如 Ascend910_9362，Ascend910B2等
# -ASCENDC_CMAKE_DIR: 样例中涉及调用AscendC算子，需配置AscendC编译器 ascendc.cmake 路径，如 /usr/local/Ascend/cann/x86_64-linux/tikcpp/ascendc_kernel_cmake
source ${git_clone_path}/example/set_sample_env.sh
```

3.先在服务端服务器执行以下命令，并按提示输入监听端口，默认端口为 `8888`。
```bash
bash run_server.sh
```

4.再在客户端服务器执行以下命令，并按提示输入服务端 IP 地址和端口，端口需与服务端监听端口保持一致。
```bash
bash run_client.sh
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
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上的任务完成。
    - 调用 `aclrtDestroyStreamForce` 接口强制销毁 Stream，丢弃所有任务。
- 内存管理
    - 调用 `aclrtMemGetAllocationGranularity` 接口查询内存申请粒度。
    - 调用 `aclrtMallocPhysical` 接口申请 Device 物理内存，并返回物理内存 handle。
    - 调用 `aclrtReserveMemAddress` 接口预留虚拟内存。
    - 调用 `aclrtMapMem` 接口将虚拟内存映射到物理内存。
    - 调用 `aclrtMemSetAccess` 接口设置虚拟内存访问权限。
    - 调用 `aclrtMemExportToShareableHandleV2` 接口将物理内存 handle 导出为跨服务器可共享的 Fabric 句柄；若当前环境不支持跨服务器共享句柄，可能返回 `207000`。
    - 调用 `aclrtMemImportFromShareableHandleV2` 接口导入 Fabric 共享句柄并获取本进程可用的物理内存 handle。
    - 调用 `aclrtUnmapMem` 接口取消虚拟内存与物理内存之间的映射关系。
    - 调用 `aclrtReleaseMemAddress` 接口释放预留的虚拟内存。
    - 调用 `aclrtFreePhysical` 接口释放物理内存。

## 示例输出

服务端典型输出如下：

```text
[INFO]: Current compile soc version is ...
[INFO]: Running server on port ...
[INFO]  Server: get memory allocation granularity successfully, granularity = ...
[INFO]  Server: allocate physical memory successfully
[INFO]  Server: reserve virtual memory successfully
[INFO]  Server: export shareable handle successfully
[INFO]  Server: listening on port ...
[INFO]  Server: send ipc message successfully, size = ...
[INFO]  Server: receive ipc message successfully, flag = 1
[INFO]  Server: ipc close successfully
[INFO]  Server: released memory successfully
[SUCCESS] Server completed successfully.
```

客户端典型输出如下：

```text
[INFO]: Current compile soc version is ...
[INFO]: Running client connecting to ...
[INFO]  Client: send connection message successfully
[INFO]  Client: import shareable handle successfully
[INFO]  Client: reserve virtual memory successfully
[INFO]  Client: map virtual memory address to physical memory handle
[INFO]  Client: released memory successfully
[SUCCESS] Client completed successfully
```

