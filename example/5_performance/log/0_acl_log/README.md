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
