# 1_error_handling

## 概述

本示例演示 Runtime 错误处理的基础模式，参考 CUDA `checkCudaErrors` 的写法，展示如何统一检查 ACL 返回值，并组合使用 `aclrtPeekAtLastError`、`aclrtGetLastError`、`aclGetRecentErrMsg` 与 `aclrtGetErrorVerbose` 获取更完整的诊断信息。

## 功能说明

该样例演示以下内容：
1. 使用统一的检查宏处理 ACL 调用失败。
2. 调用 `aclrtGetRunMode` 获取当前运行模式。
3. 故意触发一次 `aclrtGetRunMode(nullptr)` 参数错误。
4. 使用 `aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL)` 读取线程级 Runtime 错误码而不清空状态。
5. 使用 `aclrtGetLastError(ACL_RT_THREAD_LEVEL)` 获取并清空线程级 Runtime 错误码。
6. 使用 `aclGetRecentErrMsg()` 获取最近一次 ACL 调用失败的错误描述。
7. 使用 `aclrtGetErrorVerbose()` 查询更详细的设备错误摘要信息。
8. 再次读取错误信息，演示错误码和错误描述的清空语义。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在本样例中，涉及的关键功能点及其关键接口如下所示：
- 初始化
    - 调用 `aclInit` 接口初始化 ACL。
    - 调用 `aclFinalize` 接口释放 ACL 资源。
- Device 管理
    - 调用 `aclrtSetDevice` 接口绑定当前设备。
    - 调用 `aclrtResetDeviceForce` 接口重置当前设备。
    - 调用 `aclrtGetRunMode` 接口查询当前运行模式。
- 错误诊断
    - 调用 `aclrtPeekAtLastError` 接口查询线程级 Runtime 错误码而不清空状态。
    - 调用 `aclrtGetLastError` 接口获取并清空线程级 Runtime 错误码。
    - 调用 `aclGetRecentErrMsg` 接口获取最近一次 ACL 调用失败的错误描述。
    - 调用 `aclrtGetErrorVerbose` 接口查询详细的错误摘要信息。

## 示例输出

```text
[INFO]  ACL init and set device successfully
[INFO]  Current run mode: ACL_HOST
[INFO]  Triggering an expected invalid-parameter error with aclrtGetRunMode(nullptr)
[ERROR] Diagnostics: ret=..., peekErr=..., lastErr=..., recentErrMsg=...
[INFO]  Verbose error info: errorType=..., tryRepair=..., hasDetail=...
[INFO]  After diagnostics are consumed once: peekErr=0, lastErr=0, recentErrMsg=<null>
```

## 已知 issue

暂无。
