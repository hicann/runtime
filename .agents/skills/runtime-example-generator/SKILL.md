---
name: runtime-example-generator
description: 根据用户提供的 CANN Runtime API，设计并生成具有真实使用场景、完整处理流程和可验证结果的 Runtime7 单 Device 新样例。仅用于新增样例，不用于已有样例整改、API 覆盖率盘点或独立的 PR/CI 任务。
---

# CANN API 场景样例生成

## 目标

根据一个或一组 CANN Runtime API，设计真实、合理的使用场景，并生成可以构建、运行和验证结果的新样例。API 是场景的输入，不是样例的主题。

## 适用范围

- 只创建新的编号样例，不修改、移动或扩展已有可运行样例。
- 只生成单 Device 样例，不使用 P2P、设备拓扑、跨 Device 内存或其他依赖多个 Device 的能力。
- 不处理 API 覆盖率统计或与用户提供 API 无关的仓库整改。

## 工作流程

### 1. 理解 API

读取用户提供的 API、目标仓库说明、正式 API 文档、公开头文件和相邻样例，理解接口用途、调用条件和对象关系。按照 [references/change-checklist.md](references/change-checklist.md) 完成 API 准入核对，并以全部关键 API 产品支持范围的交集确定样例支持范围；不得根据编译成功或单一产品运行成功外推其他产品。

如果用户只提供 API，没有描述业务目标，则根据接口之间的关系提出最自然的实际场景。只有存在多个结果差异明显的合理方向时，才询问用户选择。

### 2. 设计场景

先用一句话写出场景中的使用者、运行条件、业务目标、主要操作和最终结果，再决定是否生成：

- 每个 API 都必须推动流程、影响决策、验证结果或完成必要的资源清理。
- 相关 API 可以组成一个完整场景；不相关的 API 应拆成多个独立样例。
- 场景必须有确定的输入或运行条件，以及能够观察和判断对错的结果。
- 不接受“依次调用 API 并全部返回成功”作为场景或验收结果。

无法满足这些条件时停止生成，并给出清晰的 API 分组或替换建议。

### 3. 确认目录

读取 [references/placement-matrix.md](references/placement-matrix.md)，根据场景目标选择 Runtime7 章节、主题、编号和名称。目录名称描述业务行为或可观察结果，不拼接 API 名称。

### 4. 生成样例

完整读取 [references/example-style-guide.md](references/example-style-guide.md)，生成源码、中文 `README.md`、英文 `README_en.md`、`CMakeLists.txt` 和 `run.sh`。两份 README 都是每个可运行样例的必需文件；不得因用户只使用一种语言或相邻样例缺少英文文档而省略其中一份。新增样例后，只更新直接父主题 README 中的链接和简短说明。

### 5. 验证样例

完整执行 [references/change-checklist.md](references/change-checklist.md)，对本任务的完整文件清单执行目标仓库定义的本地格式与静态检查。在确认当前设备属于 README 标记支持的产品后，运行生成的 `run.sh`。检查工具改写文件后必须检查差异并重新执行，直到检查以 0 退出且不再产生改动。缺少本地工具链或受支持设备时，完成仍可执行的检查，并明确列出未完成项，不得伪造结果。远端 PR/CI 状态检查、告警修复和流水线重跑不属于本 Skill 的职责。

## 交付说明

交付时说明场景目标、新增路径、构建和运行结果，以及未纳入 API 和未完成验证的原因。
