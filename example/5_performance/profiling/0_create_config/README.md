## 0_create_config

## 描述
本样例展示了采集并落盘性能数据。通过调用API方式使能性能数据采集功能，从而自动采集性能原始数据。采集性能原始数据成功后，可将采集的原始数据拷贝到装有工具的开发环境上进行原始性能数据解析，可视化展示原始性能数据解析结果。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../../README.md)。


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
- Profiling 初始化与配置
    - 调用 `aclprofInit` 接口初始化 Profiling 并设置性能数据输出路径。
    - 调用 `aclprofCreateConfig` 接口创建采集配置。
    - 调用 `aclprofSetConfig` 接口设置采集参数。
    - 调用 `aclprofDestroyConfig` 接口释放 Profiling 配置。
    - 调用 `aclprofFinalize` 接口结束 Profiling。
- Profiling 采集控制
    - 调用 `aclprofStart` 接口开启 Profiling 数据采集。
    - 调用 `aclprofStop` 接口停止 Profiling 数据采集。

## 已知issue

   暂无
