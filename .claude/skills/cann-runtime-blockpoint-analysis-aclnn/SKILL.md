---
name: cann-runtime-blockpoint-analysis-aclnn
description: >
  对 CANN Runtime 开源仓库进行 aclnn 预置算子路径的断点分析。
  模拟新手走通任意 aclnn 算子的调用全流程。
  用法：/cann-runtime-blockpoint-analysis-aclnn aclnnMatMul
  当用户要求分析 CANN Runtime 的 aclnn 算子调用路径、验证新手能否通过
  预置算子库完成计算任务时，使用此 Skill。
  也适用于"用 aclnnMatMul 做断点分析"、"预置算子路径的断点分析"等场景。
argument-hint: "[算子名称，如 aclnnAdd / aclnnMatMul]"
---

# CANN Runtime 使用断点分析 — $0 路径

## 评估对象

CANN Runtime 是华为昇腾 CANN（Compute Architecture for Neural Networks）的
Runtime 运行时模块，为算子开发者提供设备管理、内存管理、Stream/Context
管理等底层运行时 API。

- 本地目录：当前工作目录（仓库根目录）
- 仓库地址：https://gitcode.com/cann/runtime（仅供参考，不作为评估数据源）

## 这个 Skill 做什么

模拟一名应用开发新手，以 **$0** 为载体，
从零尝试走通 CANN Runtime 的**预置算子调用**全流程。
全程以第一人称叙述，像真实开发者一样探索仓库资料，
每遇到资料缺失或不足导致无法继续的地方，记录为一个"断点"。

**与 Kernel Launch 路径的区别：**
本 Skill 走的是"调用 CANN 内置算子"路径（aclnn 系列 API），
**不涉及** AscendC 核函数编写和编译。

| 对比项 | $0 路径（本 Skill） | Kernel Launch 路径 |
|-------|-------------------------|-------------------|
| 算子来源 | CANN 内置算子库 | 开发者用 AscendC 编写 |
| 关键 API | $0GetWorkspaceSize → $0 | BinaryLoad → GetFunction → LaunchKernel |
| 需要编译核函数 | 不需要 | 需要 |
| 适用场景 | 快速使用已有算子 | 开发自定义算子 |
| 参考示例 | 先搜索 `$0` 对应示例，若无则参考 `example/quickstart/` | `example/kernel/0_launch_kernel/` |

**核心价值：** 断点分析发现的是开发者实际会撞上的阻塞问题，
而不是理论上可能存在的文档缺陷。每个断点都对应一个真实的
"我卡住了，不知道怎么往下走"的时刻。

**评估聚焦点：** 本次实战验证关注两个层面的问题：
1. **Runtime 自身文档质量** — Runtime 职责范围内的 API 文档是否完整、示例是否充分（主要评估目标）
2. **端到端可达性** — 一个新手能否通过仓库内资料 + 外源知识走通 $0 全流程？
   （整体体验评估）

## 参数说明

- **$0**（必填）：目标 aclnn 算子名称，如 `aclnnAdd`、`aclnnMatMul`、`aclnnSub`
- 命名约定：算子名以 `aclnn` 开头
- 对应的 API 约定：
  - GetWorkspaceSize API：`$0GetWorkspaceSize`
  - Execute API：`$0`
  - 头文件（约定）：`aclnnop/aclnn_<operator>.h`（如 aclnnAdd → `aclnnop/aclnn_add.h`）
