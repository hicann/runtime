# 0_context_query

## 描述

本样例演示如何在单 Device、单线程场景下创建 Context、设置当前线程 Context，并查询当前 Context、默认 Stream 和当前线程资源限制。

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
cd ${git_clone_path}/example/1_basic_features/context/0_context_query
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
    - 调用 `aclrtResetDeviceForce` 接口复位当前 Device。
    - 调用 `aclFinalize` 接口完成 ACL 去初始化。
- Context 管理
    - 调用 `aclrtCreateContext` 接口创建 Context。
    - 调用 `aclrtSetCurrentContext` 接口设置当前线程 Context。
    - 调用 `aclrtGetCurrentContext` 接口查询当前线程 Context。
    - 调用 `aclrtCtxGetCurrentDefaultStream` 接口查询当前 Context 的默认 Stream。
    - 调用 `aclrtDestroyContext` 接口销毁 Context。
- 资源限制查询
    - 调用 `aclrtGetResInCurrentThread` 接口查询当前线程资源限制。

## 示例输出

样例运行成功时，输出如下：

```text
[INFO]  Get current context successfully
[INFO]  Get current default stream successfully, stream=<stream_pointer>
[INFO]  Get current thread cube core limit: <cube_core_limit>
[INFO]  Get current thread vector core limit: <vector_core_limit>
[INFO]  [SUCCESS] Context query sample completed successfully
[SUCCESS] Context query sample executed successfully.
```
