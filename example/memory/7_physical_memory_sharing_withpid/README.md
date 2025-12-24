## 7_physical_memory_sharing_withpid

## 描述
本样例展示了同一个Device、两个进程间的物理内存共享，但在共享内存时启用进程白名单校验。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品 
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 200I/500 A2 推理产品
- Atlas 推理系列产品
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。

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
    - 调用aclrtMemExportToShareableHandle将通过aclrtMallocPhysical接口获取到的物理内存handle导出。
    - 调用aclrtMemSetPidToShareableHandle设置共享内存的进程白名单。
    - 调用aclrtUnmapMem取消虚拟内存与物理内存之间的映射关系。
    - 调用aclrtReleaseMemAddress释放通过aclrtReserveMemAddress接口申请的虚拟内存。
    - 调用aclrtFreePhysical释放通过aclrtMallocPhysical接口申请的物理内存。
    - 调用aclrtDeviceGetBareTgid获取当前进程的进程ID。
    - 调用aclrtMemImportFromShareableHandle在本进程中获取shareableHandle里的信息，并返回本进程中的handle。
    - 调用aclrtMallocHost接口申请Host上的内存。
    - 调用aclrtFreeHost接口释放Host上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。

## 已知issue

  暂无
