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

## 关键约束：禁止主动发布评论

**这是最重要的约束，必须严格遵守。**

### 禁止事项

在用户**没有明确要求**发布评论时，agent **绝对不能**执行以下操作：

- ❌ 向 GitCode PR 发布 summary comment
- ❌ 向 GitCode PR 发布行内评论（inline comments）
- ❌ 使用任何 GitCode API 进行 POST/DELETE 评论操作
- ❌ 调用 `post_pr_summary_comment.py`
- ❌ 调用 `post_pr_inline_comment.py`
- ❌ 使用 `--comment` 或 `--post-inline-comments` 参数运行脚本

### 触发条件

只有在用户**明确要求**时，才允许发布评论：

| 用户明确表达 | 才能发布 |
|-------------|---------|
| "发布评论"、"提交审查结果" | ✅ summary comment |
| "post review"、"提交到GitCode" | ✅ summary comment |
| "发布行内评论"、"发inline comments" | ✅ 行内评论 |
| "把审查结果发到 PR"、"review并发评论" | ✅ summary + inline（需确认） |

### Red Flags - 这些想法意味着你需要 STOP

| Thought | Reality |
|---------|---------|
| "审查完成了，应该发布结果" | ❌ **STOP** - 必须等待用户明确指令 |
| "这是流程的最后一步" | ❌ **STOP** - 发布是可选操作，不是自动流程的一部分 |
| "用户之前做过类似操作" | ❌ **STOP** - 历史不代表当前意图，必须确认 |
| "这样更高效/更完整" | ❌ **STOP** - 未经授权的外部系统操作是危险行为 |
| "脚本支持 --comment 参数" | ❌ **STOP** - 参数存在不代表应该使用 |
| "用户没说不要发布" | ❌ **STOP** - 必须主动确认，不能假设默许 |

### 正确流程

```
审查完成 → 向用户展示审查摘要 → 等待用户反馈 → 用户明确要求发布 → 执行发布
```

**审查完成后的正确响应**：

```
审查已完成。发现：
- X 个必须修改的问题
- Y 个建议修改的问题
- Z 个仅供参考的问题

是否需要将审查结果发布到 GitCode？
```

**等待用户回复**，如果用户说：
- "是"、"可以"、"发布"、"提交" → 执行发布
- "不用"、"不需要" → 结束，不发布
- 无回复或说其他 → 再次询问或结束

### 为什么这个约束重要

1. **外部系统操作有副作用**：发布评论会影响 PR 状态、触发通知、影响他人工作流
2. **用户可能只想本地审查**：不希望立即暴露审查结果给 PR 作者
3. **用户可能想先讨论**：调整审查内容后再发布
4. **尊重用户控制权**：agent 是辅助工具，用户必须明确控制对外操作
5. **避免误操作**：未经授权的发布可能造成严重后果

## 规范加载原则

- 所有源码审查都必须遵从 `docs/guidelines/coding-guidelines.md`
- 审查 UT 代码时，除上面的文档外，还必须额外遵从：
  - `docs/guidelines/ut-coding-guidelines.md`
  - `docs/guidelines/dt_guide/UT用例开发指导.md`
