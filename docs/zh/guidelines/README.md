# Runtime 研发规范与贡献指南

本目录沉淀 Runtime 仓的软件设计模板、编码规范、测试用例规范和代码检视规则，供仓内开发者和贡献者在设计、编码、测试与评审时统一参考。

## 目录

| 文档 | 内容 | 适用场景 |
|------|------|----------|
| [design_document_template.md](design_document_template.md) | Runtime 设计文档模板，包含接口、架构、文档同步和 DT 检查项 | 输出设计方案、接口设计、特性设计时 |
| [coding-guidelines.md](coding-guidelines.md) | Runtime 代码实现时应遵守的统一编码规范 | 日常开发、自检、`/runtime-code-review`、PR 评审时 |
| [ut-coding-guidelines.md](ut-coding-guidelines.md) | Runtime UT 代码的硬性规范，补充测试实现层面的约束 | 编写、修改、审查 UT 代码时 |
| [Runtime Error Message 开发总纲](error_message_guide/README.md) | Runtime/ACL Error Message 整改和检视的统一规范，包含错误码选择、ErrMsg 上报宏选择、错误文案和上报边界 | 新增或整改 ErrMsg 上报、选择 EE/EH 错误码、优化错误文案、执行 ErrMsg 自检或评审时 |
| [DT用例开发总纲](dt_guide/README.md) | Runtime 仓 UT/ST 用例的组织方式、接入流程和通用规范 | 新增或修改测试时 |
| [pre-commit使用方法](pre-commit_guide.md) | Runtime pre-commit 配置与使用说明，包含 clang-format 格式化和 OAT 合规检查 | 提交代码前安装、运行 |

如果需要补充 Runtime 测试规范，请优先在本目录维护，避免规则散落在脚本、技能和临时文档中。
