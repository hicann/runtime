---
name: runtime-review
description: 对 Runtime 仓库提交的代码进行全面 Code Review。检查功能正确性、格式规范、日志合理性、错误处理、安全性及公共 API 兼容性。当用户请求代码审查、运行 /runtime-review、或希望在提交前进行质量检查时触发。
---

# Runtime Code Review

对当前分支相对于基线分支（默认 origin/master）的所有变更进行系统化 Code Review。

## 审查规则

**使用 Read 工具读取规则文件**：`.claude/runtime-code-review-rules.md`

该规则文件包含完整的审查维度、输出格式和严重程度定义。

## 执行流程

### 1. 获取变更范围

```bash
# 获取变更文件列表
git diff --name-only origin/master...HEAD

# 获取详细变更内容
git diff origin/master...HEAD
```

如果用户指定了特定的提交范围或文件，按用户指定范围审查。

### 2. 逐文件审查

对每个变更文件，按规则文件中定义的审查维度逐项检查。
