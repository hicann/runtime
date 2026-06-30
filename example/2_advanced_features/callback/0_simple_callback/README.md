# 0_simple_callback

## 描述
本样例展示了如何为同一个 Stream 同时注册 Report 回调线程和 HostFunc 处理线程，并通过 `aclrtLaunchCallback` 与 `aclrtLaunchHostFunc` 观察两类回调在用户指定线程上的执行行为。

## 产品支持情况

本样例关键接口在不同产品上的支持情况如下：

| 接口 | Atlas A3 训练系列产品/Atlas A3 推理系列产品 | Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| --- | --- | --- |
| aclrtSubscribeReport | √ | √ |
| aclrtProcessReport | √ | √ |
| aclrtUnSubscribeReport | √ | √ |
| aclrtLaunchCallback | √ | √ |
| aclrtSubscribeHostFunc | x | x |
| aclrtProcessHostFunc | x | x |
| aclrtUnSubscribeHostFunc | x | x |
| aclrtLaunchHostFunc | √ | √ |

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
- 控制回调
  - `aclrtSubscribeReport` / `aclrtProcessReport` / `aclrtUnSubscribeReport`
  - `aclrtLaunchCallback`
  - `aclrtSubscribeHostFunc` / `aclrtProcessHostFunc` / `aclrtUnSubscribeHostFunc`
  - `aclrtLaunchHostFunc`
- 内存与数据传输
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy`
  - `aclrtSynchronizeStream`

## 示例输出

```text
[INFO]  The main thread id is ...
[INFO]  The created report thread id is ...
[INFO]  The created hostfunc thread id is ...
[INFO]  After begin a task, launch one hostfunc and five callbacks.
[INFO]  This callback before task, result: user data is: 520.
[INFO]  Hostfunc executed in subscribed thread, user data is: 520.
[INFO]  This callback after task and loop five times, result: user data is: 520.
[INFO]  After assigning the task, the current int is: ...
[INFO]  Report callback thread exit
[INFO]  Hostfunc processing thread exit
```

## 已知 issue

暂无。
