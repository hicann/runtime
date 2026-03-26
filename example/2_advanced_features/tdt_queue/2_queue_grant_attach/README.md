# 2_queue_grant_attach

## 概述

本示例演示 TDT Queue 的权限授予与附加流程，并补充 EnqueueData / DequeueData 形式的数据收发。

## 功能说明

- 创建 Queue 后向当前进程授予管理、收发权限。
- 附加到同一个 Queue，并读取返回的权限掩码。
- 使用 EnqueueData 写入字符串和用户数据。
- 使用 DequeueData 读取消息体和用户元数据。

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

- acltdtGrantQueue / acltdtAttachQueue
- acltdtEnqueueData / acltdtDequeueData
- acltdtCreateQueue / acltdtDestroyQueue
- acltdtCreateQueueAttr / acltdtDestroyQueueAttr / acltdtSetQueueAttr

## 已知 issue

暂无。
