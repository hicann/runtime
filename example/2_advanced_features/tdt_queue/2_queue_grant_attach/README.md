# 2_queue_grant_attach

## 概述

本示例演示 TDT Queue 的权限授予与附加流程，并补充 EnqueueData / DequeueData 形式的数据收发。

## 产品支持情况

本样例关键接口在不同产品上的支持情况如下：

| 接口 | Atlas A3 训练系列产品/Atlas A3 推理系列产品 | Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| --- | --- | --- |
| acltdtCreateQueueAttr | √ | √ |
| acltdtSetQueueAttr | √ | √ |
| acltdtCreateQueue | √ | √ |
| acltdtDestroyQueueAttr | √ | √ |
| acltdtGrantQueue | x | x |
| acltdtAttachQueue | x | x |
| acltdtEnqueueData | √ | √ |
| acltdtDequeueData | √ | √ |
| acltdtDestroyQueue | √ | √ |

## 功能说明

- 创建 Queue 后向当前进程授予管理、收发权限。
- 附加到同一个 Queue，并读取返回的权限掩码。
- 使用 EnqueueData 写入字符串和用户数据。
- 使用 DequeueData 读取消息体和用户元数据。

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
- Queue创建与属性配置
    - 调用acltdtCreateQueueAttr接口创建Queue属性对象。
    - 调用acltdtSetQueueAttr接口设置Queue名称和深度。
    - 调用acltdtCreateQueue接口创建Queue。
    - 调用acltdtDestroyQueueAttr接口销毁Queue属性对象。
- Queue授权与附加
    - 调用acltdtGrantQueue接口向当前进程授予Queue权限。
    - 调用acltdtAttachQueue接口附加到Queue并读取返回的权限掩码。
- 数据收发
    - 调用acltdtEnqueueData接口写入消息体和用户数据。
    - 调用acltdtDequeueData接口读取消息体和用户元数据。
- 资源释放
    - 调用acltdtDestroyQueue接口销毁Queue。

## 已知 issue

暂无。
