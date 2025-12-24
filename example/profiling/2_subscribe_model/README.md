## 2_subscribe_model

## 描述
本样例展示了订阅算子信息。通过调用消息订阅接口实现将采集到的Profiling数据解析后写入管道，由用户读入内存，再由用户调用API获取性能数据。当前支持获取网络模型中算子的性能数据，包括算子名称、算子类型名称、算子执行时间等。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。

## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：
- 调用aclprofCreateSubscribeConfig接口，创建模型订阅的配置并且进行模型订阅。
- 调用aclprofModelSubscribe接口进行模型订阅
- 调用aclprofModelUnSubscribe接口释放模型订阅
- 调用aclprofDestroySubscribeConfig释放config指针

## 已知issue

   暂无