- 如用户未提供算子名，提示用户指定一个 aclnn 算子名
- **⚠️ 算子信息获取（优先从 reference/ 查找）：** 算子的详细信息（功能、签名、Tensor/Scalar 规格等）属于**外源知识**，应遵循外源知识处理规则，按以下优先级获取：

  **获取优先级：**
  1. **首先**：在"执行前准备 · 首要动作 0"中 clone `reference/` 外源知识仓库
  2. **然后**：在 `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/` 中搜索 `$0` 的相关文档和代码，提取以下 5 项信息：
     1. 算子的功能描述（做什么计算）
     2. 函数签名（`$0GetWorkspaceSize` 和 `$0` 的完整参数列表）
     3. 输入/输出 Tensor 的数量、维度和数据类型
     4. 是否需要 Scalar 参数，如需要则提供其类型和含义
     5. 其他特殊要求（如特定的 format、特殊的内存布局等）
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
  - 第 2 项（函数签名）：是否包含完整的参数列表（参数名、类型、顺序）？能否据此直接写出调用代码？
  - 第 3 项（Tensor）：是否明确了每个 Tensor 的维度数、shape 约束、数据类型？
  - 第 4 项（Scalar）：如需要，是否说明了类型和含义？如不需要，是否明确说明了"不需要"？
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
6. 重点查看 quickstart 示例：`ls -la example/quickstart/`
7. 确保输出目录存在：`mkdir -p reports/`
8. 查看外源知识仓库结构：`tree reference/ -L 2`

**版本号检测（必须在输出前完成）：**

输出文件命名规则：
- 分析报告：`reports/cann_runtime_blockpoint_analysis_{算子名}_v{版本号}.md`
- 整改清单：`reports/cann_runtime_blockpoint_todolist_{算子名}_v{版本号}.md`

其中 `{算子名}` 为用户传入的算子名（如 `aclnnMatMul`），`{版本号}` 格式为 `X.0.0`。

**版本号确定流程：**
1. 在 `reports/` 目录下搜索匹配 `cann_runtime_blockpoint_analysis_{算子名}_v*.md` 的文件
2. 如果**不存在**任何匹配文件 → 版本号为 `1.0.0`
3. 如果**存在**匹配文件 → 提取已有文件中最大的主版本号 N，新版本号为 `{N+1}.0.0`
4. 将确定的版本号记录下来，后续输出文件统一使用此版本号

示例：
- 首次执行 aclnnMatMul → `v1.0.0`
- 已存在 `v1.0.0` → 新文件为 `v2.0.0`
- 已存在 `v1.0.0` 和 `v2.0.0` → 新文件为 `v3.0.0`

将以上输出作为后续分析的基础索引。

**⚠️ 强制前置检查 — 确认算子信息已获取（必须在任何分析前完成）：**
在执行仓库结构探索和 `reference/` clone 之后、进入 Step 1 之前，**从 `reference/` 中搜索算子信息**：
1. 在 `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/` 中搜索 `$0` 相关文档和代码
2. 提取"参数说明"章节要求的 5 项算子信息
3. **如果 `reference/` 中信息齐全** → 直接继续，无需等待用户确认
4. **如果 `reference/` 中信息不全** → 暂停，使用"参数说明"章节中的询问模板向用户求助缺失项

**不得跳过此检查。不得以"我了解该算子"为由跳过。必须有明确的信息来源（reference/ 或用户提供）。**

**算子信息发现（在算子信息确认后执行）：**
1. 在 `example/` 中搜索 `$0` 关键词，确认是否有对应示例
2. 在 `docs/` 中搜索 `$0`，确认是否有 API 文档
3. 如无专门示例，以 `example/quickstart/`（aclnnAdd）为参考模板
4. 记录 $0 的参数签名发现情况——如果仓库中找不到签名，这本身就是断点
5. 将仓库中发现的信息与用户提供的算子信息进行对比，确认哪些属于 Runtime 职责、哪些属于外源知识

**同时确认 aclnn 相关文档：**
在 `docs/` 中搜索 aclnn、Tensor、Scalar、$0 等关键词，
了解仓库对预置算子调用路径的文档覆盖情况。

**⚠️ 外源知识前置判断（必须在进入 Step 1 之前完成）：**

在确认仓库结构和算子信息后、正式开始 8 步分析之前，**主动预判**本次分析是否会涉及
**非 Runtime 仓库范畴的知识**（即 Runtime 仓库的 docs/ 和 example/ 中不会包含、
也不应该包含的知识）。

