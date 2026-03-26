# 2_cntnotify

## 描述
- 该特性当前阶段为预留功能
- 本样例展示在流间使用CntNotify进行同步的场景，包括创建、记录、等待、复位、获取ID和销毁的操作。

## 支持的产品型号
- 该特性当前为试验阶段，暂未明确支持的产品型号

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
在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Context管理
    - 调用aclrtCreateContext接口创建Context。
    - 调用aclrtDestroyContext接口销毁Context。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream可以阻塞等待Stream上任务的完成。
    - 调用aclrtDestroyStreamForce接口强制销毁Stream，丢弃所有任务。
- CntNotify管理
    - 调用aclrtCntNotifyCreate接口创建CntNotify。
    - 调用aclrtCntNotifyRecord接口在指定Stream上记录一个CntNotify。
    - 调用aclrtCntNotifyWaitWithTimeout接口阻塞指定Stream的运行，直到指定的CntNotify完成。
    - 调用aclrtCntNotifyReset接口复位一个CntNotify，将CntNotify的计数值清空为0。
    - 调用aclrtCntNotifyGetId接口获取CntNotify的ID。
    - 调用aclrtCntNotifyDestroy接口销毁CntNotify。

## 已知issue

   暂无