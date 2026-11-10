## 0_acl_log

本样例演示用户模块使用 `acl_log.h` 中的对外 ACL 日志接口记录调试日志、运行日志，通过 `va_list` 记录日志，并注册和注销设备日志回调。

## 编译运行

在 CANN 环境中执行上级目录的 `run.sh`：

```bash
source ${install_root}/cann/set_env.sh
cd ${git_clone_path}/example/5_performance/log
bash run.sh
```

脚本会检查构建和样例输出，失败时返回非 0 退出码。

## 产物说明

### 编译产物

- 可执行文件：`example/5_performance/log/build/0_acl_log/acl_log_sample`
- 运行输出：`example/5_performance/log/0_acl_log/output_msg.txt`（stdout 完整输出，由 `run.sh` 生成）

### 运行输出（stdout）

默认配置下，日志接口可用时输出如下（`acllogCheckDebugLevel` 的返回值取决于用户模块当前日志级别配置，默认调测日志级别为 `DLOG_ERROR` 时返回 0）：

```text
[INFO] acllogCheckDebugLevel returned 0.
[SUCCESS] ACL log sample completed successfully.
```

若运行环境中存在设备侧 plog 日志上报，回调会额外打印 `[CALLBACK type=N] ...` 行；若当前产品不提供可选日志记录接口（弱符号为空），会输出 `[WARN]` 提示，样例仍正常结束。

若运行前设置 `export ASCEND_LOG_PRINT_TO_STDOUT=1`（旧变量 `ASCEND_SLOG_PRINT_TO_STDOUT` 已废弃，不建议使用），记录的日志内容会额外打印到 stdout，此时输出中还包含各条日志内容本身。

### 日志落盘

默认情况下（未开启 `ASCEND_LOG_PRINT_TO_STDOUT`），`acllogRecord`、`acllogVaList` 记录的日志内容不会打印到 stdout，而是落盘到主机日志目录：优先使用 `ASCEND_PROCESS_LOG_PATH` 环境变量指定的路径，其次使用 `ASCEND_WORK_PATH` 下的 `log` 目录，均未设置时默认为 `~/ascend/log`。其中调测日志写入 `debug` 子目录，运行日志（moduleId 携带 `RUN_LOG_MASK`）写入 `run` 子目录；用户 moduleId（`0xff00`~`0xffff`）在日志中按十进制 ID 记录。
