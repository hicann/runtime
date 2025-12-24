# 2_model_switch

## 描述
本样例展示了如何使用aclmdlRIBuildBegin接口创建模型实例，并且在任务中实现了Stream跳转以及Stream激活。

## 支持的产品型号
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
- Context管理
    - 调用aclrtCreateContext接口创建Context。
    - 调用aclrtDestroyContext接口销毁Context。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream可以阻塞等待Stream上任务的完成。
    - 调用aclrtDestroyStreamForce接口强制销毁Stream，丢弃所有任务。
    - 调用aclrtCreateStreamWithConfig接口创建特殊config的Stream。
    - 调用aclrtSwitchStream接口根据条件在Stream之间跳转。
    - 调用aclrtActiveStream接口激活Stream。
- model管理
    - 调用aclmdlRIBuildBegin接口开始构建一个模型运行实例。
    - 调用aclmdlRIBindStream接口将模型运行实例与Stream绑定。
    - 调用aclmdlRIEndTask接口标记下发任务结束。
    - 调用aclmdlRIBuildEnd接口结束构建模型运行实例。
    - 调用aclmdlRIUnbindStream接口解除模型运行实例与Stream的绑定。
    - 调用aclmdlRIExecuteAsync接口异步执行模型推理。
    - 调用aclmdlRIDestroy接口销毁模型运行实例。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。
    - 调用aclrtMemcpyAsync接口进行异步的内存复制。

## 已知issue

   暂无
