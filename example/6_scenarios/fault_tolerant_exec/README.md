# fault_tolerant_exec

本目录聚焦容错执行场景中的失败诊断、恢复和降级处理。

## 样例列表

- [0_model_task_fallback](./0_model_task_fallback/README.md)：识别模型任务，切换主任务备用输入并禁用可选后处理任务，验证回退路径输出。

## 建议关注

- 失败检测后的恢复流程。
- 与可靠性主题联动的场景化用法。
- 异常回调、状态检测和恢复策略的组合。

## 可选参考

- [../../4_reliability/README.md](../../4_reliability/README.md)
- [../../2_advanced_features/callback/2_callback_exception/README.md](../../2_advanced_features/callback/2_callback_exception/README.md)
- [../../0_quickstart/1_error_handling/README.md](../../0_quickstart/1_error_handling/README.md)
