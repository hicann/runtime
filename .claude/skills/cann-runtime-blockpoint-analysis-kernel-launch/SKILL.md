---
name: cann-runtime-blockpoint-analysis-kernel-launch
description: >
  对 CANN Runtime 开源仓库进行 Kernel Launch 路径的断点分析。
  模拟新手走通任意 AscendC 自定义核函数的"编写 → 编译 → Runtime 加载执行"全链路。
  用法：/cann-runtime-blockpoint-analysis-kernel-launch VecAdd
  当用户要求分析 CANN Runtime 的 Kernel Launch 路径、验证新手能否走通
  自定义算子开发流程时，使用此 Skill。
  也适用于"Kernel Launch 路径断点分析"、"自定义算子全链路断点分析"等场景。
argument-hint: "[算子名称，如 VecAdd / MatMul]"
---

# CANN Runtime 使用断点分析 — $0 Kernel Launch 路径

## 评估对象

CANN Runtime 是华为昇腾 CANN（Compute Architecture for Neural Networks）的
Runtime 运行时模块，为算子开发者提供设备管理、内存管理、Stream/Context
管理等底层运行时 API。

- 本地目录：当前工作目录（仓库根目录）
- 仓库地址：https://gitcode.com/cann/runtime（仅供参考，不作为评估数据源）

## 这个 Skill 做什么

模拟一名算子开发新手，以 **$0** 算子为载体，
从零尝试走通 CANN Runtime 的典型开发全流程。
全程以第一人称叙述，像真实开发者一样探索仓库资料，
每遇到资料缺失或不足导致无法继续的地方，记录为一个"断点"。

**与 aclnn 预置算子路径的区别：**
本 Skill 走的是"自定义核函数"路径（AscendC 编写 → 编译 → Runtime 加载执行），
**需要**编写 AscendC 核函数并编译。

| 对比项 | $0 Kernel Launch 路径（本 Skill） | aclnn 预置算子路径 |
|-------|----------------------------------|-------------------|
| 算子来源 | 开发者用 AscendC 编写 | CANN 内置算子库 |
| 关键 API | `<<<>>>` 内核调用符语法 | GetWorkspaceSize → Execute |
| 需要编译核函数 | 需要 | 不需要 |
| 适用场景 | 开发自定义算子 | 快速使用已有算子 |
| 参考示例 | `example/kernel/0_launch_kernel/` | `example/quickstart/` |

**核心价值：** 断点分析发现的是开发者实际会撞上的阻塞问题，
而不是理论上可能存在的文档缺陷。每个断点都对应一个真实的
"我卡住了，不知道怎么往下走"的时刻。

**评估聚焦点：** 本次实战验证关注两个层面的问题：
1. **Runtime 自身文档质量** — Runtime 职责范围内的 API 文档是否完整、示例是否充分（主要评估目标）
2. **端到端可达性** — 一个新手能否通过仓库内资料 + 外源知识走通 $0 全流程？
   （整体体验评估）

## 参数说明

- **$0**（必填）：目标自定义核函数算子名称，如 `VecAdd`、`MatMul`、`Softmax`
- 如用户未提供算子名，提示用户指定一个算子名
- **⚠️ 算子信息获取（优先从 reference/ 查找）：** 算子的详细信息（功能、输入输出、核函数接口等）属于**外源知识**，应遵循外源知识处理规则，按以下优先级获取：

  **获取优先级：**
  1. **首先**：在"执行前准备 · 首要动作 0"中 clone `reference/` 外源知识仓库
  2. **然后**：在 `reference/asc-devkit/` 中搜索 `$0` 的相关文档和代码，提取以下 5 项信息：
     1. 算子的功能描述（做什么计算）
     2. 输入/输出数据：数量、维度（1D向量 / 2D矩阵 / ND张量）、数据类型（float32 / float16 / int32 等）
     3. 核函数接口约定：核函数名称、参数列表（Device 指针 + 维度信息 + 其他）
     4. 是否涉及 tiling / workspace 等高级特性
     5. 其他特殊要求（特定对齐、特殊内存布局等）
  3. **最后**：如果 `reference/` 中**无法找到**上述任何一项信息，**再向用户求助**补充缺失项

  **从 reference/ 成功获取时：**
  - 标注 `[reference: 仓库名/文件路径]` 作为信息来源
  - 信息齐全则直接开始分析，无需等待用户确认

  **需要向用户求助时的询问模板：**
  > "我已在 `reference/` 中搜索了 $0 的信息，以下内容已找到：
  > - [列出已获取的项目及来源]
  >
  > 但以下内容未能找到，请补充：
  > - [列出缺失的项目]"

  **信息充分性验证：** 无论信息来自 `reference/` 还是用户提供，逐项核对上述 5 项信息是否齐全且可用于编写代码：
  - 第 1 项（功能描述）：是否能据此确定算子的数学语义？
  - 第 2 项（输入/输出）：是否明确了每个数据的维度、shape 约束、数据类型？
  - 第 3 项（核函数接口）：是否包含完整的参数列表（参数名、类型、顺序）？能否据此直接写出调用代码？
  - 第 4 项（高级特性）：如涉及 tiling/workspace，是否说明了 tiling 参数结构？如不涉及，是否明确说明了"不涉及"？
  - 第 5 项（特殊要求）：可选，未提供视为无特殊要求。

  **信息确认充分后，明确告知用户"算子信息已确认，开始分析"，然后进入执行流程。**

  `reference/` 中获取的信息和用户提供的算子信息均作为**权威输入**，结合仓库资料一起用于断点分析。

## 执行前准备

**首要动作 0 — 获取外源知识仓库（必须在任何分析之前完成）：**

在仓库根目录下创建 `reference/` 目录，并 clone 以下四个开源仓作为外源知识来源：

```bash
mkdir -p reference && cd reference

# AscendC 编程指导（核函数编写、编译等）
git clone https://gitcode.com/cann/asc-devkit.git 2>/dev/null || (cd asc-devkit && git pull)

# aclnn 算子仓（三个）
git clone https://gitcode.com/cann/ops-nn.git 2>/dev/null || (cd ops-nn && git pull)
git clone https://gitcode.com/cann/ops-transformer.git 2>/dev/null || (cd ops-transformer && git pull)
git clone https://gitcode.com/cann/ops-math.git 2>/dev/null || (cd ops-math && git pull)
```

**验证：** clone 完成后，确认 `reference/` 下包含 `asc-devkit/`、`ops-nn/`、`ops-transformer/`、`ops-math/` 四个目录。

