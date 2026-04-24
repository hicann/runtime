---
name: cann-runtime-usability-eval
description: >
  对 CANN Runtime 开源仓库进行系统性易用性评估。
  从仓库基础设施、API 可用性、文档质量、示例质量、开发者体验五个维度
  逐项审查，输出带评分的评估报告和按优先级排序的整改 TodoList。
  可结合断点分析（cann-runtime-blockpoint-analysis）的输出进行交叉印证。
  当用户要求评估 CANN Runtime 的文档质量、API 覆盖度、示例完整性、
  开发者体验，或需要输出整改方案时使用此 Skill。
  也适用于"评估 Runtime 仓库易用性"、"文档质量打分"、"生成整改计划"等场景。
---

# CANN Runtime 易用性评估

## 评估对象

CANN Runtime 是华为昇腾 CANN（Compute Architecture for Neural Networks）的
Runtime 运行时模块，为算子开发者提供设备管理、内存管理、Stream/Context
管理等底层运行时 API。

- 本地目录：当前工作目录（仓库根目录）
- 仓库地址：https://gitcode.com/cann/runtime（仅供参考，不作为评估数据源）

## 角色定位

你是一名**具备开源项目技术评审经验的工程师**，以 CANN Runtime 的上游使用者
（算子开发人员）视角，对仓库进行系统性的可用性与易用性审查，并输出专业的整改方案。

## 这个 Skill 做什么

对 CANN Runtime 仓库进行五维度系统性静态审查，
遍历 docs/ 和 example/ 下的每一个文件，
输出带评分的评估报告和按优先级排序的可执行整改 TodoList。

**与断点分析的关系：**
- 断点分析（Skill A）是**动态的**——通过走流程发现"实际卡在哪里"
- 易用性评估（本 Skill）是**静态的**——通过逐项审查发现"哪里缺了什么"
- 两者互补：断点分析的卡点是评估报告的实证支撑；
  评估报告能发现断点分析未覆盖到的系统性缺陷
- 如果已有断点分析的输出，本 Skill 会将其作为输入，
  在报告中交叉引用，在 Roadmap 中统一排优先级

## 执行前准备

**首要动作：** 确认仓库结构（与断点分析相同）：

1. `ls .`
2. `tree . -L 2`
3. `tree docs/ -L 3`
4. `tree example/ -L 3`
5. `ls -la README* LICENSE* CONTRIBUTING* CHANGELOG* 2>/dev/null`
6. `mkdir -p reports/`

**检查断点分析输出（可选）：**
```bash
ls reports/*blockpoint* 2>/dev/null
```
如存在，读取断点清单作为后续评估的实证输入。

## 知识来源规则

| 知识领域 | 允许的来源 | 禁止的来源 |
|---------|-----------|-----------|
| Runtime 仓库评估 | 仓库 docs/ 和 example/ 为主要来源 | 华为官网、CSDN、博客等外部 Runtime 资料 |
| AscendC 衔接判断 | AscendC 指南目录（仅用于判断衔接完整性） | 外部网络 AscendC 资料（静态评估不使用） |
| 横向对比（附录 B） | 行业经验（CUDA/ROCm）定性对比 | — |
| C/C++/CMake 基础 | 已有技能 | — |

**核心原则：**
- 静态评估中，**行业经验仅用于附录 B 横向对比**，不可用于补全 CANN 评估结论
- Runtime 仓库的评估数据**只来自仓库实际内容**
- 外部 Runtime 相关资料**禁止使用**

## 评估深度要求

- **docs/ 目录**：逐文件打开阅读，记录路径、标题、内容摘要、质量判断
- **example/ 目录**：逐文件打开阅读，记录路径、功能、完整性判断
- **禁止抽样**，须覆盖全部文件
- 文件超过 50 个的目录，按子目录分批处理，最终须全部覆盖
- 每个问题须精确到**文件路径 + 具体章节/行号**
- 每个结论须附带至少一条具体证据
- "缺失"类结论须说明查找范围（如"在 docs/ 全部 N 个文件中均未找到"）
- **禁止**泛化表述（如"文档不够完善"），须指出具体位置和具体问题

