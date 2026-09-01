# 0_simple_callback

## 描述
本样例展示了如何通过 `aclrtLaunchHostFunc` 在 Stream 上下发 Host 回调任务，在 NPU 任务执行前后插入 CPU 回调函数。该接口内部自动创建并管理回调线程，无需用户自行创建线程和注册。

## 产品支持情况

本样例关键接口在不同产品上的支持情况如下：

| 接口 | Ascend 950PR/Ascend 950DT | Atlas A3 训练系列产品/Atlas A3 推理系列产品 | Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| --- | --- | --- | --- |
| aclrtLaunchHostFunc | √ | √ | √ |

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
- Host 回调
  - `aclrtLaunchHostFunc`
- 内存与数据传输
  - `aclrtMalloc` / `aclrtFree`
  - `aclrtMemcpy`
  - `aclrtSynchronizeStream`

## 示例输出

```text
[INFO]  This callback before task, result: user data is: 520.
[INFO]  After begin a task, launch one hostfunc.
[INFO]  This callback after task, result: user data is: 520.
[INFO]  After assigning the task, the current int is: ...
```

## 已知 issue

暂无。
