# Runtime Code Review Rules

本文件定义 Runtime 仓库代码审查的 AI / 工具规则，供 `runtime-code-review` 及其子模式使用。

## 发布评论约束（重要）

**审查完成后，绝对不能自动向 GitCode 发布评论。**

### 禁止自动发布

- ❌ 审查完成后不能自动调用 GitCode API 发布评论
- ❌ 不能因为"流程结束"就假设应该发布
- ❌ 不能因为脚本支持 `--comment` 参数就默认使用

### 触发条件

只有用户**明确要求**时才能发布：

- 用户说："发布评论"、"提交审查结果"、"post review"
- 用户说："把审查结果发到 GitCode"、"发inline comments"
- 用户回复"可以"、"是"确认发布意图

### 正确行为

审查完成后的正确响应：

```
审查已完成。发现：
- [问题统计]

是否需要将审查结果发布到 GitCode？
```

等待用户明确回复后再决定是否发布。

## 输入规则

1. 必须先读取 `docs/guidelines/coding-guidelines.md`，将其作为基础规范来源。
2. 必须扫描变更文件和 diff 内容是否命中 Error Message 信号；命中时读取 `docs/guidelines/error_message_guide/README.md` 并执行 Error Message 专项检视。
3. 当变更涉及设计、接口、测试或文档时，还应结合 `docs/guidelines/design_document_template.md` 和 `docs/guidelines/dt_guide/` 下相关文档。
4. 审查对象由调用方模式提供，可以是本地 diff，也可以是 GitCode PR diff。

## 文件分类与规范加载

### 源码文件

典型路径：

- `src/**`
- `include/**`
- `pkg_inc/**`
- `cmake/**`

必须读取：

- `docs/guidelines/coding-guidelines.md`

#### Error Message 相关变更

命中以下任一信号时，必须执行 Error Message 专项检视：

| 识别标志 | 说明 |
|----------|------|
| 调用[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)中列出的宏 | Error Message错误上报点 |
| [`error_code.json`](../../../src/dfx/error_manager/error_code.json) 新增条目或 [`error_code_meta.h`](../../../src/runtime/core/inc/common/error_code_meta.h) 新增 X-Macro 行 | 新增错误码 |
| 新增 `#define` → 宏展开链追踪确认是上报宏，上报宏定义参考[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md) | 新增上报宏 |

命中后必须先读取：

- `docs/guidelines/error_message_guide/README.md`

必要时再按问题类型读取专题规范：

- 错误码选择不确定：[docs/guidelines/error_message_guide/error-code-guide.md](../../../docs/guidelines/error_message_guide/error-code-guide.md)
- 宏选择、宏签名、参数数量或字符串风格不确定：[docs/guidelines/error_message_guide/macro-selection-guide.md](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)
- 文案表达、模板或翻译口径不确定：[docs/guidelines/error_message_guide/message-examples.md](../../../docs/guidelines/error_message_guide/message-examples.md)
- 整改边界、参数来源、第一现场、防御性编程、重复结构化上报等场景不确定：[docs/guidelines/error_message_guide/rectification-principles.md](../../../docs/guidelines/error_message_guide/rectification-principles.md)

### UT 文件

典型路径：

- `tests/**`
- 文件名匹配 `*_utest*`
- 文件名匹配 `*_unittest*`

必须读取：

- `docs/guidelines/coding-guidelines.md`（重点关注其中的"通用 C/C++ 编码规范"）
- `docs/guidelines/ut-coding-guidelines.md`
- `docs/guidelines/dt_guide/UT用例开发指导.md`

### 文档文件

典型路径：

- `docs/**`

建议读取：

- `docs/guidelines/design_document_template.md`
- `docs/guidelines/coding-guidelines.md`

### 其他文件

典型路径：

- `scripts/**`
- 根目录配置文件
- 其他不属于源码、UT、文档的辅助文件

建议读取：

- `docs/guidelines/coding-guidelines.md`

## 审查优先级与高信号原则

1. 优先标记高信号问题，即能够明确说明“为什么这是问题”的缺陷。
2. 仅当问题满足以下至少一类时，优先输出：
   - 代码无法编译或解析
   - 无论输入如何，代码都必然产生错误结果
   - 明确、无歧义地违反了仓库规范，并能指出具体规则
   - 明确的兼容性破坏、资源泄漏或文档同步缺失
3. 不要优先输出以下内容：
   - 主观风格偏好
   - 需要大量上下文才能成立的猜测性问题
   - 可由通用 lint 自动发现、且不影响正确性的低信号问题
4. 如果对某个问题是否成立没有足够把握，不要标为高优先级问题。

## 审查维度

### A. 功能正确性

重点检查：

1. 变更逻辑是否符合预期意图。
2. 是否遗漏分支、边界条件或异常路径。
3. 是否与设计文档、接口约束和测试预期一致。

