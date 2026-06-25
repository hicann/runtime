# 0_basic

## 概述

本示例演示如何使用内存池（Memory Pool）进行流有序（Stream-Ordered）的异步内存分配和释放。

## 功能说明

- 通过 `aclrtMemPoolCreate` 创建设备内存池，配置内存池属性（类型、位置、最大容量）。
- 通过 `aclrtMemPoolSetAttr` 设置内存释放阈值（`ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD`），控制同步后内存是否归还操作系统。
- 通过 `aclrtMemPoolMallocAsync` 在 Stream 上异步分配设备内存。
- 通过 `aclrtMemPoolFreeAsync` 在 Stream 上异步释放设备内存，内存归还内存池而非直接释放物理内存。
- 单次执行场景：演示分配、计算、释放的完整流程。
- 循环迭代场景：演示设置较大释放阈值后，内存池在多次迭代中复用内存的性能优势。

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

# ${ascend_name} 替换为昇腾AI处理器的型号，可通过 npu-smi info 查看 Name 字段并去掉空格获得，例如 ascend910b3
export SOC_VERSION=${ascend_name}

# 部分样例中涉及调用AscendC算子，需配置AscendC编译器ascendc.cmake所在的路径，如 ${install_root}/cann/aarch64-linux/tikcpp/ascendc_kernel_cmake
# 可在CANN包安装路径下查找ascendc_kernel_cmake，例如find ./ -name ascendc_kernel_cmake，并将${cmake_path}替换为ascendc_kernel_cmake所在路径
export ASCENDC_CMAKE_DIR=${cmake_path}

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在本样例中，涉及的关键功能点及其关键接口如下所示：

- 初始化与资源管理
    - 调用 `aclInit` 和 `aclFinalize` 接口完成 ACL 初始化与去初始化。
    - 调用 `aclrtSetDevice` 和 `aclrtResetDevice` 接口管理 Device。
    - 调用 `aclrtCreateContext` 和 `aclrtDestroyContext` 接口创建与销毁 Context。
    - 调用 `aclrtCreateStream` 和 `aclrtDestroyStream` 接口创建与释放 Stream。
- 内存池管理
    - 调用 `aclrtMemPoolCreate` 和 `aclrtMemPoolDestroy` 接口创建与销毁内存池。
    - 调用 `aclrtMemPoolSetAttr` 接口设置内存池属性（如释放阈值）。
- 异步内存操作
    - 调用 `aclrtMemPoolMallocAsync` 接口在 Stream 上异步分配设备内存。
    - 调用 `aclrtMemPoolFreeAsync` 接口在 Stream 上异步释放设备内存。
- 数据传输
    - 调用 `aclrtMemcpyAsync` 接口异步执行 Host-to-Device 和 Device-to-Host 数据传输。
- 同步与事件
    - 调用 `aclrtSynchronizeStream` 接口等待 Stream 上所有任务完成。
    - 调用 `aclrtCreateEvent`、`aclrtRecordEvent`、`aclrtSynchronizeEvent`、`aclrtEventElapsedTime` 接口记录并测量执行时间。
- 主机内存管理
    - 调用 `aclrtMallocHost` 和 `aclrtFreeHost` 接口申请和释放 pinned 主机内存。

## 已知 issue

暂无。
