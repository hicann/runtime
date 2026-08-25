---
name: faq-expansion-workflow
description: 用于 CANN Runtime 仓库 FAQ 文档扩展的完整工作流程。Use when 用户要求扩展 FAQ 文档、提到"FAQ 扩展"、"添加 FAQ"、"补充常见问题"、或提供 issue 编号要求创建 FAQ 文档。务必精准匹配 issue 主题，避免惯性创建通用 FAQ。
---

# FAQ 扩展工作流 Skill

## 核心原则

1. **精准匹配 issue 主题**：分析 issue 标题关键词，创建针对性 FAQ 而非通用 FAQ
2. **错误码必须校验源码**：所有错误码编号和名称必须对照头文件确认，禁止编造
3. **现象-原因-步骤一一对应**：结构化的三段式，每个现象有示例，每个原因有对应步骤
4. **禁止虚构内容**：不伪造 API 名称、错误码、现象描述或设备状态
5. **标题命名规范**：FAQ 标题应简洁直接，如「aclrtSetDevice 调用失败」，禁止冗长后缀

## 工作流程

### 阶段1：需求澄清

1. 理解用户意图（目标用户、主题范围、单篇或批量）
2. 精准识别主题：**务必**确保 FAQ 主题与 issue 核心问题直接对应，**禁止**惯性创建通用 FAQ
3. 使用 brainstorming skill 澄清需求（批量场景）

### 阶段2：错误码校验（必须执行）

**在写 FAQ 内容之前，必须先校验所有涉及到的错误码。**

错误码有两套定义，务必区分：

| 级别 | 编号范围 | 头文件 |
|------|---------|-------|
| ACL 级别 | 100xxx/200xxx/300xxx | `include/external/acl/acl_base_rt.h` |
| Runtime 级别 | 107xxx/207xxx/507xxx | `include/external/acl/error_codes/rt_error_codes.h` |

校验命令和常见混淆详见 [错误码校验参考](references/error-code-validation.md)。

### 阶段3：FAQ 内容创作

#### FAQ 模板（严格遵循）

```markdown
# [问题标题]

## 问题现象描述

**现象1：[精炼描述]**

调用 xxx 接口时返回错误码 xxx(xxx)，表示 xxx。

报错日志示例如下：
xxx failed, ret = xxx

**现象2：[精炼描述]**
[典型场景代码或命令示例]

## 可能原因

1. **[原因1]**：[一句话概括]
2. **[原因2]**：[一句话概括]

## 处理步骤

### 原因1：[与可能原因1一一对应]

**解决方法**：
- [步骤1]
[代码或命令示例]

### 原因2：[与可能原因2一一对应]
...

## 相关 issue

- [Issue #{编号}: {标题}](https://gitcode.com/cann/runtime/issues/{编号})
或：暂无相关 Issue。
```

#### 格式规范

- **现象描述**：`**现象N：调用xxx接口时返回错误码xxx(xxx)，表示xxx。**`，每个现象必须有自己的示例
- **处理步骤标题**：统一为 `### 原因N：xxx`，禁止用"方法1"/"方案一"/"步骤1"
- **代码示例**：必须使用真实API（grep头文件确认），报错类现象展示错误用法+日志，处理步骤展示正确用法
- **issue 链接**：有则 `[Issue #{编号}: {标题}](链接)`，无则写"暂无相关Issue。"，禁止关联不相关issue
- **中英文排版**：英文单词出现在中文中间时，前后不加空格（如"调用aclrtSetDevice接口时"，而非"调用 aclrtSetDevice 接口时"）
- **错误码引用**：FAQ正文中引用任何错误码时，必须附带名称，如`507014(ACL_ERROR_RT_AICORE_TIMEOUT)`，禁止只写编号不带名称

#### 禁止事项清单

| 禁止 | 替代做法 |
|------|---------|
| 伪造 API 名称 | grep 头文件确认真实 API |
| 伪造错误码 | 校验 rt_error_codes.h |
| 虚构现象描述（如"设备忙碌"） | 只描述真实存在的错误码和日志 |
| 关联不相关 issue | 写"暂无相关 Issue。" |
| 使用 ACL 级错误码描述 Runtime 问题 | 用对应级别的正确名称 |
| 文件名含空格 | 使用无空格文件名 |

### 阶段4：交叉引用与 Issue 链接

- FAQ 底部可选添加"参见"章节，引用路径必须指向实际存在的文件
- Issue 链接格式详见模板，获取 issue 信息优先用 GitCode API

### 阶段5：README 导航更新

1. 在 `docs/zh/README.md` "常见问题"章节更新表格
2. 使用 Markdown 原生表格（禁止 HTML 表格）
3. 按四行分类：入门阶段 · 基础开发 · 进阶场景 · 错误排查

## 输出物清单

- FAQ 文档（docs/zh/FAQ/，UTF-8 无 BOM，文件名无空格）
- docs/zh/README.md FAQ 导航表格更新
- 每个 FAQ 关联 issue 链接或写"暂无相关 Issue。"
- 所有错误码已对照源码校验

## 参考资料

- [错误码校验参考](references/error-code-validation.md)
- [文件规范参考](references/file-standards.md)
- [交叉引用规范](references/cross-reference-format.md)
