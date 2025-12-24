# 2_callback_exception

## 描述
本样例展示了如何通过错误回调函数获取任务的异常信息，包括Device ID、Stream ID、Task ID、Error Code等。

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
- Context管理
    - 调用aclrtCreateContext接口创建Context。
    - 调用aclrtDestroyContext接口销毁Context。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream可以阻塞等待Stream上任务的完成。
    - 调用aclrtSetStreamFailureMode可以设置Stream执行任务遇到错误的操作，默认为遇错继续，可以设置为遇错即停。
    - 调用aclrtDestroyStreamForce接口强制销毁Stream，丢弃所有任务。
- 控制回调
    - 调用aclrtSubscribeReport接口绑定流和线程，流后续的回调函数在该线程上执行。
    - 调用aclrtLaunchCallback接口触发回调函数。
    - 调用aclrtProcessReport接口设置超时时间，等待aclrtLaunchCallback接口下发的回调任务执行。
    - 调用aclrtUnSubscribeReport接口解绑流和线程。
    - 调用aclrtSetExceptionInfoCallback接口设置错误回调函数。
    - 调用aclrtGetThreadLastTaskId接口获取下发的最后一个任务的id。
    - 调用aclrtGetTaskIdFromExceptionInfo接口获取发生错误的任务id。
    - 调用aclrtGetStreamIdFromExceptionInfo接口获取发生错误的流id。
    - 调用aclrtGetThreadIdFromExceptionInfo接口获取发生错误的线程id。
    - 调用aclrtGetDeviceIdFromExceptionInfo接口获取发生错误的设备id。
    - 调用aclrtGetErrorCodeFromExceptionInfo接口获取错误码。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。

## 已知issue

   暂无
