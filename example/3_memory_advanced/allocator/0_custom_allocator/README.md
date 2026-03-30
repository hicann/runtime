# 0_custom_allocator

## 概述

本示例演示自定义 Runtime 分配器描述符的创建、注册和回调函数执行。

## 功能说明

- 定义 alloc/free/allocAdvise/getAddr 四类回调函数。
- 把自定义分配器对象和函数指针注册到 AllocatorDesc。
- 将 AllocatorDesc 绑定到 Stream，并通过 GetByStream 读回注册结果。
- 调用回调执行一次实际的申请、取地址与释放。

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
- 初始化与 Stream 管理
    - 调用 `aclInit` 和 `aclFinalize` 接口完成 ACL 初始化与去初始化。
    - 调用 `aclrtSetDevice` 、`aclrtResetDeviceForce` 接口管理 Device。
    - 调用 `aclrtCreateStream` 和 `aclrtDestroyStream` 接口创建与释放 Stream。
- AllocatorDesc 描述符管理
    - 调用 `aclrtAllocatorCreateDesc` 和 `aclrtAllocatorDestroyDesc` 接口创建和销毁 AllocatorDesc。
    - 调用 `aclrtAllocatorSetObjToDesc` 、`aclrtAllocatorSetAllocFuncToDesc` 、`aclrtAllocatorSetFreeFuncToDesc` 、`aclrtAllocatorSetAllocAdviseFuncToDesc` 和 `aclrtAllocatorSetGetAddrFromBlockFuncToDesc` 接口绑定自定义分配器对象与回调函数。
- Allocator 注册与查询
    - 调用 `aclrtAllocatorRegister` 和 `aclrtAllocatorUnregister` 接口完成自定义分配器的注册与注销。
    - 调用 `aclrtAllocatorGetByStream` 接口按 Stream 查询当前生效的 Allocator 配置。

## 已知 issue

暂无。
