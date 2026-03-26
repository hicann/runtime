# 0_simple_queue

## 概述

本示例演示 TDT Queue 的基本队列能力，覆盖 QueueAttr 配置、Buffer 申请、入队和出队流程。

## 功能说明

- 创建 QueueAttr 并设置名称和深度。
- 读取 QueueAttr 中的名称和深度配置。
- 创建 Queue 后分配 Buffer，写入字符串并设置有效长度。
- 完成 Buffer 入队、出队、数据读取与释放。

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

- acltdtCreateQueue / acltdtDestroyQueue
- acltdtCreateQueueAttr / acltdtDestroyQueueAttr / acltdtSetQueueAttr / acltdtGetQueueAttr
- acltdtAllocBuf / acltdtFreeBuf
- acltdtGetBufData / acltdtSetBufDataLen / acltdtGetBufDataLen
- acltdtEnqueue / acltdtDequeue

## 已知 issue

暂无。
