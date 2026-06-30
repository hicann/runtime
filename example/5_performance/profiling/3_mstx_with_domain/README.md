# 3_mstx_with_domain

## 描述

本样例展示 mstx 接口在默认 domain 与自定义 domain 中打点的使用方式，并演示通过 msprof 的 `--mstx-domain-include` 和 `--mstx-domain-exclude` 参数控制采集范围。样例源码为当前目录下的 `mstx_with_domain.cpp`，由 `run.sh` 完成编译并执行。

## 产品支持情况

本样例支持以下产品：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas 800I A2 推理产品/A200I A2 Box 异构组件 | √ |
| Atlas 200I/500 A2 推理产品 | √ |
| Atlas 推理系列产品 | √ |
| Atlas 训练系列产品 | √ |

## 编译运行

1.下载样例代码至安装CANN软件的环境，切换到样例目录。
```bash
cd ${git_clone_path}/example/5_performance/profiling/3_mstx_with_domain
```

2.设置环境变量。
```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
```

3.执行以下命令运行样例。
```bash
bash run.sh
```

## msprof采集

如需使用 msprof 采集 mstx 打点数据，可按如下场景执行：

```bash
# 采集所有打点数据，包括默认 domain 和自定义 domain
msprof --msproftx=on bash run.sh

# 只采集 default domain 的打点数据
msprof --msproftx=on --mstx-domain-include="default" bash run.sh

# 采集 default domain 之外的打点数据
msprof --msproftx=on --mstx-domain-exclude="default" bash run.sh
```

`--mstx-domain-include` 与 `--mstx-domain-exclude` 参数互斥，不可同时配置。如需指定多个 domain，使用逗号隔开。

## CANN RUNTIME API

在本样例中，涉及的关键功能点及其关键接口如下所示：

- 默认 domain 打点
    - 调用 `mstxMarkA` 接口记录默认 domain 的瞬时事件。
    - 调用 `mstxRangeStartA` 和 `mstxRangeEnd` 接口记录默认 domain 的范围事件。
- 自定义 domain 管理与打点
    - 调用 `mstxDomainCreateA` 接口创建自定义 domain。
    - 调用 `mstxDomainMarkA` 接口记录自定义 domain 的瞬时事件。
    - 调用 `mstxDomainRangeStartA` 和 `mstxDomainRangeEnd` 接口记录自定义 domain 的范围事件。
    - 调用 `mstxDomainDestroy` 接口销毁自定义 domain。

## 示例输出

```text
[INFO]: AscendHome is set to ...
...
result[0] is: 1.200000
result[1] is: 2.200000
result[2] is: 3.200000
result[3] is: 5.400000
result[4] is: 6.400000
result[5] is: 7.400000
result[6] is: 9.600000
result[7] is: 10.600000
```
