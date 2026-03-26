# 0_shared_buffer

## 概述

本示例演示 TDT Buffer 的共享与链式组织能力，覆盖数据区、用户数据区和引用复制。

## 功能说明

- 分配两个 Buffer 并写入各自的数据载荷。
- 设置并读取有效数据长度。
- 设置并读取用户数据区元信息。
- 复制 Buffer 引用，并把第二个 Buffer 追加到链表中。
- 读取链上 Buffer 数量和指定位置元素。

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

- acltdtAllocBuf / acltdtFreeBuf
- acltdtGetBufData / acltdtSetBufDataLen / acltdtGetBufDataLen
- acltdtSetBufUserData / acltdtGetBufUserData
- acltdtCopyBufRef
- acltdtAppendBufChain / acltdtGetBufChainNum / acltdtGetBufFromChain

## 已知 issue

暂无。
