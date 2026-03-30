# 0_shared_buffer

## 概述

本示例演示 TDT Buffer 的共享与链式组织能力，覆盖数据区、用户数据区和引用复制。

## 产品支持情况

本样例在以下产品上的支持情况如下：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

- 分配两个 Buffer 并写入各自的数据载荷。
- 设置并读取有效数据长度。
- 设置并读取用户数据区元信息。
- 复制 Buffer 引用，并把第二个 Buffer 追加到链表中。
- 读取链上 Buffer 数量和指定位置元素。

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
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Buffer分配与数据访问
    - 调用acltdtAllocBuf接口分配Buffer。
    - 调用acltdtGetBufData接口获取Buffer的数据地址和容量。
    - 调用acltdtSetBufDataLen和acltdtGetBufDataLen接口设置并读取Buffer的有效数据长度。
    - 调用acltdtFreeBuf接口释放Buffer。
- 用户数据管理
    - 调用acltdtSetBufUserData和acltdtGetBufUserData接口设置并读取Buffer的用户数据区元信息。
- Buffer引用与链式管理
    - 调用acltdtCopyBufRef接口复制Buffer引用。
    - 调用acltdtAppendBufChain接口把Buffer追加到链中。
    - 调用acltdtGetBufChainNum和acltdtGetBufFromChain接口读取Buffer链上的元素数量和指定位置元素。

## 已知 issue

暂无。
