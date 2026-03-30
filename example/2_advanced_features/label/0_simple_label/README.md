# 0_simple_label

## 概述

本示例演示 CANN Runtime 的 Label 创建与按索引切换能力，适合作为设备端流程控制的最小示例。

## 产品支持情况

本样例在以下产品上的支持情况如下：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

- 创建两个 Label，并把它们组织成 LabelList。
- 将两个 Label 设置到同一个 Stream 上。
- 在设备内存中准备分支索引，并调用 SwitchLabelByIndex 执行流内切换。
- 同步 Stream 后完成资源销毁。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device与Context管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtCreateContext接口创建Context。
    - 调用aclrtDestroyContext接口销毁Context。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream接口阻塞等待Stream上任务执行完成。
    - 调用aclrtDestroyStream接口销毁Stream。
- 内存管理
    - 调用aclrtMalloc接口申请Device内存存放分支索引。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口将Host侧的分支索引写入Device内存。
- Label创建与切换
    - 调用aclrtCreateLabel和aclrtDestroyLabel接口创建并释放Label。
    - 调用aclrtCreateLabelList和aclrtDestroyLabelList接口组装并释放LabelList。
    - 调用aclrtSetLabel接口在Stream上设置Label。
    - 调用aclrtSwitchLabelByIndex接口根据Device内存中的分支索引执行Label切换。

## 已知 issue

暂无。
