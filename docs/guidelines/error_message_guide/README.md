# Runtime Error Message 开发总纲

本目录是 Runtime/ACL Error Message 整改和检视的统一规范来源，面向开发者和 AI agent 共用。错误码、宏、错误文案和上报边界的规则应优先在本目录维护，避免多个 skill 各自复制规则后产生口径漂移。

## 资料结构

| 文件 | 用途 |
|------|------|
| [rectification-principles.md](rectification-principles.md) | 判断整改边界、用户错误/内部错误、参数来源、第一现场、防御性编程、重复结构化上报和打印格式规范 |
| [error-code-guide.md](error-code-guide.md) | 选择Runtime EE 与 ACL EH 错误码 |
| [macro-selection-guide.md](macro-selection-guide.md) | 选择 ErrMsg外部/内部错误码上报宏 |
| [message-examples.md](message-examples.md) | 查看 ErrMsg 文案模板、Arglist、典型表达和文案整改示例 |
| [review-checklist.md](review-checklist.md) | 检视 ErrMsg 修改是否合规，重点核对 error_code.json / error_code_meta.h 双源同步、宏参数数量、错误文案语法和参数值 |

## 使用方式

- 判断是否应该整改、是否属于第一现场、是否重复上报，以及确认防御性编程和打印格式要求时，先读 `rectification-principles.md`。
- 选择或审查错误码时，读 `error-code-guide.md`；涉及 ErrCode、ErrMessage、Arglist 和 suggestion 时，以 `src/dfx/error_manager/error_code.json` 为准。
- 选择或审查宏时，读 `macro-selection-guide.md`；注意区分 `_INNER` 系列的 printf 风格参数和 `_OUTER` 系列的结构化参数。
- 优化错误文案时，读 `message-examples.md`，并结合 `error_code.json` 中的模板、Arglist 和 `rectification-principles.md` 中的打印格式规范。
- 提交或评审 ErrMsg 修改前，读 `review-checklist.md` 进行自检，重点确认 `error_code.json` 与 `error_code_meta.h` 同步、`%s` 与 Arglist 参数数量一致、宏调用未重复传参、suggestion 和 ErrMessage 文案满足格式要求。

## 事实来源

当规范文档与代码不一致时，应以代码为准，并同步修正规范文档。关键代码来源包括：

- `src/dfx/error_manager/error_code.json`
- `src/runtime/core/inc/common/error_code_meta.h`
- `src/runtime/core/inc/base.hpp`
- `src/runtime/core/inc/common/error_message_manage.hpp`
- `src/dfx/error_manager/error_manager.h`

## 维护原则

- 本目录承载正式规范；skill 只保留流程和导航，不复制完整规则。
- 修改错误码、宏或文案规范时，同步检查本目录内相关文档是否需要更新；新增或调整错误码时，重点核对并更新 `error_code.json`、`error_code_meta.h`和`error-code-guide.md`，新增或调整上报宏时，重点核对并更新`macro-selection-guide.md`。
- `review-checklist.md` 面向检视和自检，新增常见问题、参数计算规则或双源同步要求时，应同步补充该清单。
- 新增或调整 ErrMsg 调用点时，不修改业务逻辑、返回值、条件判断和普通日志级别，除非需求明确要求。
