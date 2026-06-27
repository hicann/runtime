# PR Review

对 GitCode PR 的远程变更进行代码审查。

## 重要约束（必须遵守）

**禁止主动发布评论**：在用户没有明确要求时，绝对不能向 GitCode 发布任何评论。

详见 `SKILL.md` 中的"关键约束：禁止主动发布评论"章节。

## 输入参数

建议支持以下输入形式：

- GitCode PR / MR 链接
- PR 编号
- 显式参数：
  - `--pr <number>`
  - `--owner <owner>`
  - `--repo <repo>`
  - 可选：`--comment` 表示允许发布 GitCode 评论

## 适用场景

- 用户提供 GitCode PR 链接、PR 编号或要求审查某个 PR / MR
- 用户希望基于 GitCode PR diff 进行 review，而不是基于本地 worktree

## 设计来源

本模式的流程参考 `ge/.claude/skills/ge-code-reviewer/SKILL.md`，但规范来源全部替换为 Runtime 仓规则。

## 建议脚本

可配合以下脚本使用：

- `.claude/skills/runtime-code-review/scripts/fetch_pr_meta.py`
- `.claude/skills/runtime-code-review/scripts/fetch_pr_files.py`
- `.claude/skills/runtime-code-review/scripts/fetch_pr_raw_file.py`
- `.claude/skills/runtime-code-review/scripts/classify_review_files.py`
- `.claude/skills/runtime-code-review/scripts/should_skip_pr_review.py`
- `.claude/skills/runtime-code-review/scripts/prepare_pr_review_context.py`
- `.claude/skills/runtime-code-review/scripts/render_pr_review_summary.py`
- `.claude/skills/runtime-code-review/scripts/post_pr_summary_comment.py`
- `.claude/skills/runtime-code-review/scripts/post_pr_inline_comment.py`
- `.claude/skills/runtime-code-review/scripts/run_pr_review.py`
- `.claude/skills/runtime-code-review/review-result-schema.md`

## 环境准备

必须先准备：

- `GITCODE_API_TOKEN`

建议优先从环境变量读取：

```bash
echo $GITCODE_API_TOKEN
```

如果为空，再提示用户提供 token 或按 GitCode 文档方式配置。

## 执行流程

### 推荐单入口方式

优先使用总控脚本：

```bash
python3 .claude/skills/runtime-code-review/scripts/run_pr_review.py \
  --owner <owner> \
  --repo <repo> \
  --pr <number>
```

如果已经有结构化审查结果，并希望自动渲染 summary 或发布 summary comment，可使用：

```bash
python3 .claude/skills/runtime-code-review/scripts/run_pr_review.py \
  --owner <owner> \
  --repo <repo> \
  --pr <number> \
  --review-result review-result.json \
  --comment
```

如果还希望自动发布行内评论，可使用：

```bash
python3 .claude/skills/runtime-code-review/scripts/run_pr_review.py \
  --owner <owner> \
  --repo <repo> \
  --pr <number> \
  --review-result review-result.json \
  --comment \
  --post-inline-comments
```

`review-result.json` 的结构要求见：

- `.claude/skills/runtime-code-review/review-result-schema.md`

### 分步方式

1. 获取 `GITCODE_API_TOKEN`
2. 解析 PR 链接或 PR 编号
3. 获取 PR 元信息、文件列表和 diff
   - 推荐先调用 `fetch_pr_meta.py` 获取 PR 标题、描述、状态、base/head sha
   - 再调用 `fetch_pr_files.py` 获取文件列表和 diff refs
   - 必要时使用 `fetch_pr_raw_file.py` 获取 raw 文件校验具体行号
   - 推荐命令：

```bash
python3 .claude/skills/runtime-code-review/scripts/fetch_pr_meta.py --owner <owner> --repo <repo> --pr <number>
python3 .claude/skills/runtime-code-review/scripts/fetch_pr_files.py --owner <owner> --repo <repo> --pr <number>
```
4. 进行前置检查：
   - PR 是否已关闭
   - PR 是否是 draft
   - 是否属于不需要审查的场景
   - 如为已关闭、draft、自动化 PR 或显著无需审查的微小改动，可直接停止
   - 推荐命令：

```bash
python3 .claude/skills/runtime-code-review/scripts/should_skip_pr_review.py --meta pr-meta.json
```
5. 读取共享规则文件：`.claude/skills/runtime-code-review/review-rules.md`
6. 提取变更文件路径，并调用 `classify_review_files.py` 做文件分类：

