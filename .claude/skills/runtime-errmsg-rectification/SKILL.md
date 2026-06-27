---
name: runtime-errmsg-rectification
description: "用于 Runtime 错误信息整改、整改建议生成、EE/EH 错误码选择、ErrMsg 宏审查、错误文案优化、上报边界判断。当用户要求进行 Error Message 整改、输出整改建议、生成 rectification_suggestions.md、检视 Error Message 上报正确性、新增接口或新需求要求进行错误上报设计时触发。"
argument-hint: "[整改范围或文件路径] [执行模式: 需要确认|无需确认]"
allowed-tools:
  - Read
  - Write
  - Edit
  - MultiEdit
  - Bash
  - Glob
  - Grep
---

# Runtime ErrMsg Rectification

本 skill 是 Runtime Error Message 专项整改入口，负责完整审视和整改 Runtime 错误码、宏、文案和上报边界。正式规范维护在 docs/guidelines/error_message_guide/目录下，本文件只保留工作流和按需读取规则。

用户可通过参数指定整改范围和执行模式：**$ARGUMENTS**

## 必读入口

开始整改或检视前，先读取：

- [docs/guidelines/error_message_guide/README.md](../../../docs/guidelines/error_message_guide/README.md)

再按问题类型读取专题规范：

- 错误码选择不确定：[docs/guidelines/error_message_guide/error-code-guide.md](../../../docs/guidelines/error_message_guide/error-code-guide.md)
- 宏选择、宏签名、参数数量或字符串风格不确定：[docs/guidelines/error_message_guide/macro-selection-guide.md](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)
- 文案表达、模板或翻译口径不确定：[docs/guidelines/error_message_guide/message-examples.md](../../../docs/guidelines/error_message_guide/message-examples.md)
- 整改边界、参数来源、第一现场、防御性编程、重复结构化上报等场景不确定：[docs/guidelines/error_message_guide/rectification-principles.md](../../../docs/guidelines/error_message_guide/rectification-principles.md)

## 工作流

### 执行模式
开始执行工作流前，确认执行模式：

| 模式 | 说明 |
|------|------|
| 需要确认模式（默认） | Step 6 生成整改建议后暂停，等待用户确认 `docs/rectification_suggestions.md` 没有问题，再开始执行 Step 7。 |
| 无需确认模式 | Step 6 生成整改建议后不等待用户确认，直接继续执行 Step 7。 |

如果用户已明确选择执行模式，按用户选择执行，不再重复询问。用户未明确选择时，主动询问用户选择执行模式；用户未回复或无法确认时，默认使用需要确认模式。用户在请求中明确说明“无需确认”“自动执行”“直接修改”等语义时，可使用无需确认模式；用户在请求中明确说明“先给建议”“先不要改代码”“待确认后再改”等语义时，必须使用需要确认模式。

### Step 1: 定位错误上报点
扫描代码，根据[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)中列出的全量Error Message上报宏识别错误上报点以及是否存在新增错误码或新增上报宏的场景：

| 识别标志 | 说明 |
|----------|------|
| 调用[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)中列出的宏 | Error Message错误上报点 |
| [`error_code.json`](../../../src/dfx/error_manager/error_code.json) 新增条目或 [`error_code_meta.h`](../../../src/runtime/core/inc/common/error_code_meta.h) 新增 X-Macro 行 | 新增错误码 |
| 新增 `#define` → 宏展开链追踪确认是上报宏，上报宏定义参考[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md) | 新增上报宏 |


**不整改标志**：
- `RT_LOG_ERROR`、`RT_LOG_DEBUG`、`RT_LOG_INFO` 等普通日志（不上报结构化错误）

### Step 2: 分析场景
对Step 1中识别出来的每个错误上报点以及新增错误码或新增上报宏展开分析：打开源文件阅读上下文，理解业务场景和触发原因，不只看单行宏调用。

