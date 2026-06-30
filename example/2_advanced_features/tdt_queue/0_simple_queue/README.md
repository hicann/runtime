# 0_simple_queue

## 概述

本样例演示 TDT Queue 的基础队列能力，覆盖 QueueAttr 配置、属性读取，以及 Queue 创建和销毁流程。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

- 创建 QueueAttr 并设置名称和深度。
- 读取 QueueAttr 中的名称和深度配置。
- 创建 Queue，并在样例结束时完成资源销毁。


## 编译运行

环境安装详情以及运行说明请见 example 目录下的 [README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为实际 CANN 安装根目录，默认安装在 /usr/local/Ascend
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在该 Sample 中，涉及的关键功能点及其关键接口如下：

- 初始化
  调用 `aclInit` 接口初始化 AscendCL 配置。
  调用 `aclFinalize` 接口实现 AscendCL 去初始化。
- Device 管理
  调用 `aclrtSetDevice` 接口指定用于运算的 Device。
  调用 `aclrtResetDeviceForce` 接口强制复位当前 Device，回收 Device 上的资源。
- Queue 属性配置
  调用 `acltdtCreateQueueAttr` 接口创建 Queue 属性对象。
  调用 `acltdtSetQueueAttr` 接口设置 Queue 名称和深度。
  调用 `acltdtGetQueueAttr` 接口读取 Queue 属性中的名称和深度配置。
  调用 `acltdtDestroyQueueAttr` 接口销毁 Queue 属性对象。
- Queue 管理
  调用 `acltdtCreateQueue` 和 `acltdtDestroyQueue` 接口创建并销毁 Queue。

## 示例输出

```text
[INFO]  QueueAttr name=simple_queue, depth=4
[INFO]  Created queue id=...
[INFO]  Run the simple_queue sample successfully.
```

## 已知 issue

暂无。
