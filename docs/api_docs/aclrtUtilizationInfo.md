# aclrtUtilizationInfo

```
typedef struct aclrtUtilizationInfo {
    int32_t cubeUtilization;   // Cube利用率
    int32_t vectorUtilization; // Vector利用率
    int32_t aicpuUtilization;  // AI CPU利用率
    int32_t memoryUtilization; // Device内存利用率
    aclrtUtilizationExtendInfo *utilizationExtend; // 预留参数，当前设置为null
} aclrtUtilizationInfo;
```

