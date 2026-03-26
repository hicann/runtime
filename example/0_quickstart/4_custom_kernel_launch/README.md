# 4_custom_kernel_launch

## 概述

CANN 支持对自定义 AscendC Kernel 使用内核调用符 `<<<>>>` 进行调用。

本样例提供一个最小可运行示例，演示如何使用 `<<<>>>` 调用自定义 Kernel 完成 8 元素向量加法。运行成功后，结果应与 [0_hello_cann](../0_hello_cann/README.md) 中的向量加法结果一致。

## 支持的产品型号

- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 200I/500 A2 推理产品
- Atlas 推理系列产品
- Atlas 训练系列产品

## 运行前环境变量

运行前，请先在同一个 shell 中设置以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 /usr/local/Ascend 目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# ${ascend_name} 替换为昇腾 AI 处理器型号，例如 ascend910b3
export SOC_VERSION=${ascend_name}

# ${cmake_path} 替换为 ascendc.cmake 所在目录
export ASCENDC_CMAKE_DIR=${cmake_path}
```

## 编译运行

```bash
cd ${git_clone_path}/example/0_quickstart/4_custom_kernel_launch
bash run.sh
./build/main
```

`run.sh` 只负责构建；构建成功后，执行 `./build/main` 运行样例。

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