```bash
jq -r '.file_paths[]' <pr-files.json> | python3 .claude/skills/runtime-code-review/scripts/classify_review_files.py
```

7. 聚合审查上下文：

```bash
python3 .claude/skills/runtime-code-review/scripts/prepare_pr_review_context.py \
  --meta pr-meta.json \
  --files pr-files.json \
  --classified pr-classified.json
```

8. 按共享规则加载规范文档：
    - `source_files`：`docs/guidelines/coding-guidelines.md`
      - 涉及 Error Message 相关变更：在上面的基础上，额外读取
        - `docs/guidelines/error_message_guide/README.md`
        - 必要时按共享规则继续读取错误码、宏、文案或整改原则专题文档
    - `ut_files`：额外再读
      - `docs/guidelines/ut-coding-guidelines.md`
      - `docs/guidelines/dt_guide/UT用例开发指导.md`
    - `doc_files`：必要时结合 `docs/guidelines/design_document_template.md`
9. 按共享规则逐文件审查
10. 对发现的问题做验证并过滤误报
11. 使用共享规则中定义的格式输出结果
12. 如用户明确要求，可进一步发布 GitCode summary comment 或行内评论

## 输出策略

### 默认输出（必须执行）

- **必须在终端输出完整审查结果**
- 如果未发现问题，明确输出"未发现问题"
- **不要在审查完成后自动执行任何 GitCode API POST 操作**

### 可选输出到 GitCode（需用户明确触发）

**关键约束**：只有在用户**明确要求**时才能发布评论。

#### 触发条件检查清单

在执行任何 POST 操作前，必须验证：

- [ ] 用户消息中包含明确关键词："发布"、"提交"、"post"、"发评论"
- [ ] 已向用户展示审查摘要
- [ ] 用户已回复确认（或无反对）
- [ ] **不是在审查完成后的首次响应**（不能因为"完成了"就自动发布）

**如果任何一项未满足，STOP 并询问用户：**

```
审查已完成。是否需要将审查结果发布到 GitCode？
```

#### 发布策略（仅在用户确认后执行）

当用户明确要求 `--comment` 或等价意图时，可进一步：

1. 发布 summary comment
2. 对高信号、可准确定位行号的问题发布行内评论

推荐策略：

1. 默认先发布 summary comment
2. 仅对高信号、可复现、可准确定位的少量问题发布行内评论
3. 不要把所有问题都发成行内评论，避免噪声过大
4. **发布前必须向用户展示摘要并获得确认**

推荐先渲染 summary，再发布 summary comment：

```bash
python3 .claude/skills/runtime-code-review/scripts/render_pr_review_summary.py \
  --input review-result.json \
  --output summary.md
```

```bash
python3 .claude/skills/runtime-code-review/scripts/post_pr_summary_comment.py \
  --owner <owner> \
  --repo <repo> \
  --pr <number> \
  --body-file summary.md
```

如果需要发布行内评论，可使用：

```bash
python3 .claude/skills/runtime-code-review/scripts/post_pr_inline_comment.py \
  --owner <owner> \
  --repo <repo> \
  --pr <number> \
  --path path/to/file.cc \
  --position 120 \
  --body "review comment"
```

## 行号确认策略

发布行内评论前，必须确认问题代码的准确行号。

推荐顺序：

1. 先通过 PR diff 定位大致 hunk
2. 再使用 `fetch_pr_raw_file.py` 获取 raw 文件内容
3. 必要时用 `grep -n` 或等价方式确认目标代码的精确行号

示例：

```bash
python3 .claude/skills/runtime-code-review/scripts/fetch_pr_raw_file.py \
  --owner <owner> \
  --repo <repo> \
  --sha <head_sha> \
  --path path/to/file.cc | grep -n "target_code"
```

## 注意事项

- 本模式只负责 PR 审查范围获取和 GitCode 交互。
- 审查维度、严重程度定义和输出格式必须完全复用共享规则文件。
- 如果用户只想看本地未提交改动，应切换到 `local-review.md`。
- 如果后续需要发布行内评论，建议使用 raw 文件内容确认问题行号，而不要只依赖 patch hunk 的起始位置。
- 不要在没有足够把握时发布低信号或猜测性评论。
