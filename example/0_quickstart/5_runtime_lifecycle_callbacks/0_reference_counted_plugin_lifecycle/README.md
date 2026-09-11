# 0_reference_counted_plugin_lifecycle

## 描述

本样例面向需要参与 ACL 生命周期的插件开发者：先注册有效和待取消的初始化回调，取消后者并完成 ACL 初始化与单 Device 业务；再注册有效和待取消的去初始化回调，取消后者并通过引用计数方式去初始化。样例验证有效回调各执行一次、已注销回调均不执行、Device 0 设置生效且最终引用计数为 0。全部接口静态支持 Atlas A2、Atlas A3 和 Ascend 950 系列产品。

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Ascend 950PR/Ascend 950DT | √ |

## 编译运行

1. 下载样例代码至安装 CANN 软件的环境，切换到样例目录。

```bash
cd ${git_clone_path}/example/0_quickstart/5_runtime_lifecycle_callbacks/0_reference_counted_plugin_lifecycle
```

2. 设置环境变量。

```bash
# ${install_root} 替换为 CANN 安装根目录
source ${install_root}/set_env.sh
source ${git_clone_path}/example/set_sample_env.sh
```

3. 执行以下命令编译并运行样例。

```bash
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：

- 初始化回调管理
    - 调用 `aclInitCallbackRegister` 注册插件初始化动作。
    - 调用 `aclInitCallbackUnRegister` 注销不应执行的初始化动作，并在结束时注销有效回调。
- ACL 生命周期管理
    - 调用 `aclInit` 执行初始化并触发仍有效的初始化回调。
    - 调用 `aclFinalizeCallbackRegister` 注册插件去初始化动作。
    - 调用 `aclFinalizeCallbackUnRegister` 注销不应执行的去初始化动作，并在结束时注销有效回调。
    - 调用 `aclFinalizeReference` 递减引用计数，在归零时完成去初始化并触发仍有效的去初始化回调。
- Device 业务验证
    - 调用 `aclrtSetDevice` 选择本样例使用的 Device 0。
    - 调用 `aclrtGetDevice` 回读当前 Device，并校验选择结果。
    - 调用 `aclrtResetDeviceForce` 复位 Device 0 并回收设备资源。

## 示例输出

```text
[INFO]  Start to run 0_reference_counted_plugin_lifecycle sample.
[INFO]  Initialization callbacks verified: active=1, cancelled=0.
[INFO]  Device 0 selected and verified.
[INFO]  Plugin lifecycle verified: active_init=1, cancelled_init=0, active_finalize=1, cancelled_finalize=0, reference=0.
[INFO]  Run the 0_reference_counted_plugin_lifecycle sample successfully.
```
