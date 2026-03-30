# Launch Reduce Task Sample

## 概述

本示例展示了如何使用 CANN Runtime 的 `aclrtReduceAsync` API 执行规约（Reduce）操作。规约是并行计算中的常见操作，用于对数组元素进行求和、求最大值等操作。

## 产品支持情况

本样例在以下产品上的支持情况如下：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../../README.md)。


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
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream接口阻塞等待Stream上任务执行完成。
    - 调用aclrtDestroyStream接口销毁Stream。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口在Host与Device之间拷贝输入输出数据。
- Reduce任务执行
    - 调用aclrtReduceAsync接口在Stream上异步执行Reduce操作。

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
