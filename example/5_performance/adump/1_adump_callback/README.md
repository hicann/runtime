## 1_adump_callback

## 描述
本用例展示了单算子执行场景下如何通过回调函数接收Dump数据块。示例会注册 `acldumpRegCallback` 回调，在回调中解析 `acldumpChunk` 的文件名、偏移、分块标记、flag 和数据预览，并输出汇总统计信息。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。


## 运行前环境变量

运行 `bash run.sh` 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# ${ascend_name} 替换为昇腾AI处理器的型号，可通过 npu-smi info 查看 Name 字段并去掉空格获得，例如 ascend910b3
export SOC_VERSION=${ascend_name}

# 部分样例中涉及调用AscendC算子，需配置AscendC编译器ascendc.cmake所在的路径，如 ${install_root}/cann/aarch64-linux/tikcpp/ascendc_kernel_cmake
# 可在CANN包安装路径下查找ascendc_kernel_cmake，例如find ./ -name ascendc_kernel_cmake，并将${cmake_path}替换为ascendc_kernel_cmake所在路径
export ASCENDC_CMAKE_DIR=${cmake_path}
```
## CANN RUNTIME API

在该sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用acldumpRegCallback接口注册Dump算子信息回调函数。
    - 调用acldumpGetPath接口查询当前Dump输出路径。
    - 调用acldumpUnregCallback接口去注册Dump算子信息回调函数。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtSynchronizeDevice接口阻塞等待正在运算中的Device完成运算。
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

## 本示例新增覆盖

- 回调数据解析：在回调中解析 `acldumpChunk` 的文件名、偏移、是否最后一块、flag 和数据预览。
- `acldumpGetPath`：查询当前Dump输出路径，便于与回调收到的文件名做对应。


## 已知issue

   暂无



