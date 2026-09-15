# log

本目录提供对外 ACL 日志接口的可运行样例，并通过目录级脚本输出统一的成功或失败结果。

## 样例列表

- [0_acl_log](./0_acl_log/README.md)：覆盖 `acllogRecord`、`acllogVaList`、`acllogCheckDebugLevel`、`acllogRegisterCallback` 和 `acllogUnregisterCallback`。

## 编译运行

```bash
source ${install_root}/cann/set_env.sh
bash run.sh
```

脚本返回值为 0 表示全部步骤成功，非 0 表示构建或运行失败；详细输出保存在 `output_msg.txt`。
