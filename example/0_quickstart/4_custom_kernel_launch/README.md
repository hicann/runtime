# 4_custom_kernel_launch

## 概述

CANN 支持对自定义 AscendC Kernel 使用内核调用符 `<<<>>>` 进行调用。

本样例提供一个最小可运行示例，演示如何使用 `<<<>>>` 调用自定义 Kernel 完成 8 元素向量加法。运行成功后，结果应与 [0_hello_cann](../0_hello_cann/README.md) 中的向量加法结果一致。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# ${ascend_name} 替换为昇腾 AI 处理器型号，例如 ascend910b3
export SOC_VERSION=${ascend_name}

# ${cmake_path} 替换为 ascendc.cmake 所在目录
export ASCENDC_CMAKE_DIR=${cmake_path}

# 编译运行
bash run.sh
```

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
- 内存管理与数据传输
    - 调用 `aclrtMalloc` 接口分配 Device 内存。
    - 调用 `aclrtMemcpy` 接口完成 Host/Device 数据传输。
    - 调用 `aclrtFree` 接口释放 Device 内存。
- Kernel 调用
    - 使用 `<<<>>>` 内核调用符下发自定义 AscendC Kernel。

## 运行结果

样例会打印输入向量、`<<<>>>` 调用成功信息以及最终结果。预期结果如下：

```text
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

如果输出结果与预期一致，说明 CANN 自定义 Kernel 的 `<<<>>>` 调用路径工作正常。

## 相关样例

- [0_hello_cann](../0_hello_cann/README.md)：使用 `aclnnAdd` 完成相同的向量加法。

## 已知 issue

暂无
