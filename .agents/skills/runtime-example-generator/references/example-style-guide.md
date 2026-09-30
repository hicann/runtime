# Runtime 样例风格指南

本文用于统一 `example/` 下 Runtime 样例的代码、文档、构建和运行入口。

## 设计目标

- 易实践：README 首页说明样例用途、前置条件、运行方式和典型输出，使用者能快速跑通。
- 易复用：代码把固定的初始化/清理流程和可替换的核心逻辑分开，便于复制到业务工程。
- 易学习：主流程按初始化、资源申请、核心 API 调用、同步/校验、逆序清理组织。
- 一例一主题：每个样例只讲清一个核心 Runtime 能力，复杂场景拆成多个样例。

## 目录与文件

每个可运行样例目录必须至少包含以下文件：

```text
sample_name/
|-- CMakeLists.txt
|-- README.md
|-- README_en.md
|-- main.cpp
`-- run.sh
```

## 代码模板

- 统一包含 `acl/acl.h` 和 `utils.h`，不要在样例内重复定义通用日志宏。
- Runtime API 调用默认使用 `CHECK_ERROR` 检查返回值。
- 清理阶段记录每个错误；必要清理失败必须影响程序的最终退出结果，同时保留此前的主流程失败信息。
- 资源释放按申请逆序执行：任务同步、描述对象销毁、Stream/Event/Context 销毁、内存释放、Device reset、`aclFinalize`。
- 样例必须有明确结果校验或关键状态检查，最终输出成功或失败日志。
- 在 `main.cpp` 的关键流程步骤前增加简短英文注释，说明流程意图，例如初始化、资源绑定、任务录入/执行和逆序清理；不要给显而易见的单行语句堆注释。

推荐主流程：

```cpp
int32_t main()
{
    // 1. Declare constants and resources.
    // 2. Initialize ACL and bind device.
    // 3. Allocate resources and prepare input data.
    // 4. Call the core Runtime API.
    // 5. Synchronize and verify result.
    // 6. Release resources in reverse order.
    return 0;
}
```

## 代码格式

- `main.cpp`、头文件、Ascend C Kernel 和样例新增的其他 C/C++ 源码都使用目标仓库的 `.clang-format` 及其 pre-commit hook 格式化，不手工维持与格式化器冲突的换行或参数缩进。
- 每个 C/C++ 函数最多包含 50 个非空非注释行；主流程较长时按初始化、核心操作、结果校验和逆序清理等职责提取辅助函数，不能把主体移入 Lambda 来规避统计。
- 不使用 `sizeof(pointerVariable)` 推导数组、对象、缓冲区或地址槽大小；地址槽使用 `sizeof(void*)`，指向对象使用明确类型或合法的 `sizeof(*pointerVariable)`。
- 变量作为 `/` 或 `%` 的除数时，在执行运算的同一函数中、运算之前显式处理零值，不只依赖调用方校验、API 文档约束或硬件返回值。
- 只格式化本任务负责的文件，不改写工作区中的其他用户改动。
- 完成最后一次代码编辑后，按 [change-checklist.md](change-checklist.md) 对本任务完整文件清单执行本地交付检查。构建和运行成功不代表格式与静态检查通过。

## CMake 模板

- 普通 Runtime 样例链接 `${ASCEND_CANN_PACKAGE_PATH}/lib64/libacl_rt.so`。
- `aclnn` 样例按需额外显式链接 `libnnopbase.so`、`libopapi.so`。
- AscendC 样例使用 `ascendc.cmake` 构建 kernel，并链接 `libacl_rt.so`。
- 所有样例构建链路禁止链接 `libascendcl.so` 或 `ascendcl`。
- 编译选项保持一致：`-O2 -std=c++17 -D_GLIBCXX_USE_CXX11_ABI=0 -Wall -Werror`。

## run.sh 模板

- 脚本开头使用 `set -euo pipefail`。
- 先检查 `ASCEND_INSTALL_PATH` 和必要文件，再 source CANN 环境。
- 始终切换到样例目录后执行构建，构建目录统一为 `build/`。
- 普通样例执行 `cmake ..`、`make -j"$(nproc)"`、`./main`。
- AscendC 样例额外检查 `SOC_VERSION`、`ASCENDC_CMAKE_DIR` 和 `ascendc.cmake`。
- 脚本使用 LF 换行。

## README 模板

每个可运行样例必须同时提供中文 `README.md` 和英文 `README_en.md`。两份文档的一级标题均为样例目录名，描述的场景、产品支持情况、编译运行方式、实际调用的 API 和示例输出必须保持一致；英文文档不能用指向中文文档的链接代替。

中文 `README.md` 固定使用以下章节：

1. `## 描述`
2. `## 产品支持情况`
3. `## 编译运行`
4. `## CANN RUNTIME API`
5. `## 示例输出`

