# Launch Reduce Task Sample

## 概述

本示例展示了如何使用 CANN Runtime 的 `aclrtReduceAsync` API 执行规约（Reduce）操作。规约是并行计算中的常见操作，用于对数组元素进行求和、求最大值等操作。

## 支持的产品型号

- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas A2 推理系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。


## 运行前环境变量

运行 `bash run.sh` 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```
## 相关 API

| API | 说明 |
|-----|------|
| `aclInit` | 初始化 ACL |
| `aclrtSetDevice` | 设置设备 |
| `aclrtCreateStream` | 创建 Stream |
| `aclrtMalloc` | 分配 Device 内存 |
| `aclrtMemcpy` | 内存拷贝 |
| `aclrtReduceAsync` | 异步Reduce(规约)操作 |
| `aclrtSynchronizeStream` | 同步 Stream |
| `aclrtFree` | 释放 Device 内存 |
| `aclrtDestroyStream` | 销毁 Stream |
| `aclrtResetDeviceForce` | 重置设备 |
| `aclFinalize` | 释放 ACL 资源 |

## 核心 API

### aclrtReduceAsync

```c
aclError aclrtReduceAsync(
    void* dst,                    // 输出地址
    const void* src,              // 输入地址
    uint64_t count,               // 数据大小（字节）
    aclrtReduceKind kind,         // 归约类型
    aclDataType type,             // 数据类型
    aclrtStream stream,           // Stream
    void* reserve                 // 预留参数
);
```
### 归约类型

```c
ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM  // 自动求和（前缀和）
```

## 已知issue
  
  暂无