---
name: runtime-skill-checker
description: 按 Runtime 正式 Skill 开发规范逐条审查已有 Skill，生成包含问题证据和修改建议的报告，并根据用户明确选择的问题编号优化目标 Skill。当用户要求使用 runtime-skill-checker，或提出“审查 Skill”“优化 Skill”时使用；当优化请求没有审查报告和明确问题编号时，先进入审查模式，不直接修改目标 Skill。
compatibility: 需要 Python 3.10 或更高版本，仅使用标准库；已验证 Python 3.14.6
---

# Runtime Skill Checker

## 输入与输出报告

本 Skill 需要以下输入：

- 目标 Skill 目录；
- 读取 Runtime 仓库根目录下的正式规范 `docs/zh/guidelines/agent-skill-guidelines.md`。
- 可选的报告输出目录；未提供时使用 `<工作区根目录>/skill-review-report/<platform>/<skill-name>/`；
- `skill-review-report/` 仅保存本地审查产物，不属于 Skill 交付物，不得纳入版本控制、提交或上传。

输出报告目录必须位于目标 Skill 之外。`prepare` 阶段只生成 `review-result.yaml`；`finalize` 成功后，每个目标仅保留：

```text
<工作区根目录>/skill-review-report/<platform>/<skill-name>/
|-- review-result.yaml
`-- review-report.md
```

`<platform>` 从目标 Skill 的 `.agents/skills/`、`.claude/skills/` 等平台目录提取；无法识别时使用 `other`。

`review-result.yaml` 是唯一结构化事实源。`review-report.md` 仅在 `finalize` 校验成功后由结果文件生成或重新渲染。不要生成附录、工具调用日志、独立规则清单或第三份报告。

## 模式切换

### 审查模式

默认进入审查模式，期间目标 Skill 保持只读。

完整读取开发规范文档和 `references/review.md`，运行 `python -B scripts/review_result.py prepare <目标 Skill 目录> [--report-dir <报告输出目录>] ` 准备初始 YAML，按 `references/result-schema.md` 填写审查结果文件，再运行 `python -B scripts/review_result.py finalize <review-result.yaml 路径>` 完成最终校验并首次生成或重新渲染报告。当结果或报告文件已经存在的时候，询问用户是否重新生成审查结果；仅在用户明确同意后，才使用 --overwrite 重新运行。

报告按规则权重计算百分制评分：“要求”每条 5 分，“建议”每条 1 分；不适用规则不计入分母，失败规则计入分母但不得分。评分仅展示完成度。存在 `Fail-*` 则整体不通过，否则通过；`Suggest-*` 不影响整体通过。

仅检查适用的规则，不适用规则从结果中移除。满足时输出 `pass`；仅将有证据支持、存在具体影响且维护者可采取行动的不满足项记录为问题。证据不足的处理按 `references/review.md` 的“逐条判定”执行。`Fail-*` 表示最终不通过，`Suggest-*` 不改变总体通过结论；问题编号前缀不强制与规则级别绑定。YAML 内部用 `fail` 记录问题规则，并通过问题项关联编号。当用户给出确定的编号时，才进行下一步。

### 优化模式

读取 `references/optimize.md`，验证用户指定的问题是否成立，对成立的问题实施修改，并确认问题已解决。

然后，按 `references/result-schema.md` 的规定将复核证据和处理结果写入原结果文件中对应问题项的 `resolution`，保留原规则判定、审查证据和问题编号。运行 `python -B scripts/review_result.py finalize <review-result.yaml 路径>` 校验并重新渲染报告。

## 权限与停止条件

- 审查模式不得修改目标 Skill，不得读取历史审查报告。
- 优化模式只能处理用户明确选择的问题。
- 安装依赖或改变环境配置均不执行。
- 本 Skill 仅负责已有 Skill 的规范审查及用户指定问题的优化，不负责创建 Skill 或审查普通代码。请求超出范围或包含混合任务时，不扩展任务，只询问会影响处理结果的必要问题。

## 职责边界表述

审查、生成修改建议和实施优化时，按任务、输入、输出和触发条件说明目标 Skill 的职责边界。`description` 写清调用条件，正文写清执行阶段的判断和停止条件；目标 `SKILL.md` 正文不得出现其他 Skill 的具体名称，也不得以“转交某 Skill”或指向其他 Skill 的路径替代条件说明。

相邻 Skill 可以用于比较调用范围，但不得因目标正文没有列出其名称而判定失败。规范中“相邻 Skill 的分工”按任务条件理解，不要求点名。此项是本检查器的执行约束，不改写规范原文、不新增规范规则编号，也不将其他 Skill 名称单独作为规范失败项。当前 Skill 自身名称、通用术语和本 Skill 的任务资源引用不在此限制范围内。

## 报告写作要求
面向需要直接修改 Skill 的维护者，让读者快速看懂哪里有问题、有什么影响、应该怎么改。

- 只报告有明确收益、维护者可以采取行动的问题和建议。不输出措辞偏好、章节组织偏好或凭空假设的异常场景；上下文已足以支持正确执行时，不要求补充通用常识、重复提醒或额外边界说明。
- 使用简明中文和通俗词汇，必要的专业术语应作见简短解释，并将重点词语加粗。
- 使用短句，每句话只表达一个主要意思。
- 整改意见必须给出切实可行的方案，避免“优化”等模糊表述；格式按 `references/result-schema.md` 第 4 节执行。

## 完成标准

审查完成：逐条检查全部适用规则，判定有根据，生成完整报告；存在可优化问题时，已询问用户如何处理。
优化完成：逐条验证用户指定的问题，确认处理结果，生成完整报告。

## 评测资源

`evals/routing-cases.yaml` 维护调用与不调用本 Skill 的正向和近邻负向用例。

`evals/behavior-cases.yaml` 维护审查只读、授权优化和异常停止等关键行为用例。

`evals/test_review_result.py` 验证结果准备、结构校验、报告生成和路径隔离等确定性脚本行为。

普通审查和优化任务不读取 `evals/`。只有维护本 Skill或验证时，才按受影响范围更新或运行对应评测。
