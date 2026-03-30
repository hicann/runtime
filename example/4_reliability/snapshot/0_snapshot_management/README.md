# 0_snapshot_management

## 概述

本示例演示运行时快照回调注册、状态备份和恢复流程。

## 功能说明

- 为 LOCK / BACKUP / RESTORE / UNLOCK 阶段注册统一的快照回调。
- 执行一次完整的备份流程。
- 再次加锁后执行恢复流程。
- 最后注销全部回调并完成资源释放。

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
- 初始化
    - 调用 `aclInit` 和 `aclFinalize` 接口完成 ACL 初始化与去初始化。
    - 调用 `aclrtSetDevice` 和 `aclrtResetDeviceForce` 接口管理 Device。
- 快照回调管理
    - 调用 `aclrtSnapShotCallbackRegister` 接口为 LOCK、BACKUP、RESTORE 和 UNLOCK 阶段注册快照回调。
    - 调用 `aclrtSnapShotCallbackUnregister` 接口注销快照回调。
- 快照备份与恢复
    - 调用 `aclrtSnapShotProcessLock` 和 `aclrtSnapShotProcessUnlock` 接口对快照流程进行加锁与解锁。
    - 调用 `aclrtSnapShotProcessBackup` 和 `aclrtSnapShotProcessRestore` 接口完成状态备份和恢复。

## 已知 issue

暂无。
