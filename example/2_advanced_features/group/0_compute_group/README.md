# 0_compute_group

## 概述

本示例演示算力 Group 的数量查询、组信息读取和当前 Group 设置流程。

## 功能说明

- 查询设备可见的 Group 数量。
- 创建 GroupInfo 对象并读取全部组信息。
- 读取第一个 Group 的 groupId，并设置为当前 Group。
- 遍历前两个 Group，读取 aicore、aiv 和 sdma 等属性。

## 编译运行

环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

## 运行前环境变量

运行 bash run.sh 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```
## 相关 API

- aclrtCreateGroupInfo / aclrtDestroyGroupInfo
- aclrtSetGroup / aclrtGetGroupCount
- aclrtGetAllGroupInfo / aclrtGetGroupInfoDetail

## 已知 issue

暂无。
