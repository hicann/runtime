# 0_overflow_detection

## 概述

本示例演示流级溢出检测开关、状态查询和重置流程。

## 功能说明

- 为 Stream 打开溢出检测开关，并读取当前配置。
- 获取一次溢出状态并同步到 Host。
- 调用 ResetOverflowStatus 后再次查询状态。
- 销毁 Stream、Context 和状态缓存。

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

- aclrtSetStreamOverflowSwitch / aclrtGetStreamOverflowSwitch
- aclrtGetOverflowStatus / aclrtResetOverflowStatus
- aclrtMalloc / aclrtMemcpy / aclrtSynchronizeStream

## 已知 issue

暂无。