**判断方法：**
1. 对照用户提供的算子信息，列出涉及的所有 API 和概念
2. 逐项判断每个 API/概念是否属于 Runtime 仓库的职责范围
3. 将判定结果分为两类：
   - **Runtime 仓内知识**：aclInit、aclrtSetDevice、aclrtCreateStream、aclrtMalloc、
     aclrtMemcpy、aclrtSynchronizeStream、aclrtFree 等 Runtime 基础 API
   - **非 Runtime 仓知识（外源知识）**：属于其他组件维护的 API 和概念，例如：
     - **两段式调用范式**（GetWorkspaceSize → Execute 概念、workspace/executor 含义）
     - aclCreateTensor / aclDestroyTensor（Tensor 描述 API）
     - aclCreateScalar / aclDestroyScalar（Scalar 描述 API）
     - aclnn 算子的具体签名和参数含义
     - aclnnStatus 错误码
     - AscendC 核函数编写相关知识
     - 其他非 Runtime 仓库维护的 API

**如果识别到外源知识需求，立即告知用户：**
> "在本次 $0 断点分析中，以下 API/概念不属于 Runtime 仓库的职责范围：
> - [列出具体的外源 API/概念]
>
> 我会优先从 `reference/` 目录下的外源知识仓库中查找相关资料。
> 如果 `reference/` 中也无法找到所需信息，我会向您求助。"

**等待用户确认或补充后，再进入 Step 1。**

**执行期间的外源知识处理规则：**
- 在 Step 1~8 推进过程中，遇到需要外源知识才能继续的情况时，**优先从 `reference/` 目录查找**：
  - **两段式调用范式、workspace/executor 概念** → 查找 `references/aclnn-two-phase-calling.md`（skill 内置）和 `reference/ops-math/docs/zh/context/两段式接口.md`
  - aclnn 算子签名、参数含义 → 查找 `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`
  - AscendC 相关知识 → 查找 `reference/asc-devkit/`
  - Tensor/Scalar API → 先查 Runtime 仓库 docs/example/，不足时查 `reference/` 下相关仓库
- 如果 `reference/` 中**找到了所需信息** → 标注 `[reference: 仓库名/文件路径]`，直接用于继续分析
- 如果 `reference/` 中**未找到所需信息** → **暂停分析，向用户求助**
- 将非 Runtime 仓库职责范围内的知识缺失记录为**外源知识缺失**类型（不计入 Runtime 整改项），**不得**记录为 Runtime 缺陷
- **不得**自行猜测或脑补外源知识
- `reference/` 中的信息和用户提供的外源知识均作为**权威输入**，直接用于继续分析

## 角色画像

分析全程以此角色视角进行（详见 `references/role-profile.md`）：

- 熟练掌握 C/C++ 和 CMake
- 理解异构计算基本概念（Host/Device、内存拷贝、异步执行）
- 不了解 CANN Runtime API 具体用法
- 不了解 CANN 特有的 Device-Context-Stream 编程模型

## 知识来源规则（严格执行）

详见 `references/source-rules.md`，核心原则：

| 知识领域 | 允许的来源 | 禁止的来源 |
|---------|-----------|-----------|
| Runtime API 用法 | **仅限**仓库 docs/ 和 example/ | 华为官网、CSDN、博客、CUDA 经验推断 |
| aclnn 算子相关知识 | **优先** `reference/ops-nn/`、`reference/ops-transformer/`、`reference/ops-math/`，不足时向用户求助 | 自行猜测、脑补 |
| AscendC 相关知识 | **优先** `reference/asc-devkit/`，不足时向用户求助 | 自行猜测、脑补 |
| 其他非 Runtime 仓 API | **优先** `reference/` 下查找，不足时向用户求助 | 自行猜测、脑补、基于经验推断 |
| C/C++/CMake 基础 | 角色已有技能 | — |
| 推测性知识 | 可标注 `[推测]`，不计入代码产出 | 不可当作确定信息使用 |