| 分析项 | 处理方法 |
|--------|----------|
| **判断错误类别** | 参考[用户错误与内部错误](../../../docs/guidelines/error_message_guide/rectification-principles.md)和[参数来源判断](../../../docs/guidelines/error_message_guide/rectification-principles.md)进行判断 |
| **是否第一现场** | 参考[第一现场原则](../../../docs/guidelines/error_message_guide/rectification-principles.md)处理 |
| **是否防御性编程** | 参考[防御性编程](../../../docs/guidelines/error_message_guide/rectification-principles.md)处理 |
| **是否重复结构化上报** | 参考[重复结构化上报](../../../docs/guidelines/error_message_guide/rectification-principles.md)处理 |

### Step 3: 选择错误码
根据Step 2中分析的场景选择正确的错误码：用户错误使用 EE/EH 用户类错误码，内部错误主要使用 EE9999 或仅普通日志；具体选择以[错误码使用规范](../../../docs/guidelines/error_message_guide/error-code-guide.md)和 [`src/dfx/error_manager/error_code.json`](../../../src/dfx/error_manager/error_code.json) 为准。

Step 1中涉及新增错误码时，需检查新增错误码的完备性， 缺少任一项 → 推荐使用 `errmsg-codegen` skill进行更新，同时需要刷新[错误码使用规范](../../../docs/guidelines/error_message_guide/error-code-guide.md)：
- JSON 条目完整性：[`error_code.json`](../../../src/dfx/error_manager/error_code.json) 中errClass、errTitle、ErrCode、ErrMessage、Arglist、suggestion
- X-Macro 表行：[`error_code_meta.h`](../../../src/runtime/core/inc/common/error_code_meta.h)
- UT 数据（rt_error_code_test.cc 的 allCodes 数组）

### Step 4: 选择宏
根据Step 3中选择的错误码和场景选择上报宏，优先使用与错误码和控制流匹配的专用封装宏；封装宏正确时优先只改宏参数或文案。具体选择以[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)为准，并注意区分 `_INNER` 系列 printf 风格参数和 `_OUTER` 系列结构化参数。

Step 1中涉及新增宏时，要同步更新[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)。

### Step 5: 设计整改方案
设计宏参数和错误信息整改方案，确保参数名、参数值、期望值、Reason 和标点与模板（[`src/dfx/error_manager/error_code.json`](../../../src/dfx/error_manager/error_code.json)）匹配。错误信息需满足[打印格式规范](../../../docs/guidelines/error_message_guide/rectification-principles.md)，具体的reason描述可参考[文案示例](../../../docs/guidelines/error_message_guide/message-examples.md)中的句式。本步骤只形成方案，不修改代码。

### Step 6: 输出整改建议
按[整改建议模板](references/rectification_suggestions.md)生成 `docs/rectification_suggestions.md`，内容需覆盖整改范围、拟整改项、建议保持不改项、不确定需确认项。
不确定需确认项必须由用户进一步确认，不得自动纳入 Step 7 修改范围。

需要确认模式下，生成整改建议后暂停执行，要求用户确认整改建议没有问题；用户确认前不得执行 Step 7。
无需确认模式下，生成整改建议后无需用户确认，直接执行 Step 7；但只能执行整改建议中确定的拟整改项，不得执行不确定需确认项。

### Step 7: 修改代码
按照Step 6生成的整改建议（`docs/rectification_suggestions.md`）中的拟整改项修改代码。

### Step 8: 验证整改
整改完成后按下述验证项进行验证：

| 验证项 | 验证方法 |
|--------|----------|
| 满足整改边界 | 对照[整改边界](../../../docs/guidelines/error_message_guide/rectification-principles.md) |
| 错误码正确 | 对照[错误码使用规范](../../../docs/guidelines/error_message_guide/error-code-guide.md) |
| 宏选择正确 | 对照[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md) |
| 信息完整 | 对照[打印格式规范](../../../docs/guidelines/error_message_guide/rectification-principles.md) |
| 错误信息改动自检 | 对照[review-checklist](../../../docs/guidelines/error_message_guide/review-checklist.md) |
| 不改业务逻辑 | 检查返回值、条件判断未修改 |
| 不重复上报 | 检查调用链无重复上报 |