### B. 日志合理性

重点检查：

1. 日志级别和热路径开销是否合理。
2. 日志内容是否具备足够上下文且不泄露敏感信息。
3. 格式化字符串和错误日志宏使用是否正确。

### C. 公共 API 兼容性

重点检查：

1. 公开头文件修改是否保持向后兼容。
2. 是否发生 breaking change。
3. 废弃接口、枚举和公开边界处理是否符合规范。

### D. 文档同步

重点检查：

1. 修改公开接口或错误码时，是否同步更新了对应文档。

### E. 软件架构

重点检查：

1. 是否破坏既有目录边界、平台隔离边界或组件职责边界。
2. 是否违反 `src/runtime` 中 `api` 与非 `api` 目录之间的调用边界。

### F. 构建规范

重点检查：

1. `src/runtime` 目录是否新增了不允许的编译宏。

### G. UT 规范

重点检查：

1. 测试代码是否满足断言、mock 清理和状态恢复要求。
2. 是否存在不必要的私有成员访问、`SetChipType` 使用或测试隔离问题。

### H. Error Message 规范

当变更命中 Error Message 相关信号时，必须执行本维度检视。先读取 `docs/guidelines/error_message_guide/README.md`，再按问题类型读取错误码、宏、文案或整改原则专题文档。

重点检查：

1. 用户错误和内部错误分类是否正确：按照[用户错误与内部错误](../../../docs/guidelines/error_message_guide/rectification-principles.md)和[参数来源判断](../../../docs/guidelines/error_message_guide/rectification-principles.md)进行判断。
2. 错误码选择是否正确，是否匹配场景，Arglist 数量和顺序是否与 `src/dfx/error_manager/error_code.json` 及 `src/runtime/core/inc/common/error_code_meta.h` 匹配：对新增或替换的 ErrorCode，必须按[错误码使用规范](../../../docs/guidelines/error_message_guide/error-code-guide.md)中的说明以及对应分类的决策树逐项判断。
3. 涉及新增错误码时，需检查新增错误码的完备性， 缺少任一项 → 推荐使用 `errmsg-codegen` skill进行更新，同时需要刷新[错误码使用规范](../../../docs/guidelines/error_message_guide/error-code-guide.md)：
- JSON 条目完整性：[`error_code.json`](../../../src/dfx/error_manager/error_code.json) 中errClass、errTitle、ErrCode、ErrMessage、Arglist、suggestion
- X-Macro 表行：[`error_code_meta.h`](../../../src/runtime/core/inc/common/error_code_meta.h)
- UT 数据（rt_error_code_test.cc 的 allCodes 数组）
4. 宏是否匹配错误码、控制流和参数传递风格，是否误用 `_INNER` / `_OUTER` 系列宏：按照[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)进行判断。
5. 涉及新增宏时，要同步更新[ErrMsg 上报宏使用规范](../../../docs/guidelines/error_message_guide/macro-selection-guide.md)
6. 错误文案是否包含参数名、参数值、期望值或 Reason，是否可定位、可自闭环，是否句式完整，不存在语法错误。
7. 是否存在同一错误路径重复结构化上报。
8. Error Message 整改是否误改业务逻辑、返回值、条件判断或普通日志级别。
9. 公开 API 参数错误是否漏报必要结构化错误。
10. 是否满足Error Message整改边界：按照[整改边界](../../../docs/guidelines/error_message_guide/rectification-principles.md)进行判断。

严重程度定义：

- **[必须修改]**：用户错误和内部错误分类明显错误；错误码明显选错；Arglist 数量或顺序与 `error_code.json` / `error_code_meta.h` 不匹配；同一错误路径重复结构化上报；Error Message 整改引入业务逻辑、返回值、条件判断或日志级别变化；公开 API 参数错误漏报必要结构化错误。
- **[建议修改]**：宏可工作但不是推荐专用宏；文案不够自闭环；Reason、Expected、参数名或参数值表达不清；第一现场日志上下文不足。
- **[仅供参考]**：非关键措辞优化，或不影响定位的问题说明。

## 输出格式

按文件组织审查结果，每个问题包含：

```text
### <文件路径>

- **[严重程度]** <审查维度> | 行号：<行号>
  <问题描述>
  <修改建议>（如适用）
```

## 严重程度定义

- **[必须修改]**：功能缺陷、安全漏洞、资源泄漏、兼容性破坏、缺失必要文档同步等必须修复的问题。
- **[建议修改]**：编码风格、日志合理性、可维护性、测试完备性等建议改进的问题。
- **[仅供参考]**：风格偏好、可选优化和低风险提醒。

## 审查总结格式

在所有文件审查完成后，输出总结：

1. 变更概要：本次变更的目的和范围。
2. 问题统计：各严重程度的问题数量。
3. 总体评价：代码质量评估及是否建议合入。
