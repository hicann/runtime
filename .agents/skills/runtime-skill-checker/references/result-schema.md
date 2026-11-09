# 审查结果数据结构

`review-result.yaml` 是审查与优化共用的唯一事实源。本文件只定义需要持久保存的审查事实；正式规范元数据、规则汇总、评分和总体结论均由脚本按 Runtime 正式规范动态生成。

## 1. 通用约束

- 使用 UTF-8、两个空格缩进和脚本支持的 YAML 子集。
- 字符串建议使用双引号；不使用锚点、标签或多文档语法。
- 每个对象只能包含本文列出的字段；缺少或增加字段都会校验失败。
- `prepare` 负责填入目标实际路径和默认审查规则，不手工复制规范标题、级别或行号。

## 2. 顶层结构

```yaml
phase: "review"
target: "<目标 Skill 的实际路径>"
review:
  status: "in-progress"
  blocking_reason: ""
rules:
  - id: ""
    status: "pending"
    assessment: ""
    evidence: []
failures: []
optimization:
  status: "not-started"
  requested_failure_ids: []
  blocking_reason: ""
```

此代码块只展示字段结构，不能直接作为审查结果提交。示例中的空 `id` 由 `prepare` 替换为当前正式规范中的实际规则编号；实际初始结果会列出全部默认审查规则，而不是保留空编号。

| 对象 | 固定字段 | 约束 |
| --- | --- | --- |
| 顶层 | `phase`、`target`、`review`、`rules`、`failures`、`optimization` | `phase` 为 `review` 或 `optimize`。 |
| `target` | 无子字段 | 目标 Skill 的非空实际路径；结果文件必须位于该目录之外。 |
| `review` | `status`、`blocking_reason` | 状态为 `in-progress`、`completed` 或 `blocked`；`blocking_reason` 为字符串。 |
| `optimization` | `status`、`requested_failure_ids`、`blocking_reason` | 状态及关联约束见第 5 节。 |

不保存 schema 版本、规范路径、规范摘要、规则总数、Skill 名称或仓库根路径。检查器按 `references/review.md` 规定的来源读取 Runtime 正式规范，完成校验和渲染。

## 3. 规则项

`prepare` 会把全部默认审查规则写入 `rules`。审查者可以移除不适用规则；最终没有适用规则时允许使用 `rules: []`。

每项固定包含：

| 字段 | 类型与约束 |
| --- | --- |
| `id` | `prepare` 生成的正式规则编号，不得为空或重复。 |
| `status` | 工作结果可为 `pending`、`pass`、`fail`；最终结果只能为 `pass` 或 `fail`。 |
| `assessment` | 字符串；状态为 `pass` 或 `fail` 时不得为空。 |
| `evidence` | 列表；状态为 `pass` 或 `fail` 时至少包含一项。 |

规则标题、级别和当前行号不写入 YAML，由检查器根据 `id` 从当前正式规范读取。证据项固定包含两个非空字符串：

```yaml
evidence:
  - location: "SKILL.md:12"
    observation: "入口、执行和验证步骤均围绕同一类任务。"
```

## 4. 问题项

`failures` 中每项固定包含以下字段，优化后可以额外包含 `resolution`：

| 字段 | 类型与约束 |
| --- | --- |
| `id` | `Fail-NNN` 或 `Suggest-NNN`；两类编号分别从 `001` 连续递增。 |
| `rule_ids` | 非空字符串列表，只能引用 `rules` 中状态为 `fail` 的规则。 |
| `severity` | `high`、`medium` 或 `low`。 |
| `location` | 非空字符串。 |
| `evidence` | 非空字符串。 |
| `problem` | 非空字符串。 |
| `impact` | 非空字符串。 |
| `recommendation` | 非空字符串。 |
| `suggested_change` | 字符串列表。文本修改填写简化 diff；无文本修改时填 `[]`。格式见下文。 |
| `resolution` | 可选对象，结构见第 5 节。 |

问题编号前缀决定总体结论，不强制与规则级别绑定。同一问题项只能合并同一级别规则。每条 `fail` 规则必须被问题项引用，问题项引用的规则也必须处于 `fail`。

