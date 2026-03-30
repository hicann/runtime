# 2_system_info

## 概述

本示例演示 Runtime 基础系统信息查询与常用数据类型工具接口，适合作为设备查询类示例前的预热样例。

## 功能说明

该样例演示以下内容：
1. 调用 `aclrtGetVersion` 查询 ACL Runtime API 版本号。
2. 调用 `aclsysGetVersionStr` 和 `aclsysGetVersionNum` 查询 CANN 软件包版本信息。
3. 调用 `aclrtGetRunMode` 判断当前软件栈运行在 Host 还是 Device 模式。
4. 调用 `aclFloatToFloat16` 和 `aclFloat16ToFloat` 演示 float16/float32 转换。
5. 调用 `aclDataTypeSize` 查询常见 `aclDataType` 的字节大小。

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
- 版本信息查询
    - 调用 `aclrtGetVersion` 接口查询 ACL Runtime API 版本号。
    - 调用 `aclsysGetVersionStr` 和 `aclsysGetVersionNum` 接口查询 CANN 软件包版本信息。
- 运行模式与数据类型工具
    - 调用 `aclrtGetRunMode` 接口判断当前运行在 Host 还是 Device 模式。
    - 调用 `aclFloatToFloat16` 和 `aclFloat16ToFloat` 接口完成 float16/float32 相互转换。
    - 调用 `aclDataTypeSize` 接口查询常见 `aclDataType` 的字节大小。

## 示例输出

```text
[INFO]  ACL Runtime API version: 1.2.3
[INFO]  CANN package [runtime] version string: 8.x.x
[INFO]  CANN package [runtime] version number: 8000000
[INFO]  Current run mode: ACL_HOST
[INFO]  Float conversion: 1.625000 -> 0x3e80 -> 1.625000
[INFO]  Data type size: ACL_FLOAT=4, ACL_FLOAT16=2, ACL_INT64=8
```

## 已知 issue

暂无。
