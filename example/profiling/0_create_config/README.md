## 0_create_config

## 描述
本样例展示了采集并落盘性能数据。通过调用API方式使能性能数据采集功能，从而自动采集性能原始数据。采集性能原始数据成功后，可将采集的原始数据拷贝到装有工具的开发环境上进行原始性能数据解析，可视化展示原始性能数据解析结果。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。

## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：
- 调用aclprofInit接口初始化Profiling，目前用于设置保存性能数据的文件的路径。
- 调用aclprofCreateConfig接口创建采集配置
- 调用aclprofSetConfig接口，用于设置性能数据采集参数。
- 调用aclprofStart接口下发Profiling请求，使能对应数据的采集。
- 调用aclprofStop接口停止Profiling数据采集。
- 调用aclprofFinalize接口结束Profiling。

## 已知issue

   暂无

