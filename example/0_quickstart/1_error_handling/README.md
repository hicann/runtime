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

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../README.md)。

## 运行前环境变量

运行 `bash run.sh` 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```

## 相关 API

| API | 说明 |
|-----|------|
| `aclInit` | 初始化 ACL |
| `aclFinalize` | 释放 ACL 资源 |
| `aclrtSetDevice` | 绑定当前设备 |
| `aclrtResetDeviceForce` | 重置当前设备 |
| `aclrtGetRunMode` | 获取当前运行模式 |
| `aclrtPeekAtLastError` | 查询线程级 Runtime 错误码但不清空 |
| `aclrtGetLastError` | 获取并清空线程级 Runtime 错误码 |
| `aclGetRecentErrMsg` | 获取并清空最近一次 ACL 调用失败的错误描述 |
| `aclrtGetErrorVerbose` | 获取设备级详细错误信息 |

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