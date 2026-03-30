## 1_msproftx

## 描述
本样例展示了使用 msproftx 扩展接口采集并落盘性能数据。除了瞬时事件 `aclprofMark` 外，还补充演示了 `aclprofPush` / `aclprofPop` 的嵌套范围标记，以及 `aclprofRangeStart` / `aclprofRangeStop` 的非嵌套范围标记，便于对照 NVTX 的常见使用模式。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行
环境安装详情以及运行详情请见 example 目录下的 [README](../../../README.md)。

运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Profiling 样例的 run.sh 还会读取 ASCEND_HOME_PATH，请一并设置为同一路径
export ASCEND_HOME_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在本样例中，涉及的关键功能点及其关键接口如下所示：
- msproftx 标记对象管理
    - 调用 `aclprofCreateStamp` 接口创建 msproftx 事件标记对象。
    - 调用 `aclprofSetStampTraceMessage` 接口为标记对象设置可读字符串描述。
    - 调用 `aclprofDestroyStamp` 接口释放标记对象。
- 事件与范围标记
    - 调用 `aclprofMark` 接口记录瞬时事件。
    - 调用 `aclprofPush` 和 `aclprofPop` 接口记录嵌套范围。
    - 调用 `aclprofRangeStart` 和 `aclprofRangeStop` 接口记录非嵌套范围。

## 已知issue

暂无。
