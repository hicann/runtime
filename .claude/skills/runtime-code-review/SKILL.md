---
name: runtime-code-review
description: |
  Runtime 仓统一代码审查入口。根据用户输入自动路由到本地代码检视或 GitCode PR 代码检视。
  当用户需要审查当前分支改动、本地 diff、最近提交、指定文件，或需要审查 GitCode PR / MR 时使用此 skill。
---

# Runtime Code Review

本 skill 是 Runtime 仓统一的代码审查入口，支持两种模式：

- `local-review`：审查本地 worktree / branch diff
- `pr-review`：审查 GitCode PR diff

## 共享规则

无论进入哪种模式，都必须读取共享规则文件：

- `.claude/skills/runtime-code-review/review-rules.md`

该规则文件定义：

- 必须读取的规范文档
- 审查维度
- 严重程度定义
- 输出格式
- 审查总结格式

## 路由规则

### 进入 `local-review`

满足以下任一情况时，使用 `local-review.md`：

- 用户要求审查当前分支、本地改动、最近提交、指定文件
- 用户运行 `runtime-code-review`，但未提供 PR 链接或 PR 编号

### 进入 `pr-review`

满足以下任一情况时，使用 `pr-review.md`：

- 用户提供 GitCode PR / MR 链接
- 用户给出 PR 编号并要求审查
- 用户明确说“审查这个 PR / MR”

## 规范加载原则

- 所有源码审查都必须遵从 `docs/guidelines/coding-guidelines.md`
- 审查 UT 代码时，除上面的文档外，还必须额外遵从：
  - `docs/guidelines/ut-coding-guidelines.md`
  - `docs/guidelines/dt_guide/UT用例开发指导.md`
