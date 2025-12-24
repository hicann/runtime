## 1_ipc_notify_withoutpid

## 描述
本样例展示了两个Device、两个进程间的Notify共享，但在共享Notify时关闭进程白名单校验。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品 
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 推理系列产品

## 编译运行
- 环境准备以及环境变量配置详情请见example目录下的[README](../../README.md)。

## CANN RUNTIME API
在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
    - 调用aclrtDeviceCanAccessPeer接口查询Device之间是否支持数据交互。
    - 调用aclrtDeviceEnablePeerAccess接口使能当前Device与指定Device之间的数据交互。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtDestroyStreamForce接口强制销毁Stream，丢弃所有任务。
    - 调用aclrtSynchronizeStream可以阻塞等待Stream上任务的完成。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtFree接口释放Device上的内存。
    - 调用aclrtIpcMemGetExportKey接口将指定Device内存设置为IPC共享内存，并返回共享内存key。
    - 调用aclrtIpcMemImportByKey接口获取key的信息，并返回本进程可以使用的Device内存地址指针。
    - 调用aclrtIpcMemClose接口关闭IPC共享内存。
- Notify管理
    - 调用aclrtCreateNotify接口创建Notify。
    - 调用aclrtNotifyGetExportKey接口将本进程中指定Notify设置为IPC Notify，并返回key（即Notify共享名称），用于在多Device上不同进程间实现任务同步。
    - 调用aclrtWaitAndResetNotify接口阻塞指定Stream的运行，直到指定的Notify完成，再复位Notify。
    - 调用aclrtDestroyNotify接口销毁Notify。
    - 调用aclrtNotifyImportByKey接口在本进程中获取key的信息，并返回本进程可以使用的Notify指针。
    - 调用aclrtRecordNotify接口在指定Stream上记录一个Notify。


## 已知issue

  暂无

