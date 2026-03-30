# 0_simple_queue

## 概述

本示例演示 TDT Queue 的基本队列能力，覆盖 QueueAttr 配置、Buffer 申请、入队和出队流程。

## 产品支持情况

本样例关键接口在不同产品上的支持情况如下：

| 接口 | Atlas A3 训练系列产品/Atlas A3 推理系列产品 | Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| --- | --- | --- |
| acltdtCreateQueueAttr | √ | √ |
| acltdtSetQueueAttr | √ | √ |
| acltdtGetQueueAttr | √ | √ |
| acltdtCreateQueue | √ | √ |
| acltdtDestroyQueueAttr | √ | √ |
| acltdtDestroyQueue | √ | √ |
| acltdtAllocBuf | x | x |
| acltdtGetBufData | x | x |
| acltdtSetBufDataLen | x | x |
| acltdtGetBufDataLen | x | x |
| acltdtEnqueue | x | x |
| acltdtDequeue | x | x |
| acltdtFreeBuf | x | x |

## 功能说明

- 创建 QueueAttr 并设置名称和深度。
- 读取 QueueAttr 中的名称和深度配置。
- 创建 Queue 后分配 Buffer，写入字符串并设置有效长度。
- 完成 Buffer 入队、出队、数据读取与释放。

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
- Queue属性配置
    - 调用acltdtCreateQueueAttr接口创建Queue属性对象。
    - 调用acltdtSetQueueAttr接口设置Queue名称和深度。
    - 调用acltdtGetQueueAttr接口读取Queue属性中的名称和深度配置。
    - 调用acltdtDestroyQueueAttr接口销毁Queue属性对象。
- Queue与Buffer管理
    - 调用acltdtCreateQueue和acltdtDestroyQueue接口创建并销毁Queue。
    - 调用acltdtAllocBuf接口申请Buffer。
    - 调用acltdtGetBufData接口获取Buffer可写地址和容量。
    - 调用acltdtSetBufDataLen和acltdtGetBufDataLen接口设置并读取Buffer有效数据长度。
    - 调用acltdtFreeBuf接口释放Buffer。
- 数据收发
    - 调用acltdtEnqueue接口完成Buffer入队。
    - 调用acltdtDequeue接口完成Buffer出队。

## 已知 issue

暂无。