**执行纪律：**
- Runtime API 遇到资料不足时，**不得脑补**，必须记录为断点
- **非 Runtime 仓 API**（如 aclCreateTensor、aclCreateScalar 等外部组件 API）遇到资料不足时，**优先从 `reference/` 目录下的外源知识仓库中查找**；如果 `reference/` 中也无法找到，**再暂停并向用户求助**，记录为**外源知识缺失**（不计入 Runtime 整改项）
- 推测性代码用 `[UNKNOWN: 原因]` 占位
- 来自示例代码的知识标注 `[Runtime example]`
- 来自 `reference/` 外源知识仓库的知识标注 `[reference: 仓库名/文件路径]`
- 来自用户提供的外源知识标注 `[用户提供]`

## 开发步骤（逐步推进）

以 $0 为载体，按以下 10 步推进。
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

### Step 3：理解 aclnn 算子调用范式
- **两段式调用范式、workspace、executor 概念属于 aclnn 知识（非 Runtime 范畴）**，应从 `reference/` 查找：
  - 首先查 `references/aclnn-two-phase-calling.md`（skill 内置参考文档）
  - 其次查 `reference/ops-math/docs/zh/context/两段式接口.md` 等 ops 仓库文档
- 在 Runtime 仓库 docs/ 中搜索是否有 aclnn 相关的**指引或链接**（注意：Runtime 仓无义务提供两段式调用的概念文档，但可以提供指引）
- 搜索 $0 对应示例，如无则参考 `example/quickstart/` 中的示例代码
- **断点检查：**
  - **不得**将"Runtime docs/ 中没有两段式调用范式文档"记录为 Runtime 缺陷（这是 aclnn 知识，属于外源知识范畴）
  - Tensor/Scalar 的创建和使用文档是否完整？（Tensor/Scalar API 属于外源知识）
  - `reference/` 中是否能找到两段式调用、workspace、executor 的完整解释？
  - 是否有 $0 的专门示例或文档？若无，quickstart 的指引是否足够通用？

### Step 4：创建输入输出 Tensor 和参数
- 依据文档理解 aclCreateTensor 的参数含义
- 理解 shape、strides、format、dataType 等概念
- 在 Device 上分配内存并创建 Tensor 描述
- 如 $0 需要标量参数（Scalar），理解 aclCreateScalar 的用法
- **断点检查：**
  - aclCreateTensor 的 API 文档是否完整？每个参数的含义是否清晰？
  - strides 的计算方式是否有说明？
  - aclFormat 枚举值是否有文档？
  - $0 需要几个输入 Tensor？几个输出 Tensor？是否需要 Scalar？（从文档/示例能否确定？）

