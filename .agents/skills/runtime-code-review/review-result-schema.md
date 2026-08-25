# Review Result Schema

[scripts/run_pr_review.py](scripts/run_pr_review.py) 接收的 `--review-result` 应满足以下 JSON 结构。

## 顶层结构

```json
{
  "change_summary": "本次变更的目的和范围",
  "problem_stats": {
    "must_fix": 1,
    "suggested": 2,
    "reference": 0
  },
  "overall_assessment": "代码质量评估及是否建议合入",
  "findings": []
}
```

## 顶层字段说明

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `change_summary` | string | ✅ | 变更概要 |
| `problem_stats.must_fix` | integer | ✅ | `[必须修改]` 数量 |
| `problem_stats.suggested` | integer | ✅ | `[建议修改]` 数量 |
| `problem_stats.reference` | integer | ✅ | `[仅供参考]` 数量 |
| `overall_assessment` | string | ✅ | 总体评价 |
| `findings` | array | ✅ | 逐问题明细 |

## finding 结构

```json
{
  "file": "src/runtime/foo.cc",
  "severity": "[必须修改]",
  "dimension": "功能正确性",
  "line": 123,
  "summary": "问题摘要",
  "suggestion": "建议修复方式",
  "inline_comment": {
    "path": "src/runtime/foo.cc",
    "position": 123,
    "start_position": 120,
    "body": "发布到 GitCode 的行内评论正文"
  }
}
```

## finding 字段说明

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `file` | string | ✅ | 问题所属文件 |
| `severity` | string | ✅ | `[必须修改]` / `[建议修改]` / `[仅供参考]` |
| `dimension` | string | ✅ | 审查维度 |
| `line` | integer | ❌ | 问题对应行号，summary 渲染时使用 |
| `summary` | string | ✅ | 问题摘要 |
| `suggestion` | string | ❌ | 建议修复方式 |
| `inline_comment` | object | ❌ | 仅在需要自动发布行内评论时提供 |

## inline_comment 字段说明

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `path` | string | ❌ | 默认使用 `finding.file` |
| `position` | integer | ❌ | 默认使用 `finding.line` |
| `start_position` | integer | ❌ | 多行评论起始行 |
| `body` | string | ❌ | 若未提供，则由脚本根据 finding 自动生成正文 |

## 约束

1. `severity` 必须是以下三者之一：
   - `[必须修改]`
   - `[建议修改]`
   - `[仅供参考]`
2. 若希望发布行内评论，建议为对应 finding 提供 `inline_comment`。
3. 若 `inline_comment` 未提供 `body`，脚本会根据 `severity`、`dimension`、`summary` 和 `suggestion` 自动生成正文。
