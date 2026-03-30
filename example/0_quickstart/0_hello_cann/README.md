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

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../README.md)。


运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## 相关样例

- [4_custom_kernel_launch](../4_custom_kernel_launch/README.md)：如果需要使用 `<<<>>>` 调用自定义 AscendC Kernel，可参考该样例。

## CANN RUNTIME API

在本样例中，涉及的关键功能点及其关键接口如下所示：
- 初始化
    - 调用 `aclInit` 接口初始化 ACL。
    - 调用 `aclFinalize` 接口释放 ACL 资源。
- Device 与 Stream 管理
    - 调用 `aclrtSetDevice` 接口设置计算设备。
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口等待 Stream 上任务完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtResetDeviceForce` 接口重置设备。
- Tensor 与数据描述
    - 调用 `aclCreateTensor` 接口创建输入和输出 Tensor。
    - 调用 `aclCreateScalar` 接口创建缩放因子 `alpha`。
    - 调用 `aclCreateDataBuffer` 和 `aclGetDataBufferAddr` 接口管理输出 Buffer。
    - 调用 `aclDestroyTensor`、`aclDestroyScalar` 和 `aclDestroyDataBuffer` 接口释放描述对象。
- 内存管理与数据传输
    - 调用 `aclrtMalloc` 接口分配 Device 内存。
    - 调用 `aclrtMemcpy` 接口完成 Host/Device 数据传输。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- 算子执行
    - 调用 `aclnnAddGetWorkspaceSize` 接口查询算子执行所需 workspace。
    - 调用 `aclnnAdd` 接口执行向量加法。

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
