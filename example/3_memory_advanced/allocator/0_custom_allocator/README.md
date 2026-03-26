# 0_custom_allocator

## 概述

本示例演示自定义 Runtime 分配器描述符的创建、注册和回调函数执行。

## 功能说明

- 定义 alloc/free/allocAdvise/getAddr 四类回调函数。
- 把自定义分配器对象和函数指针注册到 AllocatorDesc。
- 将 AllocatorDesc 绑定到 Stream，并通过 GetByStream 读回注册结果。
- 调用回调执行一次实际的申请、取地址与释放。

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

- aclrtAllocatorCreateDesc / aclrtAllocatorDestroyDesc
- aclrtAllocatorSetAllocFuncToDesc / aclrtAllocatorSetFreeFuncToDesc
- aclrtAllocatorSetAllocAdviseFuncToDesc / aclrtAllocatorSetGetAddrFromBlockFuncToDesc
- aclrtAllocatorSetObjToDesc
- aclrtAllocatorRegister / aclrtAllocatorUnregister / aclrtAllocatorGetByStream

## 已知 issue

暂无。
