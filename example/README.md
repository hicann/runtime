# 样例使用指导

example目录下提供了一系列Runtime接口样例，包括Device管理、Stream管理、Event管理、内存管理、Kernel执行等，供开发者参考，帮助开发者快速入门，进而掌握Runtime关键特性。


## 目录总览

- [0_quickstart](0_quickstart/README.md)：快速入门样例，以 `aclnnAdd` 向量加法为入口，展示 初始化配置、Device/Stream 创建、Tensor 与 DataBuffer 管理、workspace 分配、算子执行、同步等待和资源释放流程。
- [1_basic_features](1_basic_features/README.md)：基础特性样例，包含设备管理（包括单线程、多线程）、 内存管理（包括内存复制、进程间内存共享、虚拟内存管理等）、Stream管理（包括单流任务下发、多流任务下发等）等样例。
- [2_advanced_features](2_advanced_features/README.md)：高级特性样例，包括算子Kernel加载与执行、ACL Graph、Reduce和随机数生成的内置系统任务执行、Host侧回调函数下发等样例。
- [3_memory_advanced](3_memory_advanced/README.md)：高级内存管理样例，包括自定义内存分配器、Host内存注册、统一寻址、Stream内存操作、Stream有序内存分配等样例。
- [4_reliability](4_reliability/README.md)：可靠性样例，包括溢出检测、错误恢复等样例。
- [5_performance](5_performance/README.md)：性能分析与精度调试样例。
- [6_scenarios](6_scenarios/README.md)：场景化样例，面向训练流水线、多设备推理和容错执行等典型场景。

## 产品支持表说明

各样例 README 中的产品支持表仅列出当前样例已完成验证或已明确声明支持情况的产品。Ascend 950PR/Ascend 950DT 为新增产品，部分历史样例尚未完成该产品验证；未在表格中列出的产品不代表不支持。若某产品明确不支持，样例 README 会在表格中以 `×` 标识，并根据需要补充说明。

## 环境准备
编译运行样例前，需获取固件、驱动及CANN软件包并安装，详细步骤请参见[《CANN软件安装指南》](https://www.hiascend.com/cann/download)。

若对本仓src目录下的源码有定制，那么在安装CANN软件之后，还需编译源码并部署到环境上，具体操作请参见[README](../README.md)。

## 运行样例

1.下载样例代码并上传至安装CANN软件的环境，切换到样例目录。
```bash
# 此处以基础内存样例为例
cd ${git_clone_path}/example/1_basic_features/memory/0_h2h_memory_copy
```

2.设置环境变量。
```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```

3.执行以下命令运行样例。
```bash
# 请注意部分用例的运行命令不同，具体以各用例目录下的README.md中的编译运行命令为准
bash run.sh
```

## 样例代码说明
所有样例演示了CANN Runtime API 的典型使用方式。

- 样例代码用于学习和接口理解。
- 为了突出核心流程，部分示例会简化工程化处理。
- 用于生产环境前，请补充完整的错误处理、资源管理和边界检查。

## Device 复位接口使用约定

单机单进程样例通常使用 `aclrtResetDeviceForce` 清理当前样例占用的 Device 资源；单机多进程 IPC 样例使用 `aclrtResetDevice` 释放当前进程的 Device 资源，避免强制复位影响同机其他进程。
