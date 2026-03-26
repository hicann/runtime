# Quick Start

## 概述

本示例是使用Runtime接口的快速入门示示例。展示了如何使用 CANN Runtime 的 `aclnnAdd` API 执行向量加法操作。`aclnnAdd` 是 CANN 神经网络算子库提供的加法算子，实现了 `out = self + alpha * other` 的运算。

## 功能说明

该样例演示了使用Runtime基础API实现向量加法流程：
1. 初始化 ACL 和设置计算设备
2. 创建输入和输出 Tensor
3. 使用 `aclCreateDataBuffer` 包装输出 Device 内存，并通过 `aclGetDataBufferAddr` 取回 Buffer 地址
4. 创建 alpha Scalar（缩放因子）
5. 调用 `aclnnAddGetWorkspaceSize` 获取所需 workspace 大小
6. 分配 workspace 内存
7. 调用 `aclnnAdd` 执行向量加法运算
8. 同步等待计算完成并获取结果
9. 销毁 `aclDataBuffer` 并释放资源

## 支持的产品型号

- Atlas A3 训练系列产品/Atlas A3 推理系列产品 
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 200I/500 A2 推理产品
- Atlas 推理系列产品
- Atlas 训练系列产品


## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../README.md)。


## 运行前环境变量

运行 `bash run.sh` 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```

## 相关样例

- [4_custom_kernel_launch](../4_custom_kernel_launch/README.md)：如果需要使用 `<<<>>>` 调用自定义 AscendC Kernel，可参考该样例。

## 相关 API

| API | 说明 |
|-----|------|
| `aclInit` | 初始化 ACL |
| `aclrtSetDevice` | 设置设备 |
| `aclrtCreateStream` | 创建 Stream |
| `aclrtMalloc` | 分配 Device 内存 |
| `aclrtMemcpy` | 内存拷贝 |
| `aclCreateDataBuffer` | 创建 DataBuffer，描述一段内存地址和大小 |
| `aclGetDataBufferAddr` | 获取 DataBuffer 中保存的内存地址 |
| `aclCreateTensor` | 创建 Tensor |
| `aclCreateScalar` | 创建 Scalar |
| `aclnnAddGetWorkspaceSize` | 获取加法算子所需 workspace 大小 |
| `aclnnAdd` | 执行加法运算 |
| `aclrtSynchronizeStream` | 同步 Stream |
| `aclDestroyTensor` | 销毁 Tensor |
| `aclDestroyScalar` | 销毁 Scalar |
| `aclDestroyDataBuffer` | 销毁 DataBuffer 描述对象 |
| `aclrtFree` | 释放 Device 内存 |
| `aclrtDestroyStream` | 销毁 Stream |
| `aclrtResetDeviceForce` | 重置设备 |
| `aclFinalize` | 释放 ACL 资源 |

## 核心 API

### aclnnAdd

```c
aclError aclnnAdd(
    void* workspace,         // workspace 地址
    uint64_t workspaceSize,  // workspace 大小
    aclOpExecutor* executor, // 算子执行器
    aclrtStream stream       // Stream
);
```

### aclnnAddGetWorkspaceSize

```c
aclError aclnnAddGetWorkspaceSize(
    const aclTensor* self,   // 第一个输入张量
    const aclTensor* other,  // 第二个输入张量
    const aclScalar* alpha,  // 缩放因子
    aclTensor* out,          // 输出张量
    uint64_t* workspaceSize, // [输出] workspace 大小
    aclOpExecutor** executor // [输出] 算子执行器
);
```

## 运算公式

```
out = self + alpha * other
```

## 示例输出

```
Input vectors:
  self:   [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
  other:  [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
  alpha:  1.0
Create output aclDataBuffer successfully, buffer addr = 0x...

Vector addition result:
  result[0] = 1.5 (expected: 1.5)
  result[1] = 3.0 (expected: 3.0)
  result[2] = 4.5 (expected: 4.5)
  result[3] = 6.0 (expected: 6.0)
  result[4] = 7.5 (expected: 7.5)
  result[5] = 9.0 (expected: 9.0)
  result[6] = 10.5 (expected: 10.5)
  result[7] = 12.0 (expected: 12.0)
```

## 已知 issue

暂无
