# 2_callback_exception

## 描述
本样例展示了如何通过错误回调函数获取任务异常信息，并在同步失败后补充查询最近错误消息、线程级最后错误和详细设备错误信息，形成更完整的 Runtime 错误处理链。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 200I/500 A2 推理产品
- Atlas 推理系列产品
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见 example 目录下的 [README](../../README.md)。

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
在该 Sample 中，涉及的关键功能点及其关键接口如下：
- 初始化与资源管理
  - `aclInit` / `aclFinalize`
  - `aclrtSetDevice` / `aclrtResetDeviceForce`
  - `aclrtCreateContext` / `aclrtDestroyContext`
  - `aclrtCreateStream` / `aclrtDestroyStreamForce`
  - `aclrtSetStreamFailureMode`
- 控制回调与异常处理
  - `aclrtSubscribeReport` / `aclrtProcessReport` / `aclrtUnSubscribeReport`
  - `aclrtLaunchCallback`
  - `aclrtSetExceptionInfoCallback`
  - `aclrtGetThreadLastTaskId`
  - `aclrtGetTaskIdFromExceptionInfo`
  - `aclrtGetStreamIdFromExceptionInfo`
  - `aclrtGetThreadIdFromExceptionInfo`
  - `aclrtGetDeviceIdFromExceptionInfo`
  - `aclrtGetErrorCodeFromExceptionInfo`
  - `aclrtGetArgsFromExceptionInfo`
  - `aclrtGetFuncHandleFromExceptionInfo`
  - `aclrtPeekAtLastError` / `aclrtGetLastError`
  - `aclGetRecentErrMsg`
  - `aclrtGetErrorVerbose`
- 内存管理与数据传输
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy`
  - `aclrtSynchronizeStream`

## 已知 issue

暂无。