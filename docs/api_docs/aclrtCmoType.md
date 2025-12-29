# aclrtCmoType

```
typedef enum aclrtCmoType {
    ACL_RT_CMO_TYPE_PREFETCH = 0,     // 内存预取，从内存预取到Cache
    ACL_RT_CMO_TYPE_WRITEBACK,        // 把Cache中的数据刷新到内存中，并在Cache中保留副本
    ACL_RT_CMO_TYPE_INVALID,          // 丢弃Cache中的数据
    ACL_RT_CMO_TYPE_FLUSH,            // 把Cache中的数据刷新到内存中，不保留Cache中的副本
} aclrtCmoType;
```

