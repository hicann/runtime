# 1_context_scoped_determinism

## 描述

本样例演示单 Device 应用如何观察默认 Context 的激活状态，并为两个显式创建的 Context 分别配置不同的确定性计算模式。样例通过切换 Context 后再次读回各自的配置来验证作用域隔离；运行结束前会恢复原有的进程级配置。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | :---: |
| Ascend 950PR/Ascend 950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/1_basic_features/context/1_context_scoped_determinism
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在 `/usr/local/Ascend` 目录
source ${install_root}/cann/set_env.sh
```

3. 执行以下命令运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该 Sample 中，涉及的关键功能点及其关键接口如下所示：

- 初始化与 Device 管理
    - 调用 `aclInit` 接口完成 ACL 初始化。
    - 调用 `aclrtSetDevice` 接口指定用于运算的 Device。
    - 调用 `aclrtGetPrimaryCtxState` 接口查询默认 Context 的激活状态。
    - 调用 `aclrtResetDeviceForce` 接口复位当前 Device。
    - 调用 `aclFinalize` 接口完成 ACL 去初始化。
- 进程级确定性配置
    - 调用 `aclrtGetSysParamOpt` 接口查询进程级确定性计算配置。
    - 调用 `aclrtSetSysParamOpt` 接口设置或恢复进程级确定性计算配置。
- Context 管理与确定性配置
    - 调用 `aclrtCreateContext` 接口创建 Context。
    - 调用 `aclrtSetCurrentContext` 接口设置当前线程 Context。
    - 调用 `aclrtCtxSetSysParamOpt` 接口设置当前 Context 的确定性计算配置。
    - 调用 `aclrtCtxGetSysParamOpt` 接口查询当前 Context 的确定性计算配置。
    - 调用 `aclrtDestroyContext` 接口销毁 Context。

## 示例输出

样例运行成功时，输出如下：

```text
[INFO]  Default Context before aclrtSetDevice: inactive
[INFO]  Default Context after aclrtSetDevice: active
[INFO]  Saved process deterministic mode: 0
[INFO]  Process deterministic mode set to: 2
[INFO]  Context A deterministic mode: 1
[INFO]  Context B deterministic mode: 0
[INFO]  Context A deterministic mode after switching back: 1
[INFO]  Context B deterministic mode after switching back: 0
[INFO]  Context-scoped deterministic modes are isolated successfully
[INFO]  Restored process deterministic mode: 0
[INFO]  Default Context after aclrtResetDeviceForce: inactive
[INFO]  [SUCCESS] Context-scoped determinism sample completed successfully
[SUCCESS] Context-scoped determinism sample executed successfully.
```
