# 样例目录

`example/` 目录按学习阶段组织，可从快速入门逐步学习到基础能力、高级能力、性能分析和场景化主题。

## 目录总览

- [0_quickstart](./0_quickstart/README.md)：快速入门，包含最基础的 Runtime Hello World、自定义 Kernel `<<<>>>` 调用、错误处理、系统信息和兼容性主题。
- [1_basic_features](./1_basic_features/README.md)：基础特性，覆盖 Device、Context、Stream、Event、Memory。
- [2_advanced_features](./2_advanced_features/README.md)：高级特性，覆盖 Kernel、Model RI、Callback、Notify、TDT、Label、Group 和内建任务。
- [3_memory_advanced](./3_memory_advanced/README.md)：高级内存管理，覆盖自定义分配器、流序内存池以及更细粒度的内存控制主题。
- [4_reliability](./4_reliability/README.md)：可靠性主题，覆盖快照、溢出检测、错误恢复和容错执行。
- [5_performance](./5_performance/README.md)：性能分析与精度调试，包含 Profiling 和 Adump。
- [6_scenarios](./6_scenarios/README.md)：场景化主题，面向训练流水线、多设备推理和容错执行等典型用法。

## 使用方式

编译运行样例前，请先完成固件、驱动和 CANN 软件包安装，具体操作请参见仓库根目录的 [README](../README.md)。

典型运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# ${ascend_name} 替换为昇腾AI处理器的型号，可通过 npu-smi info 查看 Name 字段并去掉空格获得，例如 ascend910b3
export SOC_VERSION=${ascend_name}

# 部分样例中涉及调用AscendC算子，需配置AscendC编译器 ascendc.cmake 所在路径
export ASCENDC_CMAKE_DIR=${cmake_path}

# 以基础内存样例为例
cd ${git_clone_path}/example/1_basic_features/memory/0_h2h_memory_copy
bash run.sh
```

请注意：

- 具体运行方式以各样例子目录中的 `README.md` 为准。
- 部分主题目录用于集中说明某类能力，便于按主题查找相关样例。
- 部分样例依赖额外算子包或特定环境能力，请按样例说明准备环境。
- 涉及 AscendC Kernel 的样例还需要提前设置 `SOC_VERSION` 和 `ASCENDC_CMAKE_DIR`。

## 共享文件

以下目录和文件供多个样例复用，一般无需单独运行：

- `kernel_func/`：Kernel 与部分 Callback 样例复用的 AscendC 核函数源码。
- `utils.h`：多个样例共享的日志与错误检查宏。

## 示例代码说明

所有示例演示了 CANN Runtime API 的典型使用模式。

- 样例代码用于学习和接口理解。
- 为了突出核心流程，部分示例会简化工程化处理。
- 用于生产环境前，请补充完整的错误处理、资源管理和边界检查。
