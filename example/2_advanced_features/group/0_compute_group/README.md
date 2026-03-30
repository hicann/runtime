# 0_compute_group

## 概述

本示例演示算力 Group 的数量查询、组信息读取和当前 Group 设置流程。

## 产品支持情况

本样例在以下产品上的支持情况如下：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | x |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | x |

## 功能说明

- 查询设备可见的 Group 数量。
- 创建 GroupInfo 对象并读取全部组信息。
- 读取第一个 Group 的 groupId，并设置为当前 Group。
- 遍历前两个 Group，读取 aicore、aiv 和 sdma 等属性。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device与Context管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtCreateContext接口创建Context。
    - 调用aclrtDestroyContext接口销毁Context。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Group信息管理
    - 调用aclrtGetGroupCount接口查询当前Device可见的Group数量。
    - 调用aclrtCreateGroupInfo、aclrtGetAllGroupInfo和aclrtGetGroupInfoDetail接口创建GroupInfo对象并读取Group详细信息。
    - 调用aclrtDestroyGroupInfo接口释放GroupInfo资源。
- 当前Group设置
    - 调用aclrtSetGroup接口将指定Group设置为当前Group。

## 已知 issue

暂无。