```yaml
- id: "Fail-001"
  rule_ids:
    - "G.SEC.01"
  severity: "high"
  location: "SKILL.md:24"
  evidence: "正文允许直接修改目标文件，未设置只读默认。"
  problem: "审查阶段缺少最小权限边界。"
  impact: "可能在未授权时改变被审查 Skill。"
  recommendation: "明确审查模式只读，并将修改切换到优化模式。"
  suggested_change:
    - "@@ SKILL.md:25"
    - " 默认进入审查模式。"
    - "+审查阶段保持目标 Skill 只读；仅在用户授权后进入优化模式。"
    - " 审查完成后输出问题编号并等待用户选择。"
```

diff 标记后的内容必须完整保留目标文件原行。原行本身是 Markdown 列表项时，删除行保留原有的 `- `，新增行也保留新的 `- `：

```yaml
suggested_change:
  - "@@ SKILL.md:75"
  - "-- 原列表项"
  - "+- 新列表项"
```

`@@` 后只允许使用目标 Skill 内的相对路径和正整数行号，不得使用绝对路径、反斜杠、`.`、`..` 或章节名称。上下文用于帮助读者定位，条件允许时提供简短上下文，但不强制。一个修改块只能包含一个连续修改块；修改行之间重新出现上下文后，不得在同一块中继续修改。同一问题需要修改多个不连续位置时，每个位置分别写一个 `@@ 相对路径:行号` 修改块。

## 5. 优化结果

获授权的问题项可以增加：

```yaml
resolution:
  status: "fixed"
  changed_files:
    - "SKILL.md"
  verification_results:
    - check: "重新审查对应规则。"
      result: "passed"
      detail: "修改后的内容满足规则要求。"
  residual_risk: "none-known"
  reason: ""
```

`resolution` 固定包含 `status`、`changed_files`、`verification_results`、`residual_risk`、`reason`：

- `status` 为 `fixed`、`failed`、`rejected` 或 `blocked`。
- `changed_files` 使用目标 Skill 内的相对路径，不得使用绝对路径或包含 `..`。
- `verification_results` 每项固定包含非空的 `check`、`detail`，以及值为 `passed`、`failed` 或 `not-run` 的 `result`。
- `fixed` 要求修改文件和验证结果均非空，且所有验证结果为 `passed`。
- `failed` 要求验证结果、`residual_risk` 和 `reason` 均非空。
- `rejected` 要求修改文件为空；`rejected` 和 `blocked` 均要求 `reason` 非空。

`optimization.status` 为 `not-started`、`awaiting-confirmation`、`in-progress`、`completed` 或 `blocked`。`requested_failure_ids` 是问题编号列表，`blocking_reason` 是字符串。

最终审查结果中：

- 有问题项时，优化状态为 `awaiting-confirmation`。
- 无问题项时，优化状态为 `not-started`。
- `requested_failure_ids` 为空。

最终优化结果中：

- `phase` 为 `optimize`，审查状态仍为 `completed`，优化状态为 `completed`。
- `requested_failure_ids` 非空且只能引用现有问题项。
- 每个获授权问题项都有合法的 `resolution`。
- 保留原规则判定、审查证据和问题编号；复核证据和处理结果只写入对应问题项的 `resolution`。

优化阶段不改变原审查评分和总体结论；修复后的验证情况通过 `resolution` 展示。

## 6. 生命周期与派生结果

| 阶段 | 约束 |
| --- | --- |
| 准备结果 | `phase: review`、审查状态为 `in-progress`；允许规则为 `pending`，由 `review_result.py prepare` 生成；此时只创建 `review-result.yaml`，不生成 Markdown。 |
| 审查完成 | `phase: review`、审查状态为 `completed`；所有保留规则为 `pass` 或 `fail`。 |
| 审查受阻 | 审查状态为 `blocked`；只能保存为未完成结果。 |
| 优化进行中 | `phase: optimize`，按 `references/optimize.md` 记录获授权问题项。 |
| 优化完成 | 审查状态和优化状态均为 `completed`，每个获授权问题项都有处理结果。 |

`review_result.py finalize` 会根据 Runtime 正式规范和 `rules` 动态派生规则标题、级别、行号、汇总、评分和总体结论。这些派生值不写入 `review-result.yaml`。只有 `finalize` 校验成功后才生成或覆盖 `review-report.md`；Markdown 由结果文件渲染，不单独维护另一套审查事实。
