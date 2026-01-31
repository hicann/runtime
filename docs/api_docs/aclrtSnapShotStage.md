# aclrtSnapShotStage

```
typedef enum {
    ACL_RT_SNAPSHOT_LOCK_PRE = 0,    // 锁定前
    ACL_RT_SNAPSHOT_BACKUP_PRE,      // 备份前
    ACL_RT_SNAPSHOT_BACKUP_POST,     // 备份后
    ACL_RT_SNAPSHOT_RESTORE_PRE,     // 恢复前
    ACL_RT_SNAPSHOT_RESTORE_POST,    // 恢复后
    ACL_RT_SNAPSHOT_UNLOCK_POST,     // 解锁后
} aclrtSnapShotStage;
```

