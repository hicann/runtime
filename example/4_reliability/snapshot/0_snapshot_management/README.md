# 0_snapshot_management

## 概述

本示例演示运行时快照回调注册、状态备份和恢复流程。

## 功能说明

- 为 LOCK / BACKUP / RESTORE / UNLOCK 阶段注册统一的快照回调。
- 执行一次完整的备份流程。
- 再次加锁后执行恢复流程。
- 最后注销全部回调并完成资源释放。

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

- aclrtSnapShotProcessLock / aclrtSnapShotProcessUnlock
- aclrtSnapShotProcessBackup / aclrtSnapShotProcessRestore
- aclrtSnapShotCallbackRegister / aclrtSnapShotCallbackUnregister

## 已知 issue

暂无。
