# ASCEND\_LOG\_GID

<!-- md-trans-meta sourceCommit=7129f20a31b3bec0dc2e00016727dde9cb04d675 translatedAt=2026-11-23T01:44:44.203Z -->

## Description

In real-world multi-user collaboration, logs belong by default to the primary group of the process owner, which makes cross-user reading difficult. For example, when User1 (primary group group1) and User2 (primary group group2) share the common group group2, the logs created by User1 are not readable by User2.

To solve this problem, you can use the environment variable ASCEND\_LOG\_GID to specify the owning group of log directories and log files. User1 only needs to set ASCEND\_LOG\_GID to the gid of the common group group2 before starting the process. The generated log directories and log files then automatically belong to group2, and User2 can read them directly without modifying permissions or performing complex authorization.

ASCEND\_LOG\_GID specifies the owning group of process log directories and log files, changing the default primary group of the process owner to the specified user group gid for more flexible log access control. The value of the environment variable is the gid of the target user group (decimal, in the range \[0, 4294967295\]).

After the setting takes effect, the owning group of the log directories and log files changes to the specified gid, while the owner and permission bits remain unchanged. The following example shows the owning group changes before and after the setting:

```text
Before the setting (the environment variable is not configured, and the owning group is the primary group group1 of the process owner):
$HOME/ascend/log                User1:group1  750
├── debug                       User1:group1  750
│   └── plog                    User1:group1  750
│       └── plog-<pid>_*.log    User1:group1  640
├── security                    User1:group1  750
└── run                         User1:group1  750

After the setting (ASCEND_LOG_GID is set to the gid of group2, and the owning group of directories and files becomes group2):
$HOME/ascend/log                User1:group2  750
├── debug                       User1:group2  750
│   └── plog                    User1:group2  750
│       └── plog-<pid>_*.log    User1:group2  640
├── security                    User1:group2  750
└── run                         User1:group2  750
```

**Only users in the specified group can read the logs written to disk by the process. Users in other groups (including the original primary group of the process owner) cannot read them.**

> [!NOTE]Note
>
>- You can run the **echo $ASCEND\_LOG\_GID** command to view the value set for the environment variable.
>- If the log directory already exists before this environment variable is set (for example, after an upgrade deployment or a previous run with the default owning group), the process automatically converges the owning group of the existing log directory to the specified gid at runtime. Only the log directory tree itself is converged; its upper-level directories are not affected. Convergence is performed only when the value is valid and passes the group membership check. If the value is invalid or refers to a group that the current user does not belong to, the existing directories keep their original owning group. If convergence fails, a warning is printed, and log writing is not affected.
>- The value must be the gid of a user group to which the current running user belongs (either the primary group or a supplementary group). The root user can specify any gid.
>- If the environment variable is not configured, is set to an invalid value, is set to empty, or is set to a gid that the current user does not belong to, the default behavior is retained (the owning group is the primary group of the process owner), and a warning log is printed.

## Configuration Example

```sh
export ASCEND_LOG_GID=1001
```

Here, 1001 is an example gid of the target user group.

If multiple groups need read permissions on the logs at the same time, you can configure them through ACL commands: -m grants the specified group read and traverse permissions on the log directory itself, and -d sets a default ACL so that log directories and log files created later automatically inherit the read permission of that group.

```sh
setfacl -m g:<gid>:rx $HOME/ascend/log
setfacl -d -m g:<gid>:rwx $HOME/ascend/log
```

> [!NOTE]Note
>
>- The example uses the default log path $HOME/ascend/log. If a custom log path is specified through ASCEND\_PROCESS\_LOG\_PATH or ASCEND\_WORK\_PATH, replace the path in the commands with the actual log directory.
>- ACL depends on POSIX ACL support of the file system, which can be confirmed by the execution result of the setfacl command. After the log directory is deleted and recreated, the default ACL becomes invalid and must be set again.

## Constraints

- Applicable only to Ascend EP mode.
- This environment variable supports specifying only a single user group. After the setting takes effect, only users in that group can read the logs; users in other groups (including the original primary group of the process owner) cannot read them.

## Supported Models

Supported on all chips.
