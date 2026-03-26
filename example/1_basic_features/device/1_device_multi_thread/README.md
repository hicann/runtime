## 1_device_multi_thread

## 描述
本用例展示了多线程的场景如何管理Device，主线程中设置Device，设置资源限制，另一个线程获取Device相关信息（例如昇腾AI处理器版本、Device运行模式、Device资源限制）后，再根据Device资源限制下发和执行和函数任务，线程结束时采用aclrtResetDeviceForce接口释放Device上的资源。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 200I/500 A2 推理产品
- Atlas 推理系列产品
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
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtGetSocName接口查询当前运行环境的昇腾AI处理器版本。
    - 调用aclrtGetDeviceCount接口获取可用Device的数量。
    - 调用aclrtQueryDeviceStatus接口查询Device的状态。
    - 调用aclrtGetRunMode接口获取当前AI软件栈的运行模式。
    - 调用aclrtGetDeviceUtilizationRate接口查询Device上Cube、Vector、AI CPU等的利用率。
    - 调用aclrtDeviceGetStreamPriorityRange接口查询硬件支持的Stream最小、最大优先级。
    - 调用aclrtGetDeviceInfo接口获取指定Device的信息。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
    - 调用aclrtSetDeviceResLimit接口设置当前进程的Device资源限制。
    - 调用aclrtGetDeviceResLimit接口获取当前进程的Device资源限制。
    - 调用aclrtResetDeviceResLimit接口重置当前进程的Device资源限制，恢复默认配置。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream接口阻塞等待Stream上任务的完成。
    - 调用aclrtDestroyStream接口销毁Stream。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的内存。
    - 调用aclrtMallocHost接口申请Host上的内存。
    - 调用aclrtFree接口释放Device上的内存。
    - 调用aclrtFreeHost接口释放Host上的内存。
- 数据传输
    - 调用aclrtMemcpy接口通过内存复制的方式实现数据传输。

## 已知issue

   暂无

