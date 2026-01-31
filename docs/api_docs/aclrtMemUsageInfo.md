# aclrtMemUsageInfo

```
typedef struct aclrtMemUsageInfo {
    char name[32];          // 组件名称
    uint64_t curMemSize;    // 当前占用的内存大小，单位Byte
    uint64_t memPeakSize;   // 该组件的峰值内存，单位Byte
    size_t reserved[8];     // 预留参数
} aclrtMemUsageInfo;
```

