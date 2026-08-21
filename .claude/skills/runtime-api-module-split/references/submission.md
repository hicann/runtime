# 四 PR 分批上库流程

## 1. 前置原则

- 首次交付固定为 4 个 PR：独立文档 PR -> 第一批框架 PR -> 第一批路由 PR -> 第一批清理 PR。
- 三个代码业务阶段串行合入：框架 -> 路由 -> 清理。
- 文档 PR 只包含 7 项分析和方案交付件，不混入源代码、CMake 或 UT 改动。
- 每个阶段基于前一阶段实际合入后的最新 `origin/master`，不要长期堆叠在未合入提交上。
- 每个 PR 只包含一个阶段和一个清晰提交；检视清理确有必要时使用窄 PR，不混入下一阶段。
- 保留用户工作区中的无关改动。大改优先使用隔离 worktree。
- 推送、创建/更新 PR、发布评论或审批都需要用户明确授权。

## 2. 分支与提交建议

```text
docs/api-<module>-split-plan
refactor/api-<module>-framework
refactor/api-<module>-route
refactor/api-<module>-cleanup
```

建议提交标题：

```text
docs: 新增 <Module> API 拆分分析与计划
refactor: 新增 Api<Module> 框架
refactor: 切换 <Module> API 调用链
refactor: 清理主 Api <Module> 旧链路
```

若阶段一合入后需要检视清理：

```text
refactor: 清理 Api<Module> 冗余依赖
```

## 3. 准备阶段分支

先确认工作区和远程：

```bash
git status --short
git remote -v
git fetch origin master
```

可在隔离目录中基于主线创建分支：

```bash
git worktree add <isolated-path> -b refactor/api-<module>-framework origin/master
```

不要使用会覆盖用户改动的 reset/checkout 操作。若从聚合分支提取内容，按文件和 hunk 选择：

```bash
git diff --stat origin/master...<aggregate-branch>
git diff origin/master...<aggregate-branch> -- <path>
git add -p <path>
git diff --cached --stat
git diff --cached
```

提交前确认没有混入下一阶段接口或用户无关文件。

## 4. 阶段提交检查

每个阶段至少执行：

```bash
git diff --check origin/master...HEAD
git diff --stat origin/master...HEAD
git log --oneline origin/master..HEAD
```

再按 [risk-and-validation.md](risk-and-validation.md) 执行对应验证。失败不能只写“环境问题”；要定位失败发生在改动前后、是否进入目标源文件、是否属于证据缺口。

## 5. 推送与创建 PR

仅在用户明确要求后：

1. 读取仓库 `gitcode-pr` Skill。
2. 读取当前 `.gitcode/PULL_REQUEST_TEMPLATE.zh-CN.md`，不要使用旧硬编码模板。
3. 推送当前阶段分支到用户指定 fork。
4. 创建目标为 `cann/runtime:master` 或用户明确指定分支的 PR。
5. 若代码发生变更后刷新已有 PR，同步更新 PR 描述中的变更范围、风险、实际验证结果和剩余工作，不得保留与最新代码不一致的旧描述。
6. 回读线上 PR 的 title、head/base、提交数、描述和最新 commit，确认与本地一致。

前一阶段 squash/no-merge 合入后，下一阶段要基于实际主线提交刷新，并重新执行完整阶段验证。不要假设 PR head SHA 等于最终主线 SHA。

## 6. CI 门禁

每个 PR 创建或刷新后都必须检查线上 CI：

1. 文档 PR：适用的文档、格式、OAT 和仓库必选任务必须通过。
2. 框架、路由、清理 PR：仓库必选任务和 CI 编译任务必须通过，并结合阶段风险执行对应 UT。
3. CI 失败时先定位并修复，推送修复后同步更新 PR 描述，再等待新一轮 CI。
4. CI 未触发、仍在运行、编译目标被跳过或产物不可读时，记录为证据缺口，不得写成“CI 编译通过”。
5. 只有线上 CI 显示成功且目标编译任务确实执行，才能将代码 PR 标记为可合入。

三个代码 PR 严格串行。前一代码 PR 实际合入且 CI 编译通过后，下一代码 PR 才基于最新主线刷新、验证和提交。

## 7. PR 描述内容

按仓库模板填充，描述部分至少包含：

```markdown
## 描述

本 PR 是 `<模块>` API 大类拆分的 `<框架/路由/清理>` 阶段。

本批接口：
- `<aclrtXxx>` -> `<rtXxx>` -> `<ApiXxx::Xxx>`

具体变更：
- ...

行为等价说明：
- C API 签名、参数校验、返回码、ErrMsg、profiling、Context/线程环境和产品支持保持不变。

本 PR 不包含：
- 不切换/不删除下一阶段链路。
- 不整改 `<剩余接口>`；原因是 `<跨模块依赖/后续批次>`。

剩余工作：
- ...
```

“如何测试”写实际执行结果，包括命令、目标、通过数和未完成项；不要预填计划结果。Checklist 只勾选真正完成的项目。

## 8. 三阶段 PR 重点

### 框架 PR

描述必须强调现有 C API 未切路由。列出 Runtime 生命周期、各产品 CMake/stub 和直接 UT；说明新增成员布局与不支持产品语义。

### 路由 PR

描述必须列出切换的确切 C API，并声明旧主 `Api` 方法仍保留。给出路由证明、新旧行为对比和环境/profiling 验证。

### 清理 PR

描述必须列出删除的 ApiImpl/decorator/platform/UT 范围，并声明只清理本批接口。附残留扫描、正式构建和多平台 UT 结果。

## 9. 合入后收尾

每个 PR 合入后：

1. 记录实际主线提交和合入时间。
2. 更新后续阶段基线与 PR 描述。
3. 重新核对官方模块接口清单和剩余接口。
4. 将已完成项标为“本批完成”，保留后续/暂缓原因。
5. 最后一阶段合入后，确认在线 PR 描述、设计文档和主线代码一致。

不得因为三个阶段完成就自动宣称整个官方模块已完成；只有接口全集均有明确归属和处理结论时，才能给出模块级完成结论。
