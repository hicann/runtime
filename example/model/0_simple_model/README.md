# 0_simple_model

## 描述
本样例展示了如何捕获Stream中的任务并创建一个模型实例，然后执行该模型实例得到结果。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品 
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件

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
- model管理
    - 调用aclmdlRICaptureBegin接口开始捕获模式。
    - 调用aclmdlRICaptureThreadExchangeMode接口更换model的捕获模式。
    - 调用aclmdlRICaptureEnd接口结束捕获模式，并得到modelRI句柄。
    - 调用aclmdlRIDebugJsonPrint接口在维测场景下将模型运行实例信息以JSON格式导出到文件中。
    - 调用aclmdlRIExecuteAsync接口异步执行执行模型推理。
    - 调用aclmdlRIDestroy接口销毁模型运行实例。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtMallocHost接口申请Host上的锁页内存。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。
    - 调用aclrtMemcpyAsync接口进行异步的内存复制。

## 已知issue

   暂无