### Step 5：编写 Runtime 调用框架代码（核心断点区域）
**仅依赖 Runtime 仓库 docs/ 和 example/**，尝试编写完整代码

**逐 API 填写资料支撑情况表**（模板见 `references/api-coverage-table.md`）：

| API / 操作 | 文档位置 | 参数说明完整度 | 示例代码位置 | 资料来源 | 能否写出调用 |
|------------|----------|---------------|-------------|---------|-------------|

### Step 6：错误处理
- 依据 docs/ 为每个 API 添加错误检查
- **断点检查：** 错误码枚举是否完整？aclnn 相关的错误码有无说明？

### Step 7：编译与构建
- 编写包含 Runtime + aclnn 算子库链接的完整 CMakeLists.txt
- **断点检查：**
  - 需要链接哪些库？（libascendcl.so、libnnopbase.so、libopapi.so）
  - 需要包含哪些头文件路径？
  - `docs/03_api_ref/头文件-库文件说明.md` 是否涵盖 aclnn 相关的库？（若不涵盖，属于外源知识缺失）

### Step 8：运行验证
- 确认如何执行和验证结果
- 参考已有示例的 run.sh 和预期输出
- **断点检查：** 有预期输出说明吗？怎么判断结果正确？

### Step 9：验证包生成

断点分析完成后，**必须**生成一个完整可编译的验证包，打包到 `reports/` 目录下。
验证包的目的是让用户可以**直接拷贝到 NPU 机器上运行**，验证 Runtime API 调用流程能否走通。

> **注意：** 验证包验证 Runtime 调用流程的正确性（初始化 → Tensor 创建 → 两段式调用 → 同步 → 结果回传 → 资源释放），
> **同时进行精度验证**。在 Host 侧根据算子数学公式计算 expected 值，与 Device 输出逐元素对比。

**验证包命名规则：**
```
reports/{算子名小写}_verify/
```
其中 `{算子名小写}` 为用户传入的算子名的小写形式（如 `aclnnadd`、`aclnnmatmul`）。

**验证包目录结构：**
参考 `example/0_quickstart/0_hello_cann` 的结构，使用标准 C++ 项目（无需 Python 脚本）：

```
{算子名小写}_verify/
├── CMakeLists.txt           标准 C++ 项目配置（链接 ascendcl + nnopbase + opapi）
├── main.cpp                 Host 代码（aclnn 两段式调用完整流程，数据硬编码）
├── run.sh                   一键编译运行脚本
└── README.md                使用说明（前置条件、快速使用、预期输出）
```

**验证包生成规则（严格执行）：**

1. **代码必须完整可编译** — 所有代码必须是完整的、可直接编译运行的，不得包含 `[UNKNOWN]` 占位符、`// ...` 省略注释或任何需要用户补充的部分
2. **自包含** — 验证包内的代码不依赖验证包外部的任何文件。**禁止在 `include_directories` 或任何路径中使用 `../`、`${CMAKE_CURRENT_SOURCE_DIR}/../..` 等相对路径引用验证包外部的文件**。所有头文件只来自 `${ASCEND_CANN_PACKAGE_PATH}/include` 和 `${ASCEND_CANN_PACKAGE_PATH}/aclnnop`
3. **代码风格对齐 `example/0_quickstart/0_hello_cann`** — 验证包中的代码应基于该示例的模式生成：
   - 输入数据硬编码在 `main.cpp` 中（小规模，如 8 个元素的向量），不使用外部数据文件
   - aclnn 调用使用两段式调用范式（GetWorkspaceSize → Execute）
   - 结果通过 `printf` 逐元素打印（含 expected 值），由用户目视确认
   - 编译配置使用 CMake + `ASCEND_CANN_PACKAGE_PATH` 变量 + 直接链接 `.so` 全路径
   - 使用 `CHECK_ERROR` 宏检查每个 ACL API 返回值
   - 完整的资源释放（Tensor、Scalar、Device 内存、Stream、Device）
4. **一键运行** — `run.sh` 脚本包含完整流程：加载 CANN 环境 → cmake 配置 → 编译 → 提示运行命令
5. **正确性判定** — 程序输出 `Sample run successfully!` 且打印的结果与 expected 值一致即验证通过
6. **⚠️ expected 值规则（强制）** — 打印的 expected 值必须根据算子的数学语义和实际输入数据**手动计算**得出，确保与真实算子执行结果完全一致。aclnn 调用的是真实算子，expected 按数学公式算
7. **⚠️ 外源符号交叉验证（强制，在写入文件前执行）：**
   验证包中所有非 Runtime API 的符号（aclnn 函数名、头文件名、枚举值等），
   **必须**逐一在 `reference/` 或仓库 `example/` 中 grep 确认实际写法，**不得凭推断或类比补全**。

   **执行方法：**
   1. 列出验证包代码中所有来自外源库的符号（如 `aclnnMatmul`、`aclnn_matmul.h`、`aclCreateTensor` 等）
   2. 对每个符号执行 `grep -rn "符号名" reference/ops-*/` 或 `grep -rn "符号名" example/`，确认：
      - **函数命名**：大小写是否正确？（如 `aclnnMatmul` vs `aclnnMatMul`）
      - **头文件名**：是否与实际文件名一致？
      - **参数顺序**：函数签名是否与代码一致？
   3. 如果搜索结果与代码写法不一致，**以搜索结果为准修正代码**
   4. 在分析报告中附上验证记录

   **不得跳过此步骤。未经 grep 验证的外源符号不得写入验证包文件。**

**⚠️ aclnn 函数命名规范（强制，错误会导致编译失败）：**
- aclnn API 命名：`aclnn` 前缀 + **首字母大写、其余小写**。例如：`aclnnAbs`、`aclnnSin`、`aclnnMatmul`（**不是** `aclnnMatMul`）
- GetWorkspaceSize API：`aclnn{Op}GetWorkspaceSize`。例如：`aclnnMatmulGetWorkspaceSize`（**不是** `aclnnMatMulGetWorkspaceSize`）
- 头文件：`aclnnop/aclnn_{op全小写}.h`。例如：`aclnnop/aclnn_matmul.h`（**不是** `aclnnop/aclnn_mat_mul.h`）
- **如不确定命名**，在 `reference/` 的 ops 仓库中搜索确认，或在 `${ASCEND_CANN_PACKAGE_PATH}/include/aclnnop/` 下查找实际头文件名

**CMakeLists.txt 要求（对齐 `0_hello_cann`）：**
- `include_directories` **只包含** `${ASCEND_CANN_PACKAGE_PATH}/include` 和 `${ASCEND_CANN_PACKAGE_PATH}/aclnnop`，**禁止其他路径**
- 直接链接 `.so` 全路径：`${ASCEND_CANN_PACKAGE_PATH}/lib64/libascendcl.so`、`libnnopbase.so`、`libopapi.so`
- 编译选项：`-O2 -std=c++17 -D_GLIBCXX_USE_CXX11_ABI=0 -Wall -Werror`

**main.cpp 要求（对齐 `0_hello_cann`）：**
- 使用 `CreateAclTensor` 模板函数封装 Tensor 创建（含设备内存分配、数据拷贝、strides 计算）
- 输入数据直接以 `std::vector` 硬编码（根据算子语义构造有意义的小数据）
- 打印输入数据、中间状态（workspace size 等）、输出结果（含 expected 对比）
- 使用 `aclrtResetDeviceForce` 复位设备

**run.sh 要求（对齐 `0_hello_cann`）：**
- 检查 `ASCEND_INSTALL_PATH` 环境变量和 `setenv.bash` 文件存在性
- `source "$_ASCEND_INSTALL_PATH/bin/setenv.bash"` 加载环境
- 传递 `-DASCEND_CANN_PACKAGE_PATH` 给 cmake
- 编译完成后提示可执行文件路径

**README.md 要求：**
- 概述：说明验证的算子和运算公式
- 目录结构说明
- 前置条件（硬件、CANN Toolkit、GCC、CMake）
- 环境变量设置方法
- 快速使用命令（`bash run.sh` + `./build/main`）
- 预期输出示例
- 相关 API 列表

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
   cd reports/{算子名小写}_verify/
   rm -rf build && mkdir -p build && cd build
   cmake .. 2>&1
   make -j$(nproc) 2>&1
   ```

