## 1_msproftx

## 描述
本样例展示了使用msproftx扩展接口采集并落盘性能数据。为了获取用户和上层框架程序的性能数据，Profiling开启msproftx功能之前，需要在程序内调用msproftx相关接口来对用户程序进行打点以输出对应的性能数据。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。

## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：
- 调用aclprofCreateStamp接口创建msproftx事件标记。
- 调用aaclprofSetStampTraceMessage接口为msproftx事件标记携带字符串描述，在Profiling解析并导出结果中msprof_tx summary数据展示
- 调用aclprofMark接口标记瞬时事件。
- 调用aclprofDestroyStamp接口释放msproftx事件标记。

## 已知issue

   暂无

