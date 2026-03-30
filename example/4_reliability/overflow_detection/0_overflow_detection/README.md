# 0_overflow_detection

## 概述

本示例演示流级溢出检测开关、状态查询和重置流程。

## 功能说明

- 为 Stream 打开溢出检测开关，并读取当前配置。
- 获取一次溢出状态并同步到 Host。
- 调用 ResetOverflowStatus 后再次查询状态。
- 销毁 Stream、Context 和状态缓存。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

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

在本样例中，涉及的关键功能点及其关键接口如下所示：
- 初始化与 Context/Stream 管理
    - 调用 `aclInit` 和 `aclFinalize` 接口完成 ACL 初始化与去初始化。
    - 调用 `aclrtSetDevice` 、`aclrtResetDeviceForce` 接口管理 Device。
    - 调用 `aclrtCreateContext` 和 `aclrtDestroyContext` 接口创建和销毁 Context。
    - 调用 `aclrtCreateStream` 、`aclrtSynchronizeStream` 和 `aclrtDestroyStream` 接口管理 Stream。
- 溢出检测状态管理
    - 调用 `aclrtSetStreamOverflowSwitch` 和 `aclrtGetStreamOverflowSwitch` 接口开启或查询 Stream 溢出检测开关。
    - 调用 `aclrtGetOverflowStatus` 接口获取当前溢出状态。
    - 调用 `aclrtResetOverflowStatus` 接口重置溢出状态。
- 内存管理与数据传输
    - 调用 `aclrtMalloc` 和 `aclrtFree` 接口管理状态缓存。
    - 调用 `aclrtMemcpy` 接口将状态数据同步到 Host 侧。

## 已知 issue

暂无。
