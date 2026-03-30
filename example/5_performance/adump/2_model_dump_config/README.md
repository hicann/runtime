## 2_model_dump_config

## 描述
本用例展示了如何使用 `aclmdlInitDump`、`aclmdlSetDump`、`acldumpGetPath` 和 `aclmdlFinalizeDump` 这组模型级 Dump 配置接口，在单算子 API 场景下按配置文件启用 Dump，并查询当前生效的 Dump 输出路径。

## 产品支持情况

本样例支持以下产品：

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

# ${ascend_name} 替换为昇腾AI处理器的型号，可通过 npu-smi info 查看 Name 字段并去掉空格获得，例如 ascend910b3
export SOC_VERSION=${ascend_name}

# 部分样例中涉及调用AscendC算子，需配置AscendC编译器ascendc.cmake所在的路径，如 ${install_root}/cann/aarch64-linux/tikcpp/ascendc_kernel_cmake
# 可在CANN包安装路径下查找ascendc_kernel_cmake，例如find ./ -name ascendc_kernel_cmake，并将${cmake_path}替换为ascendc_kernel_cmake所在路径
export ASCENDC_CMAKE_DIR=${cmake_path}

# 编译运行
bash run.sh
```
## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclmdlInitDump接口初始化Dump配置。
    - 调用aclmdlSetDump接口加载Dump配置文件。
    - 调用acldumpGetPath接口查询当前Dump输出路径。
    - 调用aclmdlFinalizeDump接口结束本次Dump配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream接口阻塞等待Stream上任务的完成。
    - 调用aclrtDestroyStream接口销毁Stream。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。

## 说明

- 本示例将模型级 Dump 配置接口用于单算子 API 场景，便于补充 `adump` 目录中的配置式 Dump 用法。
- 配置文件 `acl.json` 采用单算子 Dump 场景推荐的 `dump_op_switch: on` 配置。

## 已知issue

   暂无
