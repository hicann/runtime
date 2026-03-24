# aclrtMemManagedLocation

```
typedef struct {
    aclrtMemManagedLocationType type;  // 内存所在位置
    int id;                            // Device ID或NUMA（Non-Uniform Memory Access） ID
} aclrtMemManagedLocation;
```

当type为ACL\_MEM\_LOCATIONTYPE\_INVALID、ACL\_MEM\_LOCATIONTYPE\_HOST、ACL\_MEM\_LOCATIONTYPE\_HOST\_NUMA\_CURRENT时，id无效。