**首要动作 1 — 确认仓库结构：**

1. 确认仓库根目录：`ls .`
2. 查看整体结构：`tree . -L 2`
3. 查看 docs/ 结构：`tree docs/ -L 3`
4. 查看 example/ 结构：`tree example/ -L 3`
5. 确认根目录关键文件：`ls -la README* LICENSE* 2>/dev/null`
6. 确保输出目录存在：`mkdir -p reports/`
7. 查看外源知识仓库结构：`tree reference/ -L 2`

**版本号检测（必须在输出前完成）：**

输出文件命名规则：
- 分析报告：`reports/cann_runtime_blockpoint_analysis_{算子名}_kernel_launch_v{版本号}.md`
- 整改清单：`reports/cann_runtime_blockpoint_todolist_{算子名}_kernel_launch_v{版本号}.md`

其中 `{算子名}` 为用户传入的算子名（如 `VecAdd`），`{版本号}` 格式为 `X.0.0`。

**版本号确定流程：**
1. 在 `reports/` 目录下搜索匹配 `cann_runtime_blockpoint_analysis_{算子名}_kernel_launch_v*.md` 的文件
2. 如果**不存在**任何匹配文件 → 版本号为 `1.0.0`
3. 如果**存在**匹配文件 → 提取已有文件中最大的主版本号 N，新版本号为 `{N+1}.0.0`
4. 将确定的版本号记录下来，后续输出文件统一使用此版本号

将以上输出作为后续分析的基础索引。

**⚠️ 强制前置检查 — 确认算子信息已获取（必须在任何分析前完成）：**
在执行仓库结构探索和 `reference/` clone 之后、进入 Step 1 之前，**从 `reference/` 中搜索算子信息**：
1. 在 `reference/asc-devkit/` 中搜索 `$0` 相关文档和代码
2. 提取"参数说明"章节要求的 5 项算子信息
3. **如果 `reference/` 中信息齐全** → 直接继续，无需等待用户确认
4. **如果 `reference/` 中信息不全** → 暂停，使用"参数说明"章节中的询问模板向用户求助缺失项

**不得跳过此检查。不得以"我了解该算子"为由跳过。必须有明确的信息来源（reference/ 或用户提供）。**

**算子信息发现（在算子信息确认后执行）：**
1. 在 `example/` 中搜索 `$0` 关键词，确认是否有对应示例
2. 在 `docs/` 中搜索 `$0`，确认是否有 API 文档
3. 如无专门示例，以 `example/kernel/0_launch_kernel/` 为参考模板
4. 将仓库中发现的信息与用户提供的算子信息进行对比，确认哪些属于 Runtime 职责、哪些属于外源知识

**⚠️ 外源知识前置判断（必须在进入 Step 1 之前完成）：**

在确认仓库结构和算子信息后、正式开始 8 步分析之前，**主动预判**本次分析是否会涉及
**非 Runtime 仓库范畴的知识**（即 Runtime 仓库的 docs/ 和 example/ 中不会包含、
也不应该包含的知识）。

**判断方法：**
1. 对照用户提供的算子信息，列出涉及的所有 API 和概念
2. 逐项判断每个 API/概念是否属于 Runtime 仓库的职责范围
3. 将判定结果分为两类：
   - **Runtime 仓内知识**：aclInit、aclrtSetDevice、aclrtCreateStream、
     aclrtMalloc、aclrtMallocHost、aclrtMemcpy、`<<<>>>` 内核调用符语法、
     aclrtSynchronizeStream、aclrtFree、aclrtFreeHost、aclrtResetDevice、aclFinalize 等 Runtime 基础 API
   - **非 Runtime 仓知识（外源知识）**：属于其他组件维护的 API 和概念，例如：
     - AscendC 核函数编写和编程范式
     - AscendC 编译流程和编译产物格式
     - tiling 策略和参数结构
     - 其他非 Runtime 仓库维护的 API

**如果识别到外源知识需求，立即告知用户：**
> "在本次 $0 断点分析中，以下 API/概念不属于 Runtime 仓库的职责范围：
> - [列出具体的外源 API/概念]
>
> 我会优先从 `reference/` 目录下的外源知识仓库中查找相关资料。
> 如果 `reference/` 中也无法找到所需信息，我会向您求助。"

**等待用户确认或补充后，再进入 Step 1。**

**执行期间的外源知识处理规则：**
- 在 Step 1~9 推进过程中，遇到需要外源知识才能继续的情况时，**优先从 `reference/` 目录查找**：
  - AscendC 核函数编写、编程范式、编译流程 → 查找 `reference/asc-devkit/`
  - aclnn 算子相关知识 → 查找 `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`
- 如果 `reference/` 中**找到了所需信息** → 标注 `[reference: 仓库名/文件路径]`，直接用于继续分析
- 如果 `reference/` 中**未找到所需信息** → **暂停分析，向用户求助**
- 将非 Runtime 仓库职责范围内的知识缺失记录为**外源知识缺失**类型（不计入 Runtime 整改项），**不得**记录为 Runtime 缺陷
- **不得**自行猜测或脑补外源知识
- `reference/` 中的信息和用户提供的外源知识均作为**权威输入**，直接用于继续分析

## 角色画像

分析全程以此角色视角进行（详见 `references/role-profile.md`）：

- 熟练掌握 C/C++ 和 CMake
- 理解异构计算基本概念（Host/Device、内存拷贝、异步执行）
- 不了解 AscendC 核函数编写（需用户提供相关知识）
- 不了解 CANN Runtime API 具体用法
- 不了解 CANN 特有的 Device-Context-Stream 编程模型

## 知识来源规则（严格执行）

详见 `references/source-rules.md`，核心原则：

| 知识领域 | 允许的来源 | 禁止的来源 |
|---------|-----------|-----------|
| Runtime API 用法 | **仅限**仓库 docs/ 和 example/ | 华为官网、CSDN、博客、CUDA 经验推断 |
| AscendC 核函数编写/编译 | **优先** `reference/asc-devkit/`，不足时向用户求助 | 自行猜测、脑补 |
| aclnn 算子相关知识 | **优先** `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`，不足时向用户求助 | 自行猜测、脑补 |
| 其他非 Runtime 仓知识 | **优先** `reference/` 下查找，不足时向用户求助 | 自行猜测、脑补、基于经验推断 |
| C/C++/CMake 基础 | 角色已有技能 | — |
| 推测性知识 | 可标注 `[推测]`，不计入代码产出 | 不可当作确定信息使用 |

