# 2_callback_exception

## 描述
本样例展示了如何通过错误回调函数获取任务异常信息，并在同步失败后补充查询最近错误消息、线程级最后错误和详细设备错误信息，形成更完整的 Runtime 错误处理链。

## 产品支持情况

本样例在以下产品上的支持情况如下：

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

# 自动识别 SOC_VERSION 和 ASCENDC_CMAKE_DIR
source ${git_clone_path}/example/set_sample_env.sh

# 编译运行
bash run.sh
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

## 示例输出

```text
[INFO]  Begin a easy task and a error task, the error task will callback exception.
[INFO]  The last task id is: ...
[INFO]  Exception occurred, callback function.
[INFO]  The error task id is ...
[INFO]  The error stream id is ...
[INFO]  The error thread id is ...
[INFO]  The error device id is ...
[INFO]  The error code id is ...
[ERROR]  aclrtSynchronizeStream(stream_) returned error code ...
[INFO]  Thread exit
[INFO]  Run the callback_exception sample successfully.
```

## 已知 issue

暂无。
