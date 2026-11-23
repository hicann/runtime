# ASCEND\_LOG\_GID

## 功能描述

在实际多用户协作中，日志默认归属进程属主主组，导致跨用户读取困难。例如User1（主组group1）与User2（主组group2）共享公共组group2时，User1创建的日志对User2不可读。

为解决此问题，可通过环境变量ASCEND\_LOG\_GID指定日志目录和日志文件的属组。User1只需在启动进程前将ASCEND\_LOG\_GID设置为公共组group2的gid，生成的日志目录和日志文件即自动归属group2，User2便可直接读取，无需修改权限或复杂授权。

ASCEND\_LOG\_GID用于指定进程日志目录和日志文件的属组，将默认的进程属主主组调整为指定的用户组gid，实现更灵活的日志访问控制。环境变量取值为目标用户组的gid（十进制，取值范围为\[0, 4294967295\]）。

设置生效后，日志目录和日志文件的属组变更为指定gid，属主与权限位保持不变。设置前后属组变化示例如下：

```text
设置前（未配置该环境变量，属组为进程属主的主组group1）：
$HOME/ascend/log                User1:group1  750
├── debug                       User1:group1  750
│   └── plog                    User1:group1  750
│       └── plog-<pid>_*.log    User1:group1  640
├── security                    User1:group1  750
└── run                         User1:group1  750

设置后（ASCEND_LOG_GID为group2的gid，目录与文件属组变为group2）：
$HOME/ascend/log                User1:group2  750
├── debug                       User1:group2  750
│   └── plog                    User1:group2  750
│       └── plog-<pid>_*.log    User1:group2  640
├── security                    User1:group2  750
└── run                         User1:group2  750
```

**仅指定的group内的用户可读取该进程落盘的日志，其他group（包括进程属主原主组）内的用户不可读取**。

> [!NOTE]说明
>
>- 通过执行**echo $ASCEND\_LOG\_GID**命令可以查看环境变量设置的值。
>- 若设置该环境变量前日志目录已存在（如升级部署，或曾以默认属组运行过），进程运行时会自动将已存在的日志目录属组收敛为指定gid，仅收敛日志目录树本身，不影响其上层目录；收敛仅在取值合法且通过组成员检查时执行，配置为非法值或非本用户所属组时已存在目录保持原属组不变；收敛失败时输出告警，不影响日志写入。
>- 取值必须为当前运行用户所属用户组的gid（主组或附加组均可），root用户可指定任意gid。
>- 若环境变量未配置/配置为非法值/配置为空/配置为当前用户不所属的gid，则保持默认行为（属组为进程属主的主组），并输出告警日志。

## 配置示例

```sh
export ASCEND_LOG_GID=1001
```

其中1001为目标用户组gid的示例值。

若需要多个group同时具备日志读权限，可通过ACL命令配置：-m为日志目录本身授予指定组读与遍历权限，-d设置默认ACL使后续新建的日志目录和日志文件自动继承该组读权限。

```sh
setfacl -m g:<gid>:rx $HOME/ascend/log
setfacl -d -m g:<gid>:rwx $HOME/ascend/log
```

> [!NOTE]说明
>
>- 示例以默认日志路径$HOME/ascend/log为例；若通过ASCEND\_PROCESS\_LOG\_PATH或ASCEND\_WORK\_PATH指定了自定义日志路径，请将命令中的路径替换为实际日志目录。
>- ACL依赖文件系统的POSIX ACL支持，可通过setfacl命令执行结果确认；日志目录被删除重建后默认ACL失效，需重新设置。

## 使用约束

- 仅适用于Ascend EP形态
- 本环境变量仅支持指定单一用户组；设置生效后仅该组内的用户可读取日志，其他group（含进程属主原主组）不可读。

## 支持的型号

全量芯片支持