**执行纪律：**
- Runtime API 遇到资料不足时，**不得脑补**，必须记录为断点（阻塞点或优化点）
- **非 Runtime 仓知识**（如 AscendC 核函数编写、编译产物格式、tiling 参数结构等）遇到资料不足时，**优先从 `reference/` 目录下的外源知识仓库中查找**；如果 `reference/` 中也无法找到所需知识，**再暂停并向用户求助**，记录为**外源知识缺失**（不计入 Runtime 整改项）
- **不确定某知识是否属于 Runtime 范畴时**，**暂停并向用户确认**："请确认 XXX 是否属于 Runtime 仓库的职责范围？"用户回复后按其判定归类（属于 Runtime → 记录为 Runtime 缺陷；不属于 → 记录为外源知识缺失）
- 推测性代码用 `[UNKNOWN: 原因]` 占位
- 来自 `reference/` 外源知识仓库的知识标注 `[reference: 仓库名/文件路径]`
- 来自用户提供的外源知识标注 `[用户提供]`
- **不得**引用仓库根目录下的《AscendC算子开发指南》或其他非 docs/、example/、reference/ 的目录作为知识来源

## 开发步骤（逐步推进）

以 $0 算子为载体，按以下 10 步推进。
每一步须记录"资料支撑情况"和"资料来源"。
代码骨架详见 `references/code-skeleton.md`。

### Step 1：环境准备
- 依据 docs/ 和 README.md 确认所需软硬件依赖
- 确认 CANN Toolkit 版本配套关系
- **断点检查：** 仓库文档是否清楚说明了依赖和版本要求？

### Step 2：理解编程模型
- 依据 docs/ 理解 Device / Context / Stream 的层级关系
- 明确算子执行前需完成哪些初始化步骤
- **断点检查：** 编程模型是否有专项文档？层级关系图是否存在？

### Step 3：编写 AscendC 核函数
- 在仓库 `example/kernel_func/` 中查看是否有可参考的核函数示例
- 核函数编写属于**外源知识**，仓库 docs/ 和 example/ 中如无充分说明，**向用户求助**获取核函数代码或编写指导
- **⚠️ 核函数与构建系统规则（强制）：**
  验证包**必须使用 ASC 构建系统**（`find_package(ASC)` + `.asc` 单文件），**禁止使用 `ascendc_library()`**。

  **核函数属性规则：**
  - Vector 核函数（纯 vector 算子）：使用 `__global__ __vector__`
  - Cube 核函数（矩阵乘法等）：使用 `__global__ __cube__`（ASC 构建系统原生支持）
  - Mix 核函数（AIC+AIV 融合）：使用 `__global__ __mix__(m, n)`（ASC 构建系统原生支持）
  - **禁止使用 `__aicore__`**（这是 `ascendc_library()` 的写法，在 ASC 构建系统下会导致编译器无法推导核函数类型，报错 `auto type derivate failed`）
  - **如果 `reference/` 中的原始代码使用了 `extern "C"`，则保留**（尊重原始写法）；仅在自行编写核函数时禁止添加

  **⚠️ 禁止使用简化核函数（强制）：**
  验证包**必须使用真实的算子核函数实现**，从 `reference/asc-devkit/` 中完整复制核函数代码（包括核函数类、辅助函数、tiling 生成函数等），
  **不得**将真实核函数简化为 element-wise copy 或其他简化逻辑。

  **理由：** 简化核函数无法真实反映开发者实际遇到的断点。断点分析的价值在于走通真实的算子调用全流程，
  包括 tiling 参数准备、workspace 分配、多参数 <<<>>> 调用、核间同步等真实场景。
  简化后这些关键环节被跳过，断点识别不完整。

  **具体要求：**
  - 核函数属性必须与 `reference/` 中原始代码一致（`__vector__`/`__cube__`/`__mix__(m,n)`）
  - 核函数类、模板参数、AscendC API 调用必须完整保留
  - tiling 生成函数（如 `GenerateTiling`）必须完整保留
  - Host 侧 main 函数中的 tiling 准备 → 内存分配 → <<<>>> 调用完整流程必须保留
  - `ReadFile`/`WriteFile` 改为硬编码数据初始化 + `printf` 输出（这是唯一允许的修改）
  - 如果算子依赖 `data_utils.h`、`nd2nz_utils.h` 等辅助头文件，必须一并复制到验证包中

  **⚠️ 当 reference/ 中的原始代码从二进制文件读取 tiling/quant 等数据时（强制）：**
  某些算子的 reference 示例不在 C++ 中生成 tiling，而是从 `input_tiling.bin` 等二进制文件读取
  （tiling 由同目录下的 `scripts/gen_data.py` 预生成）。此场景下**不得因此简化核函数**，
  必须按以下优先级处理：
  1. **首选**：查找同目录下的 `scripts/gen_data.py`，提取 tiling 数组的生成逻辑，
     将 Python 代码翻译为 C++ 硬编码数组（通常是一组 int32_t 常量）
  2. **次选**：如果 reference 中有其他同类算子使用 `MatmulApiTiling` / `MultiCoreMatmulTiling`
     在 C++ 中生成 tiling（如 bare_mix、matmul_nz），参考其模式为当前算子编写 GenerateTiling
  3. **最后**：如果以上两种方式都无法实现，**向用户求助**获取 tiling 数据，
     **不得自行简化核函数体来绕过 tiling 依赖**

  **违反判定标准：** 如果验证包中的核函数体不包含原始代码中的关键 API 调用
  （如 `MatmulImpl`、`Matmul`、`Mmad`、`Sort` 等），即判定为违反"禁止简化核函数"规则。

  **为什么不用 `ascendc_library()`：**
  `ascendc_library()` 是 legacy CMake 宏，其 auto_gen 机制会对核函数做宏重命名（`#define KernelName KernelName_origin`），导致 `__cube__` 核函数编译报错（bisheng 编译器严格校验入口身份）。即使是纯 `__aicore__` 核函数，auto_gen 重命名也会在 ASC 编译器下触发 `auto type derivate failed`。ASC 构建系统无此问题。
- **断点检查：**
  - 仓库 example/ 中的核函数示例是否有帮助？
  - Runtime 仓库 docs/ 中是否有核函数编写的说明或引用？
  - 如果 Runtime 仓库中**完全没有**核函数编写指引，是否应该有？（向用户确认这是否属于 Runtime 职责）

