# 2_device_P2P

## 描述
本样例展示了如何在多个Device之间进行切换，并进行内存复制。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 推理系列产品
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。

## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtDeviceCanAccessPeer接口查询Device之间是否支持数据交互。
    - 调用aclrtDeviceEnablePeerAccess接口使能当前Device与指定Device之间的数据交互。 
    - 调用aclrtDeviceDisablePeerAccess接口关闭当前Device与指定Device之间的数据交互功能。
    - 调用aclrtSynchronizeDevice接口阻塞等待正在运算中的device完成运算。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtMallocHost接口申请Host上的内存。
    - 调用aclrtFree接口释放Device上的内存。
    - 调用aclrtFreeHost接口释放Host上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。


## 已知issue

   暂无