3. **编译失败处理（自动修复循环）：**
   如果 cmake 或 make 失败，执行以下修复流程（**最多重试 3 次**）：

   a. **分析错误信息** — 读取编译器/链接器输出，定位错误原因
   b. **常见错误及修复策略：**
      - `undefined reference` → 检查 CMakeLists.txt 的 `target_link_libraries` 是否缺少库（如 `opapi`、`nnopbase`、`ascendcl`）
      - `No such file or directory` → 检查 `#include` 路径是否正确、头文件路径是否配置
      - 类型不匹配 → 检查 aclnn API 的参数类型是否与文档一致
      - 其他编译错误 → 回到仓库 docs/ 和 example/ 中确认正确的 API 用法，修正代码
   c. **修改验证包文件** — 直接编辑出错的文件
   d. **重新编译** — 重复步骤 2
   e. 如果 3 次重试后仍然失败，**向用户报告**具体的编译错误，请求协助

4. **运行验证包：**
   编译成功后，执行：
   ```bash
   cd reports/{算子名小写}_verify/
   ./build/main 2>&1
   ```

5. **运行失败处理（自动修复循环）：**
   如果运行时出错（返回非零退出码或输出 `[ERROR]`），执行以下修复流程（**最多重试 3 次**）：

   a. **分析运行输出** — 检查哪个 ACL/aclnn API 返回了错误码
   b. **常见运行错误及修复策略：**
      - `aclError = 100000`（参数校验失败）→ 检查 Tensor 描述符的 shape、dtype、format 是否正确
      - `aclError = 100001`（未初始化）→ 检查 aclInit 和 aclrtSetDevice 调用顺序
      - `aclError = 200000`（内存不足）→ 减小数据规模或检查 workspace 大小计算
      - GetWorkspaceSize 返回错误 → 检查输入输出 Tensor 描述符配置
      - Segfault → 检查空指针、内存越界
   c. **修改验证包代码** — 根据诊断结果修正
   d. **重新编译并运行** — 重复步骤 2-4
   e. 如果 3 次重试后仍然失败，**向用户报告**具体的运行错误，请求协助