### Step 4：编译核函数
- 参考 `example/kernel/` 中的 CMakeLists.txt，查看编译配置
- 编译流程属于**外源知识**，如仓库内资料不足，**向用户求助**
- **断点检查：**
  - Runtime 仓库中的 CMakeLists.txt 示例是否足以理解编译流程？
  - ASC 编译器（`find_package(ASC REQUIRED)`）、`.asc` 文件编译、`--npu-arch` 参数在仓库内是否有说明？
  - 编译产物格式、路径约定在仓库内是否有说明？
  - 如果仓库内有部分编译说明但不完整，向用户确认缺失部分是否属于 Runtime 职责

### Step 5：编写 Runtime 调用框架代码（核心断点区域）
**仅依赖 Runtime 仓库 docs/ 和 example/**，尝试编写完整框架

**逐 API 填写资料支撑情况表**（模板见 `references/api-coverage-table.md`）：

| API / 操作 | 文档位置 | 参数说明完整度 | 示例代码位置 | 资料来源 | 能否写出调用 |
|------------|----------|---------------|-------------|---------|-------------|

### Step 6：错误处理
- 依据 docs/ 为每个 API 添加错误检查
- **断点检查：** 错误码枚举是否完整？有无排查指引？

### Step 7：编译与构建
- 编写包含 ASC 编译器 + Runtime 链接的完整 CMakeLists.txt
- **断点检查：** 编译依赖、头文件路径、链接库名称是否有文档？
- ASC CMake 集成（`find_package(ASC REQUIRED)`、`target_compile_options` 等）的文档？

### Step 8：运行验证
- 确认如何执行和验证结果
- **断点检查：** 有预期输出说明吗？怎么判断结果正确？

### Step 9：验证包生成

断点分析完成后，**必须**生成一个完整可编译的验证包，打包到 `reports/` 目录下。
验证包的目的是让用户可以**直接拷贝到 NPU 机器上运行**，无需任何修改即可验证断点分析报告中代码的正确性。

**验证包命名规则：**
```
reports/{算子名}_verify/
```
其中 `{算子名}` 为用户传入的算子名的小写形式（如 `vecadd`、`matmul`）。

**验证包目录结构：**
使用 ASC 构建系统（`find_package(ASC)` + `.asc` 单文件），kernel 和 host 代码合并为一个 `.asc` 文件，
如有辅助头文件（`data_utils.h`、`nd2nz_utils.h` 等）一并包含：

```
{算子名}_verify/
├── CMakeLists.txt                find_package(ASC) 配置
├── {算子名}.asc                   单文件：真实 kernel 函数 + host main（<<<>>> 直接调用）
├── data_utils.h                  数据读写工具函数（从 reference/ 复制）
├── [其他辅助头文件]               如 nd2nz_utils.h 等（按需）
├── run.sh                        一键编译脚本
└── README.md                     使用说明（前置条件、环境变量、预期输出）
```

> **注意：** 验证包验证的是完整的 Runtime 调用流程 + 真实核函数的端到端可达性
> （初始化 → tiling 生成 → 内存分配 → <<<>>> 调用 → 同步 → 结果回传 → 资源释放），
> **同时进行精度验证**。验证包需根据算子的数学语义，在 Host 侧用 C++ 计算 expected 值，
> 与 Device 侧输出逐元素对比，超过容差则报错。

**验证包生成规则（严格执行）：**

1. **代码必须完整可编译** — 所有代码必须是完整的、可直接编译运行的，不得包含 `[UNKNOWN]` 占位符、`// ...` 省略注释或任何需要用户补充的部分
2. **自包含** — 验证包内的代码不依赖验证包外部的任何文件
3. **ASC 单文件模式** — kernel 和 host 代码合并在一个 `.asc` 文件中：
   - 文件顶部：`#include "acl/acl.h"` + `#include "kernel_operator.h"` + 标准库头文件
   - 核函数在前，main 函数在后
   - 核函数必须使用与 `reference/` 原始代码一致的属性标注（`__global__ __vector__`/`__global__ __cube__`/`__global__ __mix__(m,n)`）
   - 如果 `reference/` 原始代码使用了 `extern "C"`，保留之；否则不添加
   - **禁止 `__aicore__`**（ASC 下无法推导类型，会报 `auto type derivate failed`）
   - `<<<>>>` 在 main 中直接调用，不需要 Host 侧包装函数
   - **⚠️ Device 指针类型必须与核函数参数类型匹配：** ASC 编译器在 `<<<>>>` 调用时只做 `T*` → `__gm__ T*` 的地址空间转换，**不做跨类型转换**。如果核函数参数是 `GM_ADDR`（即 `__gm__ uint8_t*`），则 Device 指针必须声明为 `uint8_t*`；如果核函数参数是 `__gm__ float*`，则 Device 指针必须声明为 `float*`。**禁止** `float*` 传给 `GM_ADDR` 参数，**禁止** `reinterpret_cast<GM_ADDR>(floatPtr)`。
   - 输入数据：将 `reference/` 原始代码中的 `ReadFile` 调用替换为硬编码数据初始化（简单非零 pattern，如递增序列、全 1 等，**禁止全零**——全零输入会导致大多数算子输出全零，无法验证精度），这是唯一允许对原始 .asc 代码做的修改
   - **精度验证（强制）：** 在 Host 侧根据算子的数学公式用 C++ 计算 expected 值，与 Device 返回的结果逐元素对比。使用相对误差 + 绝对误差双重判定（默认容差：`rtol=1e-3, atol=1e-3`，half 类型可放宽到 `rtol=1e-2, atol=1e-2`）。打印前几个元素的 actual vs expected，并统计通过率。如果精度不达标，输出 `[PRECISION FAIL]` 并报告失败元素数
   - 使用 `CHECK_ERROR` 宏检查每个 ACL API 返回值
   - 使用 `aclrtResetDeviceForce` 复位设备
4. **一键运行** — `run.sh` 脚本包含完整流程：环境变量检查 → cmake 配置 → 编译 → 提示运行命令
5. **正确性判定** — 程序必须同时满足以下两个条件才算验证通过：
   (a) 输出 `Sample run successfully with <<<>>> kernel call!`
   (b) 精度验证通过（输出 `[PRECISION PASS] X/Y elements passed`，且通过率 ≥ 99%）
   如果精度验证失败，即使程序正常运行也应输出 `[PRECISION FAIL]` 并报告失败元素数和最大误差
6. **⚠️ 核函数完整性自检（强制，在写入文件前执行）：**
   验证包中的核函数必须与 `reference/` 原始代码结构一致，**不得被替换为 trivial 逻辑**。

   **执行方法：**
   1. 从 `reference/` 原始 `.asc` 文件中提取核函数体内的关键 API 调用列表
      （如 `MatmulImpl`、`Matmul`、`Mmad`、`Sort`、`DataCopy`、`LoadData` 等）
   2. 在验证包的 `.asc` 文件中检查这些关键 API 调用是否存在
   3. 对比核函数的类定义、模板参数是否与原始代码一致
   4. 在分析报告中附上自检记录表：

   | 检查项 | reference/ 原始代码 | 验证包代码 | 是否一致 |
   |--------|-------------------|-----------|---------|
   | 核函数签名（参数数量、属性） | | | |
   | 核函数类/模板定义 | | | |
   | 关键 AscendC API 调用 | | | |
   | tiling 生成/加载逻辑 | | | |

   **如果发现验证包中的核函数体被替换为赋值、memset、空函数等 trivial 逻辑，
   立即停止写入，回退到 reference/ 原始实现重新生成验证包。**

7. **⚠️ 外源符号交叉验证（强制，在写入文件前执行）：**
   验证包中所有非 Runtime API 的符号（类名、枚举、命名空间前缀、模板参数），
   **必须**逐一在 `reference/` 中 grep 确认实际用法，**不得凭推断或类比补全**。

   **执行方法：**
   1. 列出验证包代码中所有来自外源库的符号
      （如 `CubeFormat`、`MatmulType`、`TPosition`、`TCubeTiling`、`DataCopy`、`TPipe` 等）
   2. 对每个符号执行 `grep -rn "符号名" reference/asc-devkit/examples/`，确认：
      - **命名空间**：该符号是否需要命名空间前缀？前缀是什么？
      - **头文件**：该符号来自哪个头文件？
      - **参数顺序**：函数/模板的参数顺序是否与代码一致？
   3. 如果搜索结果与代码写法不一致，**以搜索结果为准修正代码**
   4. 在分析报告"最终代码产出"章节附上验证记录表：

   | 外源符号 | 代码中写法 | reference/ 中实际写法 | grep 来源文件 | 是否一致 |
   |---------|-----------|---------------------|--------------|---------|

   **不得跳过此步骤。未经 grep 验证的外源符号不得写入验证包文件。**

**⚠️ 精度验证规则（强制）：** 验证包必须在 Host 侧实现精度验证逻辑：
1. **构造非零输入数据** — 使用简单但非零的 pattern（如递增序列 `1,2,3,...`、全 1、随机小整数等），**禁止全零输入**（全零会导致输出全零，无法验证精度）
2. **Host 侧计算 expected** — 根据算子的数学公式，在 main 函数中用 C++ 计算 expected 输出（如矩阵乘用三重循环，向量加用逐元素加，排序用 std::sort 等）
3. **逐元素对比** — 将 Device 返回的结果与 expected 逐元素对比，使用相对误差 + 绝对误差双重判定：
   - float32 类型：`rtol=1e-3, atol=1e-3`
   - float16/half 类型：`rtol=1e-2, atol=1e-2`
   - int 类型：精确匹配
4. **输出格式** — 打印前几个元素的 actual vs expected，然后输出统计：
   - 通过：`[PRECISION PASS] X/Y elements passed (max_diff=Z)`
   - 失败：`[PRECISION FAIL] X/Y elements failed (max_diff=Z)`
5. **验证通过条件** — 精度通过率 ≥ 99% 且程序输出 `Sample run successfully with <<<>>> kernel call!`

**对于复杂算子（如 Matmul + LeakyReLU 融合、NZ 格式转换等）的 expected 值计算：**
- 优先从 `reference/` 目录下的 `scripts/gen_data.py` 中提取计算逻辑，完整翻译为 C++（包括 NZ 格式转换、LeakyReLU 等后处理）
- 如果 `gen_data.py` 的逻辑涉及复杂格式转换（如 ND→NZ），必须将转换函数一并翻译为 C++，**不得跳过或简化**
- 如果算子语义不明确无法计算 expected，**向用户求助**，不得自行简化计算逻辑来绕过

**CMakeLists.txt 要求（ASC 构建系统）：**
```cmake
cmake_minimum_required(VERSION 3.16)
find_package(ASC REQUIRED)
project({算子名}_Verify LANGUAGES ASC CXX)
add_executable(main {算子名}.asc)
target_link_libraries(main PRIVATE m dl)
target_compile_options(main PRIVATE
    $<$<COMPILE_LANGUAGE:ASC>:--npu-arch=dav-2201>   # Atlas A2 / Ascend 910B（默认）
    # $<$<COMPILE_LANGUAGE:ASC>:--npu-arch=dav-3510> # Atlas A3 / Ascend 950
)
```
- 如需链接 tiling 等库，按需添加 `tiling_api`、`register`、`platform`

**run.sh 要求（ASC 构建系统）：**
- **仅检查** `ASCEND_INSTALL_PATH` 环境变量和 `setenv.bash` 文件存在性
- **不需要** `SOC_VERSION` 和 `ASCENDC_CMAKE_DIR`（NPU 架构由 CMakeLists.txt 中 `--npu-arch` 指定）
- `source "$_ASCEND_INSTALL_PATH/bin/setenv.bash"` 加载环境
- `cmake ..` + `make`（不需要 `-DASCEND_CANN_PACKAGE_PATH`）

**README.md 要求：**
- 概述：说明验证的算子和运算公式
- 目录结构说明（4 个文件）
- 支持的产品型号及对应 `--npu-arch` 配置
- 前置条件（硬件、CANN Toolkit 含 ASC 编译器、GCC、CMake）
- 环境变量设置方法（仅 `ASCEND_INSTALL_PATH`）
- 如何修改目标 NPU 架构（编辑 CMakeLists.txt 的 `--npu-arch` 行）
- 快速使用命令（`bash run.sh` + `./build/main`）
- 预期输出示例

详细的文件模板见 `references/verification-package-template.md`。

### Step 10：验证包编译运行验证（强制）

验证包文件全部写入后，**必须**在当前环境中实际编译并运行验证包，确认代码正确性。
**不得跳过此步骤。** 如果编译或运行失败，必须自行诊断并修复代码，直到验证通过。

**执行流程：**

1. **检测 CANN 环境：**
   按以下优先级查找 CANN 安装路径：
   - 环境变量 `$ASCEND_INSTALL_PATH`
   - `/home/developer/Ascend/cann/`（开发机常见路径）
   - `/usr/local/Ascend/cann/`（默认安装路径）
   - `$HOME/Ascend/cann/`

   确认 `${CANN_PATH}/bin/setenv.bash` 存在。如果**所有路径都不存在**，
   向用户求助：
   > "当前环境未找到 CANN Toolkit 安装，请提供 CANN 安装路径
   > （包含 bin/setenv.bash 的目录），以便编译运行验证包。"

   **如果找到了 CANN 路径，无需向用户确认，直接使用。**

2. **编译验证包：**
   ```bash
   export ASCEND_INSTALL_PATH=${CANN_PATH}
   source ${CANN_PATH}/bin/setenv.bash
   cd reports/{算子名}_verify/
   rm -rf build && mkdir -p build && cd build
   cmake .. 2>&1
   make -j$(nproc) 2>&1
   ```

3. **编译失败处理（自动修复循环）：**
   如果 cmake 或 make 失败，执行以下修复流程（**最多重试 3 次**）：

   a. **分析错误信息** — 读取编译器/链接器输出，定位错误原因
   b. **常见错误及修复策略：**
      - `auto type derivate failed` → 检查核函数属性是否错误使用了 `__aicore__`，应改为 `__vector__`/`__cube__`/`__mix__(m,n)`
      - `undefined reference` → 检查 CMakeLists.txt 的 `target_link_libraries` 是否缺少库（如 `tiling_api`、`register`、`platform`）
      - `No such file or directory` → 检查 `#include` 路径是否正确、辅助头文件是否遗漏
      - 类型不匹配 → 检查 Device 指针类型是否与核函数参数类型一致
      - 其他编译错误 → 回到 `reference/` 中 grep 确认正确的 API 用法，修正代码
   c. **修改验证包文件** — 直接编辑出错的文件
   d. **重新编译** — 重复步骤 2
   e. 如果 3 次重试后仍然失败，**向用户报告**具体的编译错误，请求协助

4. **运行验证包：**
   编译成功后，执行：
   ```bash
   cd reports/{算子名}_verify/
   ./build/main 2>&1
   ```

5. **运行失败处理（自动修复循环）：**
   如果运行时出错（返回非零退出码或输出 `[ERROR]`），执行以下修复流程（**最多重试 3 次**）：

   a. **分析运行输出** — 检查哪个 ACL API 返回了错误码
   b. **常见运行错误及修复策略：**
      - `aclError = 100000`（参数校验失败）→ 检查内存大小、指针是否正确
      - `aclError = 100001`（未初始化）→ 检查 aclInit 和 aclrtSetDevice 调用顺序
      - `aclError = 200000`（内存不足）→ 减小数据规模或检查内存计算
      - Segfault → 检查空指针、内存越界
      - 无输出直接退出 → 检查 GenerateTiling 是否失败
   c. **修改验证包代码** — 根据诊断结果修正
   d. **重新编译并运行** — 重复步骤 2-4
   e. 如果 3 次重试后仍然失败，**向用户报告**具体的运行错误，请求协助

6. **验证通过判定：**
   程序必须同时满足以下条件才算验证通过：
   (a) 输出包含 `Sample run successfully with <<<>>> kernel call!`
   (b) 输出包含 `[PRECISION PASS]` 且精度通过率 ≥ 99%
   
   如果精度验证失败（输出 `[PRECISION FAIL]`），需分析原因并修复（可能是 expected 计算错误、数据类型不匹配、tiling 参数不对等），最多重试 3 次。

   在分析报告末尾附上验证结果：

   ```markdown
   ## 10. 验证包编译运行结果

   | 项目 | 结果 |
   |------|------|
   | CANN 路径 | ${实际使用的路径} |
   | cmake 配置 | ✅ 成功 |
   | 编译 | ✅ 成功 |
   | 运行 | ✅ 成功 |
   | 精度验证 | ✅ [PRECISION PASS] X/Y elements passed (max_diff=Z) |
   | 输出验证 | ✅ 包含 "Sample run successfully with <<<>>> kernel call!" |
   | 修复次数 | 0 次（或 N 次，附修复记录） |
   ```

   如果经历了修复，还需附上修复记录：
   ```markdown
   **修复记录：**
   | 次数 | 阶段 | 错误信息 | 修复操作 |
   |------|------|---------|---------|
   | 1 | 编译 | undefined reference to `xxx` | CMakeLists.txt 添加 xxx 库 |
   ```

## 断点记录格式

每个断点按以下格式记录（详见 `references/blockpoint-format.md`）：

```
+---------------------------------------------------------------------+
| 断点 #N                                                              |
| 问题类型：Runtime 缺陷 / 外源知识缺失 / 体验问题                        |
| 发生步骤：Step X - 步骤名称                                          |
| 问题描述：我在尝试做什么，遇到了什么障碍                                |
| 查找过程：我在哪些文件中查找过（列出具体路径）                           |
| Runtime 文档中的相关内容：有/无（若有，覆盖了什么，遗漏了什么）          |
| 示例代码中的相关内容：有/无（若有，覆盖了什么，遗漏了什么）              |
| 缺失资料：具体缺少哪个文档 / 哪个 API 的说明                           |
| 影响程度：阻塞点（真正阻断开发，无法继续）/ 优化点（可解决但过程复杂）    |
| [推测]：根据类似框架经验的猜测（标注为推测，不计入产出）                 |
| 期望补充：理想情况下该有什么资料，建议由哪方补充                        |
+---------------------------------------------------------------------+
```

**断点类型说明：**
- `Runtime 缺陷` — 问题在 Runtime 仓库的责任范围内（Runtime 维护的 API 文档、示例、构建说明等）
- `外源知识缺失` — 非 Runtime 仓库职责范围的知识缺失（如 AscendC 核函数编写、编译产物格式、
  tiling 参数结构等外部组件知识）。**记录但不计入 Runtime 整改项**，
  仅作为分析过程的完整性补充，说明开发者在此处需要依赖外部资料
- `体验问题` — 不阻塞功能，但影响开发效率或学习体验

## 卡点判定规则（责任归属）

Runtime 仓与非 Runtime 仓的职责边界**明确划分，不设灰色地带**：

| 卡住的环节 | 责任归属 | 处理方式 |
|-----------|---------|---------|
| aclInit / aclrtSetDevice / aclrtCreateContext | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| Device/Context/Stream 的初始化和管理 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| 内存分配、拷贝、释放的 API 用法 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| `<<<>>>` 内核调用符**语法定义和参数语义** | **非 Runtime 仓**（AscendC/asc-devkit） | **优先从 `reference/asc-devkit/` 查找**，记录为**外源知识缺失** |
| `<<<>>>` 在 Runtime 示例中的**使用方式**（如示例缺失） | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| aclrtSynchronizeStream / aclrtDestroyStream 等 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| Runtime 在 CANN 软件栈中的位置 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| 如何编写 AscendC 核函数 | **非 Runtime 仓** | **向用户求助**，记录为**外源知识缺失** |
| 如何编译核函数为二进制 | **非 Runtime 仓** | **向用户求助**，记录为**外源知识缺失** |
| AscendC 编译产物格式和路径约定 | **非 Runtime 仓** | **向用户求助**，记录为**外源知识缺失** |
| tiling 参数结构和传递方式 | **非 Runtime 仓** | **向用户求助**，记录为**外源知识缺失** |
| ASC 编译器、`find_package(ASC)` 等 CMake 集成 | **非 Runtime 仓** | **向用户求助**，记录为**外源知识缺失** |
| Cube/Matmul 核函数所需链接库（tiling_api、register、platform 等） | **非断点** | **不得记录为阻塞点或优化点**。CANN 正确安装后，ASC 构建系统会自动处理这些库的链接路径，用户只需在 CMakeLists.txt 中声明依赖即可，无需额外了解库的位置或手动配置路径。 |

**判断原则：** 该 API/概念是否由 Runtime 仓库维护？是 → Runtime 缺陷；否 → 外源知识缺失。
**不确定时：** 暂停分析，向用户确认该知识是否属于 Runtime 仓库职责范围，按用户判定归类。

**⚠️ 已确认的非断点事项（不得记录为断点）：**
- **链接库依赖（tiling_api、register、platform 等）**：CANN 正确安装后，ASC 构建系统的 `find_package(ASC)` 会自动设置库搜索路径，用户无需知道这些库的物理位置。在 CMakeLists.txt 中声明 `target_link_libraries(... tiling_api register platform)` 即可自然链接成功。**不得**将此记录为 Runtime 文档缺陷或阻塞点。

**⚠️ 已确认属于 AscendC 范畴的外源知识（不得记录为 Runtime 缺陷，强制）：**

以下 5 类问题由 AscendC (asc-devkit) 维护，`reference/asc-devkit/` 中已有对应资料，
**必须**分类为"外源知识缺失"，**严禁**分类为"Runtime 缺陷"或"Runtime 阻塞点"，
**不得计入 Runtime 整改项**：

| # | 知识类别 | 说明 | 归属 |
|---|---------|------|------|
| 1 | **ASC 构建系统** | `find_package(ASC)` + `.asc` 单文件编译模式的文档 | AscendC/asc-devkit |
| 2 | **两套构建系统并存** | `ascendc.cmake`（legacy）vs `find_package(ASC)`（新）的差异和选择 | AscendC/asc-devkit |
| 3 | **Tiling API** | `MultiCoreMatmulTiling`、`TCubeTiling`、`MatmulApiTiling` 等 tiling 参数结构和 API | AscendC/asc-devkit |
| 4 | **Cube/Mix 核函数属性** | `__cube__`、`__mix__(m,n)`、`__vector__` 等核函数属性的定义和使用 | AscendC/asc-devkit |
| 5 | **额外链接库** | `tiling_api`、`register`、`platform` 等 AscendC 依赖库的文档 | AscendC/asc-devkit |

**判定方法：** 遇到上述 5 类问题时，直接标记为"外源知识缺失（属于 AscendC 范畴）"，
从 `reference/asc-devkit/` 获取所需知识继续推进，**不得**将其记录为 Runtime 仓库的文档缺陷、
阻塞点或整改项。在断点汇总表和整改清单中必须明确标注"不计入 Runtime 整改"。

**违反判定：** 如果报告中将上述 5 类问题的任何一项分类为"Runtime 缺陷"，即判定为分类错误，
必须在报告提交前修正。

## 执行约束

- **⚠️ 算子信息为前置必要条件**：算子的详细信息（功能、输入输出、核函数接口等）必须在分析前获取。获取优先级：先从 `reference/` 外源知识仓库搜索，不足时再向用户求助。不得自行猜测或基于经验补全。
- **⚠️ 外源知识不得猜测**：遇到非 Runtime 仓库职责范围内的知识缺失时（如 AscendC 核函数编写、编译产物格式、tiling 参数等），**优先从 `reference/` 目录下的外源知识仓库中查找**；如果 `reference/` 中也无法找到，**再暂停并向用户求助**，不得自行猜测或脑补。此类缺失记录为**外源知识缺失**类型（不计入 Runtime 整改项），仅作为分析过程完整性的补充记录。
- **全程自主执行**（在算子信息确认后），遇到 Runtime 断点记录后继续推进；遇到外源知识需求时优先查 `reference/`，`reference/` 不足时再暂停求助用户
- **严格遵守知识来源规则**，Runtime API 只看仓库文档，非 Runtime API 优先查 `reference/`、不足时向用户求助
- **遇到资料缺失不假设**，Runtime 范畴的如实记录为断点，非 Runtime 范畴的向用户求助并记录为外源知识缺失
- **以第一人称叙述**，还原真实探索路径
- **不得跳过任何步骤**，即使预判会卡住也要尝试并记录
- **⚠️ 任务分派约束传递（当使用子 agent 并行执行多个算子时，强制）：**
  - "禁止使用简化核函数"、"外源符号交叉验证"、"核函数完整性自检"等强制规则
    **必须原文传递**给每个子 agent 的 prompt，**不得**在分派时放宽、弱化或附加例外条件
  - 不得在子 agent prompt 中写出类似"如果太复杂就简化"、"可以 memset 替代"等绕过指令
  - 每个子 agent 生成的验证包代码，需经过核函数完整性自检后才能写入最终文件
  - **违反此规则的后果：** 子 agent 产出的验证包无效，必须重新生成
- **⚠️ Step 10 编译运行验证为必选步骤（强制，不得跳过）：**
  - 验证包生成后，**必须**在当前环境中实际执行编译和运行，**编译通过不等于完成**
  - 验证通过的**两个必要条件必须同时满足**：
    (a) 程序输出包含 `Sample run successfully with <<<>>> kernel call!`
    (b) 程序输出包含 `[PRECISION PASS]` 且精度通过率 ≥ 99%
  - 如果编译失败或运行时精度验证不通过，**必须自行诊断并修复代码**，最多重试 3 次
  - **不得**在编译通过但未实际运行的情况下报告"验证完成"
  - **不得**在运行输出全零、报错、或精度不达标的情况下报告"验证通过"
  - 子 agent 返回结果时，主 agent **必须检查**结果中是否包含精度验证的具体数据
    （通过元素数、最大误差等），**缺失精度数据的结果视为未完成**，需追问或重新派发
  - **违反此规则的后果：** 该算子的分析任务视为未完成，不得标记为 completed
- **⚠️ AscendC 范畴知识分类（强制，不得错分）：**
  - 子 agent 的 prompt 中**必须原文传递**"已确认属于 AscendC 范畴的外源知识"表格（5 类）
  - 子 agent 产出的断点报告中，如果将上述 5 类问题分类为"Runtime 缺陷"，
    主 agent 在审核时**必须立即修正**，不得直接标记为 completed
  - 整改清单中上述 5 类问题**必须标注**"不计入 Runtime 整改（属于 AscendC 范畴）"

## 输出内容

分析完成后输出以下内容，写入 `reports/` 目录。

**输出文件名（使用"执行前准备"中确定的版本号）：**
- 分析报告：`reports/cann_runtime_blockpoint_analysis_{算子名}_kernel_launch_v{版本号}.md`
- 整改清单：`reports/cann_runtime_blockpoint_todolist_{算子名}_kernel_launch_v{版本号}.md`
- 验证包目录：`reports/{算子名小写}_verify/`（如 `reports/mmad_verify/`、`reports/vecadd_verify/`）

### 1. 开发过程叙述
以第一人称，按 Step 1~10 顺序完整叙述开发探索过程。
每个步骤包含：做了什么 → 查了哪些资料 → 结果如何 → 是否遇到断点。

### 2. API 资料支撑情况表
汇总每个 API 的文档覆盖情况（格式见 Step 5 表格）。

### 3. 最终代码产出
输出尽可能完整的 $0 算子调用代码。
无法填充的部分用 `[UNKNOWN: 原因]` 占位标注。

### 4. 代码完成度统计
格式详见 `references/completion-stats-template.md`：
```
Runtime 相关步骤：N 步
├─ 可完成（有明确文档支撑）：N 步
├─ 可完成但体验差（需复杂查找）：N 步（优化点）
└─ 无法完成（资料缺失导致阻断）：N 步（阻塞点）
代码完成率（仅 Runtime 部分）：XX%
```

### 5. 断点汇总表

| # | 类型 | 步骤 | 问题描述 | 查找过的文件 | 缺失资料 | 影响程度 |
|---|------|------|----------|-------------|----------|---------|

### 6. 断点统计
```
Runtime 缺陷：N 个（阻塞点 M 个 / 优化点 M 个）
外源知识缺失：N 个（不计入 Runtime 整改，仅供参考）
体验问题：N 个
阻塞点总计（仅 Runtime 缺陷）：N 个
```

### 7. 断裂地图（全链路断点分布可视化）
用文本图示展示 Step 1→8 的全链路中，哪些位置发生了断点（Step 9-10 为验证包生成与编译运行，不纳入断裂地图）：

```
Step1 ──→ Step2 ──→ Step3 ──→ Step4 ──→ Step5 ──→ Step6 ──→ Step7 ──→ Step8
 ✅        ✅        📦#1      📦#2      🔴#3      🟡#4      📦#5      ✅
```

图例：✅ 顺畅 | 🔴 阻塞点（Runtime 缺陷，真正阻断开发） | 🟡 优化点（Runtime 缺陷，可解决但体验差） | 📦 外源知识缺失

### 8. 整改 TodoList

断点分析完成后，**立即**基于断点汇总表生成整改 TodoList，
写入整改清单文件（文件名见"输出内容"章节的命名规则，与分析报告使用相同版本号）。

**优先级映射规则：**
- 阻塞点 → P0（立即修复）— 真正阻断开发过程，无法继续
- 优化点 → P1（近期改善）— 通过复杂查找可解决，但体验差

**每条任务格式：**
```markdown
- [ ] **T-P0-001 [标签]** 任务标题
      > 问题：断点描述（定位到文件/函数/章节）
      > 目标：改进后应达到的状态
      > 行动：具体操作步骤
      > 负责模块：docs / example / 根目录
      > 关联断点：#N
```

**任务标签**（每条任务必选一个）：
`[API文档]` `[编程模型]` `[示例代码]` `[错误处理]` `[构建系统]`
`[开发者体验]`

**生成规则：**
- 每个断点至少对应一条任务，不得遗漏
- 可将同类断点合并为一条任务（需在任务中列出所有关联断点编号）
- 文件头包含：关联报告、生成日期、统计概览（P0/P1 各 N 项）、完成进度条

### 9. 验证包

按照 Step 9 的要求，生成完整可编译的验证包，写入 `reports/{算子名}_verify/` 目录。

**验证包输出文件清单（以 bare_mix 为例）：**
```
reports/bare_mix_verify/
├── CMakeLists.txt               find_package(ASC) 编译配置，链接 tiling_api/register/platform 等
├── bare_mix.asc                 真实 __mix__(1,2) 核函数 + host main（ReadFile 改为硬编码数据）
├── data_utils.h                 数据读写工具函数（从 reference/ 复制）
├── run.sh                       一键编译脚本（仅需 ASCEND_INSTALL_PATH）
└── README.md                    使用说明
```

**验证包核心原则：**
- 验证包**必须包含真实的核函数实现**，从 `reference/asc-devkit/` 完整复制，包括核函数类、tiling 生成函数、辅助头文件等
- **禁止将真实核函数简化为 element-wise copy 或其他简化逻辑**
- 唯一允许的修改是将 `ReadFile`/`WriteFile` 替换为硬编码数据初始化 + `printf` 输出
- 验证包中的代码是分析报告"最终代码产出"章节的**可编译完整版**
- 如有辅助头文件（`data_utils.h`、`nd2nz_utils.h` 等），必须一并包含
- CMakeLists.txt 的链接库配置必须与 `reference/` 中的 CMakeLists.txt 一致

### 10. 验证包编译运行结果

按照 Step 10 的要求，在当前环境中实际编译并运行验证包，将验证结果附在分析报告末尾。
如果编译或运行失败，自行修复代码直到验证通过（最多重试 3 次），并记录修复过程。