## 五维度评估框架

每个维度输出四项内容：
1. **现状描述** — 实际情况 + 文件路径证据
2. **问题清单** — 编号列出，定位到文件/章节
3. **严重等级** — 阻塞性 / 影响体验 / 优化建议
4. **整改方案** — 可落地的具体改进建议

评估开始时，按需读取 `references/dimensions/` 下对应维度的详细检查项。

### 维度一：仓库基础设施（权重 10%）
→ 读取 `references/dimensions/d1-infrastructure.md`

逐项检查：
- README.md：项目简介、适用人群、快速开始、依赖说明、构建步骤
- LICENSE：开源协议是否明确
- CONTRIBUTING.md：贡献指南
- CHANGELOG / Release Notes：版本历史
- Issue / PR 模板
- CI/CD 配置

### 维度二：API 接口可用性（权重 30%）
→ 读取 `references/dimensions/d2-api-usability.md`

以算子开发者的典型使用路径为主线，检查以下接口的文档与示例覆盖：

**必查接口清单：**
- Device 管理：aclrtSetDevice / aclrtGetDevice / aclrtResetDevice
- Context 管理：aclrtCreateContext / aclrtDestroyContext
- Stream 管理：aclrtCreateStream / aclrtDestroyStream / aclrtSynchronizeStream
- 内存管理：aclrtMalloc / aclrtFree / aclrtMemcpy / aclrtMemset
- 事件管理：aclrtCreateEvent / aclrtRecordEvent / aclrtSynchronizeEvent

**补充接口清单：**
扫描 include/ 目录中实际暴露的公开头文件，
将上述清单未列出但仓库实际提供的 API 一并纳入评估。

每类接口检查：
- 头文件暴露且路径合理
- 函数签名完整（参数名、类型、返回值）
- 错误码完整枚举及说明
- ABI 兼容性和版本稳定性承诺
- 线程安全性说明

### 维度三：docs/ 文档完整性与质量（权重 25%）
→ 读取 `references/dimensions/d3-doc-completeness.md`

检查项：
- API Reference：入参/出参/错误码/使用约束
- 编程模型文档：Device-Context-Stream 层级与生命周期
- 快速上手指南：从零到跑通第一个算子
- FAQ：典型报错和解决方案
- 文档与代码同步性
- 文档内部一致性（术语、命名、描述风格）

**每篇文档打分**（标准见 `references/rating-rubric.md`）：
- **A** — 完整、有示例、与代码同步、有交叉引用
- **B** — 基本完整，缺示例或部分参数不全
- **C** — 框架在但内容不完整，关键信息缺失
- **D** — 仅标题或占位，无实质内容
- **F** — 完全缺失

### 维度四：example/ 示例可验证性（权重 20%）
→ 读取 `references/dimensions/d4-example-quality.md`

逐示例评估：

| 示例路径 | 功能描述 | 有README | 有编译指令 | 有预期输出 | 注释质量 | 与docs交叉引用 | 综合评级 |
|----------|----------|---------|-----------|-----------|---------|---------------|---------|

检查项：
- 覆盖范围：Device 初始化、Context/Stream、内存操作、Event、错误处理
- 独立可编译运行，依赖交代清楚
- 有预期输出或验证方式
- 注释质量：关键步骤有说明
- 与 docs/ 的联动

### 维度五：开发者体验（权重 15%）
→ 读取 `references/dimensions/d5-developer-experience.md`

检查项：
- 环境搭建难易度
- 编译构建流程
- 与上下游组件的集成说明（AscendC、OPP、CANN Toolkit）
- 社区活跃度（基于仓库可见信息）
- 错误信息的可调试性

## 输出内容

评估完成后，在 `reports/` 目录下输出两个文件：

### 文件一：评估报告

文件名：`cann_runtime_eval_report_vX.Y.Z.md`

#### 报告结构（详见 `references/report-template.md`）

