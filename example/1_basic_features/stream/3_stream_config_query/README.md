# 3_stream_config_query

## 描述

本样例演示如何使用指定的 Priority 和 Flag 创建 Stream，并查询创建后的 Stream ID、Flag 和 Priority。样例在单 Device 上运行，用于展示配置化 Stream 创建和属性查询的基础流程。

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
cd ${git_clone_path}/example/1_basic_features/stream/3_stream_config_query
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
- Stream 配置与创建
    - 调用 `aclrtCreateStreamWithConfig` 接口，使用指定的 Priority 和 Flag 创建 Stream。
- Stream 查询与同步
    - 调用 `aclrtStreamGetId` 接口查询 Stream ID。
    - 调用 `aclrtStreamGetFlags` 接口查询 Stream Flag。
    - 调用 `aclrtStreamGetPriority` 接口查询 Stream Priority。
    - 调用 `aclrtSynchronizeStream` 接口等待 Stream 上任务完成。
    - 调用 `aclrtDestroyStream` 接口销毁 Stream。

## 示例输出

```text
[INFO]  Create stream with priority=0 flags=0 successfully
[INFO]  Stream id: 1
[INFO]  Stream flags: 0
[INFO]  Stream priority: 0
[INFO]  [SUCCESS] Stream config query sample completed successfully
[SUCCESS] Stream config query sample executed successfully.
```
