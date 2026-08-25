# Git 工作流参考

## 提交信息格式

遵循 Conventional Commits 规范：

```bash
git commit -m "docs: 创建 FAQ - [问题标题]"
git commit -m "docs: 更新 README FAQ 导航"
git commit -m "fix: 重命名 FAQ 文件去除空格"
```

PR 标题格式：
```
<type>: <描述>(#issue_id)
```

示例：`docs: 新增常见 FAQ(#535)`

## 分步提交建议

推荐分步提交（便于回滚和审查）：

1. FAQ 文档创建 → 单独提交
2. README 更新 → 单独提交

## 推送前检查

务必确认：
- 所有文件 UTF-8编码
- README 表格链接路径正确（无空格）
- 文件名无空格
- 尾部无多余空格

## 创建 PR

使用 gitcode-pr skill 创建 PR：

- 目标仓库：cann/runtime
- 目标分支：master
- PR 标题：`docs: FAQ 扩展 - [分类名称]`
- PR 描述：按仓库模板 `.gitcode/PULL_REQUEST_TEMPLATE.zh-CN.md` 填充

## 定期同步 upstream

减少合并冲突：
```bash
git fetch origin
git merge origin/master
```

## 干净分支策略

如果当前分支历史混乱（多个 merge commit），建议重建干净分支：

```bash
git checkout -b doc/faq-clean origin/master
# 从旧分支复制文件
git checkout doc/old-messy-branch -- docs/zh/FAQ/ docs/zh/README.md
# 如有删除的旧文件
git rm docs/zh/FAQ/旧FAQ文件.md
# 提交干净 commit
git commit -m "docs: 新增常见 FAQ(#535)"
git push -u fork doc/faq-clean
```
