# 0_simple_label

## 概述

本示例演示 CANN Runtime 的 Label 创建与按索引切换能力，适合作为设备端流程控制的最小示例。

## 功能说明

- 创建两个 Label，并把它们组织成 LabelList。
- 将两个 Label 设置到同一个 Stream 上。
- 在设备内存中准备分支索引，并调用 SwitchLabelByIndex 执行流内切换。
- 同步 Stream 后完成资源销毁。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

## 运行前环境变量

运行 bash run.sh 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```
## 相关 API

- aclrtCreateLabel / aclrtDestroyLabel / aclrtSetLabel
- aclrtCreateLabelList / aclrtDestroyLabelList
- aclrtSwitchLabelByIndex
- aclrtMalloc / aclrtMemcpy / aclrtSynchronizeStream

## 已知 issue

暂无。
