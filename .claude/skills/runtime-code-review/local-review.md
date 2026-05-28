# Local Review

对当前 worktree 或本地指定范围的代码变更进行审查。

## 适用场景

- 用户要求审查当前分支、本地改动、最近提交或指定文件的代码质量
- 用户运行 `runtime-code-review` 且未提供 GitCode PR 链接或 PR 编号

## 审查范围

默认审查范围：

```bash
git diff --name-only origin/master...HEAD
git diff origin/master...HEAD
```

如果用户指定了文件、目录、提交范围或 diff 范围，以用户指定为准。

## 执行流程

1. 获取本地审查范围和变更文件列表
2. 读取共享规则文件：`.claude/skills/runtime-code-review/review-rules.md`
3. 按文件分类加载规范文档：
    - 源码文件：`docs/guidelines/coding-guidelines.md`
    - UT 文件：在上面的基础上，额外读取
      - `docs/guidelines/ut-coding-guidelines.md`
      - `docs/guidelines/dt_guide/UT用例开发指导.md`
4. 按共享规则逐文件审查
5. 使用共享规则中定义的格式输出结果

## 注意事项

- 本模式只负责本地 diff 的获取与审查，不处理 GitCode PR API。
- 如果用户要求对 GitCode PR 进行审查，应切换到 `pr-review.md`。
