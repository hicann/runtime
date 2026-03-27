# aclrtMemLocation

```
typedef struct aclrtMemLocation {
    uint32_t id;                  // Device ID或NUMA（Non-Uniform Memory Access） ID
    aclrtMemLocationType type;    // 内存所在位置
} aclrtMemLocation;
```

内存所在位置请参见[aclrtMemLocationType](aclrtMemLocationType.md)中的定义。