```
执行摘要
  ├─ 总体评分（各维度 1-5 分 + 加权综合得分）
  ├─ 核心结论（3 句话以内）
  └─ 最高优先级问题 Top 3

断点分析引用（如有 Skill A 输出）
  ├─ 断点统计摘要
  ├─ 断裂地图引用
  └─ 代码完成率

五维度评估详情
  ├─ 维度一：仓库基础设施
  ├─ 维度二：API 接口可用性
  ├─ 维度三：docs/ 文档完整性与质量
  ├─ 维度四：example/ 示例可验证性
  └─ 维度五：开发者体验

整改方案 Roadmap
  ├─ P0（立即修复，阻塞开发者使用）
  ├─ P1（近期改善，影响开发者体验）
  └─ P2（中长期优化，提升生态质量）
  每项标注来源：[断点#N] / [维度X问题#N] / [两者]

附录
  ├─ A：仓库文件遍历清单
  ├─ B：横向对比（CUDA Runtime / ROCm HIP）
  └─ C：对仓库维护者的 3 条核心建议
```

**评分权重**（详见 `references/scoring-weights.md`）：

| 维度 | 权重 |
|------|------|
| 仓库基础设施 | 10% |
| API 接口可用性 | 30% |
| 文档质量 | 25% |
| 示例质量 | 20% |
| 开发者体验 | 15% |

**Roadmap 编写规则：**
- 融合断点分析卡点 + 静态审查问题，统一排优先级
- 优先级判定标准见 `references/priority-criteria.md`
- 每项包含：编号 → 问题描述 → 改进目标 → 行动项 → 预期效果
- 问题描述须具体到文件/函数/章节，**禁止泛化**
- 标注来源：`[断点#N]` / `[维度X问题#N]` / `[两者]`

**横向对比**（附录 B，详见 `references/horizontal-comparison.md`）：

| 维度 | CANN Runtime | CUDA Runtime | ROCm HIP | 差距分析 |
|------|-------------|-------------|----------|---------|

知识来源声明：CUDA/ROCm 数据基于行业经验定性对比，CANN 数据来自本仓库实际内容。

### 文件二：TodoList

文件名：`cann_runtime_todolist_vX.Y.Z.md`

评估报告写入后**立即自动生成**。

#### TodoList 结构（详见 `references/todolist-template.md`）

```markdown
## 文件头
关联报告：cann_runtime_eval_report_vX.Y.Z.md
生成日期：YYYY-MM-DD
统计概览：P0 共 N 项 / P1 共 N 项 / P2 共 N 项 / 合计 N 项
完成进度：░░░░░░░░░░ 0%

## 映射追溯表
| TodoList 任务编号 | 对应 Roadmap 条目 | 映射关系 |
|------------------|------------------|---------|

## P0 - 立即修复
- [ ] **T-P0-001 [标签]** 任务标题
      > 问题：...
      > 目标：...
      > 行动：...
      > 负责模块：...
      > 关联断点：#N（若有）
      > 对应 Roadmap：P0 #N

## P1 - 近期改善
...

## P2 - 中长期优化
...
```

**任务标签**（每条任务必选一个）：
`[基础设施]` `[API文档]` `[编程模型]` `[快速上手]` `[示例代码]`
`[错误处理]` `[构建系统]` `[开发者体验]` `[生态集成]` `[FAQ]`
`[衔接]` — AscendC 与 Runtime 衔接缺口专用

**生成规则：**
- 完全从 Roadmap 提取，须覆盖所有问题项
- 可合理拆分或合并，不得遗漏
- 任务描述比 Roadmap 更精炼，突出"做什么"而非"为什么"

### 版本号规则（两个文件独立管理）

- 首次生成：v1.0.0
- 内容修订（结论变化）：minor +1，如 v1.1.0
- 格式微调（不影响结论）：patch +1，如 v1.0.1
- 重大重构：major +1，如 v2.0.0

## 执行约束

- **全程自主执行**，不在步骤之间询问用户
- **遍历全部文件**，不得抽样，不得跳过空目录或看似不重要的文件
- **问题定位须精确**到文件路径/函数名/章节，禁止泛化
- 整改建议须**可落地**，如"在 docs/api_reference.md 中补充 aclrtMemcpy 的 size 参数对齐要求"
- 两个输出文件均写入 reports/ 目录后，统一向用户汇报完成情况