6. **验证通过判定：**
   程序输出包含 `Sample run successfully` 即验证通过。
   在分析报告末尾附上验证结果：

   ```markdown
   ## 10. 验证包编译运行结果

   | 项目 | 结果 |
   |------|------|
   | CANN 路径 | ${实际使用的路径} |
   | cmake 配置 | ✅ 成功 |
   | 编译 | ✅ 成功 |
   | 运行 | ✅ 成功 |
   | 输出验证 | ✅ 包含 "Sample run successfully" |
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
- `外源知识缺失` — 非 Runtime 仓库职责范围的知识缺失（如 aclCreateTensor、
  aclCreateScalar 等外部组件 API 的用法，aclnn 算子签名等）。**记录但不计入 Runtime 整改项**，
  仅作为分析过程的完整性补充，说明开发者在此处需要依赖外部资料
- `体验问题` — 不阻塞功能，但影响开发效率或学习体验

## 卡点判定规则（责任归属）

Runtime 仓与非 Runtime 仓的职责边界**明确划分，不设灰色地带**：

| 卡住的环节 | 责任归属 | 处理方式 |
|-----------|---------|---------|
| aclInit / aclrtSetDevice / aclrtCreateStream | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| Device/Context/Stream 的初始化和管理 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| 内存分配、拷贝、释放的 API 用法 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| aclrtSynchronizeStream / aclrtDestroyStream 等 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| Runtime 在 CANN 软件栈中的位置 | **Runtime 仓** | 记录为 **Runtime 缺陷** |
| **两段式调用范式**（GetWorkspaceSize → Execute 概念） | **非 Runtime 仓** | **优先查 `references/aclnn-two-phase-calling.md` 和 `reference/ops-math/docs/zh/context/两段式接口.md`**，记录为**外源知识缺失** |
| workspace / executor 概念 | **非 Runtime 仓** | **优先查 `references/aclnn-two-phase-calling.md`**，记录为**外源知识缺失** |
| aclCreateTensor / aclDestroyTensor 的用法 | **非 Runtime 仓** | **优先查 `reference/`，不足时向用户求助**，记录为**外源知识缺失** |
| aclCreateScalar / aclDestroyScalar 的用法 | **非 Runtime 仓** | **优先查 `reference/`，不足时向用户求助**，记录为**外源知识缺失** |
| $0GetWorkspaceSize / $0 的具体参数含义 | **非 Runtime 仓** | **优先查 `reference/`，不足时向用户求助**，记录为**外源知识缺失** |
| aclnn 相关头文件和链接库说明 | **非 Runtime 仓** | **优先查 `reference/`，不足时向用户求助**，记录为**外源知识缺失** |
| aclnnStatus 错误码 | **非 Runtime 仓** | **优先查 `reference/`，不足时向用户求助**，记录为**外源知识缺失** |

**判断原则：** 该 API/概念是否由 Runtime 仓库维护？是 → Runtime 缺陷；否 → 外源知识缺失。不存在中间状态。

## 执行约束

- **⚠️ 算子信息为前置必要条件**：算子的详细信息（功能、签名、Tensor、Scalar 等）必须在分析前获取。获取优先级：先从 `reference/` 外源知识仓库搜索，不足时再向用户求助。不得自行猜测或基于经验补全。
- **⚠️ 外源知识不得猜测**：遇到非 Runtime 仓库职责范围内的知识缺失时（如 aclCreateTensor、aclCreateScalar、workspace/executor 概念、aclnn 头文件/库文件等），**优先从 `reference/` 目录下的外源知识仓库中查找**；如果 `reference/` 中也无法找到，**再暂停并向用户求助**，不得自行猜测或脑补。此类缺失记录为**外源知识缺失**类型（不计入 Runtime 整改项），仅作为分析过程完整性的补充记录。
- **全程自主执行**（在算子信息确认后），遇到 Runtime 断点记录后继续推进；遇到外源知识需求时优先查 `reference/`，`reference/` 不足时再暂停求助用户
- **严格遵守知识来源规则**，Runtime API 只看仓库文档，非 Runtime API 优先查 `reference/`、不足时向用户求助
- **遇到资料缺失不假设**，Runtime 范畴的如实记录为断点，非 Runtime 范畴的向用户求助并记录为外源知识缺失
- **以第一人称叙述**，还原真实探索路径
- **不得跳过任何步骤**，即使预判会卡住也要尝试并记录

## 输出内容

分析完成后输出以下内容，写入 `reports/` 目录。

**输出文件名（使用"执行前准备"中确定的版本号）：**
- 分析报告：`reports/cann_runtime_blockpoint_analysis_{算子名}_v{版本号}.md`
- 整改清单：`reports/cann_runtime_blockpoint_todolist_{算子名}_v{版本号}.md`
- 验证包目录：`reports/{算子名小写}_verify/`（如 `reports/aclnnadd_verify/`、`reports/aclnnmatmul_verify/`）

### 1. 开发过程叙述
以第一人称，按 Step 1~10 顺序完整叙述开发探索过程。
每个步骤包含：做了什么 → 查了哪些资料 → 结果如何 → 是否遇到断点。

### 2. API 资料支撑情况表
汇总每个 API 的文档覆盖情况（格式见 Step 5 表格）。

### 3. 最终代码产出
输出尽可能完整的 $0 调用代码。
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
 ✅        ✅        📦#1      📦#2      ✅        🟡#3      📦#4      ✅
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

按照 Step 9 的要求，生成完整可编译的验证包，写入 `reports/{算子名小写}_verify/` 目录。

**验证包输出文件清单（以 aclnnadd 为例）：**
```
reports/aclnnadd_verify/
├── README.md                    使用说明
├── CMakeLists.txt               标准 C++ 项目配置
├── main.cpp                     Host 代码（aclnn 两段式调用完整流程）
├── run.sh                       一键编译运行验证脚本
└── scripts/
    ├── gen_data.py              数据生成
    └── verify_result.py         精度验证
```

**验证包与分析报告的关系：**
- 验证包中的代码是分析报告"最终代码产出"章节的**可编译完整版**
- 分析报告中允许 `[UNKNOWN]` 占位的代码，在验证包中**必须**用可编译的实际代码替代
- 如果某些代码确实无法确定（如外源知识缺失导致），在分析报告中记录为断点，但验证包中仍需给出**可编译的最佳近似实现**（基于用户提供的算子信息和仓库示例）

### 10. 验证包编译运行结果

按照 Step 10 的要求，在当前环境中实际编译并运行验证包，将验证结果附在分析报告末尾。
如果编译或运行失败，自行修复代码直到验证通过（最多重试 3 次），并记录修复过程。
