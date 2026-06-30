# 0_hello_cann

## 描述

本样例是使用Runtime接口的快速入门示例。以 CANN 神经网络算子库提供的 `aclnnAdd` 向量加法算子为入口，展示一个最小计算闭环：完成初始化配置，指定 Device 并创建 Stream，准备输入/输出 Tensor 和输出 DataBuffer，查询并申请 workspace，执行 `out = self + alpha * other`，同步获取结果并释放资源。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

环境安装详情以及通用运行步骤请见 example 目录下的 [README](../../README.md)。

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化
    - 调用 `aclInit` 接口进行初始化配置。
    - 调用 `aclFinalize` 接口实现去初始化。
- Device 与 Stream 管理
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtCreateStream` 接口创建 Stream。
    - 调用 `aclrtSynchronizeStream` 接口阻塞等待 Stream 上任务完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。
    - 调用 `aclrtResetDeviceForce` 接口强制复位当前运算的 Device，回收 Device 上的资源。
- Tensor 与数据描述
    - 调用 `aclCreateTensor` 接口创建输入和输出 Tensor。
    - 调用 `aclCreateScalar` 接口创建缩放因子 `alpha`。
    - 调用 `aclCreateDataBuffer` 和 `aclGetDataBufferAddr` 接口管理输出 Buffer。
    - 调用 `aclDestroyTensor`、`aclDestroyScalar` 和 `aclDestroyDataBuffer` 接口释放描述对象。
- 内存管理与数据传输
    - 调用 `aclrtMalloc` 接口申请 Device 上的内存。
    - 调用 `aclrtMemcpy` 接口完成 Host/Device 数据传输。
    - 调用 `aclrtFree` 接口释放 Device 上的内存。
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

```text
ACL init successfully
Set device 0 successfully
Create stream successfully
Input vectors:
  self:   [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
  other:  [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
  alpha:  1.0
Create output aclDataBuffer successfully, buffer addr = 0x...
Get workspace size successfully, workspace size = ...
Launch aclnnAdd successfully
Synchronize stream successfully

Vector addition result:
  result[0] = 1.5 (expected: 1.5)
  result[1] = 3.0 (expected: 3.0)
  result[2] = 4.5 (expected: 4.5)
  result[3] = 6.0 (expected: 6.0)
  result[4] = 7.5 (expected: 7.5)
  result[5] = 9.0 (expected: 9.0)
  result[6] = 10.5 (expected: 10.5)
  result[7] = 12.0 (expected: 12.0)

Sample run successfully!
```

## 相关样例

- [4_custom_kernel_launch](../4_custom_kernel_launch/README.md)：如果需要使用 `<<<>>>` 调用自定义 AscendC Kernel，可参考该样例。
