## 12_cross_server_physical_memory_sharing_withoutpid

## 描述
本样例展示了 aclrtMemExportToShareableHandleV2 和 aclrtMemImportFromShareableHandleV2 接口实现跨机物理内存共享，在内存共享时关闭进程白名单校验。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |

## 编译运行
- 环境安装详情请见example目录下的[README](../../../README.md)。
- 本样例用于展示跨服务器共享内存功能，需在两台已完成环境配置且网络互通的服务器上分别运行脚本：
    - 在服务端服务器执行：bash run_server.sh，按提示输入监听端口号。
    - 在客户端服务器执行：bash run_client.sh，按提示输入服务端地址与端口号。

## CANN RUNTIME API
在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtDestroyStreamForce接口强制销毁Stream，丢弃所有任务。
- 内存管理
    - 调用aclrtMemGetAllocationGranularity查询内存申请粒度。
    - 调用aclrtMallocPhysical申请Device物理内存，并返回一个物理内存handle。
    - 调用aclrtReserveMemAddress预留虚拟内存。
    - 调用aclrtMapMem将虚拟内存映射到物理内存。
    - 调用aclrtMemSetAccess设置虚拟内存的访问权限。
    - 调用aclrtMemExportToShareableHandleV2将通过aclrtMallocPhysical接口获取到的物理内存handle导出为跨服务器可共享的句柄。
    - 调用aclrtMemImportFromShareableHandleV2在本进程中获取shareableHandle里的信息，并返回本进程中的handle。
    - 调用aclrtUnmapMem取消虚拟内存与物理内存之间的映射关系。
    - 调用aclrtReleaseMemAddress释放通过aclrtReserveMemAddress接口申请的虚拟内存。
    - 调用aclrtFreePhysical释放通过aclrtMallocPhysical接口申请的物理内存。
    - 调用aclrtMallocHost接口申请Host上的内存。
    - 调用aclrtFreeHost接口释放Host上的内存。

## 已知issue

  暂无
