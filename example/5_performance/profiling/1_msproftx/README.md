## 1_msproftx

## 描述
本样例展示了使用 msproftx 扩展接口采集并落盘性能数据。除了瞬时事件 `aclprofMark` 外，还补充演示了 `aclprofPush` / `aclprofPop` 的嵌套范围标记，以及 `aclprofRangeStart` / `aclprofRangeStop` 的非嵌套范围标记，便于对照 NVTX 的常见使用模式。

## 支持的产品型号
- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件
- Atlas 训练系列产品

## 编译运行
环境安装详情以及运行详情请见 example 目录下的 [README](../../README.md)。

## 运行前环境变量

运行 `bash run.sh` 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# Profiling 样例的 run.sh 还会读取 ASCEND_HOME_PATH，请一并设置为同一路径
export ASCEND_HOME_PATH=${install_root}/cann
```

## CANN RUNTIME API

在该 sample 中，涉及的关键功能点及其关键接口如下所示：
- `aclprofCreateStamp`：创建 msproftx 事件标记对象。
- `aclprofSetStampTraceMessage`：为事件标记设置可读字符串描述。
- `aclprofMark`：记录瞬时事件。
- `aclprofPush` / `aclprofPop`：记录嵌套范围，适合表达调用栈式的区间。
- `aclprofRangeStart` / `aclprofRangeStop`：记录可跨作用域的区间。
- `aclprofDestroyStamp`：释放 msproftx 事件标记对象。

## 已知issue

暂无。