英文 `README_en.md` 固定使用对应章节：

1. `## Description`
2. `## Product Support`
3. `## Compile and Run`
4. `## CANN RUNTIME API`
5. `## Sample Output`

写法要求：

- README 面向最终用户编写。除 CANN RUNTIME API 章节外，优先保留描述、必要说明、产品支持情况、环境变量、编译运行和预期结果；不要在描述中展开内部实现过程。
- `## 描述` 说明样例能做什么、适合什么场景、运行后能看到什么结果。
- 不增加 `## 概述`、`## 功能说明`、`## 说明` 或空的 `## 已知 issue` 章节。
- 具体 sample README 中不要使用 `AscendCL` 作为概述性组件名称；初始化/去初始化相关描述优先写为“初始化”“去初始化”或“初始化配置”。例如 `aclInit` 写“进行初始化配置”，`aclFinalize` 写“实现去初始化”。
- 简介目录或样例内容时，功能/特性名称必须使用对外文档中的正式叫法，不使用口头语或内部叫法，例如不要写 `Model RI`、`Adump`、`内建任务` 等；不确定时，优先核对昇腾官网 Runtime 文档或仓库 API 参考文档中的正式描述。
- 编译运行步骤与 `example/README.md` 完全一致时，只引用通用 README，不写“本样例无额外运行参数。”这类描述。
- 有额外环境变量、参数、`bash run.sh -r simple`，或需要额外设置 `ASCENDC_CMAKE_DIR` 等样例专属环境变量时，保留 `## 编译运行` 章节，并写完整自包含步骤，避免用户只查看当前样例 README 时需要来回跳转。
- `## 产品支持情况` 必须且仅列出 A2、A3、A5 三类产品，并分别说明该样例是否能正常编译、运行并通过结果校验；不得添加其他产品行。表头固定使用 `| 产品 | 是否支持 |`。
- 编写产品支持情况和关键接口说明前，先根据样例实际依赖的关键 API 核对 `docs/zh/api_ref`，但不要在 README 中写出核对过程。
- 样例对某产品的支持结论取全部关键 API 支持结论的交集：任一关键 API 不支持时，该样例必须标记为不支持。不得根据头文件存在、编译成功或在另一产品运行成功外推支持结论。
- 产品支持情况只在具体用例目录下的 README 中体现。对于 `example/<chapter>/<theme>/README.md` 这类主题目录 README，默认不体现产品支持情况，只保留目录说明和样例列表。如果这一层 README 缺失，则补充。
- 即使样例涉及的接口与硬件关联不强，也要显式写出产品支持情况，不要默认省略。
- A2、A3、A5 的产品名称以 API 参考文档为准；A5 对应 Ascend 950 时写为 `Ascend 950PR/Ascend 950DT`，不要写成 `Ascend950` 或 `Atlas A5 训练系列产品`。初始化与去初始化相关样例可参考 `docs/zh/api_ref/02_initialization_and_deinitialization.md` 的产品支持表。
- 不要在 `## 产品支持情况` 章节按接口列支持矩阵。
- 编写 CANN RUNTIME API 章节时，参考 `example/1_basic_features/memory/2_h2d_async_memory_copy/README.md` 的写法，使用“在该Sample中，涉及的关键功能点及其关键接口，如下所示：”作为引导语，按“关键功能点 + 关键接口”分组描述，不展开内部实现细节。
- 仅部分产品支持的接口，在 `## CANN RUNTIME API` 对应接口条目末尾使用括号短标注，例如 `（Atlas A2支持，Atlas A3不支持）`。
- 不要在“产品支持情况”和“CANN RUNTIME API”之间各维护一套口径不一致的接口列表。如果产品支持表需要说明口径，直接引用下文关键接口即可。
- `## 示例输出` 必须与实际日志风格一致，地址、版本号、时间戳等环境相关内容用 `...` 表示。
